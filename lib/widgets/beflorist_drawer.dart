import 'package:flutter/material.dart';
import '../pages/home_page.dart';
import '../pages/produk_page.dart';
import '../pages/login_page.dart';
import '../pages/cart_page.dart';
import '../pages/favorite_page.dart';
import '../pages/settings_page.dart';
import '../pages/account_page.dart';
import '../pages/help_page.dart';
import '../models/user.dart';

class BefloristDrawer extends StatefulWidget {
  final int selectedIndex;
  final Function(int) onItemSelected;
  final User currentUser; 

  const BefloristDrawer({
    super.key,
    required this.selectedIndex,
    required this.onItemSelected,
    required this.currentUser,
  });

  @override
  State<BefloristDrawer> createState() => _BefloristDrawerState();
}

class _BefloristDrawerState extends State<BefloristDrawer>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  int? _pressedIndex;

  final List<Map<String, dynamic>> _menuItems = [
    {'icon': Icons.home, 'title': 'Home'},
    {'icon': Icons.local_florist, 'title': 'Product'},
    {'icon': Icons.shopping_cart, 'title': 'Keranjang'},
    {'icon': Icons.favorite, 'title': 'Favorite'},
    {'icon': Icons.settings, 'title': 'Settings'},
    {'icon': Icons.person, 'title': 'Account'},
    {'icon': Icons.help, 'title': 'Help'},
    {'icon': Icons.logout, 'title': 'Logout'},
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _buildMenuItem(int index) {
    bool isActive = widget.selectedIndex == index;
    bool isPressed = _pressedIndex == index;
    bool isLogout = _menuItems[index]['title'] == 'Logout';

    return Column(
      children: [
        if (isLogout)
          Divider(
            color: Colors.grey.shade300,
            thickness: 1,
            height: 12,
          ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 10),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(12),
              splashColor:
                  isLogout ? Colors.red.shade100 : Colors.pink.shade100,
              onTap: () async {
                setState(() {
                  _pressedIndex = index;
                });

                await Future.delayed(const Duration(milliseconds: 200));
                setState(() {
                  _pressedIndex = null;
                });

                Navigator.pop(context);

                Future.delayed(const Duration(milliseconds: 200), () {
                  switch (_menuItems[index]['title']) {
                    case 'Home':
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              HomePage(currentUser: widget.currentUser),
                        ),
                      );
                      break;
                    case 'Product':
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              ProdukPage(currentUser: widget.currentUser),
                        ),
                      );
                      break;
                    case 'Keranjang':
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              CartPage(currentUser: widget.currentUser),
                        ),
                      );
                      break;
                    case 'Favorite':
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              FavoritePage(currentUser: widget.currentUser),
                        ),
                      );
                      break;
                    case 'Settings':
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              SettingPage(currentUser: widget.currentUser),
                        ),
                      );
                      break;
                    case 'Account':
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              AccountPage(currentUser: widget.currentUser),
                        ),
                      );
                      break;
                    case 'Help':
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              HelpPage(currentUser: widget.currentUser),
                        ),
                      );
                      break;
                    case 'Logout':
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginPage()),
                        (route) => false,
                      );
                      break;
                  }
                });

                widget.onItemSelected(index);
              },
              child: AnimatedScale(
                scale: isPressed ? 0.95 : 1.0,
                duration: const Duration(milliseconds: 150),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  curve: Curves.easeInOut,
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                  decoration: BoxDecoration(
                    color: isActive && !isLogout
                        ? const Color.fromRGBO(255, 182, 193, 1)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        _menuItems[index]['icon'],
                        size: 22,
                        color: isLogout
                            ? Colors.red
                            : (isActive
                                ? Colors.pink.shade700
                                : Colors.grey.shade700),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        _menuItems[index]['title'],
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: isActive && !isLogout
                              ? FontWeight.bold
                              : FontWeight.normal,
                          color: isLogout
                              ? Colors.red
                              : (isActive
                                  ? Colors.pink.shade700
                                  : Colors.grey.shade800),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(-1.0, 0.0),
        end: Offset.zero,
      ).animate(_animation),
      child: Drawer(
        child: Container(
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.pink.shade50,
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 28,
                      backgroundColor: Colors.white,
                      child: ClipOval(
                        child: Image.asset(
                          'assets/images/beflorist_logo.png',
                          fit: BoxFit.cover,
                          width: 56,
                          height: 56,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      "Hai, ${widget.currentUser.username}",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.pink.shade700,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: _menuItems.length,
                  itemBuilder: (context, index) => _buildMenuItem(index),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
