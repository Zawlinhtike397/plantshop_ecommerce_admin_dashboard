class AppRoutes {
  static const String login = '/login';
  static const String dashboard = '/dashboard';
  static const String products = '/products';
  static const String orders = '/orders';
  static const String customers = '/customers';
  static const String discountCupons = '/discounts';
  static const String categories = '/categories';
  static const String settings = '/settings';
  static const String logout = '/logout';
  static const String profile = '/profile';
  static const String addProduct = '/addProduct';

  static String editProduct = '/editProduct/:id';
  static String editProductPath(String id) => '/editProduct/$id';

  static const String orderDetail = '/orderDetail/:id';
  static String orderDetailPath(String id) => '/orderDetail/$id';
}
