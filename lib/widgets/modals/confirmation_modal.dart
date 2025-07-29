import 'package:flutter/material.dart';

class ConfirmationModal {
  static Future<bool?> show({
    required BuildContext context,
    required String title,
    required String message,
    String confirmText = 'Confirm',
    String cancelText = 'Cancel',
    Color confirmColor = Colors.red,
  }) {
    return showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(cancelText),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: confirmColor,
            ),
            onPressed: () => Navigator.pop(context, true),
            child: Text(confirmText),
          ),
        ],
      ),
    );
  }

  static Future<bool?> showDeleteConfirmation({
    required BuildContext context,
    required String itemName,
  }) {
    return show(
      context: context,
      title: 'Confirm Deletion',
      message: 'Are you sure you want to delete "$itemName"? This action cannot be undone.',
      confirmText: 'Delete',
      confirmColor: Colors.red,
    );
  }

  static Future<bool?> showLogoutConfirmation({
    required BuildContext context,
  }) {
    return show(
      context: context,
      title: 'Confirm Logout',
      message: 'Are you sure you want to log out?',
      confirmText: 'Logout',
      confirmColor: Colors.orange,
    );
  }
}