import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:piramal_channel_partner/res/AppColors.dart';
import 'package:piramal_channel_partner/res/Images.dart';
import 'package:shimmer/shimmer.dart';

///  Created by pratik kataria 18-12-2020

class CachedImageWidget extends StatelessWidget {
  final String imageUrl;
  final String placeHolderImage;
  final double height, width;
  final double radius;
  final BoxFit fit;

  const CachedImageWidget(
      {Key key, this.fit, @required this.imageUrl, this.height, this.width, this.radius, this.placeHolderImage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: CachedNetworkImage(
          imageUrl: '$imageUrl',
          placeholder: (context, url) => Shimmer.fromColors(
                baseColor: AppColors.baseLightColor,
                highlightColor: AppColors.highLightColor,
                child: Container(
                  width: width == null ? 120 : width,
                  height: height == null ? 160 : height,
                  decoration: BoxDecoration(
                    color: AppColors.shimmerBackgroundColor,
                    borderRadius: BorderRadius.circular(radius ?? 12),
                  ),
                ),
              ),
          imageBuilder: (context, imageProvider) => Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(radius ?? 12),
                  image: DecorationImage(
                    image: imageProvider,
                    fit: fit ?? BoxFit.cover,
                  ),
                ),
              ),
          errorWidget: (context, url, error) => Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(radius ?? 12),
                  image: DecorationImage(
                    image: AssetImage(placeHolderImage ?? Images.kAppIcon),
                    fit: BoxFit.fill,
                  ),
                ),
              )),
    );
  }
}
