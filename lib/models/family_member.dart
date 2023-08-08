class FamilyMember {
  final String id;
  final String name;
  final String fatherName;
  final String profileImageUrl;
  final String contact;

  FamilyMember({
    required this.id,
    required this.name,
    required this.fatherName,
    required this.profileImageUrl,
    required this.contact,
  });

  factory FamilyMember.fromJson(Map<String, dynamic> json) {
    return FamilyMember(
      id: json['id'],
      name: json['name'],
      fatherName: json['fatherName'],
      profileImageUrl: '../assets/images/header_image.png',
      contact: json['contact'],
    );
  }
}
