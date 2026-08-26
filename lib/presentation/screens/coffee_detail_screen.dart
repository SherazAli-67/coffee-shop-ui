import 'package:coffee_app/core/app_icons.dart';
import 'package:coffee_app/core/app_textstyles.dart';
import 'package:coffee_app/core/models/coffee_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CoffeeDetailScreen extends StatelessWidget{
  const CoffeeDetailScreen({super.key, required this.coffee});

  final CoffeeModel coffee;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: Padding(
        padding: const .all(24.0),
        child: Column(
          spacing: 16,
          children: [
            Row(
              mainAxisAlignment: .spaceBetween,
              children: [
                GestureDetector(onTap: ()=> Navigator.pop(context), child: Icon(Icons.arrow_back_ios_new),),
                Text("Detail", style: AppTextStyles.btnTextStyle,),
                SvgPicture.asset(AppIcons.icFavorite)
              ],
            ),
            Padding(
              padding: const .only(top: 8.0),
              child: Hero(
                tag: coffee.id,
                child: ClipRRect(
                  borderRadius: .circular(16),
                  child: SizedBox(
                      width: .infinity,
                      child: Image.asset(coffee.coffee, fit: .cover,)),
                ),
              ),
            )
          ],
        ),
      )),
    );
  }
}