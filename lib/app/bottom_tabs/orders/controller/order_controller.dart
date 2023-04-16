import 'package:get/get.dart';

class OrderController extends GetxController {
  var isDealLoading = false.obs;
  var isLoadingAddress = false.obs;
  var subCatStoreList = [].obs;
  var activeList = [].obs;
  var inActiveList = [].obs;
  var expireList = [].obs;
  var featureList = [].obs;
  var storeList = [].obs;
  var addressId;
  var tab = 0.obs;

  updateTab(val) {
    tab.value = val;

    update();
  }
  var addressList = [].obs;


  var editListId = [].obs;
  var editListName = [].obs;
  var editName = (-1).obs;


  var storeAddress = "".obs;
  var token = "".obs;






}
