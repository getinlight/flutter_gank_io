import 'package:flutter/material.dart';
import 'package:flutter_gank_io/redux/app_state.dart';
import 'package:flutter_redux/flutter_redux.dart';

class GankLocalizationWrapper extends StatefulWidget {

  final Widget child;

  GankLocalizationWrapper({Key key, this.child}) : super(key: key);

  @override
  _GankLocalizationWrapperState createState() => _GankLocalizationWrapperState();
}

class _GankLocalizationWrapperState extends State<GankLocalizationWrapper> {
  @override
  Widget build(BuildContext context) {
    return StoreBuilder<AppState>(
      builder: (context, store) {
        return Localizations.override(
          context: context,
          locale: store.state.locale,
          child: widget.child,
        );
      }
    );
  }
}
