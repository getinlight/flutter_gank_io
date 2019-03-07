import 'package:flutter/material.dart';
import 'dart:async';

import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter_gank_io/api/api_gank.dart';
import 'package:flutter_gank_io/common/model/model_gank_item.dart';
import 'package:flutter_gank_io/common/model/model_gank_post.dart';
import 'package:flutter_gank_io/ui/widget/widget_indicator_factory.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_gank_io/ui/widget/widget_gank_item_title.dart';
import 'package:flutter_gank_io/ui/widget/widget_gank_list_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_gank_io/common/event/event_refresh_new_page.dart';
import 'package:flutter_gank_io/common/manager/manager_app.dart';
import 'package:flutter_gank_io/ui/page/page_gallery.dart';

class NewPage extends StatefulWidget {
  @override
  _NewPageState createState() => _NewPageState();
}

class _NewPageState extends State<NewPage> with AutomaticKeepAliveClientMixin {
  String _girlImage;
  String _date;
  List<GankItem> _gankItems;
  RefreshController _refreshController;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    AppManager.eventBus.on<RefreshNewPageEvent>().listen((event){
      if (mounted) {
        _date = event.date;
        getNewData(date: _date);
      }
    });
    _refreshController = new RefreshController();
    getNewData();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Offstage(
          offstage: _isLoading,
          child: SmartRefresher(
            enablePullDown: true,
            enablePullUp: false,
            onRefresh: _onRefresh,
            onOffsetChange: null,
            headerBuilder: buildDefaultHeader,
            controller: _refreshController,
            child: _buildListView(),
          ),
        ),
        Offstage(
          offstage: _isLoading ? false : true,
          child: Center(
            child: CupertinoActivityIndicator(),
          ),
        )
      ],
    );
  }

  ListView _buildListView() {
    return ListView.builder(
      itemCount: _gankItems == null ? 0 : _gankItems.length + 1,
      itemBuilder: (context, i) {
        if (i == 0) {
          return _buildImageBanner(context);
        } else {
          GankItem gankItem = _gankItems[i - 1];
          return gankItem.isTitle
              ? GankItemTitle(gankItem.category)
              : GankListItem(gankItem);
        }
      }
    );
  }

  GestureDetector _buildImageBanner(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context){
          return GalleryPage([_girlImage], '');
        }));
      },
      child: CachedNetworkImage(
        width: MediaQuery.of(context).size.width,
        height: 200,
        imageUrl: _girlImage,
        fit: BoxFit.cover,
      ),
    );
  }

  Future _onRefresh(bool up) async {
    if (up) {
      await getNewData(date: _date, isRefresh: true);
      _refreshController.sendBack(true, RefreshStatus.completed);
    }
  }

  Future getNewData({String date, bool isRefresh = false}) async {
    _date = date;
    if (!isRefresh) {
      setState(() {
        _isLoading = true;
      });
    }
    var todayJson;
    if (date == null) {
      todayJson = await GankApi.getTodayData();
    } else {
      todayJson = await GankApi.getSpecialDayData(date);
    }
    var todayItem = GankPost.fromJson(todayJson);
    setState(() {
      _gankItems = todayItem.gankItems;
      _girlImage = todayItem.girlImage;
      _isLoading = false;
    });

  }

  @override
  bool get wantKeepAlive => true;
}
