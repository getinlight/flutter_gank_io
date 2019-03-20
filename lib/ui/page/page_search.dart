import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter_gank_io/common/localization/GankLocalizations.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_gank_io/api/api_gank.dart';
import 'package:flutter_gank_io/common/model/model_gank_item.dart';
import 'package:flutter_gank_io/ui/widget/widget_gank_list_item.dart';

class SearchPage extends StatefulWidget {

  static const String ROUTER_NAME = 'search';

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {

  List _searchResults;
  String _search;
  bool _searching = false;

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
        title: Directionality(
            textDirection: Directionality.of(context),
            child: TextField(
              keyboardType: TextInputType.text,
              style: TextStyle(color: Colors.white, fontSize: 16.0),
              decoration: InputDecoration(
                hintText: GankLocalizations.of(context)
                    .currentLocalized
                    .pleaseInputSearch,
                hintStyle: TextStyle(color: Colors.white54),
                border: InputBorder.none,
              ),
              autofocus: false,
              onSubmitted: (String search) async {
                _search = search;
                _searchData();
              },
            )),
        actions: [
          IconButton(
              icon: Icon(
                IconData(0xe783, fontFamily: "IconFont"),
                color: Colors.white,
              ),
              onPressed: () {
                _searchData();
              })
        ]);
  }

  void _searchData() async {
    if (_search == null || _search.isEmpty) {
      Fluttertoast.showToast(
        msg: GankLocalizations.of(context).currentLocalized.pleaseInputSearchKeywords,
        backgroundColor: Colors.black,
        gravity: ToastGravity.CENTER,
        textColor: Colors.white
      );
      return;
    }
    setState(() {
      _searching = true;
    });
    var result = await GankApi.searchData(_search);
    result = result.map<GankItem>((json)=>GankItem.fromJson(json)).toList();
    setState(() {
      _searchResults = result;
      if (_searchResults.length == 0) {
        Fluttertoast.showToast(
          msg: GankLocalizations.of(context).currentLocalized.searchResultEmpty,
          backgroundColor: Colors.black,
          gravity: ToastGravity.CENTER,
          textColor: Colors.white
        );
      }
      _searching = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: Stack(
        children: <Widget>[
          Offstage(
            offstage: _searching,
            child: ListView.builder(
              itemBuilder: (context, index) {
                return GankListItem(_searchResults[index]);
              },
              itemCount: _searchResults == null ? 0 : _searchResults.length,
            ),
          ),
          Offstage(
            offstage: !_searching,
            child: Center(
              child: CupertinoActivityIndicator(),
            ),
          )
        ],
      ),
    );
  }

}
