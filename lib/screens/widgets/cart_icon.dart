import 'package:flutter/material.dart';

class CartIcon extends StatelessWidget {
  CartIcon({
    super.key,
    required this.icon,
    required this.onPressed,
  });
  void Function()? onPressed;
  final Icon icon;

  @override
  Widget build(BuildContext context) {
    return Ink(
      decoration: const ShapeDecoration(
        color: Colors.white,
        shape: CircleBorder(),
      ),
      child: IconButton(onPressed: onPressed, icon: icon,
      color: Colors.black,),
    );
  }
}
