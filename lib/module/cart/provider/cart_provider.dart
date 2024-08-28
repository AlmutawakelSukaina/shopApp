
import '../../../libs.dart';

class CartProvider extends ChangeNotifier {
  // List to store cart items
  final List<Product> _cartItems = [];
  final  productCount={};
  // Getter for cart items
  List<Product> get cartItems => List.unmodifiable(_cartItems);

  // Add a product to the cart
  void addToCart(Product product) {
    _cartItems.add(product);
    notifyListeners(); // Notify listeners to update the UI
  }

  // Optional: Remove a product from the cart
  void removeFromCart(Product product) {
    _cartItems.remove(product);
    notifyListeners(); // Notify listeners to update the UI
  }
}
