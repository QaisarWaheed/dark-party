# Shaheen Star App - Codebase Overview

## 📱 Project Summary

**Shaheen Star App** is a Flutter-based social entertainment application featuring voice rooms, real-time chat, agency management, gifting system, and user interactions. The app uses Firebase for authentication, Zego Cloud SDK for voice calls, and WebSocket connections for real-time features.

---

## 🏗️ Architecture

### **Technology Stack**
- **Framework**: Flutter (Dart SDK ^3.9.2)
- **State Management**: Provider pattern (30+ providers)
- **Backend**: PHP REST APIs + WebSocket servers
- **Authentication**: Firebase Auth + Google Sign-In
- **Voice/Video**: Zego Cloud SDK (zego_express_engine, zego_zim)
- **Storage**: SharedPreferences, Firebase
- **Networking**: HTTP, WebSocket (multiple ports)

### **Project Structure**
```
lib/
├── admin/              # Admin features (ban users, etc.)
├── components/         # Reusable UI components
├── controller/
│   ├── api_manager/    # API calls, WebSocket services
│   └── provider/       # State management (30+ providers)
├── model/              # Data models (30+ models)
├── repository/         # Data repositories
├── routes/             # App routing
├── utils/              # Utility functions
└── view/
    └── screens/        # UI screens organized by feature
```

---

## 📊 Codebase Statistics

- **Total Dart Files**: 180 files
- **Providers**: 30+ state management providers
- **Models**: 30+ data models
- **Screens**: 50+ screen widgets
- **Components**: 20+ reusable components
- **WebSocket Services**: 5 different WebSocket connections

---

## 🔑 Core Features

### 1. **Authentication & User Management**
- Firebase Authentication
- Google Sign-In integration
- User registration/profile setup
- User session management
- Profile updates

**Key Files:**
- `lib/view/screens/login/` - Login, signup, profile setup
- `lib/controller/api_manager/auth_api.dart`
- `lib/utils/user_session.dart`

### 2. **Voice Rooms**
- Create/join/leave rooms
- Real-time room messaging
- Seat management (admin seats, regular seats)
- Room rankings
- Room settings
- Voice call integration (Zego)

**Key Files:**
- `lib/view/screens/room/` - Room screens
- `lib/controller/provider/join_room_provider.dart`
- `lib/controller/provider/room_message_provider.dart`
- `lib/controller/provider/seat_provider.dart`
- `lib/controller/provider/zego_voice_provider.dart`

**WebSocket**: `ws://shaheenstar.online:8083`

### 3. **Gifting System**
- Send gifts in rooms
- Gift animations
- Gift transactions
- Gift display overlays
- CP (Contribution Points) gifts

**Key Files:**
- `lib/controller/provider/gift_provider.dart`
- `lib/controller/provider/gift_display_provider.dart`
- `lib/repository/gift_repository.dart`
- `lib/components/gift_animation_overlay.dart`

**WebSocket**: `ws://shaheenstar.online:8085`

### 4. **Agency Management**
- View all agencies
- Join/quit agency requests
- Agency member management
- Host center
- Agency notifications

**Key Files:**
- `lib/view/screens/agency/` - All agency screens
- `lib/controller/provider/agency_provider.dart`
- `lib/controller/api_manager/agency_websocket_service.dart`

**WebSocket**: `ws://shaheenstar.online:8043`

**Documentation**: `AGENCY_ROUTING.md`, `AGENCY_JOIN_REQUEST_FLOW.md`

### 5. **User Chat**
- One-on-one messaging
- Chat room management
- User search
- Real-time message delivery

**Key Files:**
- `lib/view/screens/user_chat/` - Chat screens
- `lib/controller/provider/user_chat_provider.dart`
- `lib/controller/api_manager/user_web_socket_service.dart`

**WebSocket**: `ws://shaheenstar.online:8088`

**Documentation**: `WEBSOCKET_TESTING_GUIDE.md`

### 6. **Moments/Posts**
- Create moments (posts)
- View moments feed
- Comments
- Like/follow interactions

**Key Files:**
- `lib/view/screens/home/moment_*.dart`
- `lib/controller/provider/moment_provider.dart`
- `lib/controller/api_manager/post_web_socket_service.dart`

**WebSocket**: `ws://shaheenstar.online:8079`

### 7. **Store & Backpack**
- Virtual store (frames, themes, etc.)
- Purchase items
- Backpack management
- Item animations

**Key Files:**
- `lib/view/screens/store/`
- `lib/controller/provider/store_provider.dart`
- `lib/controller/provider/backback_provider.dart`
- `lib/repository/store_repository.dart`

