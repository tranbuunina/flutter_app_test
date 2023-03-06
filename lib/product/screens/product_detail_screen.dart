import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:milktea/cart/model/cart_model.dart';
import 'package:milktea/cart/provider/cart_repository.dart';
import 'package:milktea/product/provider/product_controller.dart';

import '../../cart/screens/cart_screen.dart';
import '../model/product_model.dart';

class ProductDetail extends ConsumerStatefulWidget {
  final int id;

  const ProductDetail({Key? key, required this.id}) : super(key: key);

  @override
  _ProductDetailState createState() => _ProductDetailState();
}

class _ProductDetailState extends ConsumerState<ProductDetail>
    with TickerProviderStateMixin {
  late TabController tabController;
  int _counter = 0;
  final int _counterStar = 1;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _incrementCounterMinus() {
    if (_counter > _counterStar) {
      setState(() {
        _counter--;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  List<String> btnSizes = ['M', 'L'];
  int? _selectedSize;

  @override
  Widget build(BuildContext context) {
    final _productDetail = ref.watch(
        ProductController.futureProductDetailProvider(widget.id.toString()));


    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leadingWidth: 50,
          iconTheme: const IconThemeData(
            color: Colors.black, // <-- SEE HERE
          ),
        ),
        extendBodyBehindAppBar: true,
        body: SingleChildScrollView(
          child: _productDetail.when(
            error: (err, stack) => Text('Error: $err'),
            data: (ProductModel? data) {
              return Column(
                children: [
                  SlideCarousel(data!.gallery),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              data!.name.toString(),
                              style: const TextStyle(
                                  fontFamily: 'Oswald',
                                  fontSize: 20,
                                  color: Color(0xff282828)),
                            ),
                            GestureDetector(
                              onTap: () => Navigator.of(context).pop(),
                              child: Container(
                                alignment: Alignment.center,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      'assets/images/Heart.png',
                                      width: 25,
                                      height: 25,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            NumberFormat.simpleCurrency(
                                    locale: 'vi-VN', decimalDigits: 0)
                                .format(data!.regularPrice),
                            style: const TextStyle(
                                fontSize: 25,
                                fontFamily: 'Oswald',
                                color: Color(0xffFB9116),
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          width: double.maxFinite,
                          child: TabBar(
                            isScrollable: false,
                            dividerColor: const Color(0xffEFEFEF),
                            controller: tabController,
                            indicatorColor: const Color(0xffFB9116),
                            indicatorSize: TabBarIndicatorSize.tab,
                            labelColor: const Color(0xffFB9116),
                            unselectedLabelColor: const Color(0xff656565),
                            labelStyle: const TextStyle(
                                fontFamily: 'Oswald',
                                color: Color(0xffFB9116),
                                fontSize: 16),
                            unselectedLabelStyle: const TextStyle(
                                fontFamily: 'Oswald',
                                color: Color(0xff656565),
                                fontSize: 16),
                            // ignore: prefer_const_literals_to_create_immutables
                            tabs: [
                              const Tab(
                                child: Text('Chi tiết'),
                              ),
                              const Tab(
                                child: Text('Thành phần'),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(top: 20, bottom: 20),
                          width: double.maxFinite,
                          height: 125,
                          child: TabBarView(
                            controller: tabController,
                            children: [
                              Text(
                                data!.desc.toString(),
                                style: const TextStyle(
                                    fontFamily: 'Oswald',
                                    fontWeight: FontWeight.w300,
                                    color: Color(0xff656565),
                                    height: 2),
                              ),
                              Text(
                                data!.content.toString(),
                                style: const TextStyle(
                                    fontFamily: 'Oswald',
                                    fontWeight: FontWeight.w300,
                                    color: Color(0xff656565),
                                    height: 2),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Text(
                              'Size:',
                              style: TextStyle(
                                  fontFamily: 'Oswald',
                                  fontSize: 14,
                                  color: Color(0xff222222)),
                            ),
                            const SizedBox(width: 20),
                            ...List.generate(
                              data.listSize!.length,
                              (index) => btnSize(
                                index: index,
                                text: data.listSize![index].namevi.toString(),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                shape: const CircleBorder(),
                                side:
                                    const BorderSide(color: Color(0xffFB9116)),
                                backgroundColor: Colors.white,
                                padding: EdgeInsets.zero,
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                minimumSize: const Size(40, 40),
                              ),
                              child: const FaIcon(
                                FontAwesomeIcons.minus,
                                color: Color(0xffFB9116),
                                size: 17,
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(left: 7, right: 7),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 10),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(3),
                                  color: Colors.white,
                                  border: Border.all(
                                      color: const Color(0xffDDDDE3))),
                              child: const Text(
                                '1',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 16),
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                shape: const CircleBorder(),
                                side:
                                    const BorderSide(color: Color(0xffFB9116)),
                                backgroundColor: Colors.white,
                                padding: EdgeInsets.zero,
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                minimumSize: const Size(40, 40),
                              ),
                              child: const FaIcon(
                                FontAwesomeIcons.plus,
                                color: Color(0xffFB9116),
                                size: 17,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 170,
                              height: 50,
                              child: ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  backgroundColor: const Color(0xffFAF2EA),
                                ),
                                child: const Text('Mua Ngay',
                                    style: TextStyle(
                                        fontFamily: 'Oswald',
                                        fontSize: 14,
                                        color: Color(0xffFB9116))),
                              ),
                            ),
                            SizedBox(
                              width: 185,
                              height: 50,
                              child: ElevatedButton(
                                onPressed: () {
                                  ref.read(cartProvider.notifier).addToCart(
                                      CartModel(
                                          id: data.id.toString(),
                                          name: data.name.toString(),
                                          price: double.parse(data.regularPrice.toString()),
                                          images: data.photo.toString(),
                                          quantity: 1));
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const CartScreen()));
                                },
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  backgroundColor: const Color(0xffFB9116),
                                ),
                                child: const Text('Thêm Vào Giỏ Hàng',
                                    style: TextStyle(
                                        fontFamily: 'Oswald',
                                        fontSize: 15,
                                        color: Colors.white)),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              );
              ;
            },
            loading: () => const Center(child: CircularProgressIndicator()),
          ),
        ));
  }

  Widget btnSize({required String text, required int index}) {

    return InkWell(
      splashColor: const Color(0xffFB9116),
      onTap: () {

        setState(() {
          _selectedSize = index;
        });
      },
      child: Container(
        padding: const EdgeInsets.all(7),
        color: index == _selectedSize ? Colors.white : Colors.white,
        child: Text(
          text,
          style: TextStyle(
            color: index == _selectedSize
                ? const Color(0xffFB9116)
                : const Color(0xff222222),
          ),
        ),
      ),
    );
  }

  SlideCarousel(List<String>? images) {
    return SizedBox(
      width: double.maxFinite,
      child: CarouselSlider(
        items: images!
            .map(
              (pic) => CachedNetworkImage(
                imageUrl: (Uri.tryParse(pic!)!.hasAbsolutePath == true)
                    ? pic
                    : 'https://upload.wikimedia.org/wikipedia/commons/1/14/No_Image_Available.jpg',
                placeholder: (context, url) => Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [CircularProgressIndicator()],
                ),
                errorWidget: (context, url, error) => const Icon(Icons.error),
                fit: BoxFit.cover,
              ),
            )
            .toList(),
        options: CarouselOptions(
          height: 350,
          enlargeCenterPage: true,
          autoPlay: true,
          aspectRatio: 16 / 9,
          autoPlayCurve: Curves.fastOutSlowIn,
          enableInfiniteScroll: true,
          autoPlayAnimationDuration: const Duration(milliseconds: 800),
          viewportFraction: 1,
        ),
      ),
    );
  }
}
