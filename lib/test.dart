class ChildrenCard extends StatelessWidget {
  final FamilyTreeMember child;

  ChildrenCard({required this.child});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, '/familyMemberDetails', arguments: child);
      },
      child: Card(
        // Your card content here (profile photo, name, and arrow icon)
      ),
    );
  }
}
