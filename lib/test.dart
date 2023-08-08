class _FamilyTreePageState extends State<FamilyTreePage> {
  // ... existing code ...

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                if (Navigator.canPop(context))
                  IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                Text(
                  'Family Tree',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Spacer(), // Adds a flexible space
                IconButton(
                  icon: Icon(Icons.home),
                  onPressed: () {
                    Navigator.popUntil(context, (route) => route.isFirst);
                  },
                ),
              ],
            ),
            // ... rest of the code ...
          ],
        ),
      ),
    );
  }
}
