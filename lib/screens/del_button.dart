import 'package:flutter/material.dart';

class DeleteConfirmationButton extends StatelessWidget {
  final VoidCallback onPressed;
  
  DeleteConfirmationButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.delete),
      onPressed: () {
        _showDeleteConfirmationDialog(context);
      },
    );
  }

  Future<void> _showDeleteConfirmationDialog(BuildContext context) async {
    bool deleteConfirmed = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Confirm Deletion"),
          content: Text("Are you sure you want to delete?"),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false); // Return false if deletion is not confirmed
              },
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true); // Return true if deletion is confirmed
              },
              child: Text("Delete"),
            ),
          ],
        );
      },
    );

    if (deleteConfirmed != null && deleteConfirmed) {
      // If deletion is confirmed, call the onPressed callback
      onPressed();
    }
  }
}
