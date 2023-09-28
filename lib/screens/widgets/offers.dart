import 'package:flutter/material.dart';

class OfferText extends StatelessWidget {
  const OfferText({
    super.key,
    required this.text,
    required this.icon,
  });
  final String text;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon),
        SizedBox(
          width: 10,
        ),
        Text(text)
      ],
    );
  }
}