class SliderModel {
  String imageAssetPath;
  String title;
  String desc;

  SliderModel({this.imageAssetPath, this.title, this.desc});

  void setImageAssetPath(String getImageAssetPath) {
    imageAssetPath = getImageAssetPath;
  }

  void setTitle(String getTitle) {
    title = getTitle;
  }

  void setDesc(String getDesc) {
    desc = getDesc;
  }

  String getImageAssetPath() {
    return imageAssetPath;
  }

  String getTitle() {
    return title;
  }

  String getDesc() {
    return desc;
  }
}

List<SliderModel> getSlides() {
  List<SliderModel> slides = new List<SliderModel>();
  SliderModel sliderModel = new SliderModel();

  //1
  sliderModel.setDesc("Learn from experts of the preffered subjects");
  sliderModel.setTitle("Knowledge");
  sliderModel.setImageAssetPath("assets/images/slider1.png");
  slides.add(sliderModel);

  sliderModel = new SliderModel();

  //2
  sliderModel.setDesc("Learn whenever you want and from anywhere");
  sliderModel.setTitle("Wisdom");
  sliderModel.setImageAssetPath("assets/images/slider2.png");
  slides.add(sliderModel);

  sliderModel = new SliderModel();

  //3
  sliderModel.setDesc("Contents available offline");
  sliderModel.setTitle("Education");
  sliderModel.setImageAssetPath("assets/images/slider3.png");
  slides.add(sliderModel);

  sliderModel = new SliderModel();

  return slides;
}
