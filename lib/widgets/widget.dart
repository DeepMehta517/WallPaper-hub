import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wallpaperhub/models/wallpapermodel.dart';
import 'package:wallpaperhub/views/image_view.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';

//Widget brandname() {
//  return RichText(
//    text: TextSpan(
//      style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500),
//      children: <TextSpan>[
//        TextSpan(text: "Wallpaper",style: TextStyle(color: Colors.black)),
//        TextSpan(text: "Hub",style: TextStyle(color: Colors.red))
//      ]
//
//    ),
//  );
//}
//
//
//Widget wallpaperlist({List<PhotosModel> wallpapers,context}) {
//  return Container(
//
//    padding: EdgeInsets.symmetric(horizontal: 16),
//    child: GridView.count(
//    shrinkWrap: true,
//        physics: ClampingScrollPhysics(),
//        crossAxisCount: 2,
//        childAspectRatio: 0.6,
//        mainAxisSpacing: 6.0,
//        crossAxisSpacing: 6.0,
//        children:wallpapers.map((wallpaper){
//          return GridTile(
//          child:GestureDetector(
//            onTap: (){
//              Navigator.push(context, MaterialPageRoute(
//                  builder: (context) => ImageView(
//                    imgUrl: wallpaper.src.portrait ,
//                  )
//              ));
//            },
//            child: Hero(
//              tag:wallpaper.src.portrait  ,
//              child: Container(
//              child: ClipRRect(
//                  borderRadius:BorderRadius.circular(16) ,
//                  child: Image.network(wallpaper.src.portrait,fit:BoxFit.cover)),
//              ),
//            ),
//          )
//          );
//    }).toList()
//    ),
//  );
//}

//shkbajadsbasd


Widget brandName() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      Text(
        "Wallpaper",
        style: TextStyle(color: Colors.black87, fontFamily: 'Overpass'),
      ),
      Text(
        "Hub",
        style: TextStyle(color: Colors.red, fontFamily: 'Overpass'),
      )
    ],
  );
}
Widget wallPaper(List<PhotosModel> listPhotos, BuildContext context) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 16),
    child: GridView.count(
        crossAxisCount: 2,
        childAspectRatio: 0.6,
        physics: ClampingScrollPhysics(),
        shrinkWrap: true,
        padding: const EdgeInsets.all(4.0),
        mainAxisSpacing: 6.0,
        crossAxisSpacing: 6.0,
        children: listPhotos.map((PhotosModel photoModel) {
          return GridTile(
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ImageView(
                            imgPath: photoModel.src.portrait,
                          )));
                },
                child: Hero(
                  tag: photoModel.src.portrait,
                  child: Container(
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: kIsWeb
                            ? Image.network(
                          photoModel.src.portrait,
                          height: 50,
                          width: 100,
                          fit: BoxFit.cover,
                        )
                            : CachedNetworkImage(
                            imageUrl: photoModel.src.portrait,
                            placeholder: (context, url) => Container(
                              color: Color(0xfff5f8fd),
                            ),
                            fit: BoxFit.cover)),
                  ),
                ),
              ));
        }).toList()),
  );
}
