class ErrorsMessages {
  static const String serverFailure =
      'There is a problem with server, please try again later';
  static const String offlineFailure = 'Please check your internet connection';
  static const String unknownFailure =
      'There is an unexpected failure, please try again later';
  static const String locationFailure = 'User denied location permission';
}

class RoutesName {
  static const String loginScreen = 'login-screen';
  static const String formScreen = 'form-screen';
  static const String selectShipmentScreen = 'select-shipment-screen';
}

class MainStrings {
  static const String mainTitle = 'Shipment Tracking';
}

class LoginStrings {
  static const String loginTitle = 'Welcome';
  static const String successLoginMessage = 'You have logged in successfully';
}

class FormStrings {
  static const String formTitle = 'Please fill this form';
  static const String formName = 'Name';
  static const String formNumber = 'Number';
  static const String formSubmit = 'Submit';
  static const String nameValidator = 'Please enter your name';
  static const String phoneValidator = 'Please enter your phone number';
  static const String successionSubmit = 'Thanks, your form submitted';
}

class SelectShipmentStrings {
  static const String title = 'Select a shipment';
  static const String enterId = 'Enter shipmentID';
  static const String textValidator = 'IDs = [ID_1, ID_2, ID_3]';
  static const String loadingShipmentsSuccessState =
      'Loading all shipments success';
}

class AllTrackersStrings {
  static const String title = 'Ongoing Shipments';
  static const String loadingAllTrackerSuccessfully = 'All trackers loaded successfully';
  static const String mapRouteName = 'Map_screen';


}