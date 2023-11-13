import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:piramal_channel_partner/api/api_controller_expo.dart';
import 'package:piramal_channel_partner/api/api_end_points.dart';
import 'package:piramal_channel_partner/api/api_error_parser.dart';
import 'package:piramal_channel_partner/ui/constructionUpdates/construction_update_view.dart';
import 'package:piramal_channel_partner/ui/constructionUpdates/model/construction_update_response.dart';
import 'package:piramal_channel_partner/ui/newsAndArticles/model/news_and_articles_response.dart';
import 'package:piramal_channel_partner/user/AuthUser.dart';
import 'package:piramal_channel_partner/utils/Dialogs.dart';
import 'package:piramal_channel_partner/utils/NetworkCheck.dart';
import 'package:piramal_channel_partner/utils/Utility.dart';

import 'model/news_and_article_detail_response.dart';
import 'news_and_articles_view.dart';

class NewsAndArticlesPresenter {
  NewsAndArticlesView _v;
  final tag = "LeadPresenter";

  NewsAndArticlesPresenter(this._v);

  void getNewsAndArticlesList(BuildContext context) async {
    //check for internal token
    if (await AuthUser.getInstance().hasToken()) {
      _v.onError("Token not found");
      return;
    }

    //check network
    if (!await NetworkCheck.check()) {
      _v.onError("Network Error");
      return;
    }

    Dialogs.showLoader(context, "Please wait fetching your news and articles ...");
    apiController.post(EndPoints.NEWS_AND_ARTICLE_LIST, headers: await Utility.header())
      ..then((response) async {
        await Dialogs.hideLoader(context);
        NewsAndArticlesResponse newsAndArticlesResponse = NewsAndArticlesResponse.fromJson(response.data);
        if (newsAndArticlesResponse.returnCode) {
          _v.onNewsAndArticlesFetched(newsAndArticlesResponse.newsAndArticleList);
        } else {
          _v.onError(newsAndArticlesResponse.message);
        }
      })
      ..catchError((e) async {
        await Dialogs.hideLoader(context);
        ApiErrorParser.getResult(e, _v);
      });
  }

  void getNewsAndArticlesDetails(BuildContext context, String id) async {
    //check for internal token
    if (await AuthUser.getInstance().hasToken()) {
      _v.onError("Token not found");
      return;
    }

    //check network
    if (!await NetworkCheck.check()) {
      _v.onError("Network Error");
      return;
    }

    final body = {"newsAndArticleRecordId": id};

    Dialogs.showLoader(context, "Please wait fetching your news and articles ...");
    apiController.post(EndPoints.NEWS_AND_ARTICLE_DETAIL, body: body, headers: await Utility.header())
      ..then((response) async {
        await Dialogs.hideLoader(context);
        NewsAndArticleDetailResponse newsAndArticlesResponse = NewsAndArticleDetailResponse.fromJson(response.data);
        if (newsAndArticlesResponse.returnCode) {
          _v.onNewsAndArticlesDetailsFetched(newsAndArticlesResponse);
        } else {
          _v.onError(newsAndArticlesResponse.message);
        }
      })
      ..catchError((e) async {
        await Dialogs.hideLoader(context);
        ApiErrorParser.getResult(e, _v);
      });
  }
}
