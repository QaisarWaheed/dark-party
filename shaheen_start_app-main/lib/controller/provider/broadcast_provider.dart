import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shaheen_star_app/controller/api_manager/gift_web_socket_service.dart';

/// Shows the high-value gift broadcast overlay (broadcasting_image.png) across the app.
/// Triggered when user sends a non-Lucky gift worth more than 1 lakh (100,000) coins.
/// Uses same position/layout as the Lucky gift banner (top banner with user data).
class BroadcastProvider with ChangeNotifier {
  final GiftWebSocketService _wsService = GiftWebSocketService.instance;
  bool _showBroadcast = false;
  Timer? _hideTimer;

  String _senderName = '';
  String _senderProfileUrl = '';
  String _receiverName = '';
  String _giftImage = '';
  int _giftCount = 1;
  double _giftAmount = 0;

  bool get isBroadcastVisible => _showBroadcast;
  String get senderName => _senderName;
  String get senderProfileUrl => _senderProfileUrl;
  String get receiverName => _receiverName;
  String get giftImage => _giftImage;
  int get giftCount => _giftCount;
  double get giftAmount => _giftAmount;

  BroadcastProvider() {
    _initWebSocketListener();
  }

  void _initWebSocketListener() {
    void handleGiftEvent(dynamic data) {
      // Robust payload normalization
      Map<String, dynamic> payload = data is Map<String, dynamic> ? data : {};
      if (data != null && data['data'] != null && data['data'] is Map) {
        payload = Map<String, dynamic>.from(data['data'] as Map);
      } else if (data is Map) {
        payload = Map<String, dynamic>.from(data);
      }

      print("🔔 [BroadcastProvider] Gift Event Received: $payload");

      // Robust helpers
      String? safeString(dynamic value) {
        if (value == null) return null;
        final s = value.toString().trim();
        if (s.isEmpty || s.toLowerCase() == 'null') return null;
        return s;
      }

      int safeInt(dynamic value) {
        return int.tryParse(value?.toString() ?? '') ?? 0;
      }

      double safeDouble(dynamic value) {
        return double.tryParse(value?.toString() ?? '') ?? 0.0;
      }

      bool safeBool(dynamic value) {
         if (value == true || value == 1) return true;
         if (value is String) {
           return value == '1' || value.toLowerCase() == 'true';
         }
         return false;
      }

      String? nestedString(Map<String, dynamic> map, List<String> path) {
        dynamic current = map;
        for (final key in path) {
          if (current is Map && current.containsKey(key)) {
            current = current[key];
          } else {
            return null;
          }
        }
        return safeString(current);
      }

      final isLucky = safeBool(payload['is_lucky']);
      final price = safeDouble(payload['gift_value']);

      // Only show for non-lucky gifts > 100k
      if (!isLucky && price > 100000) {
        print("🔔 [BroadcastProvider] High value gift detected! Processing...");
        
        // Massive search for Sender Name
        var senderName = 
            safeString(payload['sender_name']) ??
            safeString(payload['sender_username']) ??
            safeString(payload['sender']) ??
            safeString(payload['from_name']) ??
            nestedString(payload, ['sender', 'name']) ??
            nestedString(payload, ['sender', 'username']) ??
            'User';

        // Massive search for Receiver Name
        var receiverName = 
            safeString(payload['receiver_name']) ??
            safeString(payload['receiver_username']) ??
            safeString(payload['receiver']) ??
            safeString(payload['to_name']) ??
            safeString(payload['to_username']) ??
            nestedString(payload, ['receiver', 'name']) ??
            nestedString(payload, ['receiver', 'username']) ??
            nestedString(payload, ['to_user', 'name']) ??
            nestedString(payload, ['to_user', 'username']) ??
            'User';

        // Massive search for Sender Avatar
        var senderAvatar = 
            safeString(payload['sender_avatar']) ??
            safeString(payload['sender_image']) ??
            safeString(payload['sender_profile']) ??
            safeString(payload['sender_profile_url']) ??
            nestedString(payload, ['sender', 'profile_url']) ??
            nestedString(payload, ['sender', 'avatar']) ??
            nestedString(payload, ['sender', 'image']);

        // Massive search for Gift Image
        var giftImageRaw = 
            safeString(payload['gift_image']) ??
            safeString(payload['gift_icon']) ??
            safeString(payload['gift_img']) ??
            safeString(payload['image']) ??
            safeString(payload['gift_file']) ??
            nestedString(payload, ['gift', 'image']) ??
            nestedString(payload, ['gift', 'icon']) ??
            nestedString(payload, ['gift', 'url']);

        final quantity = safeInt(payload['quantity']) > 0 
            ? safeInt(payload['quantity']) 
            : 1;

        print("🔔 [BroadcastProvider] Showing Broadcast:");
        print("   Sender: $senderName, Recv: $receiverName");
        print("   Gift Img: $giftImageRaw, Qty: $quantity");

        showBroadcastOverlay(
          senderName: senderName,
          senderProfileUrl: senderAvatar ?? '',
          receiverName: receiverName,
          giftImage: _normalizeMediaUrl(giftImageRaw),
          giftCount: quantity,
          giftAmount: price,
          source: 'InternalListener',
        );
      } else {
        print("🔔 [BroadcastProvider] Gift ignored (Lucky: $isLucky, Price: $price)");
      }
    }

    _wsService.on('gift:sent', handleGiftEvent);
    _wsService.on('gift_sent', handleGiftEvent);
  }

