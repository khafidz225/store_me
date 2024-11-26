import 'home_count_product_cart.dart';

class HomeCartEntities {
  final List<HomeProductItemEntities> items;

  HomeCartEntities({this.items = const []});

  double get subtotal {
    final rawSubtotal = items.fold(
        0.0, (total, item) => total + (item.product.price * item.count));
    return double.parse(rawSubtotal.toStringAsFixed(2));
  }

  double get deliveryFee => 5.0;

  double get total {
    final rawTotal = subtotal + deliveryFee;
    return double.parse(rawTotal.toStringAsFixed(2));
  }

  HomeCartEntities copyWith({List<HomeProductItemEntities>? items}) {
    return HomeCartEntities(
      items: items ?? this.items,
    );
  }
}
