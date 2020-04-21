import 'package:flutter/material.dart';
import 'package:delivery_app/widgets/product/product_item.dart';
import 'package:delivery_app/widgets/common_widgets/top_bar_button.dart';
import 'package:delivery_app/widgets/common_widgets/top_bar.dart';

class AdminPanelScreen extends StatefulWidget {
  @override
  _AdminPanelScreenState createState() => _AdminPanelScreenState();
}

class _AdminPanelScreenState extends State<AdminPanelScreen> {
  int _currentIndex = 0;

  List<bool> buttonStates = [true, false, false];

  void checkActive(currentIndex) {
    if (currentIndex == 0) {
      buttonStates[0] = true;
      buttonStates[1] = false;
      buttonStates[2] = false;
    } else if (currentIndex == 1) {
      buttonStates[0] = false;
      buttonStates[1] = true;
      buttonStates[2] = false;
    } else if (currentIndex == 2) {
      buttonStates[0] = false;
      buttonStates[1] = false;
      buttonStates[2] = true;
    }
  }

  void setIndex(index) {
    setState(() {
      _currentIndex = index;
      checkActive(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            TopBar(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  TopBarButton(
                    title: 'Soups',
                    onPressed: () {
                      setIndex(0);
                    },
                    isActive: buttonStates[0],
                  ),
                  TopBarButton(
                    title: 'Main Dishes',
                    onPressed: () {
                      setIndex(1);
                    },
                    isActive: buttonStates[1],
                  ),
                  TopBarButton(
                    title: 'Drinks',
                    onPressed: () {
                      setIndex(2);
                    },
                    isActive: buttonStates[2],
                  ),
                ],
              ),
            ),
            Expanded(
              child: Text('admin'),
            ),
          ],
        ),
      ),
    );
  }
}