### 8. **Rankings**
- User rankings
- Room rankings
- CP (Contribution Points) rankings
- Period toggles (daily, weekly, monthly)

**Key Files:**
- `lib/view/screens/ranking/`
- `lib/controller/provider/ranking_provider.dart`
- `lib/controller/provider/room_ranking_provider.dart`
- `lib/controller/provider/cp_provider.dart`

### 9. **Merchant & Payout System**
- Transaction history
- Coin distribution
- Withdrawal system
- Merchant profiles

**Key Files:**
- `lib/view/screens/merchant/`
- `lib/controller/provider/merchant_*.dart`
- `lib/controller/provider/payout_provider.dart`
- `lib/controller/provider/withdraw_provider.dart`

### 10. **VIP System**
- VIP levels
- VIP rewards
- Level progression

**Key Files:**
- `lib/view/screens/VIP/`
- `lib/controller/provider/vip_provider.dart`
- `lib/view/screens/level/`

### 11. **Admin Features**
- Ban users
- Admin messages
- User management

**Key Files:**
- `lib/admin/`
- `lib/view/screens/home/admin_*.dart`

---

## 🌐 Backend Integration

### **Base URL**
```
https://shaheenstar.online/
```

### **REST API Endpoints** (Key ones)
- Authentication: `/login.php`, `/register.php`, `/google_auth.php`
- Rooms: `/get_rooms.php`, `/create_room.php`
- Gifts: `/get_gifts.php`, `/send_gift.php`
- Agency: `/get_all_agencies.php`, `/agency_manager.php`
- Store: `/mall_api.php`, `/purchase_item.php`
- Transactions: `/TransactionHistoryApi.php`
- Withdrawal: `/withdrawal_system.php`
- Level: `/level.php`

### **WebSocket Servers**
1. **Room WebSocket** (Port 8083): Rooms, seats, messages, mic status
2. **Gifts WebSocket** (Port 8085): Gift operations
3. **User Chat WebSocket** (Port 8088): User-to-user chat
4. **Agency WebSocket** (Port 8043): Agency management
5. **Post WebSocket** (Port 8079): Moments/posts

### **API Manager**
- `lib/controller/api_manager/api_manager.dart` - Main API service (4000+ lines)
- `lib/controller/api_manager/api_constants.dart` - All API endpoints
- Multiple WebSocket service files for different features

---

## 🎨 UI/UX Components

### **Reusable Components**
- `custom_bottom_nav.dart` - Bottom navigation bar
- `custom_profile_card.dart` - User profile cards
- `custom_profile_frame.dart` - Profile frames
- `gift_animation_overlay.dart` - Gift animations
- `rank_cards.dart` - Ranking display cards
- `store_bottom_sheet.dart` - Store UI
- `voice_option_bottom_sheet.dart` - Voice options
- And 15+ more components

### **Screen Organization**
```
view/screens/
├── agency/          # Agency management screens
├── bottom_nav/      # Main navigation
├── game/            # Game features
├── home/            # Home, moments, messages
├── level/           # Level system
├── login/           # Auth screens
├── merchant/        # Merchant/payout screens
├── profile/          # User profile screens
├── ranking/         # Rankings
├── room/            # Voice room screens
├── store/           # Store screens
├── user_chat/       # Chat screens
└── VIP/             # VIP features
```

---

## 📦 Dependencies

### **Core Dependencies**
- `firebase_core: ^3.1.0`
- `firebase_auth: ^5.1.0`
- `google_sign_in: ^6.2.1`
- `provider: ^6.1.5+1` (State management)
- `http: ^1.2.2` (REST API)
- `web_socket_channel: ^2.4.0` (WebSocket)

### **UI/Display**
- `flutter_screenutil: ^5.9.0`
- `flutter_svg: ^2.0.10+1`
- `cached_network_image: ^3.3.0`
- `carousel_slider: ^5.1.1`
- `google_fonts: ^6.3.2`

### **Media**
- `image_picker: ^1.1.1`
- `video_player: ^2.10.1`
- `svgaplayer_plus: ^2.3.1`

### **Voice/Video**
- `zego_express_engine: ^3.15.0`
- `zego_zim: ^2.15.0`
- `permission_handler: ^11.3.1`

### **Utilities**
- `shared_preferences: ^2.2.3`
- `country_picker: ^2.0.21`
- `intl: ^0.19.0`
- `crypto: ^3.0.3`

---

## 🔄 State Management

### **Provider Pattern**
The app uses Flutter's Provider package with 30+ ChangeNotifier providers:

