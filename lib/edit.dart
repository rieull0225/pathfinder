import 'package:flutter/material.dart';
import 'asset.dart';
import 'package:flutter/foundation.dart';



class Edit extends StatefulWidget {
  const Edit({Key? key}) : super(key: key);

  @override
  _EditState createState() => _EditState();
}

class _EditState extends State<Edit> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Container(
            height : MediaQuery.of(context).size.height,
            child: ReorderableListView(
              header: Center(child: Text('순서 변경은 long drag, 삭제는 휴지통 버튼',
              style: TextStyle(color : Color(0xff4271ff), fontSize: 20),)),
              padding: EdgeInsets.all(30),
              children: <Widget>[
                for(int i = 0; i < items.length ; ++i)
                  ListTile(
                    key : Key('$i'),
                    title : items[i].text == null
                        ? Text("${items[i].image_url!.substring(items[i].image_url!.lastIndexOf("/")+1)}")
                        :Text("${items[i].text!.substring(0,items[i].text!.indexOf("\n"))}"),
                    trailing: IconButton(
                        onPressed: (){
                          setState((){
                            items.removeAt(i);
                            len -= 1;
                          });
                        },
                        icon: Icon(Icons.delete)),
                  )
              ],
              onReorder: (int oldIndex, int newIndex){
                setState((){
                  if(oldIndex > newIndex){
                    newIndex -= -1;
                  }
                  final Item index = items.removeAt(oldIndex);
                  items.insert(newIndex-1, index);
                });
              },
            ),
          ),
        ),
      ),
    );
  }
}

