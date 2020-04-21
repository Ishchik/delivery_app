import 'package:flutter/material.dart';

class OrderCard extends StatelessWidget {
  final int orderID;
  final String orderDate;
  final String orderAddress;
  final int totalPrice;
  final List orderList;

  OrderCard(
      {this.orderID,
      this.orderDate,
      this.orderAddress,
      this.orderList,
      this.totalPrice});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      child: Card(
        elevation: 4,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Expanded(
              flex: 2,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Order $orderID',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Order Date:',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      orderDate,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black54,
                      ),
                    ),
                    Text(
                      'Order Address:',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      orderAddress,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 70,
              child: VerticalDivider(
                indent: 10,
                endIndent: 10,
                thickness: 2,
                color: Colors.grey,
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black54),
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.blueGrey[50],
                      ),
                      height: MediaQuery.of(context).size.height / 6,
                      child: ListView.builder(
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.all(5),
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black54),
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.white,
                              ),
                              child: ListTile(
                                title: Text(
//                                  'some soup(1)',
                                  '${orderList[index]['name']} (${orderList[index]['quantity']})',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                subtitle: Text(
                                    'Total price: ${orderList[index]['price']}'),
//                                    'total price 100'),
                              ),
                            ),
                          );
                        },
                        itemCount: orderList.length,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Total price: $totalPrice',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
