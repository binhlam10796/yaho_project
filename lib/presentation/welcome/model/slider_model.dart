import 'package:yaho/common/resources/resources.dart';

class SliderModel {
  String? image;
  String? title;
  String? content;

  SliderModel({
    this.image,
    this.title,
    this.content,
  });
}

List<SliderModel> getSlides() {
  return [
    SliderModel(
      image: ImageAssets.splashLogo,
      title: "Tiêu đề 1",
      content: "Nội dung của màn hình welcome 1",
    ),
    SliderModel(
      image: ImageAssets.splashLogo,
      title: "Tiêu đề 2",
      content: "Nội dung của màn hình welcome 2",
    ),
    SliderModel(
      image: ImageAssets.splashLogo,
      title: "Tiêu đề 3",
      content: "Nội dung của màn hình welcome 3",
    ),
  ];
}
