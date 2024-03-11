import 'package:trend/config/locale/app_localizations.dart';

String generateResponseErrorMessage(Map<String, dynamic> response) {
  List errorMessages = [];

  response.forEach((key, value) {
    if (value is List) {
      errorMessages.addAll(value);
    }
  });

  String errorMessage = errorMessages.join('\n');
  return errorMessage.isNotEmpty
      ? errorMessage
      : 'Unknown error occurred'.hardcoded;
}
