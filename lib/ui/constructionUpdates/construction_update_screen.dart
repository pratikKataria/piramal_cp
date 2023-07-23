import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:piramal_channel_partner/res/AppColors.dart';
import 'package:piramal_channel_partner/res/Fonts.dart';
import 'package:piramal_channel_partner/res/Images.dart';
import 'package:piramal_channel_partner/ui/constructionUpdates/construction_update_presenter.dart';
import 'package:piramal_channel_partner/ui/constructionUpdates/construction_update_view.dart';
import 'package:piramal_channel_partner/utils/Utility.dart';
import 'package:piramal_channel_partner/widgets/cached_image_widget.dart';
import 'package:piramal_channel_partner/widgets/refresh_list_view.dart';

import 'model/construction_update_response.dart';

class ConstructionUpdateScreen extends StatefulWidget {
  final String tID;

  const ConstructionUpdateScreen(this.tID, {Key key}) : super(key: key);

  @override
  _ConstructionUpdateScreenState createState() => _ConstructionUpdateScreenState();
}

class _ConstructionUpdateScreenState extends State<ConstructionUpdateScreen> implements ConstructionUpdateView {
  final subTextStyle = textStyleSubText14px500w;
  final mainTextStyle = textStyle14px500w;

  ConstructionUpdatePresenter projectPresenter;
  List<ConUpdateList> listOfProjects = [];

  @override
  void initState() {
    super.initState();
    projectPresenter = ConstructionUpdatePresenter(this);
    projectPresenter.getProjectList(context, widget.tID);
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
            Text("Construction Updates (${listOfProjects.length})", style: textStyle24px500w),
            verticalSpace(33.0),
            Expanded(
              child: RefreshListView(
                onRefresh: () {
                  projectPresenter.getProjectList(context, widget.tID);
                },
                children: listOfProjects.map<Widget>((e) => cardViewProjects(e)).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  cardViewProjects(ConUpdateList data) {
    return Container(
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            height: 210.0,
            margin: EdgeInsets.only(top: 5.0),
            child: Swiper(
              pagination: SwiperPagination(
                builder: DotSwiperPaginationBuilder(size: 6.0, activeSize: 8, activeColor: AppColors.colorPrimary),
              ),
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 5.0),
                  child: CachedImageWidget(imageUrl: data.constructionUpdatesList[index] ?? ""),
                );
              },
              itemCount:  data.constructionUpdatesList.length,
            ),
          ),

          verticalSpace(8.0),
          Container(
              margin: EdgeInsets.symmetric(horizontal: 8.0),
              child: Text("${ data.description}", style: textStyle14px500w)),
          verticalSpace(10.0),
        ],
      ),
    );
  }

/*
  cardViewProjects(ConUpdateList e) {
    return InkWell(
      onTap: () {},
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
        child: Stack(
          children: [
            AspectRatio(
              aspectRatio: 16 / 9,
              child: CachedImageWidget(
                width: Utility.screenWidth(context),
                height: 200.0,
                imageUrl: "",
                radius: 0.0,
                fit: BoxFit.fill,
              ),
            ),
            Positioned(
              right: 10,
              top: 10,
              child: InkWell(
                onTap: () {
                  Utility.launchUrlX(context, "image");
                },
                child: Container(
                  width: 30,
                  height: 30,
                  padding: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.black.withOpacity(0.5),
                  ),
                  child: Image.asset(Images.kIconRedirect),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }*/

  @override
  onError(String message) {
    Utility.showErrorToastB(context, message);
  }

  @override
  void onConstructionImagesFetched(List<ConUpdateList> conUpdateList) {
    listOfProjects.clear();
    listOfProjects.addAll(conUpdateList);
    setState(() {});
  }
}