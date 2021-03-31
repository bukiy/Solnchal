import 'package:eAgric_admin/helpers/enumerators.dart';
import 'package:eAgric_admin/locator.dart';
import 'package:eAgric_admin/pages/categories/categories_page.dart';
import 'package:eAgric_admin/provider/app_provider.dart';
import 'package:eAgric_admin/rounting/route_names.dart';
import 'package:eAgric_admin/services/navigation_service.dart';
import 'package:eAgric_admin/widgets/navbar/navbar_logo.dart';
import 'package:eAgric_admin/widgets/side_menu/side_menu_item.dart';
import 'package:eAgric_admin/provider/app_provider.dart';
import 'package:eAgric_admin/provider/tables.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SideMenuTabletDesktop extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AppProvider appProvider = Provider.of<AppProvider>(context);
    return Container(
      decoration: BoxDecoration(
          color: Colors.blueGrey,
          gradient: LinearGradient(
            colors: [Colors.blueGrey, Colors.blueGrey.shade600],
          ),
          boxShadow: [
            BoxShadow(
                color: Colors.grey[200], offset: Offset(3, 5), blurRadius: 17)
          ]),
      width: 250,
      child: Container(
        child: Column(
          children: [
            NavBarLogo(),
            SideMenuItemDesktop(
              icon: Icons.dashboard,
              text: 'Dashboard',
              active: appProvider.currentPage == DisplayedPage.HOME,
              onTap: () {
                appProvider.changeCurrentPage(DisplayedPage.HOME);
                locator<NavigationService>().navigateTo(HomeRoute);
              },
            ),
            SideMenuItemDesktop(
              icon: Icons.people,
              text: 'Users',
              active: appProvider.currentPage == DisplayedPage.USERS,
              onTap: () {
                appProvider.changeCurrentPage(DisplayedPage.USERS);

                // ChangeNotifierProvider.value(value: AppProvider.init());
                // ChangeNotifierProvider.value(value: TablesProvider.init());

                locator<NavigationService>().navigateTo(UsersRoute);
              },
            ),
            SideMenuItemDesktop(
              icon: Icons.shopping_cart,
              text: 'Orders',
              active: appProvider.currentPage == DisplayedPage.ORDERS,
              onTap: () {
                appProvider.changeCurrentPage(DisplayedPage.ORDERS);
                locator<NavigationService>().navigateTo(OrdersRoute);
              },
            ),
            SideMenuItemDesktop(
              icon: Icons.stream,
              text: 'Seeds',
              active: appProvider.currentPage == DisplayedPage.PRODUCTS,
              onTap: () {
                appProvider.changeCurrentPage(DisplayedPage.PRODUCTS);
                locator<NavigationService>().navigateTo(ProductsRoute);
              },
            ),
            SideMenuItemDesktop(
              icon: Icons.house_siding_sharp,
              text: 'Warehouse',
              active: appProvider.currentPage == DisplayedPage.CATEGORIES,
              onTap: () {
                appProvider.changeCurrentPage(DisplayedPage.CATEGORIES);
                locator<NavigationService>().navigateTo(CategoriesRoute);
              },
            ),
            SideMenuItemDesktop(
              icon: Icons.agriculture,
              text: 'Machines',
              active: appProvider.currentPage == DisplayedPage.Machines,
              onTap: () {
                appProvider.changeCurrentPage(DisplayedPage.Machines);
                locator<NavigationService>().navigateTo(MachinesRoute);
              },
            ),
          ],
        ),
      ),
    );
  }
}
