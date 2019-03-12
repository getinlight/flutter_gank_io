import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';
import 'package:flutter_gank_io/common/manager/manager_app.dart';
import 'package:flutter_gank_io/common/event/event_show_history_date.dart';
import 'package:flutter_gank_io/common/utils/time_utils.dart';
import 'package:flutter_gank_io/common/event/event_refresh_new_page.dart';

class HistoryDateWidget extends StatefulWidget {

  final List _historyData;

  HistoryDateWidget(this._historyData);

  @override
  _HistoryDateWidgetState createState() => _HistoryDateWidgetState();
}

class _HistoryDateWidgetState extends State<HistoryDateWidget> with TickerProviderStateMixin {

  AnimationController _controller;
  Animation<double> _historyDateDetailsOpacity;
  Animatable<Offset> _historyDateDetailsTween;
  Animation<Offset> _historyDateDetailsPosition;

  String _currentDate;

  bool _showHistoryDate = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
//    _historyDateDetailsOpacity = CurvedAnimation(
//        parent: _controller,
//        curve: Curves.fastOutSlowIn);
    _historyDateDetailsOpacity = Tween<double>(begin: 0.0, end: 1.0)
        .chain(CurveTween(curve: Curves.fastOutSlowIn)).animate(_controller);
    _historyDateDetailsTween = Tween<Offset>(
        begin: const Offset(0, -1.0),
        end: Offset.zero)
        .chain(CurveTween(curve: Curves.fastOutSlowIn));
    _historyDateDetailsPosition =
        _controller.drive(_historyDateDetailsTween);

    if (widget._historyData != null && widget._historyData.isNotEmpty) {
      _currentDate = widget._historyData[0];
    }

    AppManager.eventBus.on<ShowHistoryDateEvent>().listen((event) {
      if (mounted) {
        if (event.forceHide) {
          _showHistoryDate = false;
        } else {
          _showHistoryDate = !_showHistoryDate;
        }
        if (_showHistoryDate) {
          _controller.forward();
        } else {
          _controller.reverse();
        }
      }
    });

  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _historyDateDetailsPosition,
      child: FadeTransition(
        opacity: _historyDateDetailsOpacity,
        child: Card(
          margin: EdgeInsets.all(0.0),
          elevation: 5,
          child: Container(
            color: Colors.white,
            height: 50,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: widget._historyData == null?0:widget._historyData.length,
              itemBuilder: (context, i) {
                return GestureDetector(
                  onTap: (){
                    setState(() {
                      _currentDate = widget._historyData[i];
                    });
                    AppManager.eventBus.fire(RefreshNewPageEvent(_currentDate));
                    var x = ShowHistoryDateEvent.hide();
                    print(x.toString());
                    AppManager.eventBus.fire(ShowHistoryDateEvent.hide());
                  },
                  child: Center(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      color: Colors.white,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: <Widget>[
                              Text(
                                getDay(widget._historyData[i]),
                                style: Theme.of(context).textTheme.body2
                                .copyWith(
                                  fontSize: 18,
                                  color: (widget._historyData[i] ==
                                      _currentDate)
                                      ? Theme.of(context).primaryColor
                                      : Colors.black
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 3.0, bottom: 2.0),
                                child: Text(
                                  getWeekDay(widget._historyData[i]),
                                  style: Theme.of(context).textTheme.body2
                                      .copyWith(
                                      fontSize: 8,
                                      color: (widget._historyData[i] ==
                                          _currentDate)
                                          ? Theme.of(context).primaryColor
                                          : Colors.black
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 3.0, bottom: 2.0),
                            child: Text(
                              getMonth(widget._historyData[i]),
                              style: Theme.of(context)
                                  .textTheme
                                  .body2
                                  .copyWith(
                                  fontSize: 8,
                                  color: (widget._historyData[i] ==
                                      _currentDate)
                                      ? Theme.of(context).primaryColor
                                      : Colors.black
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
