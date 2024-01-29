import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youtube_clone/logic/services/theme_notifier.dart';

class FilterButton extends ConsumerWidget {
  final Widget item;
  final String id;
  final bool isFirst;
  final bool isSelected;
  final int index;
  final int selectedPosition;
  final ValueChanged<int> onTap;
  final double width;
  final Color? color;

  const FilterButton({
    super.key,
    required this.item,
    required this.index,
    required this.id,
    required this.selectedPosition,
    required this.onTap,
    this.isSelected = false,
    this.isFirst = false,
    this.width = 100,
    this.color,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkTheme = ref.watch(themeNP);

    return UnconstrainedBox(
      child: InkWell(
        customBorder: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
          side: const BorderSide(width: 0.8),
        ),
        onTap: () {
          if (index == selectedPosition && index != 0) return;

          onTap.call(index);
        },
        child: Container(
          padding: !isFirst ? const EdgeInsets.all(13) : const EdgeInsets.all(8),
          constraints: const BoxConstraints(maxWidth: 200),
          decoration: BoxDecoration(
            color: isDarkTheme
                ? selectedPosition == index && !isFirst
                    ? Colors.white
                    : Colors.white24
                : selectedPosition == index && !isFirst
                    ? Colors.grey.shade600
                    : Colors.grey.shade300,
            borderRadius: !isFirst ? BorderRadius.circular(30) : BorderRadius.circular(12),
            border: Border.all(
              color: isDarkTheme ? Colors.white70 : Colors.black,
              width: 0.8,
            ),
          ),
          child: FittedBox(
            fit: BoxFit.cover,
            child: Center(child: item),
          ),
        ),
      ),
    );
  }
}
