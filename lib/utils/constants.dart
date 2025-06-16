
//routes
enum SMRoute {
  login('/'),
  home('/home'),
  sendMoney('/sendMoney'),
  transaction('/transaction');

  final String path;
  const SMRoute(this.path);
}

//constants
final RegExp emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+$');