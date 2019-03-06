import 'package:flutter/material.dart';
import 'dart:async';

import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter_gank_io/api/gank_api.dart';
import 'package:flutter_gank_io/common/model/gank_item.dart';
import 'package:flutter_gank_io/common/model/gank_post.dart';
import 'package:flutter_gank_io/ui/widget/indicator_factory.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_gank_io/ui/widget/gank_item_title.dart';
import 'package:flutter_gank_io/ui/widget/gank_list_item.dart';

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
      ],
    );
  }

  ListView _buildListView() {
    return ListView.builder(
      itemCount: _gankItems == null ? 0 : _gankItems.length + 1,
      itemBuilder: (context, i) {
        if (i == 0) {
          return _buildimageBanner(context);
        } else {
          GankItem gankItem = _gankItems[i - 1];
          return gankItem.isTitle
              ? GankItemTitle(gankItem.category)
              : GankListItem(gankItem);
        }
      }
    );
  }

  GestureDetector _buildimageBanner(BuildContext context) {
    return GestureDetector(
      onTap: () {
//        Navigator.of(context).push(MaterialPageRoute(builder: (context){
//          return
//        }));
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
