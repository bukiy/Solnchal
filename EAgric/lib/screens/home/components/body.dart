import 'package:EAgric/constants.dart';
import 'package:EAgric/models/Product.dart';
import 'package:EAgric/screens/cart/cart_screen.dart';
import 'package:EAgric/screens/category_products/category_products_screen.dart';
import 'package:EAgric/screens/product_details/product_details_screen.dart';
import 'package:EAgric/screens/search_result/search_result_screen.dart';
import 'package:EAgric/services/authentification/authentification_service.dart';
import 'package:EAgric/services/data_streams/all_products_stream.dart';
import 'package:EAgric/services/data_streams/favourite_products_stream.dart';
import 'package:EAgric/services/database/product_database_helper.dart';
import 'package:EAgric/size_config.dart';
import 'package:flutter/material.dart';
import 'package:future_progress_dialog/future_progress_dialog.dart';
import 'package:logger/logger.dart';
import '../../../utils.dart';
import '../components/home_header.dart';
import 'product_type_box.dart';
import 'products_section.dart';

const String ICON_KEY = "icon";
const String TITLE_KEY = "title";
const String PRODUCT_TYPE_KEY = "product_type";

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final productCategories = <Map>[
    <String, dynamic>{
      ICON_KEY: "assets/icons/tractor-1.svg",
      TITLE_KEY: "Tractors",
      PRODUCT_TYPE_KEY: ProductType.Tractors,
    },
    <String, dynamic>{
      ICON_KEY: "assets/icons/combine-harvester-3.svg",
      TITLE_KEY: "Harvesters",
      PRODUCT_TYPE_KEY: ProductType.Harvesters,
    },
    <String, dynamic>{
      ICON_KEY: "assets/icons/tractor-2.svg",
      TITLE_KEY: "Loaders",
      PRODUCT_TYPE_KEY: ProductType.Loaders,
    },
    <String, dynamic>{
      ICON_KEY: "assets/icons/farm-11.svg",
      TITLE_KEY: "Rents",
      PRODUCT_TYPE_KEY: ProductType.Rents,
    },
    <String, dynamic>{
      ICON_KEY: "assets/icons/seeds-1.svg",
      TITLE_KEY: "Seeds",
      PRODUCT_TYPE_KEY: ProductType.Seeds,
    },
    <String, dynamic>{
      ICON_KEY: "assets/icons/spray-1.svg",
      TITLE_KEY: "Sprayes",
      PRODUCT_TYPE_KEY: ProductType.Sprayers,
    },
    <String, dynamic>{
      ICON_KEY: "assets/icons/farm-11.svg",
      TITLE_KEY: "Others",
      PRODUCT_TYPE_KEY: ProductType.Others,
    },
  ];

  final FavouriteProductsStream favouriteProductsStream =
      FavouriteProductsStream();
  final AllProductsStream allProductsStream = AllProductsStream();

  @override
  void initState() {
    super.initState();
    favouriteProductsStream.init();
    allProductsStream.init();
  }

  @override
  void dispose() {
    favouriteProductsStream.dispose();
    allProductsStream.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: RefreshIndicator(
        onRefresh: refreshPage,
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(screenPadding)),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(height: getProportionateScreenHeight(15)),
                HomeHeader(
                  onSearchSubmitted: (value) async {
                    final query = value.toString();
                    if (query.length <= 0) return;
                    List<String> searchedProductsId;
                    try {
                      searchedProductsId = await ProductDatabaseHelper()
                          .searchInProducts(query.toLowerCase());
                      if (searchedProductsId != null) {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SearchResultScreen(
                              searchQuery: query,
                              searchResultProductsId: searchedProductsId,
                              searchIn: "All Products",
                            ),
                          ),
                        );
                        await refreshPage();
                      } else {
                        throw "Couldn't perform search due to some unknown reason";
                      }
                    } catch (e) {
                      final error = e.toString();
                      Logger().e(error);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("$error"),
                        ),
                      );
                    }
                  },
                  onCartButtonPressed: () async {
                    bool allowed =
                        AuthentificationService().currentUserVerified;
                    if (!allowed) {
                      final reverify = await showConfirmationDialog(context,
                          "You haven't verified your email address. This action is only allowed for verified users.",
                          positiveResponse: "Resend verification email",
                          negativeResponse: "Go back");
                      if (reverify) {
                        final future = AuthentificationService()
                            .sendVerificationEmailToCurrentUser();
                        await showDialog(
                          context: context,
                          builder: (context) {
                            return FutureProgressDialog(
                              future,
                              message: Text("Resending verification email"),
                            );
                          },
                        );
                      }
                      return;
                    }
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CartScreen(),
                      ),
                    );
                    await refreshPage();
                  },
                ),
                SizedBox(height: getProportionateScreenHeight(15)),
                SizedBox(
                  height: SizeConfig.screenHeight * 0.1,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      physics: BouncingScrollPhysics(),
                      children: [
                        ...List.generate(
                          productCategories.length,
                          (index) {
                            return ProductTypeBox(
                              icon: productCategories[index][ICON_KEY],
                              title: productCategories[index][TITLE_KEY],
                              onPress: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        CategoryProductsScreen(
                                      productType: productCategories[index]
                                          [PRODUCT_TYPE_KEY],
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: getProportionateScreenHeight(20)),
                SizedBox(
                  height: SizeConfig.screenHeight * 0.5,
                  child: ProductsSection(
                    sectionTitle: "Products You Like",
                    productsStreamController: favouriteProductsStream,
                    emptyListMessage: "Add Product to Favourites",
                    onProductCardTapped: onProductCardTapped,
                  ),
                ),
                SizedBox(height: getProportionateScreenHeight(20)),
                SizedBox(
                  height: SizeConfig.screenHeight * 0.8,
                  child: ProductsSection(
                    sectionTitle: "Explore All Products",
                    productsStreamController: allProductsStream,
                    emptyListMessage: "Looks like all Stores are closed",
                    onProductCardTapped: onProductCardTapped,
                  ),
                ),
                SizedBox(height: getProportionateScreenHeight(80)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> refreshPage() {
    favouriteProductsStream.reload();
    allProductsStream.reload();
    return Future<void>.value();
  }

  void onProductCardTapped(String productId) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProductDetailsScreen(productId: productId),
      ),
    ).then((_) async {
      await refreshPage();
    });
  }
}
