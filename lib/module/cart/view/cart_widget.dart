import 'package:shop_app/module/product/view/product_card.dart';

import '../../../libs.dart';

class CartWidget extends StatelessWidget {
  const CartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: customAppBar(
          title: "Cart",
          actions: [  const CartCounter(),]

        ),
        body: Consumer<CartProvider>(builder: (context, cartProvider, child) {
          List<Product> product = cartProvider.cartItems.toSet().toList();
          if (product.isNotEmpty) {
            return ListView.builder(
            itemCount: product.length,
            itemBuilder: (context, index) {
              return ProductCard(product: product[index]);
            },
          );
          } else {
            return const Center(
            child: CustomTextApp(
              text: "No product in cart",
              size: 20,
            ),
          );
          }
        }));
  }
}
