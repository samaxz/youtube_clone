import 'package:flutter/material.dart';

class CustomInkWell extends StatelessWidget {
  final Widget child;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;

  const CustomInkWell({
    super.key,
    required this.child,
    this.onTap,
    this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: const BorderRadius.all(
        Radius.circular(72),
      ),
      color: Colors.transparent,
      child: InkWell(
        // this is the white splash border radius
        borderRadius: const BorderRadius.all(
          Radius.circular(72),
        ),
        onTap: onTap,
        onLongPress: onLongPress,
        child: SizedBox(
          width: 72,
          height: 72,
          child: child,
        ),
      ),
    );
  }
}
