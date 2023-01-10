import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:timelines/timelines.dart';


class CurrentOrder extends StatelessWidget {
  const CurrentOrder({Key key}) : super(key: key);
@override
Widget build(BuildContext context) {
  List<String> processes = []; 

  return Timeline.tileBuilder(
   builder: TimelineTileBuilder.connected(
            connectionDirection: ConnectionDirection.before,
            itemCount: processes.length,
            contentsBuilder: (_, index) {
              //your Container/Card Content
            },
            indicatorBuilder: (_, index) {
              // if (processes[index].isCompleted) {
              //   return DotIndicator(
              //     color: Color(0xff66c97f),
              //     child: Icon(
              //       Icons.check,
              //       color: Colors.white,
              //       size: 12.0,
              //     ),
              //   );
              // } else {
              //   return OutlinedDotIndicator(
              //     borderWidth: 2.5,
              //   );
              // }
            },
            connectorBuilder: (_, index, ___) => SolidLineConnector(
              // color: processes[index].isCompleted ? Color(0xff66c97f) : null,
            ),
          ),
  );
}
}
