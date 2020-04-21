import 'package:flutter/material.dart';

class UserInfoListTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final String trailing;
  final Widget child;

  UserInfoListTile({this.title, this.subtitle, this.trailing, this.child});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            trailing,
            style: TextStyle(
              fontSize: 22,
            ),
          ),
        ],
      ),
      subtitle: Text(subtitle),
      onTap: () async {
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
    );
  }
}
