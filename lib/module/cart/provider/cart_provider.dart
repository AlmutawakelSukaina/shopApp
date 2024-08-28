import '../../../libs.dart';

class CartProvider extends ChangeNotifier {
  // List to store cart items
  final List<Product> _cartItems = [];
  final List<Product> _allProductList = [];
  final Map<int, int> _productCount = {};

  // Getter for cart items
  List<Product> get cartItems => List.unmodifiable(_cartItems);
  List<Product> get allProduct => List.unmodifiable(_allProductList);

 int getCountProduct(Product product)
  {
  return   _productCount[product.id]??0;
  }
  // Getter for total amount
  double get totalAmount {
    double total = 0.0;
    for (var product in _cartItems) {
      total += product.price * (_productCount[product.id] ?? 1);
    }
    return total;
  }

  // Add a product to the cart
  void addToCart(Product product) {
    _allProductList.add(product);
    if (_productCount.containsKey(product.id)) {
      _productCount[product.id] = _productCount[product.id]! + 1;
    } else {
      _cartItems.add(product);
      _productCount[product.id] = 1;
    }
    notifyListeners(); // Notify listeners to update the UI
  }

  // Remove a product from the cart
  void removeFromCart(Product product) {
    if (_productCount.containsKey(product.id) && _productCount[product.id]! > 1) {
      _productCount[product.id] = _productCount[product.id]! - 1;
    } else {
      _cartItems.remove(product);
      _productCount.remove(product.id);
    }
    _allProductList.remove(product);
    notifyListeners(); // Notify listeners to update the UI
  }

  // Method to clear the cart after checkout
  void clearCart() {
    _cartItems.clear();
    _productCount.clear();
    _allProductList.clear();
    notifyListeners();
  }

  // Method to get the products and total amount for checkout
  Map<String, dynamic> checkout() {
    return {
      'products': List.unmodifiable(_cartItems),
      'totalAmount': totalAmount,
    };
  }
}
