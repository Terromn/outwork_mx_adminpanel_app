import 'package:flutter/material.dart';
import 'package:outwork_mx_admin_app/assets/app_theme.dart';

import '../assets/app_color_palette.dart';
import '../models/user_model.dart';

class AthletePreviewCard extends StatelessWidget {
  final UserModel userModel;

  const AthletePreviewCard({Key? key, required this.userModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: SizedBox(
        child: Container(
          decoration: BoxDecoration(
            color: TeAppColorPalette.black,
            borderRadius: BorderRadius.circular(22.0),
            boxShadow: const [
              BoxShadow(
                color: TeAppColorPalette.black,
                offset: Offset(0, 0),
                blurRadius: 20,
                spreadRadius: 0,
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(TeAppThemeData.contentMargin * .5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                  child: CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.transparent,
                    backgroundImage: AssetImage(
                      'assets/defaultProfilePictures/${userModel.profilePicture}',
                    ),
                  ),
                ),
                Expanded( // Moved the Expanded widget inside the Row
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        userModel.name,
                        style: Theme.of(context).textTheme.displayLarge,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "Creditos ",
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "Restantes: ${userModel.creditsAvailable}",
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
