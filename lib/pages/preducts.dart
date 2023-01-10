import 'package:flutter/material.dart';

import '../model/model.dart';
import '../repositores/rep.dart';
import '../style/style.dart';
import '../unity/horizontal_product.dart';
import '../unity/image.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({Key? key}) : super(key: key);

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  List<ProductModel?>? lifOfProduct = [];
  List getinfos = [];
  bool isLoading = true;
  bool isHorizontal = true;
  int karoci = -1;

  @override
  void initState() {
    getInformation();
    super.initState();
  }

  getInformation() async {
    isLoading = true;
    setState(() {});
    lifOfProduct = await GetInfo.getProduct();
    getinfos = await GetInfo.gethamma();
    isLoading = false;
    setState(() {});
  }

  getproducts(String cat) async {
    isLoading = true;
    setState(() {});
    lifOfProduct = await GetInfo.Getcotegories(cat);
    isLoading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: isLoading
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 60,
                        height: 40,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(24)),
                        child: Icon(Icons.arrow_back_ios_new),
                      ),
                      SizedBox(
                        height: 100,
                        child: ListView.builder(
                            padding: const EdgeInsets.symmetric(
                                vertical: 16, horizontal: 24),
                            shrinkWrap: true,
                            itemCount: getinfos.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  if (karoci == index) {
                                    karoci = -1;
                                    getproducts()
                                  } else {
                                    karoci = index;
                                    getproducts(getinfos[index]);
                                  }
                                  setState(() {});
                                },
                                child: Container(
                                    margin: const EdgeInsets.only(right: 8),
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: karoci == index
                                                ? Color(0xff2AAF7F)
                                                : Colors.transparent),
                                        borderRadius: BorderRadius.circular(16),
                                        color: Style.bgCategory),
                                    padding: const EdgeInsets.all(8),
                                    child: Center(
                                        child: Text("${getinfos[index]}"))),
                              );
                            }),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text("All Product"),
                            IconButton(
                                onPressed: () {
                                  isHorizontal = !isHorizontal;
                                  setState(() {});
                                },
                                icon: Icon(
                                    isHorizontal ? Icons.menu : Icons.list))
                          ],
                        ),
                      ),
                      isHorizontal
                          ? ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: lifOfProduct?.length ?? 0,
                              itemBuilder: (context, index) {
                                return HorizontalProduct(
                                    product: lifOfProduct?[index]);
                              },
                            )
                          : GridView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: lifOfProduct?.length ?? 0,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      crossAxisSpacing: 17,
                                      mainAxisExtent: 250),
                              itemBuilder: (context, index) => Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      width: 149,
                                      height: 250,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(23),
                                        color: Color(0xffF1F4F3),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          CustomImageNetwork(
                                            image: lifOfProduct?[index]?.image,
                                            height: 149,
                                            width: 145,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 17, right: 30, top: 8),
                                            child: Text(
                                              '${lifOfProduct?[index]?.title}',
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 17, top: 10),
                                                child: Text(
                                                  '${lifOfProduct?[index]?.price}\$',
                                                  style: TextStyle(
                                                    color: Colors.green,
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                width: 53,
                                                height: 41,
                                                decoration: BoxDecoration(
                                                    color: Colors.green,
                                                    borderRadius:
                                                        BorderRadius.only(
                                                      topLeft:
                                                          Radius.circular(18),
                                                      bottomRight:
                                                          Radius.circular(23),
                                                    )),
                                                child: Center(
                                                    child: Icon(
                                                  Icons.add,
                                                  color: Colors.white,
                                                )),
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  )),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
