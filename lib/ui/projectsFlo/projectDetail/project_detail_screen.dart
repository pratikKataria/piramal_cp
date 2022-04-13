import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:piramal_channel_partner/res/AppColors.dart';
import 'package:piramal_channel_partner/res/Fonts.dart';
import 'package:piramal_channel_partner/res/Images.dart';
import 'package:piramal_channel_partner/ui/projectsFlo/projectDetail/model/project_amenities_response.dart';
import 'package:piramal_channel_partner/ui/projectsFlo/projectDetail/model/project_download_response.dart';
import 'package:piramal_channel_partner/ui/projectsFlo/projectDetail/model/project_overview_bottom_images.dart';
import 'package:piramal_channel_partner/ui/projectsFlo/projectDetail/model/project_overview_images_response.dart';
import 'package:piramal_channel_partner/ui/projectsFlo/projectDetail/model/project_overview_response.dart';
import 'package:piramal_channel_partner/ui/projectsFlo/projectDetail/model/project_tower_response.dart';
import 'package:piramal_channel_partner/ui/projectsFlo/projectDetail/pages/project_detail_amenities_page.dart';
import 'package:piramal_channel_partner/ui/projectsFlo/projectDetail/pages/project_detail_downloads_page.dart';
import 'package:piramal_channel_partner/ui/projectsFlo/projectDetail/pages/project_detail_overview_page.dart';
import 'package:piramal_channel_partner/ui/projectsFlo/projectDetail/pages/project_detail_towers_page.dart';
import 'package:piramal_channel_partner/ui/projectsFlo/projectDetail/project_detail_view.dart';
import 'package:piramal_channel_partner/ui/projectsFlo/projectList/model/project_list_response.dart';
import 'package:piramal_channel_partner/ui/projectsFlo/project_presenter.dart';
import 'package:piramal_channel_partner/utils/Utility.dart';

class ProjectDetailScreen extends StatefulWidget {
  final ProjectListResponse arguments;

  const ProjectDetailScreen(this.arguments, {Key key}) : super(key: key);

  @override
  _ProjectDetailScreenState createState() => _ProjectDetailScreenState();
}

class _ProjectDetailScreenState extends State<ProjectDetailScreen>
    with SingleTickerProviderStateMixin
    implements ProjectDetailView {
  TabController _tabController;
  List<String> listOfImages = [Images.kImgPlaceholderCarousel1, Images.kImgPlaceholderCarousel2, Images.kImgPlaceholderCarousel3];

  ProjectOverviewResponse projectOverviewResponse;
  ProjectAmenitiesResponse projectAmenitiesResponse;

  List<ProjectTowerResponse> projectTowerResponse;
  List<ProjectDownloadResponse> projectDownloadResponse;
  List<String> projectCarouselImages = [];

  ProjectPresenter projectPresenter;

  @override
  void initState() {
    //Setup tab controller and listener
    _tabController = TabController(length: 4, vsync: this);
    _tabController.addListener(onTabChangeListener);

    // project present
    projectPresenter = ProjectPresenter(this);
    projectPresenter.getProjectOverview(context, widget?.arguments?.projectId);
    projectPresenter.getTowerList(context, widget?.arguments?.projectId);
    projectPresenter.getDownloadList(context, widget?.arguments?.projectId);
    projectPresenter.getProjectAmenities(context, widget?.arguments?.projectId);
    projectPresenter.getProjectBannerPics(context, widget?.arguments?.projectId);

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
          // new Image.asset(listOfImages[index], fit: BoxFit.fill) Container(
          if (projectCarouselImages.isNotEmpty)
            Container(
              height: 180.0,
              child: Swiper(
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    margin: EdgeInsets.symmetric(horizontal: 5.0),
                    child: Image.memory(
                      Utility.convertMemoryImage((projectCarouselImages[index] ?? "")),
                      fit: BoxFit.fill,
                    ),
                  );
                },
                itemCount: 3,
                pagination: new SwiperPagination(),
              ),
            ),
          verticalSpace(20.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Text("${projectOverviewResponse?.projectName ?? ""}", style: textStyle24px500w),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Text("${projectOverviewResponse?.projectCity ?? ""}", style: textStyleSubText14px500w),
          ),
          verticalSpace(20.0),
          buildTabs(),
          verticalSpace(20.0),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                ProjectDetailOverviewPage(projectOverviewResponse),
                ProjectDetailTowerPage(projectTowerResponse),
                ProjectDetailDownloadPage(projectDownloadResponse),
                ProjectDetailAmenitiesPage(projectAmenitiesResponse),
              ],
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
    // currentPage = listOfPages[_tabController.index];
    // projectPresenter.getProjectAmenities(context);
    // setState(() {});
  }

  @override
  onError(String message) {
    Utility.showErrorToastB(context, message);
  }

  @override
  void onProjectAmenitiesFetched(ProjectAmenitiesResponse projectAmenitiesResponse) {
    this.projectAmenitiesResponse = projectAmenitiesResponse;
    setState(() {});
  }

  @override
  void onProjectOverviewDetailsFetched(ProjectOverviewResponse projectOverviewResponse) {
    this.projectOverviewResponse = projectOverviewResponse;
    projectPresenter.getProjectBottomPics(context, widget?.arguments?.projectId);
    setState(() {});
  }

  @override
  void onProjectTowerListFetched(List<ProjectTowerResponse> projectListResponse) {
    this.projectTowerResponse = projectListResponse;
    setState(() {});
  }

  @override
  void onProjectDownloadListFetched(List<ProjectDownloadResponse> projectDownloadResponse) {
    this.projectDownloadResponse = projectDownloadResponse;
    setState(() {});
  }

  @override
  void onProjectImagesFetched(List<ProjectOverviewImagesResponse> brList) {
    projectCarouselImages.clear();
    brList.forEach((element) => projectCarouselImages.add(element.projectPic));
    setState(() {});
  }

  @override
  void onProjectBottomImagesFetched(List<ProjectOverviewBottomImages> projectListResponse) {
    projectOverviewResponse.projectBottomImagesList.clear();
    projectListResponse.forEach((imageData) {
      projectOverviewResponse.projectBottomImagesList.add(imageData.downloadlink);
    });
    setState(() {});
  }
}
