import 'package:adret/widgets/card/orderLoadingCard/index.dart';
import 'package:flutter/material.dart';

class OrderLoading extends StatelessWidget {
  const OrderLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        childCount: 10,
        (context, index) {
          return const Padding(
            padding: EdgeInsets.only(top: 10.0),
            child: OrderLoadingCard(),
          );
        },
      ),
    );
  }
}
