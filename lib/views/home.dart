import 'dart:convert';
import 'dart:ui';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wallpaperhub/data/data.dart';
import 'package:wallpaperhub/models/categorimodel.dart';
import 'package:wallpaperhub/models/wallpapermodel.dart';
import 'package:wallpaperhub/views/search.dart';
import 'package:wallpaperhub/widgets/widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:url_launcher/url_launcher.dart';

import 'catogeries.dart';

//class Home extends StatefulWidget {
//  @override
//  _HomeState createState() => _HomeState();
//}
//
//class _HomeState extends State<Home> {
//  List<CategorieModel> catogeries = new List();
//  List<PhotosModel> wallpapers = new List();
//  TextEditingController searchController = new TextEditingController();
//
//  getTrendingwallpaper() async {
//    var response = await http.get("https://api.pexels.com/v1/curated?per_page=1", headers: {"Authorization": apiKEY});
////        print(response.body.toString());
//
//    Map<String, dynamic> jsonData = jsonDecode(response.body);
//    jsonData["photos"].forEach((element) {
//      print(element);
//      PhotosModel wallpaperModel = new PhotosModel();
//      wallpaperModel = PhotosModel.fromMap(element);
//      wallpapers.add(wallpaperModel);
//    });
//
//    setState(() {});
//  }
//
//  @override
//  void initState() {
//    getTrendingwallpaper();
//    catogeries = getCategories();
//    super.initState();
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      backgroundColor: Colors.white,
//      appBar: AppBar(
//          title: brandname(), elevation: 0.0),
//      body: SingleChildScrollView(
//        child: Container(
//          child: Column(
//            children: <Widget>[
//              Container(
//                padding: const EdgeInsets.symmetric(horizontal: 24),
//                margin: const EdgeInsets.symmetric(horizontal: 24),
//                decoration: BoxDecoration(
//                  color: Color(0xfff5f8fd),
//                  borderRadius: BorderRadiusDirectional.circular(30),
//                ),
//                child: Row(
//                  children: <Widget>[
//                    Expanded(
//                      child: TextField(
//                        controller: searchController,
//                        decoration: InputDecoration(
//                          hintText: "search here",
//                          border: InputBorder.none,
//                        ),
//                      ),
//                    ),
//                    GestureDetector(
//                        onTap: () {
//                          Navigator.push(
//                            context,
//                            MaterialPageRoute(
//                                builder: (context) => SearchView(
//                                      search: searchController.text,
//                                    )),
//                          );
//                        },
//                        child: Container(child: Icon(Icons.search))),
//
////
//                  ],
//                ),
//              ),
//              SizedBox(height: 20),
//              Container(
//                height: 100,
//                child: ListView.builder(
//                  padding: const EdgeInsets.symmetric(horizontal: 16),
//                  shrinkWrap: true,
//                  scrollDirection: Axis.horizontal,
//                  itemBuilder: (context, index) {
//                    return categeriesTile(
//                      title: catogeries[index].categorieName,
//                      imgUrl: catogeries[index].imgUrl,
//                    );
//                  },
//                  itemCount: catogeries.length,
//                ),
//              ),
//              wallpaperlist(wallpapers: wallpapers, context: context)
//            ],
//          ),
//        ),
//      ),
//    );
//  }
//}
//
//class categeriesTile extends StatelessWidget {
//  final String imgUrl, title;
//
//  categeriesTile({
//    this.title,
//    this.imgUrl,
//  });
//
//  @override
//  Widget build(BuildContext context) {
//    return GestureDetector(
//      onTap: (){
//        Navigator.push(context, MaterialPageRoute(
//          builder: (context) => categorie(
//            categorieName:title.toLowerCase()  ,
//          )
//        ));
//      },
//      child: Container(
//        margin: EdgeInsets.only(right: 4),
//        child: Stack(
//          children: <Widget>[
//            GestureDetector(
//
//              child: ClipRRect(
//                  borderRadius: BorderRadius.circular(8.0),
//                  child: Image.network(
//                    imgUrl,
//                    height: 50,
//                    width: 100,
//                    fit: BoxFit.cover,
//                  )),
//            ),
//            Container(
//              decoration: BoxDecoration(
//                borderRadius: BorderRadiusDirectional.circular(8),
//                color: Colors.black26,
//              ),
//              height: 50,
//              width: 100,
//              child: Align(
//                  alignment: Alignment.center,
//                  child: Text(
//                    title,
//                    style: TextStyle(color: Colors.white, fontSize: 16),
//                  )),
//            ),
//          ],
//        ),
//      ),
//    );
//  }
//}

