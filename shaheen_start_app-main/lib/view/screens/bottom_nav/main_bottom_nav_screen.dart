


// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:shaheen_star_app/components/custom_bottom_nav.dart';
// import 'package:shaheen_star_app/controller/provider/bottom_nav_provider.dart';
// import 'package:shaheen_star_app/view/screens/home/follower_screen.dart';
// import 'package:shaheen_star_app/view/screens/home/home_screen.dart';
// import 'package:shaheen_star_app/view/screens/home/message_screen.dart';
// import 'package:shaheen_star_app/view/screens/profile/profile_screen.dart';
// // import 'package:shaheen_star_app/view/widgets/custom_bottom_nav_bar.dart';

// class MainBottomNavScreen extends StatelessWidget {
//   const MainBottomNavScreen({super.key});

//   // 👇 Screens for each taba
//   final List<Widget> _screens = const [
//     HomeScreen(),
//     FollowerScreen(),
//     MessageScreen(),
//     ProfileScreen(),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     final bottomProvider = context.watch<BottomNavProvider>();

//     return Scaffold(
//       extendBody: true,
//       body: _screens[bottomProvider.currentIndex],

//       // 👇 Your Custom Bottom Navigation
//       bottomNavigationBar: CustomBottomNavBar(
//         backgroundImage: 'assets/images/bg_bottom_nav.png', selectedIndex: bottomProvider.currentIndex,
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shaheen_star_app/components/custom_bottom_nav.dart';
import 'package:shaheen_star_app/controller/provider/bottom_nav_provider.dart';
import 'package:shaheen_star_app/controller/provider/user_chat_provider.dart';
import 'package:shaheen_star_app/view/screens/home/discover_screen.dart';
import 'package:shaheen_star_app/view/screens/home/home_screen.dart';
import 'package:shaheen_star_app/view/screens/user_chat/user_chat_list_screen.dart';
import 'package:shaheen_star_app/view/screens/home/moment_screen.dart';
import 'package:shaheen_star_app/view/screens/profile/profile_screen.dart';

class MainBottomNavScreen extends StatefulWidget {
  const MainBottomNavScreen({super.key});

  @override
  State<MainBottomNavScreen> createState() => _MainBottomNavScreenState();
}

class _MainBottomNavScreenState extends State<MainBottomNavScreen> {
  @override
  void initState() {
    super.initState();
    // ✅ Reset to home tab (index 0) when navigating to bottom nav screen
    // This ensures users always start at home after login/signup
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final bottomProvider = Provider.of<BottomNavProvider>(context, listen: false);
      bottomProvider.resetToHome();
      print("🏠 Bottom Nav reset to home (index 0)");
    });
  }

  @override
  Widget build(BuildContext context) {
    // ✅ Screens list
    final List<Widget> screens = const [
      HomeScreen(),
      DiscoverScreen(),
      MomentScreen(),
      ChatListScreen(),
      ProfileScreen(),
    ];

    return Consumer<BottomNavProvider>(
      builder: (context, bottomProvider, child) {
        // Get unread message count
        int unreadCount = 0;
        try {
          final chatProvider = Provider.of<UserChatProvider>(context, listen: false);
          unreadCount = chatProvider.chatRooms
              .fold(0, (sum, room) => sum + (room.unreadCount ?? 0));
        } catch (e) {
          // If provider not available, use default
          unreadCount = 1; // Default for demo
        }

        return Scaffold(
          extendBody: false, // ✅ Changed to false to ensure bottom nav is always accessible
          
          // ✅ Current screen based on selected tab
          body: IndexedStack(
            index: bottomProvider.currentIndex,
            children: screens,
          ),

          // ✅ Bottom Navigation Bar
          bottomNavigationBar: CustomBottomNavBar(
            backgroundImage: 'assets/images/bg_bottom_nav.png',
            selectedIndex: bottomProvider.currentIndex,
            unreadMessageCount: unreadCount > 0 ? unreadCount : null,
          ),
        );
      },
    );
  }
}
