import 'package:flutter/material.dart';
import 'package:piramal_channel_partner/generated/assets.dart';
import 'package:piramal_channel_partner/res/AppColors.dart';
import 'package:piramal_channel_partner/res/Fonts.dart';
import 'package:piramal_channel_partner/ui/videoScreen/model/video_response_model.dart';
import 'package:piramal_channel_partner/ui/videoScreen/video_presenter.dart';
import 'package:piramal_channel_partner/ui/videoScreen/video_view.dart';
import 'package:piramal_channel_partner/utils/Utility.dart';
import 'package:piramal_channel_partner/widgets/cached_image_widget.dart';
import 'package:piramal_channel_partner/widgets/extension.dart';
import 'package:piramal_channel_partner/widgets/refresh_list_view.dart';
import 'package:piramal_channel_partner/widgets/video_player_dialog.dart';

class VideoScreen extends StatefulWidget {
  const VideoScreen({Key key}) : super(key: key);

  @override
  _VideoScreenState createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> implements VideoView {
  VideoPresenter projectPresenter;
  List<DetailsList> listOfProjects = [];

  @override
  void initState() {
    super.initState();
    projectPresenter = VideoPresenter(this);
    projectPresenter.getVideoList(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.screenBackgroundColor,
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            verticalSpace(22.0),
            Text("Videos (${listOfProjects.length})", style: textStyle24px500w),
            verticalSpace(33.0),
            Expanded(
              child: RefreshListView(
                onRefresh: () {
                  projectPresenter.getVideoList(context);
                },
                children: listOfProjects.map<Widget>((e) => cardViewProjects(e)).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  cardViewProjects(DetailsList e) {
    Uri uri = Uri.parse(e.videoURL ?? "");
    String videoId = uri.queryParameters['v'];

    return InkWell(
      onTap: () {
        // Navigator.pushNamed(context, Screens.kProjectDetailScreen, arguments: projectData);
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 18.0),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(6.0),
          boxShadow: [
            BoxShadow(
              // box-shadow: 0px 10px 30px 0px #0000000D;
              color: AppColors.colorSecondary.withOpacity(0.1),
              blurRadius: 20.0,
              spreadRadius: 5.0,
              offset: Offset(0, 8),
            ),
          ],
        ),
        child:  Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              foregroundDecoration: BoxDecoration(image: DecorationImage(image: AssetImage(Assets.imagesIcPlay), fit: BoxFit.scaleDown, scale: 4)),
              child: AspectRatio(
                aspectRatio: 16 / 9,
                // "Latest_URL": "https://www.youtube.com/watch?v=fXgg3MsqMIk",
                child: CachedImageWidget(
                  imageUrl: "https://i.ytimg.com/vi/$videoId/hqdefault.jpg",
                  radius: 0.0,
                ),
              ),
            ).onClick(() {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return MyVideoPlayerDialog(url: "$videoId");
                },
              );
            }),
            verticalSpace(10.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Text("${e?.videoHeading}", style: textStyleSubText14px500w),
            ),
            verticalSpace(10.0),
          ],
        ),
      ),
    );
  }

  @override
  onError(String message) {
    Utility.showErrorToastB(context, message);
  }

  @override
  void onVideoListFetched(List<DetailsList> detailsList) {
    listOfProjects.clear();
    listOfProjects.addAll(detailsList);
    setState(() {});
  }
}
