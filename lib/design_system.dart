import 'package:flutter/material.dart';
import 'package:wet_dreams/utils/app_texts.dart';
import 'package:wet_dreams/views/base/custom_app_bar.dart';
import 'package:wet_dreams/views/base/custom_button.dart';
import 'package:wet_dreams/views/base/custom_text_field.dart';
import 'package:wet_dreams/views/base/profile_picture.dart';

class DesignSystem extends StatelessWidget {
  const DesignSystem({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Design System"),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          spacing: 16,
          children: [
            ProfilePicture(image: "https://picsum.photos/200/200",),
            Text("Display Text", style: AppTexts.dlgr,),
            Text("Text Text", style: AppTexts.txlr,),
            CustomTextField(
              title: "Custom Title",
              hintText: "Hint Text",
            ),
            CustomButton(text: "Button Text"),
            
          ],
        ),
      ),
    );
  }
}
