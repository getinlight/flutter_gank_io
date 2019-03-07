import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:cached_network_image/cached_network_image.dart';

class GalleryPage extends StatefulWidget {

  final List urls;
  final String title;

  GalleryPage(this.urls, this.title);

  @override
  _GalleryPageState createState() => _GalleryPageState();
}

class _GalleryPageState extends State<GalleryPage> {

  int tagIndex = 0;

  @override
  Widget build(BuildContext context) {

    var pageOptions = widget.urls.map<PhotoViewGalleryPageOptions>((url) {
      tagIndex++;
      return PhotoViewGalleryPageOptions(
        imageProvider: CachedNetworkImageProvider(url),
        heroTag: url+tagIndex.toString(),
        minScale: PhotoViewComputedScale.contained * 1,
        maxScale: PhotoViewComputedScale.contained * 1.5,
      );
    }).toList();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          widget.title,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
      ),
      body: Container(
        child: PhotoViewGallery(
          loadingChild: CupertinoActivityIndicator(),
          backgroundDecoration: BoxDecoration(color: Colors.white),
          pageOptions: pageOptions,
        ),
      ),
    );
  }
}
