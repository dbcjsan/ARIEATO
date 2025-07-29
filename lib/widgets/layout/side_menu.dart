import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class SideMenu extends StatefulWidget {
  final bool isCollapsed;
  final ValueChanged<bool>? onToggle;
  final Function(int)? onItemSelected;
  final int selectedIndex;

  const SideMenu({
    super.key,
    this.isCollapsed = false,
    this.onToggle,
    this.onItemSelected,
    this.selectedIndex = 0,
  });

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: widget.isCollapsed ? 70 : 250,
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(16),
          bottomRight: Radius.circular(16),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(2, 0),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildHeader(),
          const Divider(height: 1),
          _buildMenuItems(),
          const Spacer(),
          const Divider(height: 1),
          _buildFooter(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (!widget.isCollapsed) ...[
            const Text(
              'Dashboard',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
          IconButton(
            icon: Icon(
              widget.isCollapsed
                  ? Icons.menu_open
                  : Icons.menu_open_outlined,
            ),
            onPressed: () {
              widget.onToggle?.call(!widget.isCollapsed);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItems() {
    final menuItems = [
      {'icon': FontAwesomeIcons.house, 'title': 'Dashboard', 'route': 0},
      {'icon': FontAwesomeIcons.chartLine, 'title': 'Analytics', 'route': 1},
      {'icon': FontAwesomeIcons.users, 'title': 'Users', 'route': 2},
      {'icon': FontAwesomeIcons.cartShopping, 'title': 'Orders', 'route': 3},
      {'icon': FontAwesomeIcons.gear, 'title': 'Settings', 'route': 4},
    ];

    return Expanded(
      child: ListView.builder(
        padding: EdgeInsets.zero,
        itemCount: menuItems.length,
        itemBuilder: (context, index) {
          final item = menuItems[index];
          final isSelected = widget.selectedIndex == index;

          return _MenuItem(
            icon: item['icon'] as IconData,
            title: item['title'] as String,
            isSelected: isSelected,
            isCollapsed: widget.isCollapsed,
            onTap: () {
              widget.onItemSelected?.call(index);
            },
          );
        },
      ),
    );
  }

  Widget _buildFooter() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          _UserProfileSection(isCollapsed: widget.isCollapsed),
          const SizedBox(height: 8),
          _LogoutButton(isCollapsed: widget.isCollapsed),
        ],
      ),
    );
  }
}

class _MenuItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final bool isSelected;
  final bool isCollapsed;
  final VoidCallback? onTap;

  const _MenuItem({
    required this.icon,
    required this.title,
    this.isSelected = false,
    this.isCollapsed = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          decoration: BoxDecoration(
            color: isSelected
                ? Theme.of(context).primaryColor.withOpacity(0.1)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              Icon(
                icon,
                size: 20,
                color: isSelected
                    ? Theme.of(context).primaryColor
                    : Theme.of(context).textTheme.bodyMedium?.color,
              ),
              if (!isCollapsed) ...[
                const SizedBox(width: 12),
                Text(
                  title,
                  style: TextStyle(
                    color: isSelected
                        ? Theme.of(context).primaryColor
                        : Theme.of(context).textTheme.bodyMedium?.color,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _UserProfileSection extends StatelessWidget {
  final bool isCollapsed;

  const _UserProfileSection({required this.isCollapsed});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const CircleAvatar(
          radius: 16,
          backgroundImage: NetworkImage(
            'https://via.placeholder.com/32x32',
          ),
        ),
        if (!isCollapsed) ...[
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Admin User',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  'admin@example.com',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontSize: 10,
                        color: Theme.of(context).textTheme.bodySmall?.color
                            ?.withOpacity(0.7),
                      ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }
}

class _LogoutButton extends StatelessWidget {
  final bool isCollapsed;

  const _LogoutButton({required this.isCollapsed});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: () {
          // Handle logout
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Row(
            children: [
              const Icon(Icons.logout, size: 20, color: Colors.red),
              if (!isCollapsed) ...[
                const SizedBox(width: 12),
                const Text(
                  'Logout',
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}