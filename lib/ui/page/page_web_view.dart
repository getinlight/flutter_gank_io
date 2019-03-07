import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:flutter_gank_io/common/model/model_gank_item.dart';
import 'package:flutter_gank_io/common/manager/manager_favorite.dart';
import 'package:flutter_gank_io/common/manager/manager_app.dart';
import 'package:flutter_gank_io/common/event/event_refresh_db.dart';
import 'package:url_launcher/url_launcher.dart';

class WebViewPage extends StatefulWidget {

  final GankItem gankItem;

  WebViewPage(this.gankItem);

  @override
  _WebViewPageState createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {

  bool _favorite = false;

  @override
  Widget build(BuildContext context) {
    return WebviewScaffold(
      appBar: AppBar(
        title: Text(widget.gankItem.desc),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.favorite,
                color: _favorite ? Colors.red : Colors.white),
            onPressed: () async {
              if (_favorite) {
                await FavoriteManager.remove(widget.gankItem);
                setState(() {
                  _favorite = false;
                });
              } else {
                await FavoriteManager.insert(widget.gankItem);
                setState(() {
                  _favorite = true;
                });
              }
              AppManager.eventBus.fire(RefreshDBEvent());
            },
          ),
          IconButton(
            icon: IconButton(
              icon: Icon(Icons.language),
              onPressed: () async {
                if (await canLaunch(widget.gankItem.url)) {
                  launch(widget.gankItem.url);
                }
              }
            ),
          )
        ],
      ),
      withLocalStorage: true,
      url: widget.gankItem.url,
      withJavascript: true,
    );
  }
}
