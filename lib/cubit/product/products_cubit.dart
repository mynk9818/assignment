import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import '../../models/product.dart';
import '../../routes.dart';
import '../../services/dio_service.dart';

part 'products_state.dart';

class ProductsCubit extends Cubit<ProductsState> {
  ProductsCubit() : super(ProductsInitial());
  final List<Product> products = [];

  int currentPage = 0;
  bool isCurrentlyFetching = false;
  bool hasMoreData = true;

  Future<void> fetch() async {
    if (isCurrentlyFetching) return;
    int page = currentPage * 10;
    String url = 'https://dummyjson.com/products?skip=$page&limit=10';
    isCurrentlyFetching = true;
    final response = await DioServices.getInstance().get(url);
    if (response.statusCode != 200) {
      emit(ProductsErrorState());
      hasMoreData = false;
      showToast();
      return;
    }

    final data = response.data['products'];
    for (var element in data) {
      products.add(Product.fromJson(element));
    }
    if (data.length < 10) {
      showToast();
      hasMoreData = false;
    }
    isCurrentlyFetching = false;
    currentPage += 1;
    emit(ProductsLoadedState());
  }

  void showToast() {
    OnGenerateRoute.scaffoldKey.currentState?.showSnackBar(const SnackBar(content: Text('End Of List')));
  }
}
