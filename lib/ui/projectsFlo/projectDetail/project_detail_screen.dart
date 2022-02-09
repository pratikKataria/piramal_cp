import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:piramal_channel_partner/res/AppColors.dart';
import 'package:piramal_channel_partner/res/Fonts.dart';
import 'package:piramal_channel_partner/res/Images.dart';
import 'package:piramal_channel_partner/ui/projectsFlo/projectDetail/pages/project_detail_amenities_page.dart';
import 'package:piramal_channel_partner/ui/projectsFlo/projectDetail/pages/project_detail_downloads_page.dart';
import 'package:piramal_channel_partner/ui/projectsFlo/projectDetail/pages/project_detail_overview_page.dart';
import 'package:piramal_channel_partner/ui/projectsFlo/projectDetail/pages/project_detail_towers_page.dart';
import 'package:piramal_channel_partner/ui/projectsFlo/project_marker_interface.dart';
import 'package:piramal_channel_partner/ui/projectsFlo/project_presenter.dart';
import 'package:piramal_channel_partner/utils/Utility.dart';

class ProjectDetailScreen extends StatefulWidget {
  const ProjectDetailScreen({Key key}) : super(key: key);

  @override
  _ProjectDetailScreenState createState() => _ProjectDetailScreenState();
}

class _ProjectDetailScreenState extends State<ProjectDetailScreen> with SingleTickerProviderStateMixin {
  TabController _tabController;
  List<String> listOfImages = [Images.kImgPlaceholderCarousel1, Images.kImgPlaceholderCarousel2, Images.kImgPlaceholderCarousel3];
  List listOfPages = [
    ProjectDetailOverviewPage(),
    ProjectDetailTowerPage(),
    ProjectDetailDownloadPage(),
    ProjectDetailAmentiesPage(),
  ];

  ProjectPresenter projectPresenter;
  ProjectMarkerInterface currentPage;

  @override
  void initState() {
    //Setup tab controller and listener
    _tabController = TabController(length: 4, vsync: this);
    _tabController.addListener(onTabChangeListener);

    // init current view and project present
    currentPage = listOfPages[0];
    projectPresenter = ProjectPresenter(currentPage);

    super.initState();
  }

  @override
  void dispose() {
    _tabController.removeListener(onTabChangeListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 180.0,
            child: Swiper(
              itemBuilder: (BuildContext context, int index) {
                return new Image.asset(listOfImages[index], fit: BoxFit.fill);
              },
              itemCount: 3,
              pagination: new SwiperPagination(),
            ),
          ),
          verticalSpace(20.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Text("Piramal Mahalaxmi", style: textStyle24px500w),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Text("South Mumbai - India", style: textStyleSubText14px500w),
          ),
          verticalSpace(20.0),
          buildTabs(),
          verticalSpace(20.0),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [...listOfPages],
            ),
          ),
        ],
      ),
    );
  }

  TabBar buildTabs() {
    return TabBar(
      controller: _tabController,
      labelStyle: textStyle14px500w,
      labelColor: AppColors.textColor,
      indicatorColor: Colors.transparent,
      unselectedLabelStyle: textStyleSubText14px500w,
      labelPadding: EdgeInsets.symmetric(horizontal: 5.0),
      unselectedLabelColor: AppColors.textColorSubText.withOpacity(0.5),
      onTap: (int index) {
        setState(() {});
      },
      tabs: [
        Tab(
          icon: buildCircularIcon(child: Image.asset(Images.kIconOverview), value: 0),
          text: "Overview",
        ),
        Tab(
          icon: buildCircularIcon(child: Image.asset(Images.kIconTower), value: 1),
          text: "Towers",
        ),
        Tab(
          icon: buildCircularIcon(child: Image.asset(Images.kIconDownload), value: 2),
          text: "Downloads",
        ),
        Tab(
          icon: buildCircularIcon(child: Image.asset(Images.kIconAmenities), value: 3),
          text: "Amenities",
        ),
      ],
    );
  }

  Container buildCircularIcon({Image child, int value}) {
    return Container(
      width: 38.0,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: _tabController.index == value ? AppColors.colorSecondary : AppColors.colorSecondary.withOpacity(0.5),
      ),
      padding: EdgeInsets.all(11.0),
      child: child,
    );
  }

  void onTabChangeListener() {
    //update currentPage view
    currentPage = listOfPages[_tabController.index];
    setState(() {});
  }
}
