import 'package:flutter/widgets.dart';

class OrderProvider extends ChangeNotifier{
  int quantity =1;
  String selectedDeliveryType = 'Deliver';

  bool get isDeliverOrder => selectedDeliveryType == 'Deliver';
  void changeDeliveryType(String deliveryType){
    selectedDeliveryType = deliveryType;
    notifyListeners();
  }

  void onIncreaseQuantityTap(){
    quantity = quantity +1;
    notifyListeners();
  }

  void onDecreaseQuantityTap(){
    if(quantity == 1) return;
    quantity = quantity - 1;
    notifyListeners();
  }
}