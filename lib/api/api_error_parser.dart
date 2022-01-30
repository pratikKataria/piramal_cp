import 'package:dio/dio.dart';
import 'package:piramal_channel_partner/ui/base/BaseView.dart';
import 'package:piramal_channel_partner/ui/base/base_presenter.dart';
import 'package:piramal_channel_partner/utils/Utility.dart';

import 'model/api_error_model.dart';

abstract class ApiErrorParser {
  static getResult(dynamic e, BaseView view) {
    final tag = "ApiErrorParser";
    String errorMessage = "Something went wrong";
    if (e is DioError) {
      try {
        List response = e.response.data;
        ApiErrorModel apiErrorModel = ApiErrorModel.fromJson(response[0]);
        errorMessage = apiErrorModel?.message ?? errorMessage;
      } catch (xe) {
        errorMessage = xe.toString();
      }

      showErrorToView(errorMessage, view);
    } else {
      showErrorToView(e.toString(), view);
    }
  }

  static showErrorToView(String message, BaseView view) {
    view.onError(message);
    exeTaskOnError(message, view);
    Utility.log("api_error_parser", message);
  }

  static exeTaskOnError(String message, BaseView view) {
    switch (message) {
      case ErrorCodes.INVALID_SESSION_ID:
        revokeSessionCode(view);
        break;
    }
  }

  static revokeSessionCode(BaseView view) {
    BasePresenter presenter = BasePresenter(view);
    presenter.getAccessToken();
  }
}

abstract class ErrorCodes {
  static const INVALID_SESSION_ID = "Session expired or invalid";
}
