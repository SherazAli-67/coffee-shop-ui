import 'package:coffee_app/core/app_icons.dart';
import 'package:coffee_app/core/models/coffee_model.dart';

class AppData {
  static List<String> get categoriesList => [
    'All Coffee', 'Machiato', 'Latte', 'Americano', 'Espresso'
  ];

  static List<CoffeeModel> get coffeesList => [
    CoffeeModel(id: '1', title: 'Caffe Mocha', coffee: AppIcons.coffee1, subtitle: 'Deep Foam', price: 4.53, rating: 4.8),
    CoffeeModel(id: '2', title: 'Flat White', coffee: AppIcons.coffee2, subtitle: 'Espresso', price: 3.53, rating: 4.8),
    CoffeeModel(id: '3', title: 'Mocha Fusi', coffee: AppIcons.coffee3, subtitle: 'Ice/Hot', price: 7.53, rating: 4.8),
    CoffeeModel(id: '4', title: 'Caffe Panna', coffee: AppIcons.coffee4, subtitle: 'Deep Foam', price: 5.53, rating: 4.8),
  ];
}