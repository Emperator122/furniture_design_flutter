import 'package:bloc/bloc.dart';
import 'package:furniture/cart/models/cart_product.dart';
import 'package:furniture/repositories/cart_repository.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final CartRepository repository;

  CartBloc({
    required this.repository,
  }) : super(CartLoadingState()) {
    on<Initialize>(_onInitialize);
    on<IncreaseProductCount>(_onIncreaseProductCount);
    on<DecreaseProductCount>(_onDecreaseProductCount);
    on<RemoveProduct>(_onRemoveProduct);

    add(Initialize());
  }

  Future<void> _onInitialize(
    Initialize event,
    Emitter<CartState> emit,
  ) async {
    final products = await repository.getProducts();
    emit(CartLoadedState(products: products));
  }

  void _onIncreaseProductCount(
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

  void _onDecreaseProductCount(
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

  void _onRemoveProduct(
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
    final index =
        products.indexWhere((element) => element.product == product.product);
    if (index == -1) return false;
    final oldProduct = products[index];
    products.removeAt(index);
    final newProduct = oldProduct.copyWith(count: oldProduct.count + count);
    if (newProduct.count > 0) {
      products.insert(index, newProduct);
    }
    return true;
  }
}

abstract class CartEvent {}

class Initialize extends CartEvent {}

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