//cshbcsjbscjcbjsan


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<CategorieModel> categories = new List();

  int noOfImageToLoad = 100;
  List<PhotosModel> photos = new List();

  getTrendingWallpaper() async {
    await http.get(
        "https://api.pexels.com/v1/curated?per_page=$noOfImageToLoad&page=1",
        headers: {"Authorization": apiKEY}).then((value) {
      //print(value.body);

      Map<String, dynamic> jsonData = jsonDecode(value.body);
      jsonData["photos"].forEach((element) {
        //print(element);
        PhotosModel photosModel = new PhotosModel();
        photosModel = PhotosModel.fromMap(element);
        photos.add(photosModel);
        //print(photosModel.toString()+ "  "+ photosModel.src.portrait);
      });

      setState(() {});
    });
  }

  TextEditingController searchController = new TextEditingController();

  ScrollController _scrollController = new ScrollController();

  @override
  void initState() {
    //getWallpaper();
    getTrendingWallpaper();
    categories = getCategories();
    super.initState();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        noOfImageToLoad = noOfImageToLoad + 30;
        getTrendingWallpaper();
      }
    });
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: brandName(),
        elevation: 0.0,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  color: Color(0xfff5f8fd),
                  borderRadius: BorderRadius.circular(30),
                ),
                margin: EdgeInsets.symmetric(horizontal: 24),
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  children: <Widget>[
                    Expanded(
                        child: TextField(
                          controller: searchController,
                          decoration: InputDecoration(
                              hintText: "search wallpapers",
                              border: InputBorder.none),
                        )),
                    InkWell(
                        onTap: () {
                          if (searchController.text != "") {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SearchView(
                                      search: searchController.text,
                                    )));
                          }
                        },
                        child: Container(child: Icon(Icons.search)))
                  ],
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Made By ",
                    style: TextStyle(
                        color: Colors.black54,
                        fontSize: 12,
                        fontFamily: 'Overpass'),
                  ),
                  GestureDetector(
                    onTap: () {
                      _launchURL("https://www.linkedin.com/in/deepmehta517/");
                    },
                    child: Container(
                        child: Text(
                          "Deep Mehta",
                          style: TextStyle(
                              color: Colors.blue,
                              fontSize: 12,
                              fontFamily: 'Overpass'),
                        )),
                  ),
                ],
              ),
              SizedBox(
                height: 16,
              ),
              Container(
                height: 80,
                child: ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 24),
                    itemCount: categories.length,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      /// Create List Item tile
                      return CategoriesTile(
                        imgUrls: categories[index].imgUrl,
                        categorie: categories[index].categorieName,
                      );
                    }),
              ),
              wallPaper(photos, context),
              SizedBox(
                height: 24,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Photos provided By ",
                    style: TextStyle(
                        color: Colors.black54,
                        fontSize: 12,
                        fontFamily: 'Overpass'),
                  ),
                  GestureDetector(
                    onTap: () {
                      _launchURL("https://www.pexels.com/");
                    },
                    child: Container(
                        child: Text(
                          "Pexels",
                          style: TextStyle(
                              color: Colors.blue,
                              fontSize: 12,
                              fontFamily: 'Overpass'),
                        )),
                  )
                ],
              ),
              SizedBox(
                height: 24,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CategoriesTile extends StatelessWidget {
  final String imgUrls, categorie;

  CategoriesTile({@required this.imgUrls, @required this.categorie});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CategorieScreen(
                  categorie: categorie,
                )));
      },
      child: Container(
        margin: EdgeInsets.only(right: 8),
        child: kIsWeb
            ? Column(
          children: <Widget>[
            ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: kIsWeb
                    ? Image.network(
                  imgUrls,
                  height: 50,
                  width: 100,
                  fit: BoxFit.cover,
                )
                    : CachedNetworkImage(
                  imageUrl: imgUrls,
                  height: 50,
                  width: 100,
                  fit: BoxFit.cover,
                )),
            SizedBox(
              height: 4,
            ),
            Container(
                width: 100,
                alignment: Alignment.center,
                child: Text(
                  categorie,
                  style: TextStyle(
                      color: Colors.black54,
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Overpass'),
                )),
          ],
        )
            : Stack(
          children: <Widget>[
            ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: kIsWeb
                    ? Image.network(
                  imgUrls,
                  height: 50,
                  width: 100,
                  fit: BoxFit.cover,
                )
                    : CachedNetworkImage(
                  imageUrl: imgUrls,
                  height: 50,
                  width: 100,
                  fit: BoxFit.cover,
                )),
            Container(
              height: 50,
              width: 100,
              decoration: BoxDecoration(
                color: Colors.black26,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            Container(
                height: 50,
                width: 100,
                alignment: Alignment.center,
                child: Text(
                  categorie ?? "Yo Yo",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Overpass'),
                ))
          ],
        ),
      ),
    );
  }
}