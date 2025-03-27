import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AmpLock',
            theme: ThemeData.light().copyWith(
              primaryColor: themeProvider.accentColor,
              scaffoldBackgroundColor: Colors.white,
              iconTheme: IconThemeData(
                color: themeProvider.accentColor,
                size: themeProvider.fontSize * 1.5,
              ),
              textTheme: TextTheme(
                titleLarge: TextStyle(
                  fontSize: themeProvider.fontSize + 4,
                  color: Colors.black87,
                ),
                bodyLarge: TextStyle(
                  fontSize: themeProvider.fontSize,
                  color: Colors.black87,
                ),
                bodyMedium: TextStyle(
                  fontSize: themeProvider.fontSize - 2,
                  color: Colors.black54,
                ),
              ),
              appBarTheme: AppBarTheme(
                backgroundColor: Colors.white,
                elevation: 0,
                iconTheme: IconThemeData(
                  color: themeProvider.accentColor,
                  size: themeProvider.fontSize * 1.5,
                ),
                titleTextStyle: TextStyle(
                  color: Colors.black87,
                  fontSize: themeProvider.fontSize + 4,
                  fontWeight: FontWeight.bold,
                ),
              ),
              floatingActionButtonTheme: FloatingActionButtonThemeData(
                backgroundColor: themeProvider.accentColor,
              ),
              bottomNavigationBarTheme: BottomNavigationBarThemeData(
                selectedItemColor: themeProvider.accentColor,
                unselectedItemColor: Colors.grey,
              ),
            ),
            darkTheme: ThemeData.dark().copyWith(
              primaryColor: themeProvider.accentColor,
              scaffoldBackgroundColor: Colors.black,
              iconTheme: IconThemeData(
                color: themeProvider.accentColor,
                size: themeProvider.fontSize * 1.5,
              ),
              textTheme: TextTheme(
                titleLarge: TextStyle(
                  fontSize: themeProvider.fontSize + 4,
                  color: Colors.white,
                ),
                bodyLarge: TextStyle(
                  fontSize: themeProvider.fontSize,
                  color: Colors.white,
                ),
                bodyMedium: TextStyle(
                  fontSize: themeProvider.fontSize - 2,
                  color: Colors.white70,
                ),
              ),
              appBarTheme: AppBarTheme(
                backgroundColor: Colors.black,
                elevation: 0,
                iconTheme: IconThemeData(
                  color: themeProvider.accentColor,
                  size: themeProvider.fontSize * 1.5,
                ),
                titleTextStyle: TextStyle(
                  color: Colors.white,
                  fontSize: themeProvider.fontSize + 4,
                  fontWeight: FontWeight.bold,
                ),
              ),
              floatingActionButtonTheme: FloatingActionButtonThemeData(
                backgroundColor: themeProvider.accentColor,
              ),
              bottomNavigationBarTheme: BottomNavigationBarThemeData(
                selectedItemColor: themeProvider.accentColor,
                unselectedItemColor: Colors.white70,
              ),
            ),
            themeMode: themeProvider.isDarkMode ? ThemeMode.dark : ThemeMode.light,
            home: MainScreen(),
          );
        },
      ),
    );
  }
}

class ThemeProvider with ChangeNotifier {
  bool _isDarkMode = true;
  Color _accentColor = Colors.green;
  double _fontSize = 16.0;

