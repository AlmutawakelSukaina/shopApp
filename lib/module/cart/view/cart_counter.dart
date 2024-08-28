import '../../../libs.dart';

class CartCounter extends StatelessWidget {
  const CartCounter({super.key});

  @override
  Widget build(BuildContext context) {
  return  Consumer<CartProvider>(
      builder: (context, cartProvider, child) {
        final itemCount = cartProvider.cartItems.length;

        return
          Badge(
            alignment: AlignmentDirectional.center,
            isLabelVisible: itemCount>0,
            backgroundColor: Colors.red,
            label: CustomTextApp(text:"$itemCount",
              colors: AppColors.white,),


            child: IconButton(
              icon:   Icon(Icons.shopping_basket,
                color: AppColors.orange,
              ),
              onPressed: () {
                context.pushName(AppRoutes.cartWidget);

              },
            ),).onTap((){
            context.pushName(AppRoutes.cartWidget);

          });

      },
    );
  }
}
