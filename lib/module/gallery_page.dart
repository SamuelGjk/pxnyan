import 'package:flutter/material.dart';
import 'package:flutter_advanced_networkimage/zoomable_widget.dart';
import 'package:flutter_advanced_networkimage/transition_to_image.dart';
import 'package:flutter_advanced_networkimage/flutter_advanced_networkimage.dart';
import 'package:pxnyan/http/api.dart' as Api;

class GalleryPage extends StatefulWidget {
  final List<String> _imageUrls;

  GalleryPage(this._imageUrls);

  @override
  State<StatefulWidget> createState() => new GalleryPageState();
}

class GalleryPageState extends State<GalleryPage> {
  int position = 0;

  @override
  Widget build(BuildContext context) {
    return new Container(
      color: Colors.grey[800],
      child: new Stack(
        children: <Widget>[
          new PageView.builder(
            itemCount: widget._imageUrls.length,
            onPageChanged: (position) {
              setState(() {
                this.position = position;
              });
            },
            itemBuilder: (context, index) {
              TransitionToImage imageWidget = new TransitionToImage(
                new AdvancedNetworkImage(widget._imageUrls[index], header: Api.HEADER),
                useReload: true,
                reloadWidget: new Icon(
                  Icons.replay,
                  color: Colors.white,
                ),
              );

              return new ZoomableWidget(
                maxScale: 3.0,
                child: imageWidget,
                tapCallback: imageWidget.reloadImage,
              );
            },
          ),
          new Container(
            margin: const EdgeInsets.only(bottom: 16.0),
            alignment: AlignmentDirectional.bottomCenter,
            child: new Text(
              '${position + 1}/${widget._imageUrls.length}',
              style: new TextStyle(
                fontSize: 16.0,
                color: Colors.white,
                decoration: TextDecoration.none,
              ),
            ),
          ),
          new Container(
            margin: const EdgeInsets.only(top: 40.0, left: 16.0),
            child: new GestureDetector(
              onTap: () => Navigator.pop(context),
              child: new Icon(
                Icons.close,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
    );
  }
}
