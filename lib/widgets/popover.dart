import 'package:flutter/material.dart';

// ignore: must_be_immutable
// * this is used for comments section handler in helper
class Popover extends StatelessWidget {
  final Widget child;
  final double? height;
  final bool isCommentsSection;

  const Popover({
    super.key,
    required this.child,
    this.height,
    this.isCommentsSection = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: !isCommentsSection ? const EdgeInsets.all(30) : EdgeInsets.zero,
      child: Container(
        clipBehavior: Clip.antiAlias,
        height: height,
        decoration: BoxDecoration(
          color: theme.cardColor,
          borderRadius: !isCommentsSection
              ? const BorderRadius.all(
                  Radius.circular(16),
                )
              : const BorderRadius.vertical(
                  top: Radius.circular(16),
                ),
        ),
        child: Column(
          mainAxisSize:
              !isCommentsSection ? MainAxisSize.max : MainAxisSize.min,
          children: [
            _buildHandle(context, isCommentsSection),
            child,
          ],
        ),
      ),
    );
  }

  // builds the ios home indicator
  // TODO make this a widget
  Widget _buildHandle(context, isCommentsSection) {
    final theme = Theme.of(context);

    if (!isCommentsSection) {
      return FractionallySizedBox(
        widthFactor: 0.25,
        child: Container(
          margin: const EdgeInsets.only(top: 14, bottom: 5),
          child: Container(
            height: 5,
            decoration: BoxDecoration(
              color: theme.dividerColor,
              borderRadius: const BorderRadius.all(
                Radius.circular(2.5),
              ),
            ),
          ),
        ),
      );
    } else {
      return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Flexible(
            child: FractionallySizedBox(
              widthFactor: 0.25,
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 12),
                child: Container(
                  height: 5,
                  decoration: BoxDecoration(
                    color: theme.dividerColor,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(2.5),
                    ),
                  ),
                ),
              ),
            ),
          ),
          const Spacer(),
          Flexible(
            child: IconButton(
              onPressed: () => Navigator.of(context).pop(),
              icon: const Icon(Icons.clear),
            ),
          ),
        ],
      );
    }
  }
}
