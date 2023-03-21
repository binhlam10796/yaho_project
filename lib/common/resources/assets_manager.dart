import 'package:yaho/utils/extension/extension_string.dart';

const String imagePath = "assets/images";
const String jsonPath = "assets/json";

class ImageAssets {
  static final String splashLogo = "splash".toPNG;
  static final String imgError = "img_error".toPNG;
}


class JsonAssets {
  static final String appConfig = "app_config".toJSON;
  static final String error = "error".toJSON;
  static final String bottomLoading = "bottom_loading".toJSON;
  static final String dotsLoading = "dots_animation".toJSON;
}
