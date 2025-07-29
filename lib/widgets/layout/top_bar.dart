import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TopBar extends StatefulWidget {
  final VoidCallback? onMenuPressed;
  final String title;
  final bool showMenuButton;

  const TopBar({
    super.key,
    this.onMenuPressed,
    this.title = 'Dashboard',
    this.showMenuButton = false,
  });

  @override
  State<TopBar> createState() => _TopBarState();
}

class _TopBarState extends State<TopBar> {
  bool _isSearching = false;
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          if (widget.showMenuButton) ...[
            IconButton(
              icon: const Icon(Icons.menu),
              onPressed: widget.onMenuPressed,
            ),
            const SizedBox(width: 8),
          ],
          if (!_isSearching) ...[
            Text(
              widget.title,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ],
          if (_isSearching) ...[
            Expanded(
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search...',
                  border: InputBorder.none,
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      setState(() {
                        _isSearching = false;
                        _searchController.clear();
                      });
                    },
                  ),
                ),
                onSubmitted: (value) {
                  // Handle search
                },
              ),
            ),
          ],
          const Spacer(),
          if (!_isSearching) ...[
            _buildSearchButton(),
            const SizedBox(width: 8),
            _buildNotificationButton(),
            const SizedBox(width: 8),
            _buildProfileDropdown(),
          ],
        ],
      ),
    );
  }

  Widget _buildSearchButton() {
    return IconButton(
      icon: const Icon(Icons.search),
      onPressed: () {
        setState(() {
          _isSearching = true;
        });
      },
    );
  }

  Widget _buildNotificationButton() {
    return Stack(
      children: [
        IconButton(
          icon: const Icon(Icons.notifications_outlined),
          onPressed: () {
            _showNotifications(context);
          },
        ),
        Positioned(
          right: 8,
          top: 8,
          child: Container(
            width: 8,
            height: 8,
            decoration: const BoxDecoration(
              color: Colors.red,
              shape: BoxShape.circle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildProfileDropdown() {
    return PopupMenuButton<String>(
      offset: const Offset(0, 50),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      itemBuilder: (context) => [
        PopupMenuItem(
          value: 'profile',
          child: ListTile(
            leading: const Icon(Icons.person_outline),
            title: const Text('Profile'),
            dense: true,
            contentPadding: EdgeInsets.zero,
          ),
        ),
        PopupMenuItem(
          value: 'settings',
          child: ListTile(
            leading: const Icon(Icons.settings_outlined),
            title: const Text('Settings'),
            dense: true,
            contentPadding: EdgeInsets.zero,
          ),
        ),
        const PopupMenuDivider(),
        PopupMenuItem(
          value: 'logout',
          child: ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: const Text('Logout', style: TextStyle(color: Colors.red)),
            dense: true,
            contentPadding: EdgeInsets.zero,
          ),
        ),
      ],
      child: const Row(
        children: [
          CircleAvatar(
            radius: 16,
            backgroundImage: NetworkImage(
              'https://via.placeholder.com/32x32',
            ),
          ),
          SizedBox(width: 8),
          Icon(Icons.arrow_drop_down, size: 20),
        ],
      ),
    );
  }

  void _showNotifications(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Notifications'),
        content: SizedBox(
          width: 400,
          child: ListView(
            shrinkWrap: true,
            children: [
              _NotificationItem(
                title: 'New user registered',
                message: 'John Doe just created an account',
                time: '2 min ago',
                icon: Icons.person_add,
                color: Colors.green,
              ),
              _NotificationItem(
                title: 'New order received',
                message: 'Order #1234 has been placed',
                time: '5 min ago',
                icon: Icons.shopping_cart,
                color: Colors.blue,
              ),
              _NotificationItem(
                title: 'System update',
                message: 'Dashboard updated successfully',
                time: '1 hour ago',
                icon: Icons.system_update,
                color: Colors.orange,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
          TextButton(
            onPressed: () {
              // Mark all as read
              Navigator.pop(context);
            },
            child: const Text('Mark all read'),
          ),
        ],
      ),
    );
  }
}

class _NotificationItem extends StatelessWidget {
  final String title;
  final String message;
  final String time;
  final IconData icon;
  final Color color;

  const _NotificationItem({
    required this.title,
    required this.message,
    required this.time,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: color.withOpacity(0.1),
        child: Icon(icon, color: color, size: 20),
      ),
      title: Text(title, style: const TextStyle(fontSize: 14)),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(message, style: const TextStyle(fontSize: 12)),
          Text(time, style: const TextStyle(fontSize: 11, color: Colors.grey)),
        ],
      ),
      contentPadding: const EdgeInsets.symmetric(vertical: 8),
    );
  }
}