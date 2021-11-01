import 'package:json_annotation/json_annotation.dart';

part 'Item.g.dart';

@JsonSerializable(nullable: false)
class Item {
  String name;

  Item(this.name);

  factory Item.fromJson(Map<String, dynamic> json) => _$ItemFromJson(json);

  Map<String, dynamic> toJson() => _$ItemToJson(this);
}
