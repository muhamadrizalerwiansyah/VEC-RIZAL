import 'package:get/get.dart';

import '../../../../../models/product_model.dart';
import '../../../../../models/request/product_list_request_model.dart';
import '../../../../../repositories/product_repository.dart';
import '../../../../../utils/networking_util.dart';
import '../../../../../widgets/snackbar_widget.dart';

class ProductListController extends GetxController {
  final ProductRepository _productRepository;

  ProductListController({
    required ProductRepository productRepository,
  }) : _productRepository = productRepository;

  final _products = Rx<List<ProductModel>>([]);

  List<ProductModel> get products => _products.value;

  final _isLoadingRetrieveProduct = false.obs;

  bool get isLoadingRetrieveProduct => _isLoadingRetrieveProduct.value;

  final _isLoadingRetrieveMoreProduct = false.obs;

  bool get isLoadingRetrieveMoreProduct => _isLoadingRetrieveMoreProduct.value;

  final _isLoadingRetrieveCategory = false.obs;

  bool get isLoadingRetrieveCategory => _isLoadingRetrieveCategory.value;

  final _canFilterCategory = true.obs;

  bool get canFilterCategory => _canFilterCategory.value;

  final _isLastPageProduct = false.obs;

  //The number of product retrieved each time a call is made to server
  final _limit = 10;

  //The number which shows how many product already loaded to the device,
  //thus giving the command to ignore the first x number of data when retrieving
  int _skip = 0;

  @override
  void onInit() {
    super.onInit();
    getProducts();
  }

  //first load or after refresh.
  void getProducts() async {
    _isLoadingRetrieveProduct.value = true;
    _skip = 0;
    try {
      final productList =
          await _productRepository.getProductList(ProductListRequestModel(
        limit: _limit,
        skip: _skip,
      ));
      _products.value = productList.data;
      _products.refresh();
      _isLastPageProduct.value = productList.data.length < _limit;
      _skip = products.length;
    } catch (error) {
      SnackbarWidget.showFailedSnackbar(NetworkingUtil.errorMessage(error));
    }
    _isLoadingRetrieveProduct.value = false;
  }

  void getMoreProducts() async {
    if (_isLastPageProduct.value || _isLoadingRetrieveMoreProduct.value) return;

    _isLoadingRetrieveMoreProduct.value = true;

    //TODO: finish this function by calling get product list with appropriate parameters

    _isLoadingRetrieveMoreProduct.value = false;
  }

  void toProductDetail(ProductModel product) async {
    //TODO: finish this implementation by creating product detail page & calling it here
  }

  void setFavorite(ProductModel product) {
    product.isFavorite = !product.isFavorite;
  }
}
