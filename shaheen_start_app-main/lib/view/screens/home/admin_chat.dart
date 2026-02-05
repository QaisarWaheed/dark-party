// admin_messages_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shaheen_star_app/controller/provider/user_message_provider.dart';
import 'package:shaheen_star_app/model/admin_message_model.dart';

class AdminMessagesScreen extends StatefulWidget {
  const AdminMessagesScreen({super.key});

  @override
  State<AdminMessagesScreen> createState() => _AdminMessagesScreenState();
}

class _AdminMessagesScreenState extends State<AdminMessagesScreen> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<UserMessageProvider>(context);

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,

        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black, size: 15),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Admin',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert, color: Colors.black, size: 15),
            onPressed: provider.loadAdminMessages,
          ),
        ],
      ),
      body: _buildBody(provider),
    );
  }

  Widget _buildBody(UserMessageProvider provider) {
    if (provider.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (provider.error != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, color: Colors.red, size: 64),
            const SizedBox(height: 16),
            const Text(
              'Error loading messages',
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
            const SizedBox(height: 8),
            Text(provider.error!, textAlign: TextAlign.center),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: provider.loadAdminMessages,
              child: const Text('Try Again'),
            ),
          ],
        ),
      );
    }

    if (provider.adminMessages.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.notifications_none, size: 80, color: Colors.grey[400]),
            const SizedBox(height: 16),
            const Text(
              'No admin messages',
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
            const SizedBox(height: 8),
            const Text(
              'You will see admin notifications here',
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: provider.adminMessages.length,
      itemBuilder: (context, index) {
        return _buildAdminMessageCard(provider.adminMessages[index]);
      },
    );
  }

  // Widget _buildAdminMessageCard(AdminMessage message) {
  //   return Card(
  //     margin: const EdgeInsets.only(bottom: 12),
  //     elevation: 2,
  //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
  //     child: Padding(
  //       padding: const EdgeInsets.all(16),
  //       child: Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           // Header
  //           Row(
  //             children: [
  //               const Icon(Icons.notifications, color: Colors.orange),
  //               const SizedBox(width: 8),
  //               const Text(
  //                 'Admin Notification',
  //                 style: TextStyle(
  //                   fontWeight: FontWeight.bold,
  //                   color: Colors.orange,
  //                 ),
  //               ),
  //               const Spacer(),
  //               Text(
  //                 _formatDate(message.createdAt),
  //                 style: const TextStyle(fontSize: 12, color: Colors.grey),
  //               ),
  //             ],
  //           ),
  //           const SizedBox(height: 12),
  //           // Title
  //           Text(
  //             message.title,
  //             style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
  //           ),
  //           const SizedBox(height: 8),
  //           // Content
  //           Text(
  //             message.content,
  //             style: TextStyle(fontSize: 14, color: Colors.grey[700]),
  //           ),
  //           const SizedBox(height: 12),
  //           // Footer
  //           Row(
  //             children: [
  //               const Icon(Icons.flag, size: 16, color: Colors.grey),
  //               const SizedBox(width: 4),
  //               Text(
  //                 'Country: ${message.country}',
  //                 style: const TextStyle(fontSize: 12, color: Colors.grey),
  //               ),
  //               const Spacer(),
  //               const Icon(Icons.calendar_today, size: 16, color: Colors.grey),
  //               const SizedBox(width: 4),
  //               Text(
  //                 message.formattedDate,
  //                 style: const TextStyle(fontSize: 12, color: Colors.grey),
  //               ),
  //             ],
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  // String _formatDate(DateTime date) {
  //   final now = DateTime.now();
  //   final difference = now.difference(date);

  //   if (difference.inMinutes < 1) return 'Just now';
  //   if (difference.inMinutes < 60) return '${difference.inMinutes}m ago';
  //   if (difference.inHours < 24) return '${difference.inHours}h ago';
  //   if (difference.inDays < 7) return '${difference.inDays}d ago';
  //   return '${date.day}/${date.month}/${date.year}';
  // }

  Widget _buildAdminMessageCard(AdminMessage message) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 18,
            backgroundImage: AssetImage(
              'assets/images/app_logo.jpeg',
            ), // ✅ AssetImage use karo
            // backgroundColor: Colors.grey[200], // optional fallback color
          ),

          // Message Text
          const SizedBox(width: 8),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Text(
                message.content,
                style: const TextStyle(fontSize: 14, color: Colors.black87),
              ),
            ),
          ),

          // Right side logo
        ],
      ),
    );
  }
}
