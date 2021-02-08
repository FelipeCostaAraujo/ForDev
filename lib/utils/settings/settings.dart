import 'package:flutter_dotenv/flutter_dotenv.dart';

class Settings{
  static final String apiUrl = env['API_URL'];
  static final String fordevUrl = env['FORDEV_URL'];
  static final String oneSignalAppId = env['ONESIGNAL_APP_ID'];
}