class FamilyMember {
  final String id;
  final String name;
  final String fatherName;
  final String profileImageUrl;
  final String contact;
  final String familyId;

  FamilyMember({
    required this.id,
    required this.name,
    required this.fatherName,
    required this.profileImageUrl,
    required this.contact,
    required this.familyId,
  });

  factory FamilyMember.fromJson(Map<String, dynamic> json) {
    return FamilyMember(
      id: json['id'],
      name: json['name'],
      fatherName: json['fatherName'],
      profileImageUrl:    json['profileImageUrl'], //'../assets/images/logo.png',//
      contact: json['contact'],
      familyId: json['familyId'],
    );
  }
}
