import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'package:pokecenter_front/globals.dart';
import 'package:pokecenter_front/utils/company_info.dart';
import 'package:pokecenter_front/utils/info_report.dart';
import '../../mock/mock_company_info.dart';
import '../../mock/mock_info_april.dart';

class InfoTab extends StatelessWidget {
  InfoTab({Key? key}) : super(key: key);

  Widget buildReportCard(InfoReport report) {
    return Container(
        child: GestureDetector(
      child: Card(
          child: ListTile(
        leading: CircleAvatar(backgroundImage: AssetImage(report.srcUrl)),
        title: Text(report.title),
        subtitle: Text(report.text),
      )),
    ));
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
    return companyInfos
        .map((companyInfo) => Padding(
              padding: EdgeInsets.only(bottom: 20),
              child: IntrinsicWidth(
                child: Row(
                  children: buildCompanyInfoFragment(
                      companyInfo, companyInfos.indexOf(companyInfo)),
                  mainAxisAlignment: MainAxisAlignment.center,
                ),
              ),
            ))
        .toList();
  }

  Widget buildCultureValue(IconData icon, String title, String text) {
    return Container(
      width: 200,
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              Icon(icon),
              Text(title),
              Padding(padding: EdgeInsets.all(10)),
              Text(text)
            ],
          ),
        )
      )
    );
  }

  List<Widget> buildCompanyInfoFragment(CompanyInfo companyInfo, int index) {
    List<Widget> fragment = [
      Expanded(
          child: Container(
        child: Text(
          companyInfo.text,
          style: TextStyle(fontSize: 18),
          textAlign: TextAlign.center,
        ),
        width: 500,
      )),
      Padding(padding: EdgeInsets.all(15)),
      ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Image(
          image: AssetImage(companyInfo.srcUrl),
          fit: BoxFit.fitHeight,
          height: 150,
          width: 200,
        ),
      )
    ];
    return index.isEven ? fragment : fragment.reversed.toList();
  }

  @override
  Widget build(BuildContext context) {
    const imgList = [
      "assets/images/report1_thumb.jpg",
      "assets/images/report1_thumb.jpg",
      "assets/images/report1_thumb.jpg",
    ];
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
              width: 1000,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: CarouselSlider(
                  options: CarouselOptions(
                    autoPlay: true,
                    aspectRatio: 2.0,
                    enlargeCenterPage: true,
                  ),
                  items: _buildImageSliders(imgList),
                ),
              )),
          Padding(
            padding: EdgeInsets.all(20),
            child: Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ...buildHeading("História de Sucesso:"),
                    ...buildCompanyInfoFragments(companyInfos
                        .map((info) => CompanyInfo.fromJson(info))
                        .toList()),
                    ...buildHeading("Cultura:"),
                    IntrinsicWidth(
                      child: Row(
                        // Missão Visão Valores
                        children: [
                          buildCultureValue(Icons.golf_course_sharp, "Missão", "A missão da Pokecenter é trazer qualidade de vida e saúde a todos"),
                          buildCultureValue(Icons.remove_red_eye, "Visão", "A visão da PokeCenter é ser a maior empresa da próxima década"),
                          buildCultureValue(Icons.book, "Valores", "A PokeCenter valoriza honestidade, dedicação e transparência"),
                        ],
                      ),
                    ),
                    ...buildHeading("Novidades:"),
                    ...infoReports
                        .map((report) =>
                            buildReportCard(InfoReport.fromJson(report)))
                        .toList()
                  ]),
            ),
          )
        ],
      ),
    );
  }

  List<Widget> _buildImageSliders(List<String> imgList) {
    return imgList
        .map((item) => Container(
              child: Container(
                margin: EdgeInsets.all(5.0),
                child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    child: Stack(
                      children: <Widget>[
                        Image.asset(item, fit: BoxFit.cover, width: 1000.0),
                      ],
                    )),
              ),
            ))
        .toList();
  }
}
