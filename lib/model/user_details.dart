import 'package:json_annotation/json_annotation.dart';

part 'user_details.g.dart';

@JsonSerializable()
class UserDetails {
  String firstName;
  String lastName;
  String phoneNumber;
  String emailAddress;

  UserDetails(
      this.firstName, this.lastName, this.phoneNumber, this.emailAddress);

  factory UserDetails.fromJson(Map<String, dynamic> json) =>
      _$UserDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$UserDetailsToJson(this);
}
