import 'package:flutter/material.dart';

/// When scrolling, the header that shrinks to become the standard AppBar.
///
/// https://medium.com/@eibaan_54644/reappearing-app-bar-titles-eff8b35f6826
class SliverAppTitle extends StatefulWidget {
  const SliverAppTitle({
    Key key,
    @required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  _SliverAppTitleState createState() {
    return _SliverAppTitleState();
  }
}

class _SliverAppTitleState extends State<SliverAppTitle> {
  ScrollPosition _position;
  bool _visible;

  @override
  void dispose() {
    _removeListener();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _removeListener();
    _addListener();
  }

  void _addListener() {
    _position = Scrollable.of(context)?.position;
    _position?.addListener(_positionListener);
    _positionListener();
  }

  void _removeListener() {
    _position?.removeListener(_positionListener);
  }

  void _positionListener() {
    final FlexibleSpaceBarSettings settings =
        context.dependOnInheritedWidgetOfExactType<FlexibleSpaceBarSettings>();
    final bool visible =
        settings == null || settings.currentExtent <= settings.minExtent;

    if (_visible != visible) {
      setState(() => _visible = visible);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: _visible,
      child: widget.child,
    );
  }
}
