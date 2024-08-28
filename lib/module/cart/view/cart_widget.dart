import 'package:shop_app/core/custom_widget/custom_text.dart';

import '../../../libs.dart';

class CartWidget extends StatelessWidget {
  const CartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(title: "Cart", actions: [
        const CartCounter(),
      ]),
      body: Consumer<CartProvider>(builder: (context, cartProvider, child) {
        List<Product> product = cartProvider.cartItems.toSet().toList();
        if (product.isNotEmpty) {
          return ListView.builder(
            itemCount: product.length,
            itemBuilder: (context, index) {
              return ProductCard(
                product: product[index],
                count: cartProvider.getCountProduct(product[index]),
              );
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
      }),
      bottomNavigationBar: Consumer<CartProvider>(
        builder: (context, cartProvider, child) {
          return cartProvider.cartItems.isNotEmpty
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomTextApp(
                      text:
                          'Total: \$${cartProvider.totalAmount.toStringAsFixed(2)}',
                      size: 18,
                      font: FontWeight.bold,
                    ),
                    CustomButton(
                      onPressed: () {
                        context.pushName(AppRoutes.checkoutPage);
                      },
                      text: "Check out",
                    ),
                  ],
                ).symmetricPadding(10, 10)
              : const Nothing();
        },
      ),
    );
  }
}
