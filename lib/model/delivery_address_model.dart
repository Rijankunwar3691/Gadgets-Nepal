class DeliveryAddressModel {
  String firstName;
  String lastName;
  String mobileNo;
  String alternateMobileNo;

  String city;
  String aera;

  String addressType;

  DeliveryAddressModel({
    required this.addressType,
    required this.aera,
    required this.alternateMobileNo,
    required this.city,
    required this.firstName,
    required this.lastName,
    required this.mobileNo,
  });
}
