import 'package:json_annotation/json_annotation.dart';

part 'baseModel.g.dart';

@JsonSerializable(
  checked: true,
  disallowUnrecognizedKeys: true,
  fieldRename: FieldRename.snake,
)
class BaseModel {
  @JsonKey(defaultValue: false)
  bool isError = false;
  @JsonKey(defaultValue: "")
  String error = "";

  BaseModel() {
    isError = false;
    error = "";
  }
}
