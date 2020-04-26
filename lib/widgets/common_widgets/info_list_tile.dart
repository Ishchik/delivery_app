import 'package:flutter/material.dart';

class InfoListTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final Widget child;

  InfoListTile({this.title, this.subtitle, this.child});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        isThreeLine: false,
        title: Text(
          title,
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle:
            subtitle != null ? Text(subtitle) : Text('Tap on icon to edit'),
        trailing: IconButton(
          icon: Icon(Icons.edit),
          onPressed: () {
            showModalBottomSheet(
              isScrollControlled: true,
              context: context,
              builder: (context) {
                return SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom),
                    child: child,
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
