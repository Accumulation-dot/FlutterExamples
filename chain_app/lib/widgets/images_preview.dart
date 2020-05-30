import 'package:flutter/material.dart';
import 'package:photo_view/photo_view_gallery.dart';

// ignore: must_be_immutable
class ImagePreview extends StatefulWidget {
  final List<dynamic> images;

  final bool network;

  int index = 0;
  PageController pageController;

  ImagePreview(
      {Key key,
      this.images,
      this.pageController,
      this.index = 0,
      this.network = true})
      : super(key: key) {
    pageController = PageController(initialPage: index);
  }

  @override
  _ImagePreviewState createState() => _ImagePreviewState();
}

class _ImagePreviewState extends State<ImagePreview> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: PhotoViewGallery.builder(
          itemCount: widget.images.length,
          pageController: widget.pageController,
          builder: (context, index) {
            return PhotoViewGalleryPageOptions(
                imageProvider: widget.network
                    ? NetworkImage(widget.images[index].toString())
                    : Image.file(widget.images[index]).image,
                onTapDown: (context, detail, _) {
                  Navigator.of(context).pop();
                }, minScale: 0.2, maxScale: 1.5,);
          }),
    );
  }
}
