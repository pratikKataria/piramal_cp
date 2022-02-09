import 'package:flutter/material.dart';
import 'package:piramal_channel_partner/res/Fonts.dart';
import 'package:piramal_channel_partner/res/Images.dart';
import 'package:piramal_channel_partner/utils/Utility.dart';

class ProjectDetailAmentiesPage extends StatelessWidget  {
  const ProjectDetailAmentiesPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: ListView(
        children: [
          Image.asset(Images.kImgPlaceholderAmenities),
          verticalSpace(10.0),
          Row(
            children: [
              Expanded(
                child: Text(
                  "1. Tower Lobby Entry\n2. Pets Park\n3. Sitting Planter & Garden\n4. Jogging track\n5. Grand Lawn\n6. Swimming Pool\n7. Basketball Court\n8. Children’s Meadow",
                  style: textStyle14px500w20H,
                ),
              ),
              Expanded(
                child: Text(
                  "15. Reading Corner\n16. Children’s Pool\n17. Pool Pavilion\n18. 5-Lane Lap Pool\n19. Jacuzzi\n20. Climbing\n21. Helix Club House Entry\n22. Amphitheatre",
                  style: textStyle14px500w20H,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
