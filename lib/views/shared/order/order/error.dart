import 'package:adret/widgets/empty/index.dart';
import 'package:flutter/material.dart';

class OrderError extends StatelessWidget {
  final Function onRetry;
  const OrderError({
    super.key,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildListDelegate([
        Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height - 400,
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
          ),
          child: EmptyState(
            action: () async {
              onRetry();
            },
            emptyIcon: "assets/icons/warning.svg",
            height: 150,
            actionIcon: "assets/icons/bold/reload.svg",
            actionText: "Retry",
            subText: "Something went wrong and could not fetch orders.",
            topText: "Error Fetching Order",
          ),
        ),
      ]),
    );
  }
}
