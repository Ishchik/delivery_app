import 'package:delivery_app/models/firestore_product_data.dart';
import 'package:delivery_app/models/new_order_data.dart';
import 'package:flutter/material.dart';
import 'welcome_screen.dart';
import 'package:delivery_app/widgets/common_widgets/card_button.dart';
import 'package:provider/provider.dart';
import 'package:delivery_app/models/user_data.dart';
import 'package:delivery_app/widgets/common_widgets/info_list_tile.dart';
import 'package:delivery_app/widgets/common_widgets/small_bottom_sheet_container.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            InfoListTile(
              title: Provider.of<UserData>(context).userName,
              subtitle: 'Name',
              child: SmallBottomSheetContainer(
                hintText: 'Enter new name',
                onPressed: (value) async {
                  Provider.of<UserData>(context, listen: false)
                      .changeName(value);
                },
              ),
            ),
            InfoListTile(
              title: Provider.of<UserData>(context).userDefaultAddress != null
                  ? Provider.of<UserData>(context).userDefaultAddress
                  : 'Not set up yet',
              subtitle: 'Address',
              child: SmallBottomSheetContainer(
                hintText: 'Enter new address',
                onPressed: (value) async {
                  Provider.of<UserData>(context, listen: false)
                      .changeAddress(value);
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                CardButton(
                  onPressed: () async {
                    await Provider.of<UserData>(context, listen: false)
                        .resetPassword();
                  },
                  text: 'Reset password',
                ),
                CardButton(
                  onPressed: () async {
                    Provider.of<NewOrderData>(context, listen: false)
                        .clearOrder();
                    Provider.of<FirestoreProductData>(context, listen: false)
                        .clearProducts();
                    await Provider.of<UserData>(context, listen: false)
                        .signOut();
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => WelcomeScreen()),
                      (Route<dynamic> route) => false,
                    );
                  },
                  text: 'Sign out',
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
