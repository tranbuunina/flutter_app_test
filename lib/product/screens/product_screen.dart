// ignore_for_file: library_private_types_in_public_api, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:animations/animations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:milktea/product/screens/product_detail_screen.dart';
import 'package:riverpod/riverpod.dart';

import '../../cart/screens/cart_screen.dart';
import '../model/product_model.dart';
import '../provider/product_controller.dart';



class ProductScreen extends ConsumerStatefulWidget {
  const ProductScreen({Key? key}) : super(key: key);

  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends ConsumerState<ProductScreen> with TickerProviderStateMixin{

  late TabController tabController;
  int indexTab = 0;

  @override
  void initState() {
    super.initState();
    tabController =
        TabController(length: 1, vsync: this, initialIndex: indexTab);
  }

  _handleTabController() {
    if (tabController.indexIsChanging) {
      setState(() {
        indexTab = tabController.index;
      });
    }
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Menu"),
          actions: <Widget>[
            TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                          const CartScreen()));
                },
                child: Image.asset("assets/images/icon_cart.png",
                    fit: BoxFit.contain)),
          ],
        ),
      body: Padding(
        padding: const EdgeInsets.only(top: 0, bottom: 0, left: 10, right: 10),
        child: ref.watch(ProductController.futureCategoryProvider).when(
          error: (err, stack) => Text('Error: $err'),
          data: (List<Category>? data){
            tabController = TabController(
                vsync: this,
                length: data!.length,
                initialIndex: indexTab);
            tabController.addListener(_handleTabController);
            return Column(
              children: [
                TabBar(
                  overlayColor:
                  MaterialStateProperty.all<Color>(Colors.transparent),
                  isScrollable: true,
                  dividerColor: Colors.transparent,
                  controller: tabController,
                  indicatorColor: Colors.transparent,
                  labelPadding: const EdgeInsets.only(
                      top: 0, left: 0, right: 5, bottom: 0),
                  tabs: data.map((e) {
                    return Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 20),
                      decoration: BoxDecoration(
                        border: indexTab == data.indexOf(e)
                            ? Border.all(color: Colors.white, width: 0)
                            : Border.all(
                            color: const Color(0xff757575), width: 1),
                        borderRadius: BorderRadius.circular(50),
                        color: indexTab == data.indexOf(e)
                            ? const Color(0xffFB9116)
                            : Colors.white,
                      ),
                      child: Text(
                        e.namevi.toString(),
                        style: TextStyle(
                          fontFamily: 'Oswald',
                          fontSize: 16,
                          color: indexTab == data.indexOf(e)
                              ? Colors.white
                              : const Color(0xff171717),
                        ),
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: TabBarView(
                    controller: tabController,
                    children: data.map((var e) {
                      return GridProductView(id: int.parse(e.id.toString()));
                    }).toList(),
                  ),
                )
              ],
            );
          }, loading: () =>  const Center(child: CircularProgressIndicator()),
        ),
      ),
    );
  }
}

class GridProductView extends ConsumerWidget {
  late int id;
  GridProductView({super.key,required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var transitionType = ContainerTransitionType.fadeThrough;
    final listProduct = ref.watch(ProductController.futureProductCategoryProvider('$id')) ;
    return Container(
      child: listProduct.when(
        error: (err, stack) => Text('Error: $err'),
        data: (List<ProductModel>? data){
          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200,
                childAspectRatio: 0.8,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10),
            itemCount: data?.length,
            itemBuilder: (context, index) => OpenContainer(
              closedColor: Colors.white,
              closedElevation: 0,
              transitionType: transitionType,
              transitionDuration: const Duration(milliseconds: 490),
              openBuilder: (context, _) => ProductDetail(id: int.parse(data![index].id.toString())),
              closedBuilder: (context, action) {
                return Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Card(
                      color: const Color(0xfff8f8f8),
                      elevation: 0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(0),
                            child: Image.network(
                              data![index].photo.toString(),
                              fit: BoxFit.cover,
                              width: 200,
                              height: 150,
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 10, bottom: 5),
                            child: Text(
                              data![index].name.toString(),
                              style: const TextStyle(
                                  fontFamily: 'Oswald',
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xff222222)),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Text(
                            NumberFormat.simpleCurrency(
                                locale: 'vi-VN', decimalDigits: 0)
                                .format(data![index].regularPrice),
                            style: const TextStyle(
                                fontSize: 14,
                                fontFamily: 'Oswald',
                                color: Color(0xffFB9116),
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                    ));
              },
            ),
          );
        }, loading: () =>  const Center(child: CircularProgressIndicator()),
      ),
    );
  }

}
