import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:penstore/controller/wishlist/wishlist_controller.dart';

void showDeleteConfirmationDialog(
    BuildContext context, String wishlistId, VoidCallback onConfirm) {
  final WishlistController wishlistController = Get.put(WishlistController());

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Confirm Delete'),
        content:
            const Text('Are you sure you want to delete this wishlist item?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              onConfirm();
              //reload data
              await wishlistController.getAllWishlist();
              Navigator.of(context).pop(); // Close the dialog
            },
            child: const Text('Delete'),
          ),
        ],
      );
    },
  );
}
