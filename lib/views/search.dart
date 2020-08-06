import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:wallpaperhub/data/data.dart';
import 'package:wallpaperhub/models/wallpapermodel.dart';
import 'package:wallpaperhub/widgets/widget.dart';
import 'package:http/http.dart' as http;
//
//
//class Search extends StatefulWidget {
//
//  final String searchQuery;
//  Search({this.searchQuery});
//  @override
//  _SearchState createState() => _SearchState();
//}
//
//class _SearchState extends State<Search> {
//
//  TextEditingController searchController = new TextEditingController();
//
//  List<WallpaperModel> wallpapers = new List();
//
//  @override
//  void initState() {
//    super.initState();
//    getsearchedwallpaper(widget.searchQuery);
//    searchController.text=widget.searchQuery;
//  }
//
//  getsearchedwallpaper(String query) async {
//    var response = await http.get(
//        "https://api.pexels.com/v1/search?query=$query&per_page=1",
//        headers: {"Authorization": apiKEY});
////        print(response.body.toString());
//
//    Map<String, dynamic> jsonData = jsonDecode(response.body);
//    jsonData["photos"].forEach((element) {
//      print(element);
//      WallpaperModel wallpaperModel = new WallpaperModel();
//      wallpaperModel = WallpaperModel.fromMap(element);
//      wallpapers.add(wallpaperModel);
//    });
//    setState(() {
//
//    });
//
//    @override
//    Widget build(BuildContext context) {
//
//    }
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      appBar: AppBar(title: brandname(), elevation: 0.0),
//      body: SingleChildScrollView(
//        child: Container(
//          child: Column(
//            children: <Widget>[ Container(
//              padding: const EdgeInsets.symmetric(horizontal: 24),
//              margin: const EdgeInsets.symmetric(horizontal: 24),
//              decoration: BoxDecoration(
//                color: Color(0xfff5f8fd),
//                borderRadius: BorderRadiusDirectional.circular(30),
//              ),
//              child: Row(
//                children: <Widget>[
//                  Expanded(
//                    child: TextField(
//                      controller: searchController,
//                      decoration: InputDecoration(
//                        hintText: "search here",
//                        border: InputBorder.none,
//                      ),
//                    ),
//                  ),
//                  GestureDetector(
//                      onTap: () {
//                        getsearchedwallpaper(searchController.text);
//                      },
//                      child: Container(child: Icon(Icons.search))),
//
////
//                ],
//              ),
//            ),
//
//          SizedBox(
//          height: 20,
//    ),
//
//
//    wallpaperlist(wallpapers: wallpapers, context: context)
//            ],
//          ),
//        ),
//      ),
//
//    );
//  }
//}
//nxccjzxnjzvnvsajlknc




class SearchView extends StatefulWidget {
  final String search;

  SearchView({@required this.search});

  @override
  _SearchViewState createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  List<PhotosModel> photos = new List();
  TextEditingController searchController = new TextEditingController();

  getSearchWallpaper(String searchQuery) async {
    await http.get(
        "https://api.pexels.com/v1/search?query=$searchQuery&per_page=30&page=1",
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

  @override
  void initState() {
    getSearchWallpaper(widget.search);
    searchController.text = widget.search;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: brandName(),
        elevation: 0.0,
        actions: <Widget>[
          Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Icon(
                Icons.image,
                color: Colors.black54,
              ))
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 16,
              ),
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
                          getSearchWallpaper(searchController.text);
                        },
                        child: Container(child: Icon(Icons.search)))
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              wallPaper(photos, context),
              /*Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: GridView.count(
                    crossAxisCount: 2,
                    childAspectRatio: 0.6,
                    physics: ClampingScrollPhysics(),
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(4.0),
                    mainAxisSpacing: 6.0,
                    crossAxisSpacing: 6.0,
                    children: photos.map((PhotosModel photoModel) {
                      return GridTile(
                          child: GestureDetector(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(
                                  builder: (context) => ImageView(
                                    imgPath: photoModel.src.portrait,
                                  )
                              ));
                            },
                            child: Hero(
                              tag: photoModel.src.portrait,
                              child: Container(
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(16),
                                    child: kIsWeb ? Image.network(
                                      photoModel.src.portrait,
                                      height: 50,
                                      width: 100,
                                      fit: BoxFit.cover,
                                    ) : CachedNetworkImage(
                                        imageUrl: photoModel.src.portrait,
                                        placeholder: (context, url) => Container(color: Color(0xfff5f8fd),),
                                        fit: BoxFit.cover)),
                              ),
                            ),
                          ));
                    }).toList()),
              ),*/
            ],
          ),
        ),
      ),
    );
  }
}