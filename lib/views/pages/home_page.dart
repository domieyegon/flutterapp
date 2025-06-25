import 'package:flutter/material.dart';
import 'package:flutterapp/data/constants.dart';
import 'package:flutterapp/views/pages/course_page.dart';
import 'package:flutterapp/widgets/container_widget.dart';
import 'package:flutterapp/widgets/hero_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 10.0,),
            HeroWidget(title: 'Home', nextPage: CoursePage(),),
            SizedBox(height: 10.0,),
            ...List.generate(
              KItemList.items.length,
              (index) => ContainerWidget(
                title: KItemList.items.elementAt(index)['title']!,
                description: KItemList.items.elementAt(index)['description']!,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
