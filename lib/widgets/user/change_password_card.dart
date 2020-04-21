import 'package:flutter/material.dart';
import 'package:delivery_app/widgets/common_widgets/bottom_sheet_container.dart';
import 'package:delivery_app/constants.dart';
import 'package:provider/provider.dart';
import 'package:delivery_app/models/user_data.dart';

class ChangePasswordCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String newName;
    return BottomSheetContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          TextField(
            autofocus: true,
            keyboardType: TextInputType.emailAddress,
            textAlign: TextAlign.center,
            onChanged: (value) {
              newName = value;
            },
            decoration:
                kTextFieldDecoration.copyWith(hintText: 'Enter new name'),
          ),
          FlatButton(
            child: Text('change name'),
            onPressed: () async {
              if (newName != null) {
                await Provider.of<UserData>(context, listen: false)
                    .changeName(newName);
                Navigator.pop(context);
              }
              //TODO: alert about empty name
            },
          )
        ],
      ),
    );
  }
}
