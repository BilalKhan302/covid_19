import 'package:flutter/material.dart';

import 'home.dart';
class DetailScreen extends StatefulWidget {
  String name;
  String image;
  int totalCases,totalDeaths,totalRecovered,active,critical,todayRecovered,test;
   DetailScreen({
     required this.name,
     required this.image,
     required this.totalCases,
     required this.totalDeaths,
     required this.totalRecovered,
     required this.active,
     required this.critical,
     required this.todayRecovered,
     required this.test,
   });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.topCenter,
            children: [
              Padding(
                padding:  EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height*0.067),
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        SizedBox(height:MediaQuery.of(context).size.height*0.06,),
                        ReusableRow(title: 'Cases',value: widget.totalCases.toString()),
                        ReusableRow(title: 'totalDeaths',value: widget.totalDeaths.toString()),
                        ReusableRow(title: 'totalRecovered',value: widget.totalRecovered.toString()),
                        ReusableRow(title: 'Critical',value: widget.critical.toString()),
                        ReusableRow(title: 'todayRecovered',value: widget.todayRecovered.toString()),
                      ],

                ),
                  ),),
              ),
              CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(widget.image),)
            ],
          )
        ],
      ),
    );
  }
}
