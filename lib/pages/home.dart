import 'package:covid_19/Model/WorldStatesModel.dart';
import 'package:covid_19/Services/states_services.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'country_list.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  late final AnimationController _controller=AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this)..repeat();
  @override
  void dispose(){
    super.dispose();
    _controller.dispose();
  }
  final colorList=<Color>[
    const Color(0xff4285F4),
    const Color(0xff1aa260),
    const Color(0xffde5246),
  ];
  @override
  Widget build(BuildContext context) {
    StatesServices statesServices=StatesServices();
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height*0.01,),
               FutureBuilder(
                   future: statesServices.fetchWorldStatesRecord(),
                   builder: (context,AsyncSnapshot<WorldStatesModel>snapshot){
                    if(!snapshot.hasData){
                      return const Expanded(
                          flex: 1,
                          child: SpinKitFadingCircle(
                            color: Colors.white,
                            size: 50,
                          ));
                    }else{
                      return Column(
                        children: [
                          PieChart(
                            chartValuesOptions: const ChartValuesOptions(
                              showChartValuesInPercentage: true
                            ),
                            chartRadius: MediaQuery.of(context).size.width/3.2,
                            animationDuration: const Duration(milliseconds: 1200),
                            colorList: colorList,
                            chartType: ChartType.ring,
                            // ignore: prefer_const_constructors
                            legendOptions: LegendOptions(
                                legendPosition: LegendPosition.left
                            ),
                            dataMap:  {
                              'Total':double.parse(snapshot.data!.cases.toString()),
                              'Recovered':double.parse(snapshot.data!.recovered.toString()),
                              'Deaths':double.parse(snapshot.data!.deaths.toString()),
                            },),
                          Padding(
                            padding:  EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height*0.06),
                            child: Card(
                              child:Padding(
                                padding: const EdgeInsets.only(left: 15,right: 15,top: 10,bottom: 5),
                                child: Column(
                                  children: [
                                    ReusableRow(title: 'Total', value: (snapshot.data!.cases.toString())),
                                    ReusableRow(title: 'Recovered', value: (snapshot.data!.recovered.toString())),
                                    ReusableRow(title: 'Deaths', value: (snapshot.data!.deaths.toString())),
                                    ReusableRow(title: 'Active', value: (snapshot.data!.active.toString())),
                                    ReusableRow(title: 'Critical', value: (snapshot.data!.critical.toString())),
                                    ReusableRow(title: 'Today Death', value: (snapshot.data!.todayDeaths.toString())),
                                    ReusableRow(title: 'Today Recovered', value: (snapshot.data!.todayRecovered.toString())),

                                  ],
                                ),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>const CountriesList()));
                            },
                            child: Container(
                              height: 50,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: const Color(0xff1aa260)
                              ),
                              child: const Center(child: Text("Track Countries")),
                            ),
                          )
                        ],
                      );
                    }
               }),


            ],
          ),
        ),
      ),
    );
  }
}
class ReusableRow extends StatelessWidget {
  String title,value;
   ReusableRow({Key? key,required this.title,required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title),
            Text(value),
          ],
        ),
        const SizedBox(height: 5,),
        const Divider(),
      ],
    );
  }
}

