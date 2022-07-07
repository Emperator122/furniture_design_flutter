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

  Future<void> _onIncreaseProductCount(
    IncreaseProductCount event,
    Emitter<CartState> emit,
  ) async {
    if (state is CartLoadedState) {
      final loadedState = state as CartLoadedState;
      emit(loadedState.copyWith(sendingData: true));
      if (_changeProductCount(1, event.product)) {
        await repository.changeProductCount(1, event.product);
        emit(loadedState.copyWith(sendingData: false));
      }
    }
  }

  Future<void> _onDecreaseProductCount(
    DecreaseProductCount event,
    Emitter<CartState> emit,
  ) async {
    if (state is CartLoadedState) {
      final loadedState = state as CartLoadedState;
      emit(loadedState.copyWith(sendingData: true));
      if (_changeProductCount(-1, event.product)) {
        await repository.changeProductCount(-1, event.product);
        emit(loadedState.copyWith(sendingData: false));
      }
    }
  }

  Future<void> _onRemoveProduct(
    RemoveProduct event,
    Emitter<CartState> emit,
  ) async {
    if (state is CartLoadedState) {
      final loadedState = state as CartLoadedState;
      emit(loadedState.copyWith(sendingData: true));
      final products = loadedState.products;
      products.remove(event.product);
      emit(loadedState.copyWith(sendingData: false));
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
  final bool sendingData;

  CartLoadedState({
    required this.products,
    this.sendingData = false,
  });

  CartLoadedState copyWith({
    List<CartProduct>? products,
    bool? sendingData,
  }) {
    return CartLoadedState(
      products: products ?? this.products,
      sendingData: sendingData ?? this.sendingData,
    );
  }
}

class CartEmpty extends CartState {}

class CartLoadingState extends CartState {}

class CartErrorState extends CartState {}