  bool get isDarkMode => _isDarkMode;
  Color get accentColor => _accentColor;
  double get fontSize => _fontSize;

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }

  void setAccentColor(Color color) {
    _accentColor = color;
    notifyListeners();
  }

  void setFontSize(double size) {
    _fontSize = size;
    notifyListeners();
  }
}

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _selectedIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onPageChanged(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onBottomNavTapped(int index) {
    _pageController.animateToPage(
      index,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _navigateToNextPage() {
    if (_selectedIndex < 2) {
      _pageController.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _navigateToPreviousPage() {
    if (_selectedIndex > 0) {
      _pageController.previousPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            onPageChanged: _onPageChanged,
            children: [
              HomeScreen(),
              ActivityLogScreen(),
              SettingsScreen(),
            ],
          ),
          // Left Arrow Button
          if (_selectedIndex > 0)
            Positioned(
              left: 16,
              top: MediaQuery.of(context).size.height / 2 - 28,
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: _navigateToPreviousPage,
                  child: Container(
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor.withOpacity(0.9),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 8,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                ),
              ),
            ),
          // Right Arrow Button
          if (_selectedIndex < 2)
            Positioned(
              right: 16,
              top: MediaQuery.of(context).size.height / 2 - 28,
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: _navigateToNextPage,
                  child: Container(
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor.withOpacity(0.9),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 8,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Icon(
                      Icons.arrow_forward,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
      bottomNavigationBar: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        child: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _onBottomNavTapped,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.history),
              label: 'Activity',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Settings',
            ),
          ],
        ),
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  bool isLocked = true;
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _rotateAnimation;
  late Animation<double> _colorAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 800),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    _rotateAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    _colorAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggleLock() {
    setState(() {
      isLocked = !isLocked;
      if (isLocked) {
        _controller.reverse();
      } else {
        _controller.forward();
      }
    });
  }

  Color _getLockColor() {
    return Color.lerp(Colors.green, Colors.green.shade300, _colorAnimation.value) ?? Colors.green;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final iconSize = theme.iconTheme.size ?? 24.0;
    
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Header Section
            Padding(
              padding: EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Welcome Back",
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Your Smart Door",
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.textTheme.bodyMedium?.color?.withOpacity(0.7),
                        ),
                      ),
                    ],
                  ),
                  Stack(
                    children: [
                      IconButton(
                        icon: Icon(Icons.notifications, size: iconSize),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => NotificationScreen(),
                            ),
                          );
                        },
                      ),
                      Positioned(
                        right: 8,
                        top: 8,
                        child: Container(
                          padding: EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          constraints: BoxConstraints(
                            minWidth: 12,
                            minHeight: 12,
                          ),
                          child: Text(
                            '3',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: iconSize * 0.4,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Live Feed Section
            Expanded(
              flex: 3,
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: theme.scaffoldBackgroundColor,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: Offset(0, 5),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Stack(
                    children: [
                      // Live Feed Background
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Colors.green.withOpacity(0.1),
                              Colors.blue.withOpacity(0.2),
                              Colors.black.withOpacity(0.3),
                            ],
                            stops: [0.0, 0.5, 1.0],
                          ),
                        ),
                      ),
                      
                      // Camera Icon or Video Feed
                      Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.videocam,
                              size: iconSize * 3,
                              color: theme.primaryColor.withOpacity(0.7),
                            ),
                            SizedBox(height: 12),
                            Text(
                              'Connecting to camera...',
                              style: theme.textTheme.bodyLarge?.copyWith(
                                color: theme.primaryColor.withOpacity(0.7),
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Overlay Elements
                      Positioned(
                        top: 16,
                        right: 16,
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.6),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 8,
                                height: 8,
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              SizedBox(width: 8),
                              Text(
                                'REC',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      // Bottom Info Bar
                      Positioned(
                        bottom: 16,
                        left: 16,
                        right: 16,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.6),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Icon(Icons.live_tv, color: Colors.white, size: iconSize),
                                      SizedBox(width: 8),
                                      Text(
                                        "Live Feed",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        width: 8,
                                        height: 8,
                                        decoration: BoxDecoration(
                                          color: theme.primaryColor,
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                      SizedBox(width: 8),
                                      Text(
                                        'LIVE',
                                        style: TextStyle(
                                          color: theme.primaryColor,
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 8),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.4),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.wifi,
                                    color: Colors.white70,
                                    size: iconSize * 0.8,
                                  ),
                                  SizedBox(width: 8),
                                  Text(
                                    "Connected",
                                    style: TextStyle(
                                      color: Colors.white70,
                                      fontSize: 12,
                                    ),
                                  ),
                                  Spacer(),
                                  Text(
                                    "Front Door Camera",
                                    style: TextStyle(
                                      color: Colors.white70,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Quick Actions
                      Positioned(
                        top: 16,
                        left: 16,
                        child: Column(
                          children: [
                            _buildQuickActionButton(
                              icon: Icons.photo_camera,
                              onTap: () {
                                // Take snapshot
                              },
                            ),
                            SizedBox(height: 8),
                            _buildQuickActionButton(
                              icon: Icons.volume_up,
                              onTap: () {
                                // Toggle audio
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Lock Control Section
            Expanded(
              flex: 2,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
                    AnimatedBuilder(
                      animation: _controller,
                      builder: (context, child) {
                        return Transform.scale(
                          scale: _scaleAnimation.value,
                          child: Transform.rotate(
                            angle: _rotateAnimation.value * 2 * 3.14159,
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Container(
                                  padding: EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    color: _getLockColor().withOpacity(0.1),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    Icons.lock_outline,
                                    size: iconSize * 2,
                                    color: _getLockColor(),
                                  ),
                                ),
                                if (!isLocked)
                                  Positioned(
                                    top: -5,
                                    right: -5,
                                    child: Container(
                                      padding: EdgeInsets.all(4),
                                      decoration: BoxDecoration(
                                        color: Colors.green,
                                        shape: BoxShape.circle,
                                      ),
                                      child: Icon(
                                        Icons.check,
                                        size: iconSize * 0.8,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                    SizedBox(height: 16),
                    AnimatedBuilder(
                      animation: _controller,
                      builder: (context, child) {
                        return Opacity(
                          opacity: _fadeAnimation.value,
                          child: Text(
                            "Door Status: ${isLocked ? 'Locked' : 'Unlocked'}",
                            style: theme.textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        );
                      },
                    ),
            SizedBox(height: 20),
                    GestureDetector(
                      onTapDown: (_) => _controller.forward(),
                      onTapUp: (_) => _toggleLock(),
                      onTapCancel: () => _controller.reverse(),
                      child: AnimatedBuilder(
                        animation: _controller,
                        builder: (context, child) {
                          return Transform.scale(
                            scale: _scaleAnimation.value,
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                              decoration: BoxDecoration(
                                color: _getLockColor(),
                                borderRadius: BorderRadius.circular(30),
                                boxShadow: [
                                  BoxShadow(
                                    color: _getLockColor().withOpacity(0.3),
                                    blurRadius: 8,
                                    offset: Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    isLocked ? Icons.lock_open : Icons.lock,
                                    color: Colors.white,
                                    size: iconSize,
                                  ),
                                  SizedBox(width: 8),
            Text(
                                    isLocked ? "Unlock Door" : "Lock Door",
                                    style: theme.textTheme.titleLarge?.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickActionButton({
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.6),
        shape: BoxShape.circle,
      ),
      child: IconButton(
        icon: Icon(icon, color: Colors.white),
        onPressed: onTap,
      ),
    );
  }
}

class NotificationScreen extends StatefulWidget {
  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  List<NotificationItem> notifications = [
    NotificationItem(
      type: NotificationType.doorbell,
      title: "Doorbell Pressed",
      description: "Someone is at the door",
      timestamp: DateTime.now().subtract(Duration(minutes: 5)),
      imageUrl: "https://example.com/doorbell1.jpg",
      isRead: false,
    ),
    NotificationItem(
      type: NotificationType.tamper,
      title: "Tamper Alert",
      description: "Unauthorized access attempt detected",
      timestamp: DateTime.now().subtract(Duration(minutes: 15)),
      imageUrl: "https://example.com/tamper1.jpg",
      isRead: false,
    ),
    NotificationItem(
      type: NotificationType.status,
      title: "Door Status Changed",
      description: "Door was unlocked via app",
      timestamp: DateTime.now().subtract(Duration(hours: 1)),
      imageUrl: "https://example.com/status1.jpg",
      isRead: true,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final iconSize = theme.iconTheme.size ?? 24.0;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: theme.textTheme.titleLarge?.color),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text("Notifications", style: theme.textTheme.titleLarge),
        actions: [
          IconButton(
            icon: Icon(Icons.done_all, color: theme.textTheme.titleLarge?.color),
            onPressed: () {
              setState(() {
                notifications.forEach((notification) => notification.isRead = true);
              });
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          final notification = notifications[index];
          return Dismissible(
            key: Key(notification.timestamp.toString()),
            direction: DismissDirection.endToStart,
            background: Container(
              color: Colors.red,
              alignment: Alignment.centerRight,
              padding: EdgeInsets.only(right: 20),
              child: Icon(Icons.delete, color: Colors.white),
            ),
            onDismissed: (direction) {
              setState(() {
                notifications.removeAt(index);
              });
            },
            child: GestureDetector(
              onTap: () {
                setState(() {
                  notification.isRead = true;
                });
                // Show notification details
                showModalBottomSheet(
                  context: context,
                  builder: (context) => NotificationDetailSheet(notification: notification),
                );
              },
              child: Container(
                color: notification.isRead ? null : Theme.of(context).primaryColor.withOpacity(0.1),
                child: ListTile(
                  leading: Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: _getNotificationColor(notification.type).withOpacity(0.2),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      _getNotificationIcon(notification.type),
                      color: _getNotificationColor(notification.type),
                      size: iconSize,
                    ),
                  ),
                  title: Text(
                    notification.title,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: notification.isRead ? FontWeight.normal : FontWeight.bold,
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
            Text(
                        notification.description,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      SizedBox(height: 4),
                      Text(
                        _getTimeAgo(notification.timestamp),
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                  trailing: Icon(Icons.chevron_right, size: iconSize),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Color _getNotificationColor(NotificationType type) {
    switch (type) {
      case NotificationType.doorbell:
        return Colors.blue;
      case NotificationType.tamper:
        return Colors.red;
      case NotificationType.status:
        return Colors.green;
    }
  }

  IconData _getNotificationIcon(NotificationType type) {
    switch (type) {
      case NotificationType.doorbell:
        return Icons.notifications_active;
      case NotificationType.tamper:
        return Icons.warning;
      case NotificationType.status:
        return Icons.lock;
    }
  }

  String _getTimeAgo(DateTime timestamp) {
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.inMinutes < 60) {
      return '${difference.inMinutes} minutes ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} hours ago';
    } else {
      return '${difference.inDays} days ago';
    }
  }
}

enum NotificationType {
  doorbell,
  tamper,
  status,
}

class NotificationItem {
  final NotificationType type;
  final String title;
  final String description;
  final DateTime timestamp;
  final String imageUrl;
  bool isRead;

  NotificationItem({
    required this.type,
    required this.title,
    required this.description,
    required this.timestamp,
    required this.imageUrl,
    this.isRead = false,
  });
}

class NotificationDetailSheet extends StatelessWidget {
  final NotificationItem notification;

  const NotificationDetailSheet({Key? key, required this.notification}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final iconSize = theme.iconTheme.size ?? 24.0;

    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
              children: [
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: _getNotificationColor(notification.type).withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  _getNotificationIcon(notification.type),
                  color: _getNotificationColor(notification.type),
                  size: iconSize,
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      notification.title,
                      style: theme.textTheme.titleLarge,
                    ),
                    Text(
                      _getTimeAgo(notification.timestamp),
                      style: theme.textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          Text(
            notification.description,
            style: theme.textTheme.bodyLarge,
          ),
          SizedBox(height: 24),
          Container(
            height: 200,
            width: double.infinity,
            decoration: BoxDecoration(
              color: theme.scaffoldBackgroundColor,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Center(
              child: Icon(Icons.image, size: iconSize * 2, color: theme.textTheme.bodyLarge?.color),
            ),
          ),
        ],
      ),
    );
  }

  Color _getNotificationColor(NotificationType type) {
    switch (type) {
      case NotificationType.doorbell:
        return Colors.blue;
      case NotificationType.tamper:
        return Colors.red;
      case NotificationType.status:
        return Colors.green;
    }
  }

  IconData _getNotificationIcon(NotificationType type) {
    switch (type) {
      case NotificationType.doorbell:
        return Icons.notifications_active;
      case NotificationType.tamper:
        return Icons.warning;
      case NotificationType.status:
        return Icons.lock;
    }
  }

  String _getTimeAgo(DateTime timestamp) {
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.inMinutes < 60) {
      return '${difference.inMinutes} minutes ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} hours ago';
    } else {
      return '${difference.inDays} days ago';
    }
  }
}

class ActivityLogScreen extends StatelessWidget {
  final List<Activity> activities = [
    Activity(
      type: ActivityType.tamperAlert,
      title: "Tamper Alert",
      description: "Unauthorized access attempt detected",
      timestamp: DateTime.now().subtract(Duration(minutes: 5)),
      imageUrl: "https://example.com/tamper1.jpg",
    ),
    Activity(
      type: ActivityType.notification,
      title: "Doorbell Pressed",
      description: "Someone is at the door",
      timestamp: DateTime.now().subtract(Duration(minutes: 15)),
      imageUrl: "https://example.com/doorbell1.jpg",
    ),
    Activity(
      type: ActivityType.tamperAlert,
      title: "Tamper Alert",
      description: "Multiple failed attempts detected",
      timestamp: DateTime.now().subtract(Duration(hours: 1)),
      imageUrl: "https://example.com/tamper2.jpg",
    ),
    Activity(
      type: ActivityType.notification,
      title: "Door Unlocked",
      description: "Door was unlocked via app",
      timestamp: DateTime.now().subtract(Duration(hours: 2)),
      imageUrl: "https://example.com/unlock1.jpg",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final iconSize = theme.iconTheme.size ?? 24.0;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Container(
              padding: EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Activity Log",
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 28,
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.filter_list),
                    onPressed: () {
                      // Add filter functionality
                    },
                  ),
                ],
              ),
            ),

            // Activity List
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 16),
                itemCount: activities.length,
                itemBuilder: (context, index) {
                  final activity = activities[index];
                  return Container(
                    margin: EdgeInsets.only(bottom: 12),
                    decoration: BoxDecoration(
                      color: theme.scaffoldBackgroundColor,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(16),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ActivityDetailScreen(activity: activity),
                            ),
                          );
                        },
                        child: Padding(
                          padding: EdgeInsets.all(16),
                          child: Row(
                            children: [
                              Container(
                                padding: EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: activity.type == ActivityType.tamperAlert
                                      ? Colors.red.withOpacity(0.1)
                                      : Colors.green.withOpacity(0.1),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  activity.type == ActivityType.tamperAlert
                                      ? Icons.warning_rounded
                                      : Icons.check_circle_outline,
                                  color: activity.type == ActivityType.tamperAlert
                                      ? Colors.red
                                      : Colors.green,
                                  size: iconSize,
                                ),
                              ),
                              SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      activity.title,
                                      style: theme.textTheme.titleMedium?.copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(height: 4),
                                    Text(
                                      activity.description,
                                      style: theme.textTheme.bodyMedium,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    SizedBox(height: 4),
                                    Text(
                                      _getTimeAgo(activity.timestamp),
                                      style: theme.textTheme.bodySmall?.copyWith(
                                        color: theme.textTheme.bodySmall?.color?.withOpacity(0.7),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Icon(
                                Icons.chevron_right,
                                color: theme.textTheme.bodySmall?.color?.withOpacity(0.7),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getTimeAgo(DateTime timestamp) {
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.inMinutes < 60) {
      return '${difference.inMinutes} minutes ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} hours ago';
    } else {
      return '${difference.inDays} days ago';
    }
  }
}

enum ActivityType {
  tamperAlert,
  notification,
}

class Activity {
  final ActivityType type;
  final String title;
  final String description;
  final DateTime timestamp;
  final String imageUrl;

  Activity({
    required this.type,
    required this.title,
    required this.description,
    required this.timestamp,
    required this.imageUrl,
  });
}

class ActivityDetailScreen extends StatelessWidget {
  final Activity activity;

  const ActivityDetailScreen({Key? key, required this.activity}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image Section
            Container(
              height: 300,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.black87,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Center(
                child: Icon(
                  Icons.image,
                  size: 50,
                  color: Colors.white70,
                ),
              ),
            ),
            SizedBox(height: 24),
            
            // Activity Details
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: activity.type == ActivityType.tamperAlert
                              ? Colors.red.withOpacity(0.2)
                              : Colors.blue.withOpacity(0.2),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          activity.type == ActivityType.tamperAlert
                              ? Icons.warning
                              : Icons.notifications,
                          color: activity.type == ActivityType.tamperAlert
                              ? Colors.redAccent
                              : Colors.blueAccent,
                        ),
                      ),
                      SizedBox(width: 16),
            Text(
                        activity.title,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
            Text(
                    activity.description,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white70,
                    ),
                  ),
                  SizedBox(height: 24),
                  Text(
                    "Time of Event",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "${activity.timestamp.hour.toString().padLeft(2, '0')}:${activity.timestamp.minute.toString().padLeft(2, '0')}",
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.white70,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "${activity.timestamp.day}/${activity.timestamp.month}/${activity.timestamp.year}",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white60,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final iconSize = theme.iconTheme.size ?? 24.0;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Container(
              padding: EdgeInsets.all(16),
              child: Row(
                children: [
                  Text(
                    "Settings",
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 28,
                    ),
                  ),
                ],
              ),
            ),

            // Settings List
            Expanded(
              child: ListView(
                padding: EdgeInsets.symmetric(horizontal: 16),
                children: [
                  _buildSettingGroup(
                    theme,
                    title: "Security",
                    items: [
                      SettingItem(
                        icon: Icons.notifications,
                        title: "Notifications",
                        subtitle: "Manage notification preferences",
                        onTap: () => Navigator.push(
                          context,
                          CustomPageRoute(child: NotificationSettingsScreen()),
                        ),
                      ),
                      SettingItem(
                        icon: Icons.security,
                        title: "Security",
                        subtitle: "Configure security settings",
                        onTap: () => Navigator.push(
                          context,
                          CustomPageRoute(child: SecuritySettingsScreen()),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 24),
                  _buildSettingGroup(
                    theme,
                    title: "Device",
                    items: [
                      SettingItem(
                        icon: Icons.devices,
                        title: "Connected Devices",
                        subtitle: "Manage connected locks",
                        onTap: () => Navigator.push(
                          context,
                          CustomPageRoute(child: ConnectedDevicesScreen()),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 24),
                  _buildSettingGroup(
                    theme,
                    title: "Support",
                    items: [
                      SettingItem(
                        icon: Icons.help_outline,
                        title: "Help & Support",
                        subtitle: "Get assistance",
                        onTap: () => Navigator.push(
                          context,
                          CustomPageRoute(child: HelpSupportScreen()),
                        ),
                      ),
                      SettingItem(
                        icon: Icons.info_outline,
                        title: "About",
                        subtitle: "App information",
                        onTap: () => Navigator.push(
                          context,
                          CustomPageRoute(child: AboutScreen()),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingGroup(
    ThemeData theme, {
    required String title,
    required List<SettingItem> items,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 8, bottom: 8),
          child: Text(
            title,
            style: theme.textTheme.titleMedium?.copyWith(
              color: theme.primaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: theme.scaffoldBackgroundColor,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            children: items.map((item) {
              return Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(16),
                  onTap: item.onTap,
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: theme.primaryColor.withOpacity(0.1),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            item.icon,
                            color: theme.primaryColor,
                            size: theme.iconTheme.size,
                          ),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item.title,
                                style: theme.textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                item.subtitle,
                                style: theme.textTheme.bodyMedium,
                              ),
                            ],
                          ),
                        ),
                        Icon(
                          Icons.chevron_right,
                          color: theme.textTheme.bodySmall?.color?.withOpacity(0.7),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}

class SettingItem {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  SettingItem({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });
}

class NotificationSettingsScreen extends StatefulWidget {
  @override
  _NotificationSettingsScreenState createState() => _NotificationSettingsScreenState();
}

class _NotificationSettingsScreenState extends State<NotificationSettingsScreen> {
  bool tamperAlerts = true;
  bool doorbellNotifications = true;
  bool doorStatusChanges = true;
  bool lowBatteryAlerts = true;
  bool soundEnabled = true;
  bool vibrationEnabled = true;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: theme.textTheme.titleLarge?.color),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text("Notification Settings", style: theme.textTheme.titleLarge),
      ),
      body: SingleChildScrollView(
        child: ListView(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          children: [
            _buildNotificationTile(
              title: "Tamper Alerts",
              subtitle: "Get notified about unauthorized access attempts",
              value: tamperAlerts,
              onChanged: (value) => setState(() => tamperAlerts = value),
            ),
            _buildNotificationTile(
              title: "Doorbell Notifications",
              subtitle: "Receive alerts when someone rings the doorbell",
              value: doorbellNotifications,
              onChanged: (value) => setState(() => doorbellNotifications = value),
            ),
            _buildNotificationTile(
              title: "Door Status Changes",
              subtitle: "Get notified when the door is locked or unlocked",
              value: doorStatusChanges,
              onChanged: (value) => setState(() => doorStatusChanges = value),
            ),
            _buildNotificationTile(
              title: "Low Battery Alerts",
              subtitle: "Receive notifications when battery is low",
              value: lowBatteryAlerts,
              onChanged: (value) => setState(() => lowBatteryAlerts = value),
            ),
            Divider(color: theme.dividerColor),
            _buildNotificationTile(
              title: "Sound",
              subtitle: "Play sound for notifications",
              value: soundEnabled,
              onChanged: (value) => setState(() => soundEnabled = value),
            ),
            _buildNotificationTile(
              title: "Vibration",
              subtitle: "Vibrate for notifications",
              value: vibrationEnabled,
              onChanged: (value) => setState(() => vibrationEnabled = value),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNotificationTile({
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        final theme = Theme.of(context);
        return ListTile(
          title: Text(title, style: theme.textTheme.titleLarge),
          subtitle: Text(subtitle, style: theme.textTheme.bodyMedium),
          trailing: Switch(
            value: value,
            onChanged: onChanged,
            activeColor: themeProvider.accentColor,
          ),
        );
      },
    );
  }
}

class SecuritySettingsScreen extends StatefulWidget {
  @override
  _SecuritySettingsScreenState createState() => _SecuritySettingsScreenState();
}

class _SecuritySettingsScreenState extends State<SecuritySettingsScreen> {
  bool biometricEnabled = true;
  bool autoLockEnabled = true;
  int autoLockDelay = 30; // seconds
  bool tamperDetectionEnabled = true;
  bool motionDetectionEnabled = true;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: theme.textTheme.titleLarge?.color),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text("Security Settings", style: theme.textTheme.titleLarge),
      ),
      body: SingleChildScrollView(
        child: ListView(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          children: [
            _buildSecurityTile(
              title: "Biometric Authentication",
              subtitle: "Use fingerprint or face recognition",
              value: biometricEnabled,
              onChanged: (value) => setState(() => biometricEnabled = value),
            ),
            _buildSecurityTile(
              title: "Auto-Lock",
              subtitle: "Automatically lock after inactivity",
              value: autoLockEnabled,
              onChanged: (value) => setState(() => autoLockEnabled = value),
            ),
            if (autoLockEnabled)
              ListTile(
                title: Text("Auto-Lock Delay", style: theme.textTheme.titleLarge),
                subtitle: Slider(
                  value: autoLockDelay.toDouble(),
                  min: 5,
                  max: 300,
                  divisions: 59,
                  label: "$autoLockDelay seconds",
                  onChanged: (value) => setState(() => autoLockDelay = value.round()),
                ),
              ),
            _buildSecurityTile(
              title: "Tamper Detection",
              subtitle: "Detect and alert unauthorized access attempts",
              value: tamperDetectionEnabled,
              onChanged: (value) => setState(() => tamperDetectionEnabled = value),
            ),
            _buildSecurityTile(
              title: "Motion Detection",
              subtitle: "Detect movement near the door",
              value: motionDetectionEnabled,
              onChanged: (value) => setState(() => motionDetectionEnabled = value),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSecurityTile({
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        final theme = Theme.of(context);
        return ListTile(
          title: Text(title, style: theme.textTheme.titleLarge),
          subtitle: Text(subtitle, style: theme.textTheme.bodyMedium),
          trailing: Switch(
            value: value,
            onChanged: onChanged,
            activeColor: themeProvider.accentColor,
          ),
        );
      },
    );
  }
}

class ConnectedDevicesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text("Connected Devices", style: TextStyle(color: Colors.white)),
      ),
      body: SingleChildScrollView(
        child: ListView(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          children: [
            _buildDeviceTile(
              name: "Front Door Lock",
              status: "Connected",
              battery: 85,
              lastSeen: "2 minutes ago",
            ),
            _buildDeviceTile(
              name: "Back Door Lock",
              status: "Connected",
              battery: 45,
              lastSeen: "5 minutes ago",
            ),
            _buildDeviceTile(
              name: "Garage Door",
              status: "Disconnected",
              battery: 0,
              lastSeen: "1 hour ago",
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add new device logic
        },
        backgroundColor: Colors.redAccent,
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _buildDeviceTile({
    required String name,
    required String status,
    required int battery,
    required String lastSeen,
  }) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      color: Colors.black87,
      child: ListTile(
        leading: Icon(
          status == "Connected" ? Icons.lock : Icons.lock_open,
          color: status == "Connected" ? Colors.green : Colors.red,
        ),
        title: Text(name, style: TextStyle(color: Colors.white)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Status: $status",
              style: TextStyle(color: Colors.white70),
            ),
            Text(
              "Battery: $battery%",
              style: TextStyle(color: Colors.white70),
            ),
            Text(
              "Last seen: $lastSeen",
              style: TextStyle(color: Colors.white60),
            ),
          ],
        ),
        trailing: IconButton(
          icon: Icon(Icons.settings, color: Colors.white70),
          onPressed: () {
            // Device settings logic
          },
        ),
      ),
    );
  }
}

class HelpSupportScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final iconSize = theme.iconTheme.size ?? 24.0;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Container(
              padding: EdgeInsets.all(16),
              child: Row(
                children: [
                  Text(
                    "Help & Support",
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 28,
                    ),
                  ),
                ],
              ),
            ),

            // Help & Support List
            Expanded(
              child: ListView(
                padding: EdgeInsets.symmetric(horizontal: 16),
                children: [
                  _buildHelpItem(
                    theme,
                    icon: Icons.book,
                    title: "User Guide",
                    subtitle: "Learn how to use the app",
                    onTap: () {
                      // Open user guide
                    },
                  ),
                  _buildHelpItem(
                    theme,
                    icon: Icons.help_outline,
                    title: "FAQ",
                    subtitle: "Frequently asked questions",
                    onTap: () {
                      // Open FAQ
                    },
                  ),
                  _buildHelpItem(
                    theme,
                    icon: Icons.support_agent,
                    title: "Contact Support",
                    subtitle: "Get help from our support team",
                    onTap: () {
                      // Open support contact
                    },
                  ),
                  _buildHelpItem(
                    theme,
                    icon: Icons.bug_report,
                    title: "Report Issue",
                    subtitle: "Report a bug or problem",
                    onTap: () {
                      // Open bug report form
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHelpItem(
    ThemeData theme, {
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: theme.scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: onTap,
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: theme.primaryColor.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    icon,
                    color: theme.primaryColor,
                    size: theme.iconTheme.size,
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        subtitle,
                        style: theme.textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.chevron_right,
                  color: theme.textTheme.bodySmall?.color?.withOpacity(0.7),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AboutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final iconSize = theme.iconTheme.size ?? 24.0;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Container(
              padding: EdgeInsets.all(16),
              child: Row(
                children: [
                  Text(
                    "About",
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 28,
                    ),
                  ),
                ],
              ),
            ),

            // About Content
            Expanded(
              child: ListView(
                padding: EdgeInsets.symmetric(horizontal: 16),
                children: [
                  // App Icon
                  Center(
                    child: Icon(
                      Icons.lock,
                      size: 80,
                      color: theme.primaryColor,
                    ),
                  ),
                  SizedBox(height: 24),

                  // App Name
                  Center(
                    child: Text(
                      "AmpLock",
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 8),

                  // App Version
                  Center(
                    child: Text(
                      "Version 1.0.0",
                      style: theme.textTheme.bodyMedium,
                    ),
                  ),
                  SizedBox(height: 32),

                  // Terms of Service
                  _buildAboutItem(
                    theme,
                    title: "Terms of Service",
                    onTap: () {
                      // Open terms of service
                    },
                  ),
                  SizedBox(height: 12),

                  // Privacy Policy
                  _buildAboutItem(
                    theme,
                    title: "Privacy Policy",
                    onTap: () {
                      // Open privacy policy
                    },
                  ),
                  SizedBox(height: 12),

                  // Open Source Licenses
                  _buildAboutItem(
                    theme,
                    title: "Open Source Licenses",
                    onTap: () {
                      // Open licenses
                    },
                  ),
                  SizedBox(height: 32),

                  // Copyright
                  Center(
                    child: Text(
                      "© 2024 Smart Lock App. All rights reserved.",
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.textTheme.bodySmall?.color?.withOpacity(0.7),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAboutItem(
    ThemeData theme, {
    required String title,
    required VoidCallback onTap,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: theme.scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: onTap,
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Icon(
                  Icons.chevron_right,
                  color: theme.textTheme.bodySmall?.color?.withOpacity(0.7),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CustomPageRoute extends PageRouteBuilder {
  final Widget child;

  CustomPageRoute({required this.child})
      : super(
          pageBuilder: (context, animation, secondaryAnimation) => child,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(1.0, 0.0);
            const end = Offset.zero;
            const curve = Curves.easeInOut;
            var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
            var offsetAnimation = animation.drive(tween);

            return SlideTransition(
              position: offsetAnimation,
              child: child,
            );
          },
          transitionDuration: Duration(milliseconds: 300),
        );
}
