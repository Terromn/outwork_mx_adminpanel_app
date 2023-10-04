import 'package:flutter/material.dart';
import 'package:outwork_mx_admin_app/assets/app_color_palette.dart';

class TeMenuButton extends StatelessWidget {
  final String textContent;
  final IconData buttonIcon;
  final VoidCallback onPressed;

  const TeMenuButton({
    super.key,
    required this.textContent,
    required this.buttonIcon,
    required this.onPressed,
  });

  @override
  Widget build(
    BuildContext context,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: ElevatedButton(
          onPressed: onPressed,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(buttonIcon, color: TeAppColorPalette.black),
                const SizedBox(width: 24),
                Text(textContent, style: Theme.of(context).textTheme.labelMedium),
              ],
            ),
          )),
    );
  }
}