  Map<String, dynamic> _normalizePayload(Map<String, dynamic> data) {
    if (data['data'] is Map<String, dynamic>) {
      return Map<String, dynamic>.from(data['data'] as Map<String, dynamic>);
    }
    return data;
  }

  bool _parseBool(dynamic value) {
    if (value == true || value == 1) return true;
    if (value is String) {
      return value == '1' || value.toLowerCase() == 'true';
    }
    return false;
  }

  double _parseDouble(dynamic value) {
    return double.tryParse(value?.toString() ?? '0') ?? 0;
  }

  int _parseInt(dynamic value, {int fallback = 0}) {
    return int.tryParse(value?.toString() ?? '') ?? fallback;
  }

  String _firstNonEmptyString(Map<String, dynamic> data, List<String> keys) {
    for (final key in keys) {
      final val = data[key];
      if (val != null) {
        final s = val.toString().trim();
        if (s.isNotEmpty && s.toLowerCase() != 'null') return s;
      }
    }
    return '';
  }

  String _normalizeMediaUrl(String? raw) {
    if (raw == null) return '';
    var url = raw.trim();
    if (url.isEmpty || url.toLowerCase() == 'null') return '';
    if (url.startsWith('http://') || url.startsWith('https://')) return url;
    if (url.startsWith('/')) url = url.substring(1);
    return 'https://shaheenstar.online/$url';
  }

  /// Show the broadcast overlay in the same position as Lucky banner, with user data.
  void showBroadcastOverlay({
    String senderName = '',
    String senderProfileUrl = '',
    String receiverName = '',
    String giftImage = '',
    int giftCount = 1,
    double giftAmount = 0,
    Duration duration = const Duration(seconds: 4),
    String source = 'Unknown',
  }) {
    print("🔔 [BroadcastProvider] showBroadcastOverlay called from [$source]");
    print("   -> Sender: '$senderName'");
    print("   -> Receiver: '$receiverName'");
    
    // Final defensive fallback to prevent 'Blank' names
    final finalSender = (senderName.trim().isEmpty || senderName == 'null') ? 'User' : senderName;
    final finalReceiver = (receiverName.trim().isEmpty || receiverName == 'null') ? 'User' : receiverName;

    print("   -> Final Resolved: Sender='$finalSender', Receiver='$finalReceiver'");

    _hideTimer?.cancel();
    _senderName = finalSender;
    _senderProfileUrl = senderProfileUrl;
    _receiverName = finalReceiver;
    _giftImage = giftImage;
    _giftCount = giftCount;
    _giftAmount = giftAmount;
    _showBroadcast = true;
    notifyListeners();

    _hideTimer = Timer(duration, () {
      _showBroadcast = false;
      _senderName = '';
      _senderProfileUrl = '';
      _receiverName = '';
      _giftImage = '';
      _giftCount = 1;
      _giftAmount = 0;
      _hideTimer = null;
      notifyListeners();
    });
  }

  void hideBroadcast() {
    _hideTimer?.cancel();
    _hideTimer = null;
    _showBroadcast = false;
    notifyListeners();
  }

  @override
  void dispose() {
    _hideTimer?.cancel();
    super.dispose();
  }
}
