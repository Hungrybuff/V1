import 'package:hungrybuff/other/utils/baseModel.dart';
import 'package:json_annotation/json_annotation.dart';

part 'splash_screen_data.g.dart';

@JsonSerializable()
class SplashScreenData extends BaseModel {
  bool didUserGiveAllTheDetials;
  bool isUserValidUser;

  SplashScreenData({this.didUserGiveAllTheDetials, this.isUserValidUser});

  @override
  String toString() {
    return 'SplashScreenData{didUserGiveAllTheDetials: $didUserGiveAllTheDetials, isUserValidUser: $isUserValidUser}';
  }

  factory SplashScreenData.fromJson(Map<String, dynamic> json) =>
      _$SplashScreenDataFromJson(json);

  Map<String, dynamic> toJson() => _$SplashScreenDataToJson(this);
}
