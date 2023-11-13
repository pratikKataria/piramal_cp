import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:piramal_channel_partner/res/AppColors.dart';
import 'package:piramal_channel_partner/res/Fonts.dart';
import 'package:piramal_channel_partner/res/Images.dart';
import 'package:piramal_channel_partner/res/Screens.dart';
import 'package:piramal_channel_partner/ui/constructionUpdates/construction_update_presenter.dart';
import 'package:piramal_channel_partner/ui/constructionUpdates/construction_update_view.dart';
import 'package:piramal_channel_partner/ui/newsAndArticles/model/news_and_article_detail_response.dart';
import 'package:piramal_channel_partner/ui/newsAndArticles/news_and_articles_presenter.dart';
import 'package:piramal_channel_partner/ui/newsAndArticles/news_and_articles_view.dart';
import 'package:piramal_channel_partner/utils/Utility.dart';
import 'package:piramal_channel_partner/widgets/cached_image_widget.dart';
import 'package:piramal_channel_partner/widgets/extension.dart';
import 'package:piramal_channel_partner/widgets/refresh_list_view.dart';

import 'model/news_and_articles_response.dart';

class NewsAndArticlesScreen extends StatefulWidget {
  const NewsAndArticlesScreen({Key key}) : super(key: key);

  @override
  _NewsAndArticlesScreenState createState() => _NewsAndArticlesScreenState();
}

class _NewsAndArticlesScreenState extends State<NewsAndArticlesScreen> implements NewsAndArticlesView {
  final subTextStyle = textStyleSubText14px500w;
  final mainTextStyle = textStyle14px500w;

  NewsAndArticlesPresenter newsAndArticlesPresenter;
  List<NewsAndArticleList> listOfNewsAndArticle = [];

  @override
  void initState() {
    super.initState();
    newsAndArticlesPresenter = NewsAndArticlesPresenter(this);
    newsAndArticlesPresenter.getNewsAndArticlesList(context);
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
            Text("News And Articles (${listOfNewsAndArticle.length})", style: textStyle24px500w),
            verticalSpace(33.0),
            Expanded(
              child: RefreshListView(
                onRefresh: () {
                  newsAndArticlesPresenter.getNewsAndArticlesList(context);
                },
                children: listOfNewsAndArticle.map<Widget>((e) => cardViewProjects(e)).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  cardViewProjects(NewsAndArticleList data) {
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
                  child: CachedImageWidget(imageUrl: data.newsAndArticlesMediaList[index] ?? ""),
                );
              },
              itemCount: data.newsAndArticlesMediaList.length,
            ),
          ),
          verticalSpace(8.0),
          Container(margin: EdgeInsets.symmetric(horizontal: 8.0), child: Text("${data.heading}", style: textStyle14px500w)),
          verticalSpace(10.0),
        ],
      ),
    ).onClick(() {
      Navigator.pushNamed(context, Screens.kNewsAndArticlesDetailScreen, arguments: data.newsAndArticleRecordId);
    });
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
  void onNewsAndArticlesFetched(List<NewsAndArticleList> newsAndArticleList) {
    listOfNewsAndArticle.clear();
    listOfNewsAndArticle.addAll(newsAndArticleList);
    setState(() {});
  }

  @override
  void onNewsAndArticlesDetailsFetched(NewsAndArticleDetailResponse newsAndArticlesResponse) {}
}
