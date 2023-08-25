import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ResizeableWidget extends StatefulWidget {
  const ResizeableWidget({
    required this.child,
    required this.initHeight,
    required this.initWidth,
    required this.showHandles,
    required this.onImageResize,
    super.key,
  });
  final Widget child;
  final double initHeight;
  final double initWidth;
  final bool showHandles;
  final Function(double, double) onImageResize;
  @override
  _ResizeableWidgetState createState() => _ResizeableWidgetState();
}

const ballDiameter = 10.0;

class _ResizeableWidgetState extends State<ResizeableWidget> {
  double height = 150;
  double width = 300;

  @override
  void initState() {
    height = widget.initHeight;
    width = widget.initWidth;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.showHandles ? height + 15 : height,
      width: widget.showHandles ? width + 14 : width,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          if (widget.showHandles)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // top left
                DragWidget(
                  child: horizontalBar(),
                  onDrag: (dx, dy) {
                    final mid = (dx + dy) / 2;
                    final newHeight = height - 2 * mid;
                    final newWidth = width - 2 * mid;
                    setState(() {
                      height = newHeight > 0 ? newHeight : 0;
                      width = newWidth > 0 ? newWidth : 0;
                    });
                    widget.onImageResize(width, height);
                  },
                ),

                // top middle
                DragWidget(
                  child: horizontalBar(),
                  onDrag: (dx, dy) {
                    final newHeight = height - dy;
                    setState(() {
                      height = newHeight > 0 ? newHeight : 0;
                    });
                    widget.onImageResize(width, height);
                  },
                ),
                // top right

                DragWidget(
                  child: horizontalBar(),
                  onDrag: (dx, dy) {
                    final mid = (dx + (dy * -1)) / 2;
                    final newHeight = height + 2 * mid;
                    final newWidth = width + 2 * mid;
                    setState(() {
                      height = newHeight > 0 ? newHeight : 0;
                      width = newWidth > 0 ? newWidth : 0;
                    });
                    widget.onImageResize(width, height);
                  },
                ),
              ],
            ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (widget.showHandles)
                SizedBox(
                  height: height,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // top left
                      DragWidget(
                        child: verticalBar(h: 14),
                        onDrag: (dx, dy) {
                          final mid = (dx + dy) / 2;
                          final newHeight = height - 2 * mid;
                          final newWidth = width - 2 * mid;
                          setState(() {
                            height = newHeight > 0 ? newHeight : 0;
                            width = newWidth > 0 ? newWidth : 0;
                          });
                          widget.onImageResize(width, height);
                        },
                      ), //left center
                      DragWidget(
                        child: verticalBar(),
                        onDrag: (dx, dy) {
                          final newWidth = width - dx;
                          setState(() {
                            width = newWidth > 0 ? newWidth : 0;
                          });
                          widget.onImageResize(width, height);
                        },
                      ),
                      // bottom left
                      if (widget.showHandles)
                        DragWidget(
                          child: verticalBar(h: 14),
                          onDrag: (dx, dy) {
                            final mid = ((dx * -1) + dy) / 2;
                            final newHeight = height + 2 * mid;
                            final newWidth = width + 2 * mid;

                            setState(() {
                              height = newHeight > 0 ? newHeight : 0;
                              width = newWidth > 0 ? newWidth : 0;
                            });
                            widget.onImageResize(width, height);
                          },
                        ),
                    ],
                  ),
                ),
              SizedBox(
                width: width,
                height: height,
                child: widget.child,
              ),
              if (widget.showHandles)
                SizedBox(
                  height: height,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // top right
                      DragWidget(
                        child: verticalBar(h: 14),
                        onDrag: (dx, dy) {
                          final mid = (dx + (dy * -1)) / 2;
                          final newHeight = height + 2 * mid;
                          final newWidth = width + 2 * mid;
                          setState(() {
                            height = newHeight > 0 ? newHeight : 0;
                            width = newWidth > 0 ? newWidth : 0;
                          });
                          widget.onImageResize(width, height);
                        },
                      ),
                      // center right
                      DragWidget(
                        child: verticalBar(),
                        onDrag: (dx, dy) {
                          final newWidth = width + dx;
                          setState(() {
                            width = newWidth > 0 ? newWidth : 0;
                          });
                          widget.onImageResize(width, height);
                        },
                      ),
                      // bottom right
                      DragWidget(
                        child: verticalBar(h: 14),
                        onDrag: (dx, dy) {
                          final mid = (dx + dy) / 2;

                          final newHeight = height + 2 * mid;
                          final newWidth = width + 2 * mid;

                          setState(() {
                            height = newHeight > 0 ? newHeight : 0;
                            width = newWidth > 0 ? newWidth : 0;
                          });
                          widget.onImageResize(width, height);
                        },
                      ),
                    ],
                  ),
                ),
            ],
          ),
          if (widget.showHandles)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // bottom left

                DragWidget(
                  child: horizontalBar(),
                  onDrag: (dx, dy) {
                    final mid = ((dx * -1) + dy) / 2;
                    final newHeight = height + 2 * mid;
                    final newWidth = width + 2 * mid;

                    setState(() {
                      height = newHeight > 0 ? newHeight : 0;
                      width = newWidth > 0 ? newWidth : 0;
                    });
                    widget.onImageResize(width, height);
                  },
                ),
                // bottom center
                DragWidget(
                  child: horizontalBar(),
                  onDrag: (dx, dy) {
                    final newHeight = height + dy;
                    setState(() {
                      height = newHeight > 0 ? newHeight : 0;
                    });
                    widget.onImageResize(width, height);
                  },
                ),
                // bottom right
                DragWidget(
                  child: horizontalBar(),
                  onDrag: (dx, dy) {
                    final mid = (dx + dy) / 2;

                    final newHeight = height + 2 * mid;
                    final newWidth = width + 2 * mid;

                    setState(() {
                      height = newHeight > 0 ? newHeight : 0;
                      width = newWidth > 0 ? newWidth : 0;
                    });
                    widget.onImageResize(width, height);
                  },
                ),
              ],
            ),
        ],
      ),
    );
  }

  Widget horizontalBar() {
    return Container(
      width: 20,
      height: 7,
      color: Colors.black,
    );
  }

  Widget verticalBar({double? h}) {
    return Container(
      width: 7,
      height: h ?? 20,
      color: Colors.black,
    );
  }
}

class DragWidget extends StatefulWidget {
  const DragWidget({required this.onDrag, required this.child, super.key});
  final Function onDrag;
  final Widget child;

  @override
  _DragWidgetState createState() => _DragWidgetState();
}

class _DragWidgetState extends State<DragWidget> {
  late double initX;
  late double initY;

  void _handleDrag(details) {
    setState(() {
      initX = details.globalPosition.dx;
      initY = details.globalPosition.dy;
    });
  }

  void _handleUpdate(details) {
    final dx = details.globalPosition.dx - initX;
    final dy = details.globalPosition.dy - initY;
    initX = details.globalPosition.dx;
    initY = details.globalPosition.dy;
    widget.onDrag(dx, dy);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanStart: _handleDrag,
      onPanUpdate: _handleUpdate,
      child: widget.child,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DoubleProperty('initX', initX));
  }
}
