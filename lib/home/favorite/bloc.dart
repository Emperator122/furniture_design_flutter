import 'package:bloc/bloc.dart';
import 'package:furniture/home/models/product.dart';
import 'package:furniture/repositories/favorite_repository.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  final FavoriteRepository repository;

  FavoriteBloc({
    required this.repository,
  }) : super(FavoriteLoadingState()) {
    on<Initialize>(_onInitialize);
    on<RemoveProduct>(_onRemoveProduct);

    add(Initialize());
  }

  Future<void> _onInitialize(
    Initialize event,
    Emitter<FavoriteState> emit,
  ) async {
    final products = await repository.getProducts();
    emit(FavoriteLoadedState(products: products));
  }

  void _onRemoveProduct(
    RemoveProduct event,
    Emitter<FavoriteState> emit,
  ) {
    if (state is FavoriteLoadedState) {
      final products = (state as FavoriteLoadedState).products;
      products.remove(event.product);
      emit(FavoriteLoadedState(products: products));
    }
  }
}

abstract class FavoriteEvent {}

class Initialize extends FavoriteEvent {}

class RemoveProduct extends FavoriteEvent {
  final Product product;

  RemoveProduct({required this.product});
}

abstract class FavoriteState {}

class FavoriteLoadedState extends FavoriteState {
  final List<Product> products;

  FavoriteLoadedState({required this.products});
}

class FavoriteEmpty extends FavoriteState {}

class FavoriteLoadingState extends FavoriteState {}

class FavoriteErrorState extends FavoriteState {}
