import 'package:flutter/material.dart';
import 'package:iconnect_crm/common/constans.dart';

class ProductsPage extends StatelessWidget {
  const ProductsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(41.0),
        child: Column(
          children: [
            Text('Hello, Pavel', style: TextStyle(fontSize: 25)),
            Card(
              //TODO: Убрать отсюда color
              color: Colors.white,
              elevation: 0,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: DynamicColors().greenIconBackgroundColor,
                      child: Icon(
                        Icons.cancel,
                        color: DynamicColors().greenIconDataColor,
                      ),
                    )
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
