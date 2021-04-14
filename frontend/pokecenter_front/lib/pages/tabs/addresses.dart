import 'package:flutter/material.dart';
import 'package:pokecenter_front/mock/mock_company_addresses.dart';
import 'package:pokecenter_front/utils/company_address.dart';
import 'dart:html';

class Addresses extends StatelessWidget {
  const Addresses({Key? key}) : super(key: key);

  Widget buildAddressCard(CompanyAddress address) {
    return Container(
        child: GestureDetector(
      onTap: () => window.open(address.mapsUrl, "Mapa"),
      child: Card(
        child: ListTile(
          leading: CircleAvatar(backgroundImage: AssetImage(address.srcUrl),radius: 35,),
          title: Text(address.text),
          horizontalTitleGap: 20,
          contentPadding: EdgeInsets.all(20),
        ),
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          expandedHeight: 400.0,
          flexibleSpace: const FlexibleSpaceBar(
            title: Text('Endereços'),
            background: Image(
              image: AssetImage('assets/images/city_background.jpg'),
              fit: BoxFit.fitWidth,
            ),
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                child: buildAddressCard(
                    CompanyAddress.fromJson(companyAddresses[index])),
              );
            },
            childCount: companyAddresses.length,
          ),
        ),
      ],
    );
  }
}
