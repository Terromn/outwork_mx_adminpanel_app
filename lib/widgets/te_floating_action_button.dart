import 'package:flutter/material.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../assets/app_color_palette.dart';

class TeFloatingActionButton extends StatelessWidget {
  const TeFloatingActionButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ExpandableFab(
      distance: 100,
      type: ExpandableFabType.up,
      childrenOffset: const Offset(-4, 0),
      overlayStyle: ExpandableFabOverlayStyle(
        blur: 0,
      ),
      openButtonBuilder: RotateFloatingActionButtonBuilder(
        child: const Icon(
          FontAwesomeIcons.screwdriverWrench,
          size: 20,
        ),
        fabSize: ExpandableFabSize.regular,
        foregroundColor: TeAppColorPalette.black,
        backgroundColor: TeAppColorPalette.green,
      ),
      closeButtonBuilder: DefaultFloatingActionButtonBuilder(
        child: const Icon(
          FontAwesomeIcons.xmark,
          size: 22,
        ),
        fabSize: ExpandableFabSize.small,
      ),
      children: [
        FloatingActionButton.small(
          child: const Icon(FontAwesomeIcons.qrcode, size: 20),
          onPressed: () {
            Navigator.pushNamed(context, '/QRScannerScreen');
          },
        ),
        FloatingActionButton.small(
          child: const Icon(
            FontAwesomeIcons.plus,
            size: 20,
          ),
          onPressed: () {
            Navigator.pushNamed(context, '/AddClassScreen');
          },
        ),
      ],
    );
  }
}
