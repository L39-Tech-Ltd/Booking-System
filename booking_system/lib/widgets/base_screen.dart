import 'package:booking_system/widgets/side_menu.dart';
import 'package:flutter/material.dart';
import 'footer.dart';
import 'header.dart';

class BaseScreen extends StatelessWidget {
  final Widget body;
  final String title;

  final double headHeight = 60.0 + 28.0;
  final double footerHeight = 200.0;

  const BaseScreen({
    super.key,
    required this.body,
    this.title = 'App Title'
  });

  @override
  Widget build(BuildContext context) {

    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(headHeight), 
        child: Header(title: title),
      ),

      endDrawer: SideMenu(),

      body: SingleChildScrollView(
        child: Column(
          children: [
            ConstrainedBox(
              constraints: BoxConstraints( 
                minHeight: screenHeight - headHeight - footerHeight,
              ),
              child: body,
            ),
            Footer()
          ],
        )
      )
    );
  }
}