import 'package:delivery_app/services/firestore_product_service.dart';
import 'package:delivery_app/services/new_order_service.dart';
import 'package:flutter/material.dart';
import 'welcome_screen.dart';
import 'package:delivery_app/widgets/common_widgets/card_button.dart';
import 'package:provider/provider.dart';
import 'package:delivery_app/services/user_data_service.dart';
import 'package:delivery_app/widgets/common_widgets/info_list_tile.dart';
import 'package:delivery_app/widgets/common_widgets/small_bottom_sheet_container.dart';
import 'package:fluttertoast/fluttertoast.dart';

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
              title: Provider.of<UserDataService>(context).userName,
              subtitle: 'Name',
              child: SmallBottomSheetContainer(
                hintText: 'Enter new name',
                onPressed: (value) async {
                  if (value != null) {
                    Provider.of<UserDataService>(context, listen: false)
                        .changeName(value);
                  }
                },
              ),
            ),
            InfoListTile(
              title: Provider.of<UserDataService>(context)
                      .userDefaultAddress
                      .isNotEmpty
                  ? Provider.of<UserDataService>(context).userDefaultAddress
                  : 'Not set up yet',
              subtitle: 'Address',
              child: SmallBottomSheetContainer(
                hintText: 'Enter new address',
                onPressed: (value) async {
                  if (value != null) {
                    Provider.of<UserDataService>(context, listen: false)
                        .changeAddress(value);
                  }
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                CardButton(
                  onPressed: () async {
                    Fluttertoast.showToast(
                      msg: 'Reset link has been sent to your email',
                    );
                    await Provider.of<UserDataService>(context, listen: false)
                        .resetPassword();
                  },
                  text: 'Reset password',
                ),
                CardButton(
                  onPressed: () async {
                    Provider.of<NewOrderService>(context, listen: false)
                        .clearOrder();
                    Provider.of<FirestoreProductService>(context, listen: false)
                        .clearProducts();
                    await Provider.of<UserDataService>(context, listen: false)
                        .signOut();
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => WelcomeScreen()),
                      (Route<dynamic> route) => false,
                    );
                  },
                  text: 'Log out',
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
