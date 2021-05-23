import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:scroll_snap_list/scroll_snap_list.dart';
import 'package:way_to_heaven/User/application.dart';
import 'package:way_to_heaven/User/userProvider.dart';
import 'package:way_to_heaven/components/constants.dart';

class UserHomePage extends StatefulWidget {
  @override
  _UserHomePageState createState() => _UserHomePageState();
}

class _UserHomePageState extends State<UserHomePage> with SingleTickerProviderStateMixin {
  Completer<GoogleMapController> _controller = Completer();
  static const LatLng _center = const LatLng(21.1458, 79.0882);
  MapType _currentMapType = MapType.normal;

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  TabController tabController;
 
  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
    tabController.addListener(() {
     print(tabController.index);
    });
  }
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<UserProvider>(context); 

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.dark,
    ));
    return Stack(children: [
        Container(
          height: 110,
          width: MediaQuery.of(context).size.width,
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.only(top: 30, left: 20, right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Image.asset(
                      'assets/icons/user.png',
                      height: 35,
                    ),
                    SizedBox(width: 15),
                    Text(
                      "Shubham",
                      style: lightBlackTextStyle().copyWith(fontSize: 17),
                    )
                  ],
                ),
                Icon(
                  Icons.notifications_none_rounded,
                  size: 20,
                  color: Color(0xFF929292),
                )
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 110),
          child: Scaffold(
            appBar: AppBar(
              toolbarHeight: 50,
              backwardsCompatibility: false,
              systemOverlayStyle: SystemUiOverlayStyle(
                statusBarColor: Colors.white, // status bar color
                statusBarBrightness: Brightness.light, //status bar brigtness
              ),
              bottom: TabBar(
                tabs: [
                  Tab(
                    text: "Crematoriums",
                  ),
                  Tab(text: "Applications")
                ],
                onTap: (index) {
                  print(index);
                },
                labelStyle: normalTextStyle().copyWith(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500),
                indicatorPadding: EdgeInsets.only(bottom: 2, top: 0),
                indicator: UnderlineTabIndicator(
                    borderSide: BorderSide(
                      color: Colors.white,
                      width: 2.0,
                    ),
                    insets: EdgeInsets.symmetric(horizontal: 45.0)),
                    controller: tabController,
              ),
              backgroundColor: orangeColor(),
              
            ),
            body: TabBarView(
              controller: tabController,
              physics: NeverScrollableScrollPhysics(),
              children: [
                Stack(
                children :[
                  GoogleMap(
                    onMapCreated: _onMapCreated,
                    zoomGesturesEnabled: true,
                    zoomControlsEnabled: false,
                    initialCameraPosition: CameraPosition(
                      target: _center,
                      zoom: 11.0,
                    ),
                    mapType: _currentMapType,
                  ),
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.all(0.0),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Container(
                              height: 70.0,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                  color: Color(0xFFffffff),
                                   child: Padding(                           
                                     padding: const EdgeInsets.symmetric( vertical: 0 , horizontal: 10 ),
                                     child: DropdownButton(
                                      items: provider.zonesDropDownList,
                                      hint: Text('Select Zone'),
                                      value: provider.selectedZone,
                                      onChanged: (val){
                                        provider.selectZone(val);
                                      },
                                      focusColor: lightBlack(),
                                      iconEnabledColor: redOrangeColor(),
                                      underline: Padding(padding: EdgeInsets.all(0)),
                                     ),
                                   )
                                  ),
                                  Column(
                                    children: [
                                      Text('Under' , style: lightBlackTextStyle()),
                                      SizedBox(height: 8.0,),
                                      Row(
                                        children: [
                                           Padding(
                                              padding: const EdgeInsets.symmetric( horizontal: 5 ),
                                              child: Container(
                                              color: Color(0xFFffffff),
                                              child: Padding(                           
                                                padding: const EdgeInsets.symmetric( vertical: 7 , horizontal: 12 ),
                                                child: Text("2 KM" , style: lightBlackTextStyle(), )
                                              )
                                              ),
                                            ),
                                            Padding(
                                              padding:  const EdgeInsets.symmetric( horizontal: 5 ),
                                              child: Container(
                                              color: Color(0xFFffffff),
                                              child: Padding(                           
                                                padding: const EdgeInsets.symmetric( vertical: 7 , horizontal: 12 ),
                                        
                                                child: Text("5 KM" , style: lightBlackTextStyle(), )
                                              )
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.symmetric( horizontal: 5 ),
                                              child: Container(
                                              color: Color(0xFFffffff),
                                              child: Padding(                           
                                                padding: const EdgeInsets.symmetric( vertical: 7 , horizontal: 12 ),
                                                child: Text("10 KM" , style: lightBlackTextStyle(), )
                                              )
                                              ),
                                            ),
                                        ],
                                      )
                                    ],
                                  )
                                 
                                  ]),
                            ),
                          ),
                          Spacer(),
                          Container(
                            width: MediaQuery.of(context).size.width ,
                            height : 150,
                            child: ScrollSnapList(
                                itemSize: MediaQuery.of(context).size.width - 80 ,
                                itemCount: provider.crematoriumSearchList.length,
                                onItemFocus: (index){
                                  print(index);
                                },
                                itemBuilder: (context , index){
                                    return Container(
                                      width: MediaQuery.of(context).size.width - 80,
                                      child: Center(
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            SizedBox(
                                              width: MediaQuery.of(context).size.width - 80,
                                              child: Card( 
                                                shape: RoundedRectangleBorder(side: BorderSide(
                                                          color: Colors.white,
                                                          width: 1,
                                                          style: BorderStyle.solid
                                                        ), borderRadius: BorderRadius.circular(5.0)),    
                                                shadowColor: Colors.transparent,                                         
                                                child: Padding(
                                                  padding: const EdgeInsets.symmetric( vertical : 8.0 ,horizontal : 15.0),
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text(provider.crematoriumSearchList[index]['crematoriumName'] != null 
                                                           ?  provider.crematoriumSearchList[index]['crematoriumName'] 
                                                           : '', style: lightBlackTextStyle().copyWith(fontSize: 18),),
                                                      SizedBox(height: 5.0,),
                                                      Text(provider.crematoriumSearchList[index]['zone'] != null 
                                                           ?  provider.crematoriumSearchList[index]['zone'] 
                                                           : '' , style: normalTextStyle(),),
                                                      Text( (provider.crematoriumSearchList[index]['status'] != null 
                                                           ?  provider.crematoriumSearchList[index]['status'] 
                                                           : '' ) + '. ' + (
                                                           provider.crematoriumSearchList[index]['timing'] != null 
                                                           ?  provider.crematoriumSearchList[index]['timing'] 
                                                           : '') , style: normalTextStyle(),),
                                                      SizedBox(height: 5.0,),
                                                      FlatButton(
                                                        onPressed: (){
                                                          provider.selectCrematorium(index);
                                                          Navigator.push(context, MaterialPageRoute(builder: (context) => Application(provider) ) );
                                                         },
                                                        child: Text('Apply', style: whiteTextStyle().copyWith(fontSize: 15 , fontWeight: FontWeight.w600)
                                                        ),
                                                        color: Colors.blue,
                                                        shape: RoundedRectangleBorder(side: BorderSide(
                                                          color: Colors.blueAccent,
                                                          width: 1,
                                                          style: BorderStyle.solid
                                                        ), borderRadius: BorderRadius.circular(50)),
                                                      )
                                                    ],
                                                  )
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    );
                                },
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ]
                ),
                Container(child: Center(child: Text("It seems you don't have any applications." , style: lightBlackTextStyle() ) ) )
              ],
            ),
          ),
        ),
      ]);
  }
}
