import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:lean_requester/lean_interceptor.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'api/data_source.dart';
import 'app/app_widget.dart';
import 'base/screens/exports.dart';
import 'modules/products/data/datasource/products_local_datasource.dart';
import 'modules/products/data/datasource/products_remote_datasource.dart';
import 'modules/products/data/models/product_model.dart';
import 'modules/products/data/repository/products_repository_impl.dart';
import 'modules/products/domain/repository/products_repository.dart';
import 'modules/products/domain/usecases/get_product_by_id.dart';
import 'modules/products/presentation/bloc/products_bloc.dart';

part 'main_injection.dart';
part 'main_styling.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await _Dependencies.inject();

  final List<ProductModel>? products = await TestDataSource(client: Dio()).getProducts();

  _Styling.statusBarTransparency();
  _Styling.allowedDeviceOrientations();

  if (false) runApp(AppWidget());
}

final class TestDataSource extends LeanRequesterConfig {
  TestDataSource({required Dio client}) : super(client);

  Future<List<ProductModel>?> getProducts() async {
    try {
      return (await performDecodingRequest<DaoList>(
        debugIt: false,
        path: "products",
        method: RestfullMethods.get,
        dao: DaoList<ProductModel>(item: ProductModel(), key: "products"),
        mockIt: false,
        mockingData: {
          "id": 2,
          "title": "iPhone de Jewel",
          "description": "SIM-Free, Model A19211 6.5-inch Super Retina HD display with OLED technology A12 Bionic chip with ...",
          "price": 899,
          "rating": 4.44,
          "stock": 34,
          "thumbnail": "https://i.dummyjson.com/data/products/2/thumbnail.jpg",
          "images": [
            "https://i.dummyjson.com/data/products/2/1.jpg",
            "https://i.dummyjson.com/data/products/2/2.jpg",
            "https://i.dummyjson.com/data/products/2/3.jpg",
          ]
        },
      ))
          .list as List<ProductModel>?;
    } catch (_) {
      throw ServerException();
    }
  }
}
