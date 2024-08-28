import '../../../libs.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final int? count;

  const ProductCard({
    super.key,
    required this.product,   this.count,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      surfaceTintColor: AppColors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(15),
        onTap: () {
          context.pushPage(ProductDetailsScreen(product: product));
        },
        child: Row(
          children: [
            // Image section

            //TODO There is problem with cacheNetowkImage
               if( product.image!=null)
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                product.image!,
                fit: BoxFit.cover,
                height: 80,
                width: 80,
              ),
            ),

            16.pw,
            // Content section
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  CustomTextApp(
                    text: product.title,
                    size: 16,
                    font: FontWeight.bold,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  4.ph,

                  // Category
                  Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 4, horizontal: 8),
                      decoration: BoxDecoration(
                        color: Colors.orange[50],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: CustomTextApp(
                        text: product.category,
                        font: FontWeight.w500,
                        colors: Colors.blueGrey.shade700,
                      )),

                  8.ph,

                  // Rating
                  Row(
                    children: [
                      const Icon(
                        Icons.star,
                        color: Colors.yellow,
                        size: 16,
                      ),
                      4.pw,
                      CustomTextApp(
                        text: product.rating.rate.toString(),
                        size: 14,
                      ),
                      4.pw,
                      CustomTextApp(
                        text: '(${product.rating.count})',
                        size: 12,
                        colors: Colors.grey,
                      )
                    ],
                  ),
                  8.ph,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomTextApp(
                        text: '\$${product.price}',
                        size: 16,
                        font: FontWeight.bold,
                        colors: Colors.green,
                      ),
                      if(count!=null&&count! >0)
                      Container(
                        padding: const EdgeInsets.all(5),

                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.red

                        ),
                        child: CustomTextApp(
                          text:"$count",
                          size: 20,
                          colors: Colors.white,
                        ),
                      ),
                      5.pw,
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
