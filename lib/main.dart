import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:async';
import 'dart:convert';
import 'asset.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:pathfinder/edit.dart';



Future<List<Item>> _fetchItems() async{
  final _response =
  await http.get(
      Uri.parse(
          'https://storage.googleapis.com/mobile_example/data/items.json'
      )
  );
  var _text = utf8.decode(_response.bodyBytes);
  var _dataJson = jsonDecode(_text)['items'] as List;
  final List<Item> parsedResponse = _dataJson.map((dataJson)=>Item.fromJson(dataJson)).toList();

  items.clear();
  items.addAll(parsedResponse);

  return items;
}


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'PathFinder Coding Test',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("박민준, rieull0225@gmail.com"),

                OrientationBuilder(
                  builder: (context, orientation){
                    return Container(
                      decoration:  BoxDecoration(color : Colors.white, borderRadius: BorderRadius.all(Radius.circular(15))),
                      height: orientation == Orientation.portrait ?  MediaQuery.of(context).size.height*0.7 : MediaQuery.of(context).size.width*0.7,
                      child :FutureBuilder<List<Item>>(
                          future: _fetchItems(),
                          builder : (context, snapshot){
                            if(snapshot.hasError) print("error :  ${snapshot.error}" );
                            return snapshot.hasData ?
                            CardView()
                                :Center(child : CircularProgressIndicator());
                          }
                      )

                    );
                  } ,
                ),

                TextButton(child : Text("편집") , onPressed: (){
                  Get.to(()=>Edit());
                },),

              ],
            ),
          ),
        )
    );
  }


}

 class CardView extends StatefulWidget {
  const CardView({Key? key}) : super(key: key);

  @override
  _CardViewState createState() => _CardViewState();
}

class _CardViewState extends State<CardView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: PageView.builder(
        controller : PageController(initialPage: 0),
        itemCount: len,
        itemBuilder: (BuildContext context, int index){
          return items[index].text == null
              ? CachedNetworkImage(
              imageUrl: "${items[index].image_url}",
          placeholder: (context, url) =>Padding(
            padding: const EdgeInsets.fromLTRB(130, 220,130,220),
            child: CircularProgressIndicator(),
          ))
              : Padding(
            padding: const EdgeInsets.all(18.0),
            child: Center(
              child: ListView(
                children: [
                  Center(child: Text("${items[index].text}")),
                ],
              ),
            ),
          );
        },
      ),
    );

  }
}



