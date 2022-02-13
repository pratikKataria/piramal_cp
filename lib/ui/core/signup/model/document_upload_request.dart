/// CustomerAccountId : "001p000000zH3GlAAK"
/// ReraCertificatePDF : "\nXD0YiaiXkPX85Okmt/YbI+WXZi/7UqtdDZT8o/9a54yU55ETamvJfsEJqUee/e7KiANWYXN3\ns6OR9NmaJalDSErzL3tSWr0qJnx9ni6Q1F6RunzPJ0src9ZnVq4xwfVop9xOfkgoa6qKjwU27x\nXNG5Lud4AqEKUiC0GweATF333yauX18O "
///  PanCard : "WKglfTxolNaJNbJ7f3ovB6+/q7nhm36GxZFHboVDxJb/xA3odlmUTZwxs7Cc53FuQWqvWWd\nyXKlTsfXGitPP6BfavG0BCY6Kt+vuIy7/36Kho1emmOe5Psa2YEaF967FCa1j8qqDAu06dN "
/// LISTofDirectors : "XD0YiaiXkPX85Okmt/YbI+WXZi/7UqtdDZT8o/9a54yU55ETamvJfsEJqUee/e7KiANWYXN\n3s6OR9NmaJalDSErzL3tSWr0qJnx9ni6Q1F6RunzPJ0src9ZnVq4xwfVop9xOfkgoa6qKjwU27x\nXNG5Lud4AqEKUiC0GweATF333yauX18O "
/// partnershipDeeds : "wfOQjvGmZOSORcZFROVtJst7Pr7rztxPDhOrvWZ4kNF/dDdJvz/u9aFruDexakV3d1Ld5JSIT7\ncXXpyi1YlrNlRtLLGwTFY1OXNq6tWDuXNVP9uuUdvWMV0t5t+ "
/// listOfpartners : "qjFYOy983NSM0Oqa0JqFpHJ2xHYzUNBdYcB2D2ceqHN89yFokHyO1wLZ0Ttu4kUHbmqa7\n+ac1KQQY56Xdu/X2Q5d00QaNB+dK8lpfTQ+\n/L42Uph6nAKfL04sQuNxBi+8wFp832LzCHLwp1Kk2vcvCvEgtCW9emAtwmekrl78WOSz3/Xn\nvOJzY8jAQV/h8DxJj8KRKZqYI5pYcXCKUWs3wXA6KWMecKJRk / "
/// TnCFlag : "true "

class DocumentUploadRequest {
  DocumentUploadRequest({
      String customerAccountId, 
      String reraCertificatePDF, 
      String  PanCard, 
      String lISTofDirectors, 
      String partnershipDeeds, 
      String listOfpartners, 
      String tnCFlag,}){
    _customerAccountId = customerAccountId;
    _reraCertificatePDF = reraCertificatePDF;
    _PanCard =  PanCard;
    _lISTofDirectors = lISTofDirectors;
    _partnershipDeeds = partnershipDeeds;
    _listOfpartners = listOfpartners;
    _tnCFlag = tnCFlag;
}

  DocumentUploadRequest.fromJson(dynamic json) {
    _customerAccountId = json['CustomerAccountId'];
    _reraCertificatePDF = json['ReraCertificatePDF'];
    _PanCard = json[' PanCard'];
    _lISTofDirectors = json['LISTofDirectors'];
    _partnershipDeeds = json['partnershipDeeds'];
    _listOfpartners = json['listOfpartners'];
    _tnCFlag = json['TnCFlag'];
  }
  String _customerAccountId;
  String _reraCertificatePDF;
  String _PanCard;
  String _lISTofDirectors;
  String _partnershipDeeds;
  String _listOfpartners;
  String _tnCFlag;

  String get customerAccountId => _customerAccountId;
  String get reraCertificatePDF => _reraCertificatePDF;
  String get  PanCard => _PanCard;
  String get lISTofDirectors => _lISTofDirectors;
  String get partnershipDeeds => _partnershipDeeds;
  String get listOfpartners => _listOfpartners;
  String get tnCFlag => _tnCFlag;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['CustomerAccountId'] = _customerAccountId;
    map['ReraCertificatePDF'] = _reraCertificatePDF;
    map[' PanCard'] = _PanCard;
    map['LISTofDirectors'] = _lISTofDirectors;
    map['partnershipDeeds'] = _partnershipDeeds;
    map['listOfpartners'] = _listOfpartners;
    map['TnCFlag'] = _tnCFlag;
    return map;
  }

}