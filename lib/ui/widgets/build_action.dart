// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youtube_clone/logic/services/theme_notifier.dart';

class BuildAction extends ConsumerWidget {
  final IconData icon;
  final String label;
  final bool isInfoSection;
  final VoidCallback? onTap;

  const BuildAction(
    this.icon,
    this.label, {
    super.key,
    this.isInfoSection = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkTheme = ref.watch(themeNP);

    return Material(
      child: InkWell(
        onTap: onTap,
        borderRadius: const BorderRadius.all(
          Radius.circular(60),
        ),
        child: !isInfoSection
            // this is for the handle more vert pressed
            ? Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 9,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(icon, size: 28),
                    const SizedBox(width: 15),
                    Text(
                      label,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: isDarkTheme ? Colors.white : Colors.black,
                            fontSize: 16,
                          ),
                    ),
                  ],
                ),
              )
            // this is for info
            : Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(icon),
                  const SizedBox(height: 6),
                  Text(
                    label,
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.white),
                  ),
                ],
              ),
      ),
    );
  }
}
