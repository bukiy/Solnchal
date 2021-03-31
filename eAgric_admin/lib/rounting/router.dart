
import 'package:eAgric_admin/main.dart';
import 'package:eAgric_admin/pages/brands/brands_page.dart';
import 'package:eAgric_admin/pages/categories/categories_page.dart';
import 'package:eAgric_admin/pages/login/login.dart';
import 'package:eAgric_admin/pages/registration/registration.dart';
import 'package:eAgric_admin/widgets/layout/layout.dart';

import '../pages/home/home_page.dart';
import '../pages/orders/orders_page.dart';
import '../pages/products/products_page.dart';
import '../pages/users/users_page.dart';
import 'package:eAgric_admin/rounting/route_names.dart';
import 'package:flutter/material.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  print('generateRoute: ${settings.name}');
  switch (settings.name) {
    case HomeRoute:
      return _getPageRoute(HomePage());
    case UsersRoute:
      return _getPageRoute(UsersPage());
    case ProductsRoute:
      return _getPageRoute(ProductsPage());
    case OrdersRoute:
      return _getPageRoute(OrdersPage());
    case LoginRoute:
      return _getPageRoute(LoginPage());
    case RegistrationRoute:
      return _getPageRoute(RegistrationPage());
          case LayoutRoute:
      return _getPageRoute(LayoutTemplate());
                case CategoriesRoute:
      return _getPageRoute(CategoriesPage());
                case MachinesRoute:
      return _getPageRoute(MachinesPage());
                case PageControllerRoute:
      return _getPageRoute(AppPagesController());
    default:
      return _getPageRoute(LoginPage());
  }
}

PageRoute _getPageRoute(Widget child) {
  return MaterialPageRoute(
    builder: (context) => child,
  );
}