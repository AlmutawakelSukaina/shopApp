import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/libs.dart';
import 'package:shop_app/module/cart/view/cart_counter.dart';
import 'package:shop_app/module/product/model/model.dart';
import 'package:shop_app/module/product/view/product_card.dart';

class ProductList extends StatefulWidget {
  const ProductList({super.key});

  @override
  ProductListState createState() => ProductListState();
}

class ProductListState extends State<ProductList> {
  final TextEditingController searchProduct = TextEditingController();
  final refreshProduct=ValueNotifier<bool>(false);
  Future<List<Product>>? responseProduct;

  void getProduct() {
    responseProduct = sl<ProductProvider>().getProductFromApi();
  }
List<Product> searchFun(List product)
{
  List<Product> listProduct=[];
  for(Product pro in product)
    {
      if(pro.title.contains(searchProduct.text) || pro.description.contains(searchProduct.text) )

        {
          listProduct.add(pro);
        }
    }
  return listProduct;
}
  @override
  void initState() {
    super.initState();
    getProduct();
  }

  @override
  void dispose() {
    searchProduct.dispose();
    refreshProduct.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: customAppBar(
          hasBack: false,
          title: 'Products',
          actions: const [
            CartCounter(),
          ],
        ),
        body: FutureBuilder<List<Product>>(
          future: responseProduct,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const LoadingIndicator();
            } else if (snapshot.data != null && snapshot.data!.isEmpty) {
              return const CustomTextApp(
                text: "No Products found",
              );
            } else {
              List<Product> list=snapshot.data!;
              return Column(
                children: [

                  CustomTextField(
                    textEditingController: searchProduct,
                    hint: "What you are looking for",
                    suffixIcon: Icon(
                      Icons.search,
                      color: AppColors.orange,

                    ),
                    onChange: (String value){
                    list=  searchFun(snapshot.data!);
                    refreshProduct.value=!  refreshProduct.value;
                    },
                  ).symmetricPadding(10, 10),

                  ValueListenableBuilder(valueListenable: refreshProduct,
                      builder: (context, value, child) {
                      return   Expanded(
                        child: ListView.builder(
                          itemCount: list.length,
                          itemBuilder: (context, index) {
                            return ProductCard(product:list[index])
                                .symmetricPadding(10, 10);
                          },
                        ),
                      );

                      },)

                ],
              );
            }
          },
        ));
  }
}
