import 'package:flutter/material.dart';
import 'package:pokecenter_front/globals.dart';
import 'package:pokecenter_front/utils/info_report.dart';
import '../../mock/mock_info_april.dart' as mock;

class InfoTab extends StatelessWidget {
  const InfoTab({Key? key}) : super(key: key);

  Widget buildReportCard(InfoReport report) {
    return Container(
      child: Card(
          child: ListTile(
        leading: CircleAvatar(backgroundImage: AssetImage(report.srcUrl)),
        title: Text(report.title),
        subtitle: Text(report.text),
      )),
    );
  }

  List<Widget> buildHeading(String title) {
    return [
      Divider(),
      Text(
        title,
        style: titleStyle,
      ),
      Padding(padding: EdgeInsets.all(10))
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          ...buildHeading("Informações:"),
          ...buildHeading("Novidades:"),
          ...mock.infoReports
              .map((report) => buildReportCard(InfoReport.fromJson(report)))
              .toList()
        ]),
      ),
    );
  }
}
