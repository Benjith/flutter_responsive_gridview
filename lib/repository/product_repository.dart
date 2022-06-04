import 'package:ateammt/model/product_model.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';

class ProductRepository {
  Future<List<Productmodel>> fetchProductList() async {
    try {
      var connectivityResult = await (Connectivity().checkConnectivity());
      if (connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.wifi) {
        var response = await Dio().get('https://fakestoreapi.com/products',);
        return List.generate(response.data.length,
            (index) => Productmodel.fromJson(response.data[index]));
      } else {
        throw ("No internet connection! retry");
      }
    } catch (e) {
      rethrow;
    }
  }
}
