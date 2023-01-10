import 'package:flutter/material.dart';

import '../model/model.dart';
import '../repositores/rep.dart';
import '../style/style.dart';
import '../unity/horizontal_product.dart';

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

  @override
  void initState() {
    getInformation();
    super.initState();
  }

  getInformation() async {
    isLoading = true;
    lifOfProduct = await GetInfo.getProduct();
    getinfos = await GetInfo.gethamma();
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
                              return Container(
                                  margin: const EdgeInsets.only(right: 8),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(16),
                                      color: Style.bgCategory),
                                  padding: const EdgeInsets.all(8),
                                  child: Center(
                                      child: Text("${getinfos[index]}")));
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
                                      crossAxisCount: 2),
                              itemBuilder: (context, index) => Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      width: 149,
                                      height: 215,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(23),
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
