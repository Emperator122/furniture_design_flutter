import 'package:bloc/bloc.dart';
import 'package:furniture/cart/models/cart_product.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc({
    required CartState initialState,
  }) : super(initialState) {
    on<IncreaseProductCount>(_increaseProductCount);
    on<DecreaseProductCount>(_decreaseProductCount);
    on<RemoveProduct>(_removeProduct);
  }

  void _increaseProductCount(
    IncreaseProductCount event,
    Emitter<CartState> emit,
  ) {
    if (state is CartLoadedState) {
      if (_changeProductCount(1, event.product)) {
        final products = (state as CartLoadedState).products;
        emit(CartLoadedState(products: products));
      }
    }
  }

  void _decreaseProductCount(
    DecreaseProductCount event,
    Emitter<CartState> emit,
  ) {
    if (state is CartLoadedState) {
      if (_changeProductCount(-1, event.product)) {
        final products = (state as CartLoadedState).products;
        emit(CartLoadedState(products: products));
      }
    }
  }

  void _removeProduct(
    RemoveProduct event,
    Emitter<CartState> emit,
  ) {
    if (state is CartLoadedState) {
      final products = (state as CartLoadedState).products;
      products.remove(event.product);
      emit(CartLoadedState(products: products));
    }
  }

  bool _changeProductCount(
    int count,
    CartProduct product,
  ) {
    assert(state is CartLoadedState);
    final products = (state as CartLoadedState).products;
    final index = products.indexWhere((element) => element.product == product.product);
    if (index == -1) return false;
    final oldProduct = products[index];
    products.removeAt(index);
    final newProduct = CartProduct(
      product: oldProduct.product,
      count: oldProduct.count + count,
    );
    if (newProduct.count > 0) {
      products.insert(index, newProduct);
    }
    return true;
  }
}

abstract class CartEvent {}

class IncreaseProductCount extends CartEvent {
  final CartProduct product;

  IncreaseProductCount({required this.product});
}

class DecreaseProductCount extends CartEvent {
  final CartProduct product;

  DecreaseProductCount({required this.product});
}

class RemoveProduct extends CartEvent {
  final CartProduct product;

  RemoveProduct({required this.product});
}

abstract class CartState {}

class CartLoadedState extends CartState {
  final List<CartProduct> products;

  CartLoadedState({required this.products});
}

class CartEmpty extends CartState {}

class CartLoadingState extends CartState {}

class CartErrorState extends CartState {}
