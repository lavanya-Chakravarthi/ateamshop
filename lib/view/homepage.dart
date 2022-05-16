
import 'package:ateamtest/service/productservice.dart';
import 'package:ateamtest/view/settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

import '../model/ProductProvider.dart';

class homePage extends StatefulWidget{
  homePageState createState()=> new homePageState();
}

class homePageState extends State<homePage>{

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    int count;
    if(MediaQuery.of(context).orientation == Orientation.landscape){
      count=4;
    }else{
      count=2;
    }
    var products=context.watch<productProvider>();
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: Text("Products"),
          actions: [
            IconButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>Settings()));
            }, icon: Icon(Icons.settings,color: Colors.white,))
          ],
        ),
        body: products.product==null?Container(
          child:const Center(
            child: CircularProgressIndicator(),
          )
        ):Container(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: count),
              itemCount: products.product.length,
              itemBuilder: (BuildContext context, int index){
                return productcard(products.product[index]);
              },
            )
        ),
    );
  }


  //product list as Grid view
  Widget productcard(item){
    return InkWell(
      onTap: (){
        showModalBottomSheet(
            isScrollControlled: true,
            // isDismissible: true,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            context: context,
            builder: (context) => modalSheet(item));
      },
      child: Card(
        elevation: 10.0,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(

            children: [
              Image.network(item["image"],
                height: 100.0,
                width: 100.0,
                // fit:BoxFit.cover,
              ),
              SizedBox(height: 5,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item["title"]??"N/A",
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    softWrap: true,
                  ),
                  SizedBox(height: 5,),
                  Text(
                    item["price"] != null?"\u{20B9} ${item["price"].toString()}" : "\u{20B9} 00.0",
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    softWrap: true,
                  ),
                ],
              )

            ],
          ),
        ),
      ),
    );
  }


  //Bottom Modal sheet widget
  Widget modalSheet(item){
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children:  [
          Row(
            children: [
              Text.rich(
                  TextSpan(
                      text: "Rating:  ",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                      children: <InlineSpan>[
                        TextSpan(
                            text: item["rating"]["rate"] != null?item["rating"]["rate"].toString():"null",
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                            )
                        )
                      ]
                  )
              ),
              RatingBar.builder(
                initialRating: item["rating"]["rate"],
                // minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemSize: 20,
                itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                itemBuilder: (context, _) => const Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                ignoreGestures:false,
                onRatingUpdate: (rating) {
                  print(rating);
                },
              )
            ],
          ),
          SizedBox(height: 10,),
          Text.rich(
              TextSpan(
                  text: "Category:  ",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                  children: <InlineSpan>[
                    TextSpan(
                        text: item["category"]??"null",
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                        )
                    )
                  ]
              )
          ),
          SizedBox(height: 10,),
          Text.rich(
              TextSpan(
                  text: "Description:  ",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                  children: <InlineSpan>[
                    TextSpan(
                        text: item["description"]??"null",
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                        )
                    )
                  ]
              )
          )
          // Text(item["description"]),
        ],),
    );
  }

}