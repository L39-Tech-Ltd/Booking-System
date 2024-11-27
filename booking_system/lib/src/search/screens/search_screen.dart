import 'package:booking_system/src/search/screens/search_business.dart';
import 'package:flutter/material.dart';
import '../../../widgets/base_screen.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context){
    return BaseScreen(
      title: 'L39',
      body: Container(
        child: Column(
          children: [
            const Text("Search"),
            ElevatedButton(onPressed: () {Navigator.pop(context);}, child: const Text("Back")),
            SearchBusiness()
          ]
        ),
      ),
    );
  }
}