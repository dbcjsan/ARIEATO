import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class User {
  final String id;
  final String name;
  final String email;
  final String role;
  final String status;
  final DateTime joinDate;
  final String avatarUrl;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    required this.status,
    required this.joinDate,
    required this.avatarUrl,
  });
}

class UserTableWidget extends StatefulWidget {
  final List<User> users;
  final Function(User)? onUserTap;
  final Function(User)? onEdit;
  final Function(User)? onDelete;

  const UserTableWidget({
    super.key,
    required this.users,
    this.onUserTap,
    this.onEdit,
    this.onDelete,
  });

  @override
  State<UserTableWidget> createState() => _UserTableWidgetState();
}

class _UserTableWidgetState extends State<UserTableWidget> {
  String _searchQuery = '';
  String _sortBy = 'name';
  bool _sortAscending = true;
  int _currentPage = 0;
  static const int _itemsPerPage = 10;

  @override
  Widget build(BuildContext context) {
    final filteredUsers = _filterUsers(widget.users);
    final sortedUsers = _sortUsers(filteredUsers);
    final paginatedUsers = _paginateUsers(sortedUsers);

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            const SizedBox(height: 16),
            _buildTable(paginatedUsers),
            const SizedBox(height: 16),
            _buildPagination(sortedUsers.length),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        Expanded(
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Search users...',
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            ),
            onChanged: (value) {
              setState(() {
                _searchQuery = value.toLowerCase();
                _currentPage = 0;
              });
            },
          ),
        ),
        const SizedBox(width: 16),
        DropdownButton<String>(
          value: _sortBy,
          hint: const Text('Sort by'),
          items: const [
            DropdownMenuItem(value: 'name', child: Text('Name')),
            DropdownMenuItem(value: 'email', child: Text('Email')),
            DropdownMenuItem(value: 'role', child: Text('Role')),
            DropdownMenuItem(value: 'joinDate', child: Text('Join Date')),
          ],
          onChanged: (value) {
            if (value != null) {
              setState(() {
                _sortBy = value;
                _currentPage = 0;
              });
            }
          },
        ),
        IconButton(
          icon: Icon(
            _sortAscending ? Icons.arrow_upward : Icons.arrow_downward,
          ),
          onPressed: () {
            setState(() {
              _sortAscending = !_sortAscending;
            });
          },
        ),
      ],
    );
  }

  Widget _buildTable(List<User> users) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 600;
        
        if (isMobile) {
          return _buildMobileTable(users);
        } else {
          return _buildDesktopTable(users);
        }
      },
    );
  }

  Widget _buildDesktopTable(List<User> users) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columnSpacing: 20,
        columns: const [
          DataColumn(label: Text('User')),
          DataColumn(label: Text('Email')),
          DataColumn(label: Text('Role')),
          DataColumn(label: Text('Status')),
          DataColumn(label: Text('Join Date')),
          DataColumn(label: Text('Actions')),
        ],
        rows: users.map((user) => _buildDataRow(user)).toList(),
      ),
    );
  }

  Widget _buildMobileTable(List<User> users) {
    return Column(
      children: users.map((user) => _buildMobileUserCard(user)).toList(),
    );
  }

  Widget _buildMobileUserCard(User user) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: NetworkImage(user.avatarUrl),
          radius: 20,
        ),
        title: Text(user.name),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(user.email),
            const SizedBox(height: 4),
            Row(
              children: [
                _buildStatusChip(user.status),
                const SizedBox(width: 8),
                Text(user.role, style: const TextStyle(fontSize: 12)),
              ],
            ),
          ],
        ),
        trailing: PopupMenuButton<String>(
          itemBuilder: (context) => [
            const PopupMenuItem(
              value: 'edit',
              child: ListTile(
                leading: Icon(Icons.edit, size: 20),
                title: Text('Edit'),
                dense: true,
                contentPadding: EdgeInsets.zero,
              ),
            ),
            const PopupMenuItem(
              value: 'delete',
              child: ListTile(
                leading: Icon(Icons.delete, color: Colors.red, size: 20),
                title: Text('Delete', style: TextStyle(color: Colors.red)),
                dense: true,
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ],
          onSelected: (value) {
            switch (value) {
              case 'edit':
                widget.onEdit?.call(user);
                break;
              case 'delete':
                widget.onDelete?.call(user);
                break;
            }
          },
        ),
        onTap: () => widget.onUserTap?.call(user),
      ),
    );
  }

  DataRow _buildDataRow(User user) {
    return DataRow(
      cells: [
        DataCell(
          Row(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(user.avatarUrl),
                radius: 16,
              ),
              const SizedBox(width: 8),
              Text(user.name),
            ],
          ),
        ),
        DataCell(Text(user.email)),
        DataCell(Text(user.role)),
        DataCell(_buildStatusChip(user.status)),
        DataCell(Text(_formatDate(user.joinDate))),
        DataCell(
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.edit, size: 18),
                onPressed: () => widget.onEdit?.call(user),
              ),
              IconButton(
                icon: const Icon(Icons.delete, color: Colors.red, size: 18),
                onPressed: () => widget.onDelete?.call(user),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStatusChip(String status) {
    Color color;
    String text;

    switch (status.toLowerCase()) {
      case 'active':
        color = Colors.green;
        text = 'Active';
        break;
      case 'inactive':
        color = Colors.orange;
        text = 'Inactive';
        break;
      case 'pending':
        color = Colors.blue;
        text = 'Pending';
        break;
      default:
        color = Colors.grey;
        text = status;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildPagination(int totalItems) {
    final totalPages = (totalItems / _itemsPerPage).ceil();
    if (totalPages <= 1) return const SizedBox.shrink();

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: const Icon(Icons.chevron_left),
          onPressed: _currentPage > 0
              ? () => setState(() => _currentPage--)
              : null,
        ),
        for (int i = 0; i < totalPages; i++)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: TextButton(
              style: TextButton.styleFrom(
                backgroundColor: i == _currentPage
                    ? Theme.of(context).primaryColor
                    : Colors.transparent,
                foregroundColor: i == _currentPage ? Colors.white : null,
                minimumSize: const Size(40, 40),
              ),
              onPressed: () => setState(() => _currentPage = i),
              child: Text('${i + 1}'),
            ),
          ),
        IconButton(
          icon: const Icon(Icons.chevron_right),
          onPressed: _currentPage < totalPages - 1
              ? () => setState(() => _currentPage++)
              : null,
        ),
      ],
    );
  }

  List<User> _filterUsers(List<User> users) {
    if (_searchQuery.isEmpty) return users;
    
    return users.where((user) {
      return user.name.toLowerCase().contains(_searchQuery) ||
             user.email.toLowerCase().contains(_searchQuery) ||
             user.role.toLowerCase().contains(_searchQuery);
    }).toList();
  }

  List<User> _sortUsers(List<User> users) {
    users.sort((a, b) {
      int comparison = 0;
      
      switch (_sortBy) {
        case 'name':
          comparison = a.name.compareTo(b.name);
          break;
        case 'email':
          comparison = a.email.compareTo(b.email);
          break;
        case 'role':
          comparison = a.role.compareTo(b.role);
          break;
        case 'joinDate':
          comparison = a.joinDate.compareTo(b.joinDate);
          break;
      }
      
      return _sortAscending ? comparison : -comparison;
    });
    
    return users;
  }

  List<User> _paginateUsers(List<User> users) {
    final startIndex = _currentPage * _itemsPerPage;
    final endIndex = startIndex + _itemsPerPage;
    
    return users.sublist(
      startIndex.clamp(0, users.length),
      endIndex.clamp(0, users.length),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}