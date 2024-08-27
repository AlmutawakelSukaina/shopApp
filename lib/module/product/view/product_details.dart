import '../../../libs.dart';

class ProductDetailsScreen extends StatelessWidget {
  final Product product;

  const ProductDetailsScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        title: product.title,
        actions: const [
          CartCounter(),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Image
            if( product.image!=null)
            Center(
              child: Image.network(
                product.image!,
                height: 250,
                fit: BoxFit.cover,
              ),
            ),
            16.ph,

            // Product Title
            CustomTextApp(
              text: product.title,
              size: 24,
              font: FontWeight.bold,
            ),
            8.ph,

            // Product Category
            CustomTextApp(
              text: product.category.toUpperCase(),
              size: 14,
              colors: Colors.grey,
            ),
            8.ph,

            // Product Rating
            Row(
              children: [
                const Icon(Icons.star, color: Colors.yellow, size: 20),
                4.pw,
                CustomTextApp(
                  text: product.rating.rate.toString(),
                  size: 16.0,
                  font: FontWeight.w500,
                ),
                4.pw,
                CustomTextApp(
                  text: '(${product.rating.count} reviews)',
                  size: 14.0,
                  colors: Colors.grey,
                ),
              ],
            ),
            16.ph,

            // Product Description
            CustomTextApp(
              text: product.description,
              size: 16.0,
            ),
            16.ph,

            // Product Price
            CustomTextApp(
              text: '\$${product.price}',
              size: 28.0,
              font: FontWeight.bold,
              colors: Colors.green,
            ),
            24.ph,

            Center(
              child: CustomButton(
                  onPressed: () {
                    Provider.of<CartProvider>(context, listen: false)
                        .addToCart(product);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('${product.title} added to cart')),
                    );
                  },
                  text: "Add to Cart"),
            )
          ],
        ),
      ),
    );
  }
}
