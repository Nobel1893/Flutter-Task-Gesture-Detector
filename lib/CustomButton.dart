import 'package:flutter/material.dart';

/**
 * this class used to wrap a clickable item
 * to detect un expected behavior of clicks
 * Ex. When user click on a button 5 times in less than [criticalDuration] param
 * it fires an event [onUnOrdinaryCLicksDetected] if is not null
 *
 */
typedef OnUnOrdinaryCLicksDetected = void Function(
    int clicks, Duration timeFrame, Offset offset, String clickedWidgetId);

class CustomButton extends StatelessWidget {
  Widget child;
  Duration criticalDuration;
  OnUnOrdinaryCLicksDetected? onUnOrdinaryCLicksDetected;

  CustomButton(
      {required this.child,
      this.criticalDuration = const Duration(seconds: 2),
      OnUnOrdinaryCLicksDetected? onUnOrdinaryCLicksDetected,
      Key? key})
      : super(key: key);
  int clicksCounter = 0;
  Offset? clickedPosition;
  DateTime? firstClickTime;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanDown: (details) {
        recordClick(details.globalPosition);
      },
      child: child,
    );
  }

  void recordClick(Offset position) {
    if (clickedPosition == null) {
      firstClickTime = DateTime.now();
      clickedPosition = position;
      clicksCounter++;
      return;
    }
    if (isSameClick(clickedPosition!, position) &&
        withinCriticalTimeFrame(firstClickTime!, DateTime.now())) {
      clicksCounter++;
      if (clicksCounter >= 5) {
        print('un-ordinary behavior detected button with id $key'
            'button clicked 5 times in less than ${criticalDuration.inSeconds} seconds,'
            ' with offset ${clickedPosition?.dx} ${clickedPosition?.dy}');
        if (onUnOrdinaryCLicksDetected != null) {
          onUnOrdinaryCLicksDetected!(clicksCounter, criticalDuration,
              clickedPosition!, key.toString());
        }
      }
      return;
    }
    clickedPosition = position;
    clicksCounter = 1;
  }

  bool isSameClick(Offset clickedPosition, Offset position) {
    return clickedPosition.dx == position.dx &&
        clickedPosition.dy == position.dy;
  }

  bool withinCriticalTimeFrame(DateTime firstClickTime, DateTime nextClick) {
    return nextClick.difference(firstClickTime).inMicroseconds <
        criticalDuration.inMicroseconds;
  }
}
