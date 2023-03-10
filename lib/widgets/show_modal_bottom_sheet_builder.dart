import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youtube_demo/services/common/theme_notifier.dart';

class ShowModalBottomSheetBuilder extends ConsumerWidget {
  final List<Widget> actions;
  final bool isAddContentButton;
  final bool enableHomeIndicator;
  final bool enableExit;

  const ShowModalBottomSheetBuilder({
    super.key,
    required this.actions,
    this.isAddContentButton = false,
    this.enableHomeIndicator = true,
    this.enableExit = true,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final darkTheme = ref.watch(themeNP);

    return !isAddContentButton
        ? Padding(
            padding: const EdgeInsets.all(20),
            child: Container(
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.background,
                borderRadius: const BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  enableHomeIndicator
                      ? FractionallySizedBox(
                          widthFactor: 0.14,
                          child: Container(
                            margin: const EdgeInsets.only(
                              top: 14,
                              bottom: 5,
                            ),
                            child: Container(
                              height: 5,
                              decoration: const BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(2.5),
                                ),
                              ),
                            ),
                          ),
                        )
                      : const Padding(
                          padding: EdgeInsets.only(top: 8),
                        ),
                  ...actions,
                  const SizedBox(height: 5),
                ],
              ),
            ),
          )
        : Padding(
            padding: const EdgeInsets.all(0),
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.background,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  enableExit
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(left: 15),
                              child: Text(
                                'Create',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            IconButton(
                              onPressed: Navigator.of(context).pop,
                              icon: Icon(
                                Icons.clear_outlined,
                                color: darkTheme ? Colors.white : Colors.black,
                              ),
                            ),
                          ],
                        )
                      : const Padding(
                          padding: EdgeInsets.only(top: 8),
                        ),
                  ...actions,
                  const SizedBox(height: 5),
                ],
              ),
            ),
          );
  }
}
