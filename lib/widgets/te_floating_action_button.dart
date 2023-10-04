import 'package:flutter/cupertino.dart';
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
      distance: 200,
      overlayStyle:  ExpandableFabOverlayStyle(
        blur: 6,
      ),

      openButtonBuilder: RotateFloatingActionButtonBuilder(
        child: const Icon(FontAwesomeIcons.screwdriverWrench),
        fabSize: ExpandableFabSize.large,
        foregroundColor: TeAppColorPalette.black,
        backgroundColor: TeAppColorPalette.green,
      ),
      closeButtonBuilder: DefaultFloatingActionButtonBuilder(
        child: const Icon(Icons.close),
        fabSize: ExpandableFabSize.large,
      ),
      children: [
        FloatingActionButton.small(
          heroTag: null,
          child: const Icon(FontAwesomeIcons.qrcode),
          onPressed: () {},
        ),
        FloatingActionButton.small(
          heroTag: null,
          child: const Icon(FontAwesomeIcons.searchengin),
          onPressed: () {},
        ),
         FloatingActionButton.small(
          heroTag: null,
          child: const Icon(Icons.search),
          onPressed: () {},
        ),
         FloatingActionButton.small(
          heroTag: null,
          child: const Icon(Icons.search),
          onPressed: () {},
        ),
        
      ],
    );
  }
}