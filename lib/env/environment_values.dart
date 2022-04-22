import 'package:piramal_channel_partner/env/environment_control.dart';

abstract class EnvironmentValues {
  static const int DEV = 0;
  static const int PROD = 1;

  static getTokenBody() {
    if (EnvironmentControl.currentEnv == DEV) {
      return {
        "grant_type": "password",
        "client_id": "3MVG9Se4BnchkASnJ0eDEZX9z9D7w5.Useb0G1N5w8TloI60n3z2sLOgAP.kQJMu4cDVDD6R8ZoiI52dTnngF",
        "client_secret": "ABBF4E5B2A89FD49A3FE015D63A715BDA2D7CA9CE54AD3991560E98276387FB4",
        "username": "aniket.khillari1010@stetig.in",
        "password": "Mobileapp@123u0vS6ZiRg9RNJHRVr9WeO1jpY",
      };
    } else {
      return {
        "grant_type": "password",
        "client_id": "3MVG9Y6d_Btp4xp4lVI7hc0WUtDYjwSgLAw.8mGivfrt3frW8NVjEjcjLI2Vfg_FzkEDulWGtkRqeiSxZ6nle",
        "client_secret": "C892D8F3AAAF197C32FB41ECF5BA1C2EB151A1F2B2586AB3BB26C51E5662B92B",
        "username": "swapnil.gavande1010@stetig.in",
        "password": "Salesforce@123IhdyiMlHpHSilZ3EJMSu8jdWx",
      };
    }
  }

  static get getBaseURL => EnvironmentControl.currentEnv == PROD
      ? "https://piramal-realty.my.salesforce.com/services/apexrest"
      : "https://prl--PRLAPP.my.salesforce.com/services/apexrest";

  static get getAccessTokenURL => EnvironmentControl.currentEnv == PROD
      ? "https://login.salesforce.com/services/oauth2/token"
      : "https://test.salesforce.com/services/oauth2/token";
}