**Key Providers:**
- `SignUpProvider` - User registration
- `JoinRoomProvider` - Room joining logic
- `RoomMessageProvider` - Room messaging
- `GiftProvider` - Gift operations
- `AgencyProvider` - Agency management
- `UserChatProvider` - User chat
- `ZegoVoiceProvider` - Voice calls
- `StoreProvider` - Store operations
- `RankingProvider` - Rankings
- `MomentProvider` - Posts/moments
- And 20+ more...

All providers are registered in `main.dart` using `MultiProvider`.

---

## 📱 Navigation Flow

### **Main Flow**
```
SplashScreen
  ↓
SignupScreen / Login
  ↓
ProfileSetupScreen (if new user)
  ↓
MainBottomNavScreen
  ├── HomeScreen
  ├── FollowerScreen
  ├── MomentScreen
  ├── MessageScreen
  └── ProfileScreen
```

### **Routes**
Defined in `lib/routes/app_routes.dart`:
- `/` - Splash
- `/signup` - Signup
- `/home` - Main bottom nav
- `/profile-update` - Profile setup
- `/wallet` - Wallet screen

Most navigation uses `Navigator.push()` with `MaterialPageRoute`.

---

## 🐛 Known Issues & Documentation

### **Documentation Files**
1. `AGENCY_ROUTING.md` - Agency navigation guide
2. `AGENCY_JOIN_REQUEST_FLOW.md` - Agency join/quit flow
3. `AGENCY_TESTING_GUIDE.md` - Agency testing procedures
4. `WEBSOCKET_TESTING_GUIDE.md` - WebSocket testing
5. `SEATS_DEBUGGING_GUIDE.md` - Seat system debugging
6. `ZEGO_SETUP.md` - Zego Cloud setup
7. `BUILD_FIX.md` - Build issues and fixes
8. `BACKEND_WEBSOCKET_FIX.md` - WebSocket fixes
9. `FRONTEND_RETRY_SOLUTION.md` - Retry logic solutions

---

## 🔐 Security & Configuration

### **API Authentication**
- Static bearer token: `"mySuperSecretStaticToken123"`
- Firebase token for user authentication
- Token passed in Authorization header

### **Firebase Configuration**
- `lib/firebase_options.dart` - Firebase platform configs
- Firebase initialized in `main.dart`

### **Zego Configuration**
- `lib/controller/api_manager/zego_config.dart` - Zego Cloud settings
- App ID and Server Secret configured

---

## 📂 Assets

### **Image Assets**
- `assets/images/` - 100+ images (icons, backgrounds, frames, etc.)
- `assets/icons/` - Icon images
- `assets/svg/` - SVG graphics

### **Key Images**
- App logo, banners
- Room backgrounds
- Profile frames
- Level badges
- VIP icons
- Gift icons
- Store items

---

## 🧪 Testing

### **Test Files**
- `test/widget_test.dart` - Basic widget test

### **Testing Guides**
- Multiple markdown files with testing procedures
- WebSocket testing documentation
- Agency testing guide

---

## 🚀 Build Configuration

### **Platforms**
- ✅ Android (configured)
- ✅ iOS (configured)
- ✅ Web (configured)
- ✅ Linux (configured)
- ✅ macOS (configured)
- ✅ Windows (configured)

### **Version**
- App Version: `1.0.1+3`
- Flutter SDK: `^3.9.2`

---

## 📝 Key Implementation Patterns

1. **Provider Pattern**: Extensive use of ChangeNotifier for state
2. **Repository Pattern**: Some features use repository pattern (gifts, store)
3. **WebSocket Services**: Separate service classes for each WebSocket connection
4. **Model Classes**: Data models for all API responses
5. **Component-Based UI**: Reusable components for common UI elements
6. **Error Handling**: Try-catch blocks with logging throughout

---

## 🔍 Code Quality Notes

- **Large Files**: `api_manager.dart` is 4000+ lines (consider splitting)
- **Commented Code**: Some commented-out code present
- **Logging**: Extensive print statements for debugging
- **Error Handling**: Good error handling in most places
- **Documentation**: Multiple markdown docs for complex features

---

## 🎯 Next Steps for Development

1. **Code Organization**: Consider splitting large files
2. **Testing**: Add more unit and integration tests
3. **Documentation**: Add inline code documentation
4. **Error Handling**: Standardize error handling patterns
5. **Performance**: Optimize image loading and caching
6. **Security**: Review API token handling

---

## 📞 Support & Resources

- **Backend**: `https://shaheenstar.online/`
- **WebSocket Servers**: Multiple ports (8083, 8085, 8043, 8079, 8088)
- **Documentation**: See markdown files in root directory

---

**Last Updated**: January 26, 2026
**Total Files Scanned**: 180 Dart files + assets + configuration files
