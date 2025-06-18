
//routes
enum SMRoute {
  login('/'),
  home('/home'),
  sendMoney('/sendMoney'),
  transaction('/transaction');

  final String path;
  const SMRoute(this.path);
}

//status
enum SendMoneyStatus {
  notStarted,
  loading,
  done,
}

//constants
final RegExp emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+$');