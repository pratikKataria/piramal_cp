import 'package:piramal_channel_partner/api/api_error_view.dart';
import 'package:piramal_channel_partner/ui/base/BaseView.dart';
import 'package:piramal_channel_partner/ui/constructionUpdates/model/construction_update_response.dart';
import 'package:piramal_channel_partner/ui/newsAndArticles/model/news_and_article_detail_response.dart';
import 'package:piramal_channel_partner/ui/projectsFlo/projectList/model/project_list_response.dart';
import 'package:piramal_channel_partner/ui/projectsFlo/project_marker_interface.dart';

import 'model/news_and_articles_response.dart';

abstract class NewsAndArticlesView extends BaseView{
  void onNewsAndArticlesFetched(List<NewsAndArticleList> newsAndArticleList);
  void onNewsAndArticlesDetailsFetched(NewsAndArticleDetailResponse newsAndArticlesResponse);
}
