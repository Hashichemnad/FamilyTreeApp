class FamilyTreeMember {
  final String id;
  final String name;
  final String profileImageUrl;
  final String contact;
  final String education;
  final String whatsapp;
  final String age;
  final String familyId;
  final String blood;
  final String count;
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
    required this.familyId,
    required this.blood,
    required this.count,
    this.spouse,
    this.children = const [],
  });

  factory FamilyTreeMember.fromJson(Map<String, dynamic> json) {
    return FamilyTreeMember(
      id: json['id'],
      name: json['name'],
      profileImageUrl: json['profileImageUrl'],  // '../assets/images/logo.png',// 
      contact: json['contact'],
      education: json['education'],
      whatsapp: json['whatsapp'],
      age: json['age'],
      familyId: "[ "+json['familyId']+" ]",
      blood: json['blood'],
      count: "[ Members : "+json['count']+" ]",
      spouse: json['spouse'] != null ? FamilyTreeMember.fromJson(json['spouse']) : null,
      children: json['children'] != null
          ? (json['children'] as List).map((child) => FamilyTreeMember.fromJson(child)).toList()
          : [],
    );
  }
}
