import 'package:card_loading/card_loading.dart';
import 'package:flutter/material.dart';

class SklProductCard extends StatelessWidget {
  const SklProductCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CardLoading(
          height: 150,
          borderRadius: BorderRadius.circular(20),
        ),
        const SizedBox(
          height: 10,
        ),
        CardLoading(
          width: 120,
          height: 16,
          borderRadius: BorderRadius.circular(20),
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          children: [
            const Padding(
                padding: EdgeInsets.only(right: 2),
                child: Text(
                  '\$',
                  style: TextStyle(color: Colors.grey),
                )),
            CardLoading(
              width: 100,
              height: 16,
              borderRadius: BorderRadius.circular(20),
            ),
          ],
        )
      ],
    );
  }
}
