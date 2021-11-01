class User {
  String firstName,
      lastName,
      phoneNumber,
      emailAddress,
      role,
      foodTruckId,
      profilePicUrl;

  User(this.firstName, this.lastName, this.phoneNumber, this.emailAddress,
      this.role, this.foodTruckId);

  Map<String, String> toMap() {
    Map<String, String> mapToReturn = new Map();

    mapToReturn["firstName"] = firstName;
    mapToReturn["lastName"] = lastName;
    mapToReturn["phoneNumber"] = phoneNumber;
    mapToReturn["emailAddress"] = emailAddress;
    mapToReturn["role"] = role;
    mapToReturn["foodTruckId"] = foodTruckId;
    mapToReturn["profilePicUrl"] = profilePicUrl;

    return mapToReturn;
  }

  User.fromMap(Map<String, dynamic> mapToReturn) {
    this.firstName = mapToReturn["firstName"];
    this.lastName = mapToReturn["lastName"];
    this.phoneNumber = mapToReturn["phoneNumber"];
    this.emailAddress = mapToReturn["emailAddress"];
    this.role = mapToReturn["role"];
    this.foodTruckId = mapToReturn["foodTruckId"];
    this.profilePicUrl = mapToReturn["profilePicUrl"];
  }

  @override
  String toString() {
    return 'User{firstName: $firstName, lastName: $lastName, phoneNumber: $phoneNumber, emailAddress: $emailAddress, role: $role, foodTruckId: $foodTruckId, profilePicUrl: $profilePicUrl}';
  }
}