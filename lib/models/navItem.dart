class NavItem {
  final String title;

  const NavItem({required this.title});

  static NavItem fromJson(Map<String, dynamic> json) => NavItem(title: json["army"]);
}
