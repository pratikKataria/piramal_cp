import 'dart:io';

import 'package:dio/dio.dart';
import 'package:piramal_channel_partner/utils/Utility.dart';

import 'http.dart';

/// 🔥 MVP Architecture🔥
/// 🍴 Focused on Clean Architecture
/// Created by 🔱 Pratik Kataria 🔱 on 12-08-2021.

class ApiController {
  var tag = "ApiController";
  static ApiController _instance = ApiController.internal();

  ApiController.internal();

  factory ApiController() {
    return _instance;
  }

  static ApiController getInstance() {
    if (_instance == null) {
      _instance = ApiController.internal();
    }
    return _instance;
  }

  Future<Response> post(String url, {Map headers, body, encoding, payload}) async {
    Map<String, String> headersMap = headers ?? {};
    // headersMap["NoEncryption"] = 'true';
    Utility.log(
        tag, "Api Call :\n $url \n --> Inputs :\n $body \n --> payload :\n ${payload.toString()} \n --> header :\n $headers");
    Response response = await dio.post(
      url,
      data: body,
      queryParameters: payload,
      options: Options(
        contentType: ContentType.json.toString(),
        receiveTimeout: 300000,
        sendTimeout: 300000,
        method: "POST",
        headers: headersMap,
      ),
    );

    Utility.log(
      tag,
      "\n----------------------------RESPONSE START-----------------------------\nApi Call :\n $url \n --> Inputs :\n $body \n --> payload :\n ${payload.toString()} \n --> header :\n $headers \n --> Response :\n ${response.toString()} \n----------------------------RESPONSE END-----------------------------\n",
    );
    return response;
  }

  Future<Response> postV2(String url, {Map text, encoding, payload, String body}) async {
    Map<String, String> headersMap = text ?? {};
    // headersMap["NoEncryption"] = 'true';
    Utility.log(tag,
        "Api Call :\n $url \n --> Inputs :\n ${body.toString()} \n --> payload :\n ${payload.toString()} \n --> header :\n ${text.toString()}");
    Response response = await dio.post(
      url,
      data: body,
      queryParameters: payload,
      options: Options(
        contentType: ContentType.json.toString(),
        receiveTimeout: 300000,
        sendTimeout: 300000,
        method: "POST",
        headers: headersMap,
      ),
    );

    Utility.log(
      tag,
      "Api Call :\n $url \n --> Inputs :\n $body \n --> payload :\n ${payload.toString()} \n --> Response :\n ${response.toString()}",
    );
    return response;
  }

  Future<Response> put(String url, {Map headers, body, encoding, payload}) async {
    Map<String, String> headersMap = headers ?? {};
    // headersMap["NoEncryption"] = 'true';
    Utility.log(tag,
        "Api Call :\n $url \n --> Inputs :\n ${body.toString()} \n --> payload :\n ${payload.toString()} \n --> header :\n ${headers.toString()}");
    Response response = await dio.put(
      url,
      data: body,
      queryParameters: payload,
      options: Options(
        contentType: ContentType.json.toString(),
        receiveTimeout: 300000,
        sendTimeout: 300000,
        method: "PUT",
        headers: headersMap,
      ),
    );

    Utility.log(
      tag,
      "Api Call :\n $url \n --> Inputs :\n $body \n --> payload :\n ${payload.toString()} \n --> header :\n $headers \n --> Response :\n ${response.toString()}",
    );
    return response;
  }

  Future<Response> patch(String url, {Map headers, body, encoding, payload}) async {
    Map<String, String> headersMap = headers ?? {};
    // headersMap["NoEncryption"] = 'true';
    Utility.log(tag,
        "Api Call :\n $url \n --> Inputs :\n ${body.toString()} \n --> payload :\n ${payload.toString()} \n --> header :\n ${headers.toString()}");
    Response response = await dio.patch(
      url,
      data: body,
      queryParameters: payload,
      options: Options(
        contentType: ContentType.json.toString(),
        receiveTimeout: 300000,
        sendTimeout: 300000,
        method: "PATCH",
        headers: headersMap,
      ),
    );

    Utility.log(
      tag,
      "Api Call :\n $url \n --> Inputs :\n $body \n --> payload :\n ${payload.toString()} \n --> header :\n $headers \n --> Response :\n ${response.toString()}",
    );
    return response;
  }

  Future<Response> get(String url, {Map headers, body, encoding, payload}) async {
    Map<String, String> headerMap = headers ?? {};
    // headerMap["NoEncryption"] = 'true';
    Utility.log(tag, "Api Call :\n $url \n Inputs :\n ${body.toString()} \n Payload :\n ${payload}  \n Header :\n $headers");

    Response response = await dio.get(url,
        queryParameters: payload,
        options: Options(
          contentType: ContentType.json.toString(),
          receiveTimeout: 300000,
          sendTimeout: 300000,
          method: "GET",
          headers: headerMap,
        ));

    Utility.log(
      tag,
      "Api Call :\n $url \n --> Inputs :\n $body \n --> payload :\n ${payload.toString()} \n --> header :\n $headers \n --> Response :\n ${response.toString()}",
    );
    return response;
  }

  Future<Response> delete(String url, {Map headers, body, encoding, payload}) async {
    Map<String, String> headerMap = headers ?? {};
    Utility.log(tag, "Api Call :\n $url \n Inputs :\n ${body.toString()} \n Payload :\n ${payload} \n Headers :\n ${headerMap} ");

    Response response = await dio.deleteUri(Uri.parse(url),
        data: body,
        options: Options(
          contentType: ContentType.json.toString(),
          receiveTimeout: 300000,
          sendTimeout: 300000,
          method: "DELETE",
          headers: headerMap,
        ));

    Utility.log(
      tag,
      "Api Call :\n $url \n --> Inputs :\n $body \n --> payload :\n ${payload.toString()} \n --> header :\n $headers \n --> Response :\n ${response.toString()}",
    );
    return response;
  }

  Future<Response> download(String url, {Map headers, body, encoding, payload}) async {
    Map<String, String> headerMap = headers ?? {};
    // headerMap["NoEncryption"] = 'true';
    Utility.log(tag, "Api Call :\n $url \n Inputs :\n ${body.toString()} \n Payload :\n ${payload}  \n Header :\n $headers");

    Response response = await dio.get(
      url,
      queryParameters: payload,
      options: Options(
          responseType: ResponseType.bytes,
          contentType: ContentType.json.toString(),
          followRedirects: false,
          receiveTimeout: 300000,
          sendTimeout: 300000,
          method: "GET",
          headers: headerMap),
    );
    print(response.headers);

    Utility.log(
      tag,
      "Api Call :\n $url \n --> Inputs :\n $body \n --> payload :\n ${payload.toString()} \n --> header :\n $headers \n --> Response :\n ${response.toString()}",
    );
    return response;
  }
}
