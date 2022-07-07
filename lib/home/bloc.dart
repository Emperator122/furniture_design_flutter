import 'package:bloc/bloc.dart';
import 'package:furniture/home/models/product.dart';
import 'package:furniture/repositories/products_repository.dart';

class HomePageBloc extends Bloc<HomePageEvent, HomePageState> {
  final ProductsRepository repository;

  HomePageBloc({
    required this.repository,
  }) : super(HomeLoadingState()) {
    on<Initialize>(_onInitialize);

    add(Initialize());
  }

  Future<void> _onInitialize(
    Initialize event,
    Emitter<HomePageState> emit,
  ) async {
    final products = await repository.getProducts();
    emit(HomeLoadedState(products: products));
  }
}

abstract class HomePageEvent {}

class Initialize extends HomePageEvent {}


abstract class HomePageState {}

class HomeLoadedState extends HomePageState {
  final List<Product> products;

  HomeLoadedState({required this.products});
}

class HomeEmpty extends HomePageState {}

class HomeLoadingState extends HomePageState {}

class HomeErrorState extends HomePageState {}
