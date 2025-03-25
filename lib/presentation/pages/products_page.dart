import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:iconnect_crm/common/constans.dart';

class ProductsPage extends StatelessWidget {
  const ProductsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(41.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Hello, Pavel', style: TextStyle(fontSize: 25)),
            const SizedBox(height: 20),
            Card(
              margin: EdgeInsets.zero,
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: DynamicColors.greenIconBackgroundColor,
                      radius: 40,
                      child: SvgPicture.asset(
                        'assets/images/profile-2user.svg',
                      ),
                    ),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Всего продаж',
                          style: TextStyle(
                            color: DynamicColors.secondaryTextColor,
                          ),
                        ),
                        Text(
                          '5,423',
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.arrow_upward,
                              color: DynamicColors.greenIconDataColor,
                            ),
                            Text('16%', style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: DynamicColors.greenIconDataColor,
                            ),),
                            Text(' в этом месяце'),
                          ],
                        ),
                      ],
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
