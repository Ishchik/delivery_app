import 'package:flutter/material.dart';
import 'package:delivery_app/widgets/common_widgets/bottom_sheet_container.dart';
import 'package:delivery_app/constants.dart';
import 'package:provider/provider.dart';
import 'package:delivery_app/models/user_data.dart';

class ChangeAddressCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String newAddress;
    return BottomSheetContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          TextField(
            autofocus: true,
            keyboardType: TextInputType.emailAddress,
            textAlign: TextAlign.center,
            onChanged: (value) {
              newAddress = value;
            },
            decoration:
                kTextFieldDecoration.copyWith(hintText: 'Enter new address'),
          ),
          FlatButton(
            child: Text('change address'),
            onPressed: () async {
              if (newAddress != null) {
                await Provider.of<UserData>(context, listen: false)
                    .changeAddress(newAddress);
                Navigator.pop(context);
              }
              //TODO: alert about empty address
            },
          )
        ],
      ),
    );
  }
}
