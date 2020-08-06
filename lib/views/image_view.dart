
import 'dart:io';
import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';

//class ImageView extends StatefulWidget {
//  @override
//  _ImageViewState createState() => _ImageViewState();
//
//  final String imgUrl;
//  ImageView({@required this.imgUrl});
//}
//
//class _ImageViewState extends State<ImageView> {
//
//
//  var filepath;
//  _launchURL(String url) async {
//    if (await canLaunch(url)) {
//      await launch(url);
//    } else {
//      throw 'Could not launch $url';
//    }
//  }
//
//
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      body: GestureDetector(
//        onTap: () {
//          _save();
//        },
//        child: Stack(
//          children: <Widget>[
//            Hero(
//              tag: widget.imgUrl,
//              child: Container(
//                  height: MediaQuery
//                      .of(context)
//                      .size
//                      .height,
//                  width: MediaQuery
//                      .of(context)
//                      .size
//                      .width,
//                  child: Image.network(widget.imgUrl, fit: BoxFit.contain,)),
//            ),
//            Container(
//              height: MediaQuery
//                  .of(context)
//                  .size
//                  .height,
//              width: MediaQuery
//                  .of(context)
//                  .size
//                  .width,
//              alignment: Alignment.bottomCenter,
//              child: Column(
//                children: <Widget>[
//                  Stack(
//                    children: <Widget>[
//                      Container(
//                        height: 50,
//                        width: MediaQuery
//                            .of(context)
//                            .size
//                            .width / 2,
//                        color: Color(0xff1C1B1B).withOpacity(0.8),
//                decoration: BoxDecoration(
//                    borderRadius: BorderRadius.circular(30),
//                    border: Border.all(color: Colors.white54, width: 1),)
//
//                      ),
//                      Container(
//                        height: 50,
//                        width: MediaQuery
//                            .of(context)
//                            .size
//                            .width / 2,
//
//                        padding: const EdgeInsets.symmetric(
//                            horizontal: 8, vertical: 8),
//                        decoration: BoxDecoration(
//                            borderRadius: BorderRadius.circular(30),
//                            border: Border.all(color: Colors.white54, width: 1),
//                            gradient: LinearGradient(
//                                colors: [
//                                  Color(0x36FFFFFF),
//                                  Color(0x0FFFFFFF),
//                                ]
//                            )
//                        ),
//                        child: Column(
//                          mainAxisAlignment: MainAxisAlignment.end,
//                          children: <Widget>[
//                            Text("Set as Wallpaper", style: TextStyle(
//                                color: Colors.white70, fontSize: 16)),
//                            Text("Image will be  saved in your gallery",
//                                style: TextStyle(color: Colors.white70)),
//                          ],),
//                      ),
//                    ],
//                  )
//                ],
//              ),
//            ),
//            SizedBox(height: 16,),
//            GestureDetector(
//              onTap: (){
//                Navigator.pop(context);
//              },
//                child: Text("cancel", style: TextStyle(color: Colors.white),)),
//            SizedBox(height: 50,)
//
//
//          ],
//
//        ),
//      ),
//
//    );
//  }
//
//  _save() async {
//    await _askPermission();
//    var response = await Dio().get(widget.imgUrl,
//        options: Options(responseType: ResponseType.bytes));
//    final result =
//    await ImageGallerySaver.saveImage(Uint8List.fromList(response.data));
//    print(result);
//    Navigator.pop(context);
//  }
//
//  _askPermission() async {
//    if (Platform.isIOS) {
//      /*Map<PermissionGroup, PermissionStatus> permissions =
//          */ await PermissionHandler()
//          .requestPermissions([PermissionGroup.photos]);
//    } else {
//      /* PermissionStatus permission = */ await PermissionHandler()
//          .checkPermissionStatus(PermissionGroup.storage);
//    }
//  }
//}

//dfjkfjasasas

class ImageView extends StatefulWidget {
  final String imgPath;

  ImageView({@required this.imgPath});

  @override
  _ImageViewState createState() => _ImageViewState();
}

class _ImageViewState extends State<ImageView> {
  var filePath;

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
      body: Stack(
        children: <Widget>[
          Hero(
            tag: widget.imgPath,
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: kIsWeb
                  ? Image.network(widget.imgPath, fit: BoxFit.cover)
                  : CachedNetworkImage(
                imageUrl: widget.imgPath,
                placeholder: (context, url) => Container(
                  color: Color(0xfff5f8fd),
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            alignment: Alignment.bottomCenter,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                InkWell(
                    onTap: () {
                      if (kIsWeb) {
                        _launchURL(widget.imgPath);
                        //js.context.callMethod('downloadUrl',[widget.imgPath]);
                        //response = await dio.download(widget.imgPath, "./xx.html");
                      } else {
                        _save();
                      }
                      //Navigator.pop(context);
                    },
                    child: Stack(
                      children: <Widget>[
                        Container(
                          width: MediaQuery.of(context).size.width / 2,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Color(0xff1C1B1B).withOpacity(0.8),
                            borderRadius: BorderRadius.circular(40),
                          ),
                        ),
                        Container(
                            width: MediaQuery.of(context).size.width / 2,
                            height: 50,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.white24, width: 1),
                                borderRadius: BorderRadius.circular(40),
                                gradient: LinearGradient(
                                    colors: [
                                      Color(0x36FFFFFF),
                                      Color(0x0FFFFFFF)
                                    ],
                                    begin: FractionalOffset.topLeft,
                                    end: FractionalOffset.bottomRight)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  "Set Wallpaper",
                                  style: TextStyle(
                                      color: Colors.white70,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500),
                                ),
                                SizedBox(
                                  height: 1,
                                ),
                                Text(
                                  kIsWeb
                                      ? "Image will open in new tab to download"
                                      : "Image will be saved in gallery",
                                  style: TextStyle(
                                      fontSize: 8, color: Colors.white70),
                                ),
                              ],
                            )),
                      ],
                    )),
                SizedBox(
                  height: 16,
                ),
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    "Cancel",
                    style: TextStyle(
                        color: Colors.white60,
                        fontSize: 12,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                SizedBox(
                  height: 50,
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  _save() async {
    await _askPermission();
    var response = await Dio().get(widget.imgPath,
        options: Options(responseType: ResponseType.bytes));
    final result =
    await ImageGallerySaver.saveImage(Uint8List.fromList(response.data));
    print(result);
    Navigator.pop(context);
  }

  _askPermission() async {
    if (Platform.isIOS) {
      /*Map<PermissionGroup, PermissionStatus> permissions =
          */await PermissionHandler()
          .requestPermissions([PermissionGroup.photos]);
    } else {
      /* PermissionStatus permission = */await PermissionHandler()
          .checkPermissionStatus(PermissionGroup.storage);
    }
  }
}