import 'dart:async';
import 'package:booking_system/models/business_data.dart';
import 'package:booking_system/services/search_business.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:dio/dio.dart';

class SearchBusiness extends StatefulWidget{
  const SearchBusiness({super.key});

  @override
  _SearchBusinessState createState() => _SearchBusinessState();
}

class _SearchBusinessState extends State<SearchBusiness>{
  final TextEditingController _searchController = TextEditingController();
  Timer? _debounce;
  List<BusinessData> _searchResults = [];
  bool _isLoading = false;
  
  void onSearchChanged(String query){
    if(_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(Duration(milliseconds: 500), (){
      if(query.isNotEmpty){
        _performSearch(query);
      }
    });
  }

  Future<void> _performSearch(String query) async{
    setState(() => _isLoading = true);
    final dio = Provider.of<Dio>(context, listen: false);
    try{
      final results = await searchBusiness(dio, query);
      setState(() {
        _searchResults = results;
        _isLoading = false;
      });
    }catch(error){
      print(error);
    }finally{
      setState(() {
      //_searchResults = results;
      _isLoading = false;
    });
    }
  }

  @override
  void initState(){
    super.initState();
    _searchController.addListener(() {
      onSearchChanged(_searchController.text);
    });
    _searchController.text = "t";
  }

  @override
  void dispose(){
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context){

    return Column(
      children: [
        //Search Bar
        Container(
          margin: EdgeInsets.symmetric(horizontal: 25.0),
          child: TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: 'Search for business... NOW',
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: Colors.grey
            ),
          ),
        ),
        SizedBox(height: 16.0),

        _isLoading ? const Center(child: CircularProgressIndicator())
        : _searchResults.isNotEmpty ? 
          Column(
            children: [
              for (var result in _searchResults)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(result.getName()!),
                    SizedBox(width: 30,),
                    ElevatedButton(
                      onPressed: () {Navigator.pushNamed(context, '/Business', arguments: result);},
                      child: Text("Press")
                    )
                  ],
                ),
            ],
          )
          : _searchController.text.isNotEmpty ? const Center(child: Text("No business found!")) : SizedBox.shrink(),

      ],
    );
  }
}