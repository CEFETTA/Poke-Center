import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'package:pokecenter_front/globals.dart';

class Galery extends StatelessWidget {
  Galery({Key? key}) : super(key: key);

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
    const imgListCompany = [
      "assets/images/report1_thumb.jpg",
      "assets/images/clinica.jpg",
      "assets/images/pikachu_doente.jpg",
    ];

    const imgListNobel = [
      "assets/images/nobel.jpg",
      "assets/images/nobel2.jpg",
      "assets/images/nobel3.jpg",
    ];

    const imgListSupporters = [
      "assets/images/google.jpg",
      "assets/images/amazon.jpg",
      "assets/images/nintendo.jpg",
    ];
    return SingleChildScrollView(
        child: Center(
      child: Column(
        children: [
          Container(
              width: 1000,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ...buildHeading("Conheça a empresa:"),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: CarouselSlider(
                      options: CarouselOptions(
                        autoPlay: true,
                        aspectRatio: 2.0,
                        enlargeCenterPage: true,
                      ),
                      items: _buildImageSliders(imgListCompany),
                    ),
                  ),
                  ...buildHeading("Nossas conquistas:"),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: CarouselSlider(
                      options: CarouselOptions(
                        autoPlay: true,
                        aspectRatio: 2.0,
                        enlargeCenterPage: true,
                      ),
                      items: _buildImageSliders(imgListNobel),
                    ),
                  ),
                  ...buildHeading("Principais apoiadores:"),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: CarouselSlider(
                      options: CarouselOptions(
                        autoPlay: true,
                        aspectRatio: 2.0,
                        enlargeCenterPage: true,
                      ),
                      items: _buildImageSliders(imgListSupporters),
                    ),
                  ),
                ],
              )),
        ],
      ),
    ));
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
