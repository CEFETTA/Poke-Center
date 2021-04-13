import 'package:flutter/material.dart';

import 'package:pokecenter_front/globals.dart';
import 'package:pokecenter_front/utils/company_info.dart';
import 'package:pokecenter_front/utils/info_report.dart';
import '../../mock/mock_company_info.dart';
import '../../mock/mock_info_april.dart';

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

  List<Widget> buildCompanyInfoFragments(List<CompanyInfo> companyInfos) {
    const positionRight = false;
    return companyInfos
        .map((companyInfo) => Padding(
          padding: EdgeInsets.only(bottom: 20),
          child: IntrinsicWidth(
            child: Row(
              children: buildCompanyInfoFragment(
                companyInfo,
                companyInfos.indexOf(companyInfo)
              ),
              mainAxisAlignment: MainAxisAlignment.center,
            ),
          ),
        ))
        .toList();
  }

  List<Widget> buildCompanyInfoFragment(CompanyInfo companyInfo, int index) {
    List<Widget> fragment = [
      Expanded(child: Container(child: Text(companyInfo.text), width: 500,)),
      Padding(padding: EdgeInsets.all(15)),
      ClipRRect( borderRadius: BorderRadius.circular(15), child: Image(image: AssetImage(companyInfo.srcUrl), width: 300, ),)
    ];
    return index.isEven ? fragment : fragment.reversed.toList();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            ...buildHeading("Informações:"),
            ...buildCompanyInfoFragments(companyInfos
                .map((info) => CompanyInfo.fromJson(info))
                .toList()),
            ...buildHeading("Novidades:"),
            ...infoReports
                .map((report) => buildReportCard(InfoReport.fromJson(report)))
                .toList()
          ]),
        ),
      ),
    );
  }
}
