import 'package:bloc/bloc.dart';

class ValueCubit<T> extends Cubit<T> {
  ValueCubit(T initialState) : super(initialState);

  set state(T value) {
    emit(value);
  }
}
