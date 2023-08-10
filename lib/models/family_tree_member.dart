// models/family_tree_member.dart
class FamilyTreeMember {
  final String id;
  final String name;
  final String profileImageUrl;
  final String contact;
  final String education;
  final String whatsapp;
  final String age;
  final FamilyTreeMember? spouse;
  final List<FamilyTreeMember> children;

  FamilyTreeMember({
    required this.id,
    required this.name,
    required this.profileImageUrl,
    required this.contact,
    required this.education,
    required this.whatsapp,
    required this.age,
    this.spouse,
    this.children = const [],
  });

  factory FamilyTreeMember.fromJson(Map<String, dynamic> json) {
    return FamilyTreeMember(
      id: json['id'],
      name: json['name'],
      profileImageUrl: json['profileImageUrl'],
      contact: json['contact'],
      education: json['education'],
      whatsapp: json['whatsapp'],
      age: json['age'],
      spouse: json['spouse'] != null ? FamilyTreeMember.fromJson(json['spouse']) : null,
      children: json['children'] != null
          ? (json['children'] as List).map((child) => FamilyTreeMember.fromJson(child)).toList()
          : [],
    );
  }
}
