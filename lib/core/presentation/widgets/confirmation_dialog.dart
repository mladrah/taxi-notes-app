import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ConfirmationDialog extends StatelessWidget {
  ConfirmationDialog({
    Key? key,
    this.icon,
    this.iconData,
    required this.title,
    required this.content,
    this.cancelBackgroundColor,
    this.cancelForegroundColor,
    this.confirmBackgroundColor,
    this.confirmForegroundColor,
    required this.cancelLabel,
    required this.confirmLabel,
    this.popOnConfirm = true,
    required this.onConfirm,
  }) : super(key: key);

  Widget? icon;
  IconData? iconData;
  final String title;
  final Widget content;
  Color? confirmBackgroundColor;
  Color? confirmForegroundColor;
  Color? cancelBackgroundColor;
  Color? cancelForegroundColor;
  final String cancelLabel;
  final String confirmLabel;
  final bool popOnConfirm;
  final VoidCallback onConfirm;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      surfaceTintColor: Colors.transparent,
      backgroundColor: Theme.of(context).colorScheme.surface,
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      content: content,
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: TextButton(
                onPressed: () => Navigator.pop(context),
                style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(
                    cancelBackgroundColor ??
                        Theme.of(context).colorScheme.surface,
                  ),
                  foregroundColor: WidgetStatePropertyAll(
                    cancelForegroundColor ??
                        Theme.of(context).colorScheme.onSurface,
                  ),
                  overlayColor: WidgetStatePropertyAll(
                    cancelBackgroundColor != null &&
                            cancelBackgroundColor!.computeLuminance() < 0.5
                        ? Theme.of(context).splashColor
                        : null,
                  ),
                ),
                child: Text(cancelLabel),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: TextButton(
                style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(
                      confirmBackgroundColor ??
                          Theme.of(context).colorScheme.primary),
                  foregroundColor: WidgetStatePropertyAll(
                      confirmForegroundColor ??
                          Theme.of(context).colorScheme.onPrimary),
                  overlayColor: WidgetStatePropertyAll(
                    cancelBackgroundColor != null &&
                            confirmBackgroundColor!.computeLuminance() < 0.5
                        ? Theme.of(context).splashColor
                        : null,
                  ),
                ),
                onPressed: () {
                  onConfirm();
                  if (popOnConfirm) Navigator.pop(context);
                },
                child: Text(confirmLabel),
              ),
            ),
          ],
        ),
      ],
    );
  }

  static void show({
    required BuildContext context,
    required String title,
    required String description,
    required VoidCallback onConfirm,
    Color? cancelBackgroundColor,
    Color? cancelForegroundColor,
    Color? confirmBackgroundColor,
    Color? confirmForegroundColor,
    String confirmLabel = 'Ja',
    String cancelLabel = 'Nein',
  }) async {
    // pop up menu item will pop automatically after onTap which pops the dialog that we want to show
    // to prevent it, we are delaying the dialog, so the pop will be first called
    await Future.delayed(Duration.zero);

    // ignore: use_build_context_synchronously
    showDialog(
      context: context,
      builder: (_) => ConfirmationDialog(
        title: title,
        content: Text(description),
        onConfirm: onConfirm,
        cancelBackgroundColor: cancelBackgroundColor,
        cancelForegroundColor: cancelForegroundColor,
        confirmBackgroundColor: confirmBackgroundColor,
        confirmForegroundColor: confirmForegroundColor,
        confirmLabel: confirmLabel,
        cancelLabel: cancelLabel,
      ),
    );
  }
}
