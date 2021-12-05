
List<Item> items = [];
int len = items.length;

class Item{
  final String? text;
  final String? image_url;

  Item({this.text, this.image_url});

  factory Item.fromJson(Map<String, dynamic> parsedJson){
    return Item(
        text : parsedJson['text'],
        image_url : parsedJson['image_url']
    );
  }

}