class StaffModel {
  StaffModel({
    required this.id,
    required this.designation,
    required this.mobileNo,
    required this.email,
    required this.name,
    required this.dob,
    required this.address,
    required this.bloodGroup,
    required this.idCardNumber,
    required this.profileImage,
    required this.rewardPoints,
    required this.isActive,
  });

  int id;
  String designation;
  String mobileNo;
  String email;
  String name;
  String dob;
  String address;
  String bloodGroup;
  String idCardNumber;
  String profileImage;
  String rewardPoints;
  int isActive;

  factory StaffModel.fromJson(Map<String, dynamic> json) => StaffModel(
        id: json["id"],
        designation: json["designation"],
        mobileNo: json["mobile_no"],
        email: json["email"],
        name: json["name"],
        dob: json["dob"],
        address: json["address"],
        bloodGroup: json["blood_group"],
        idCardNumber: json["id_card_number"],
        profileImage: json["profile_image"],
        rewardPoints: json["reward_points"],
        isActive: json["is_active"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "designation": designation,
        "mobile_no": mobileNo,
        "email": email,
        "name": name,
        "dob": dob,
        "address": address,
        "blood_group": bloodGroup,
        "id_card_number": idCardNumber,
        "profile_image": profileImage,
        "reward_points": rewardPoints,
        "is_active": isActive,
      };
}
