import 'package:ateammt/model/product_model.dart';
import 'package:ateammt/repository/product_repository.dart';
import 'package:flutter/cupertino.dart';

class ProductState extends ChangeNotifier {
  ProductState() {
    fetchProductsList();
  }

  PageViewType _pageView = PageViewType.waiting;
  get pageView => _pageView;

  final List<Productmodel> _list = [];
  List<Productmodel> get productList => _list;

  String errorText = '';

  changeConnectionState(PageViewType state) {
    _pageView = state;
    notifyListeners();
  }

  Future<void> fetchProductsList() async {
    try {
      changeConnectionState(PageViewType.waiting);
      final response = await ProductRepository().fetchProductList();
      if (response?.isNotEmpty ?? false) {
        _list.addAll(response);
        changeConnectionState(PageViewType.active);
      }
    } catch (e) {
      errorText = e.toString();
      changeConnectionState(PageViewType.error);
      notifyListeners();
    }
  }
}

enum PageViewType { waiting, active, error }
