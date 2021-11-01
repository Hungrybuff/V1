import 'package:json_annotation/json_annotation.dart';

part 'payment_model.g.dart';

@JsonSerializable()
class Payment {
  String url;
  String name;
  bool isTap;

  Payment(this.url, this.name, this.isTap);

  @override
  String toString() {
    return 'PaymentModel{url: $url, name: $name, isTap: $isTap}';
  }

  factory Payment.fromJson(Map<String, dynamic> json) =>
      _$PaymentFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentToJson(this);
}
