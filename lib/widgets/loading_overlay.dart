import 'package:flutter/material.dart';

/// A fading effect wrapper around any widget that makes an async call to show a
/// modal progress indicator while the async call is in progress.
///
/// Forked from: https://github.com/java-james/loading_overlay
///
/// The progress indicator can be turned on or off using [isLoading]
///
/// The progress indicator defaults to a [CircularProgressIndicator] but can be
/// any kind of widget.
///
/// The color of the modal barrier can be set using [color].
///
/// The opacity of the modal barrier can be set using [opacity].
class LoadingOverlay extends StatefulWidget {
  const LoadingOverlay({
    @required this.isLoading,
    @required this.child,
    this.opacity = 0.1,
    this.progressIndicator = const CircularProgressIndicator(),
    this.color,
  }) : assert(isLoading != null);

  final bool isLoading;
  final double opacity;
  final Color color;
  final Widget progressIndicator;
  final Widget child;

  @override
  _LoadingOverlayState createState() => _LoadingOverlayState();
}

class _LoadingOverlayState extends State<LoadingOverlay>
    with SingleTickerProviderStateMixin {
  _LoadingOverlayState();

  AnimationController _controller;
  Animation<double> _animation;
  bool _overlayVisible;

  @override
  void initState() {
    super.initState();
    _overlayVisible = false;
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);
    _animation.addStatusListener((AnimationStatus status) {
      status == AnimationStatus.forward
          ? setState(() => <bool>{_overlayVisible = true})
          // ignore: unnecessary_statements
          : null;
      status == AnimationStatus.dismissed
          ? setState(() => <bool>{_overlayVisible = false})
          // ignore: unnecessary_statements
          : null;
    });
    if (widget.isLoading) {
      _controller.forward();
    }
  }

  @override
  void didUpdateWidget(LoadingOverlay oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!oldWidget.isLoading && widget.isLoading) {
      _controller.forward();
    }

    if (oldWidget.isLoading && !widget.isLoading) {
      _controller.reverse();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> widgets = <Widget>[];
    widgets.add(widget.child);
    if (_overlayVisible == true) {
      final FadeTransition modal = FadeTransition(
        opacity: _animation,
        child: Stack(
          children: <Widget>[
            Opacity(
              child: ModalBarrier(
                dismissible: false,
                color: widget.color ?? Colors.black,
              ),
              opacity: widget.opacity,
            ),
            Center(child: widget.progressIndicator),
          ],
        ),
      );
      widgets.add(modal);
    }
    return Stack(children: widgets);
  }
}
