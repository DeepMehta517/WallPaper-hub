//class WallpaperModel {
//
//  String photographer;
//  String photographer_url;
//  int photographer_id;
//  SrcModel src;
//
//  WallpaperModel(
//      {this.src, this.photographer, this.photographer_id, this.photographer_url});
//
//  factory WallpaperModel.fromMap(Map<String,dynamic> jsonData)
//  {
//    return WallpaperModel(
//      src: SrcModel.fromMap(jsonData["src"]),
//      photographer: jsonData["photographer"],
//      photographer_url: jsonData["photographer_url"],
//      photographer_id: jsonData["photographer_id "],
//    );
//  }
//}
//
//class SrcModel {
//  String original;
//  String small;
//  String portrait;
//
//  SrcModel({this.original, this.small, this.portrait});
//
//  factory SrcModel.fromMap(Map<String,dynamic> jsonData)
//  {
//
//    return SrcModel(
//      portrait: jsonData["potrait"],
//      original: jsonData["original"],
//      small: jsonData["small"]
//    );
//  }
//
//}

//sanjafnjkafnka
class PhotosModel {
  String url;
  String photographer;
  String photographerUrl;
  int photographerId;
  SrcModel src;

  PhotosModel(
      {this.url,
        this.photographer,
        this.photographerId,
        this.photographerUrl,
        this.src});

  factory PhotosModel.fromMap(Map<String, dynamic> parsedJson) {
    return PhotosModel(
        url: parsedJson["url"],
        photographer: parsedJson["photographer"],
        photographerId: parsedJson["photographer_id"],
        photographerUrl: parsedJson["photographer_url"],
        src: SrcModel.fromMap(parsedJson["src"]));
  }
}

class SrcModel {
  String portrait;
  String large;
  String landscape;
  String medium;

  SrcModel({this.portrait, this.landscape, this.large, this.medium});

  factory SrcModel.fromMap(Map<String, dynamic> srcJson) {
    return SrcModel(
        portrait: srcJson["portrait"],
        large: srcJson["large"],
        landscape: srcJson["landscape"],
        medium: srcJson["medium"]);
  }
}