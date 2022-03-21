


class NotificationReadResponse {
    String message;
    int returnCode;

    NotificationReadResponse({this.message, this.returnCode});

    factory NotificationReadResponse.fromJson(Map<String, dynamic> json) {
        return NotificationReadResponse(
            message: json['message'],
            returnCode: json['returnCode'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['message'] = this.message;
        data['returnCode'] = this.returnCode;
        return data;
    }
}