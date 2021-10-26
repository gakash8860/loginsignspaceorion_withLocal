import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:loginsignspaceorion/BillPrediction.dart';
import 'package:loginsignspaceorion/profilepage.dart';
import 'package:loginsignspaceorion/Setting_Page.dart';
import 'package:loginsignspaceorion/about_Genorion.dart';
import 'package:loginsignspaceorion/addMember.dart';
import 'package:loginsignspaceorion/dropdown1.dart';
import 'package:loginsignspaceorion/main.dart';
import 'package:loginsignspaceorion/utility.dart';
import 'package:loginsignspaceorion/whatNew.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'models/modeldefine.dart';

void main()=>runApp(MaterialApp(
  home:HomePageFinal(
    fl: null,
    pt: null,
    rm: null,
  ) ,
));


class HomePageFinal extends StatefulWidget {
  final  pt;
  final fl;
 final List<RoomType>   rm;
  //List<Device> dv;

  const HomePageFinal({Key key, this.pt, this.fl, this.rm}) : super(key: key);
  @override
  _HomePageFinalState createState() => _HomePageFinalState();
}

class _HomePageFinalState extends State<HomePageFinal> {
  Image setImage;
  int _currentIndex = 0;
  final storage= new FlutterSecureStorage();
  GlobalKey<RefreshIndicatorState> refreshKey;
  ScrollController _controller;
  SharedPreferences preferences;
  List<bool> isSelected = [true, false, false];
  Future<String> getToken()async{
    final token =await storage.read(key: 'token');
    return token;
  }

  Future<void> _logout()async{
    final token=await storage.delete(key: 'token');

  }

  loadImageFromPreferences() async{
    preferences = await SharedPreferences.getInstance();
    final _imageKeyValue =preferences.getString(IMAGE_KEY);
    if(_imageKeyValue!=null){
      final imageString= await Utility.getImagefrompreference();
      setState(() {
        setImage=Utility.imageFrom64BaseString(imageString);
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.pt),
        backgroundColor: Colors.blueAccent,
      ),
      drawer: Drawer(
        child: Container(
          height: 100,
          child: ListView(
            children: <Widget>[
              Container(
                width: double.infinity,
                //padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Color(0xff669df4), Color(0xff4e80f3)]),
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(30),
                      bottomLeft: Radius.circular(30),
                    )),
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(top: 10, bottom: 10),
                        // width: 100,
                        // height: 100,
                        // decoration: BoxDecoration(
                        //     shape: BoxShape.circle,
                        //
                        //     image: DecorationImage(
                        //       image: NetworkImage(url),
                        //
                        //       fit: BoxFit.fitHeight,
                        //     )),
                      ),
                      CircularProfileAvatar(
                        '',
                        child: setImage == null
                            ? Image.asset('assets/images/blank.png')
                            : setImage,
                        radius: 60,
                        elevation: 5,
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ProfilePage()));
                        },
                        cacheImage: true,
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      GestureDetector(
                        child: Text(
                          'Hello ' ,
                              // + widget.fl.user.first_name,
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ProfilePage()),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
              ListTile(
                leading: Icon(Icons.home_work_rounded),
                title: Text('Add Place'),
                onTap: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(builder: (context) => DropDown()),
                  // );
                },
              ),
              ListTile(
                  leading: Icon(Icons.perm_identity),
                  title: Text('Add Member'),
                  onTap: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => ReadContacts(),
                    //   ),
                    // );
                  }),
              ListTile(
                  leading: Icon(Icons.power_rounded),
                  title: Text('Bill Prediction'),
                  onTap: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => BillPrediction(),
                    //   ),
                    // );
                  }),
              ListTile(
                leading: Icon(Icons.settings),
                title: Text('Setting'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SettingPage()),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.add_business_outlined),
                title: Text('Whats new'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => WhatsNew()),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.info),
                title: Text('About Genorion'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AboutGen()),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.logout),
                title: Text('Logout'),
                onTap: () {
                  _logout().then((value) => Navigator.push(context, MaterialPageRoute(builder: (context)=>GettingStartedScreen())).then((value) => Navigator.pop(context)));
                  // Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen())).then((_logout()));
                },
              ),
            ],
          ),
        ),
      ),

      body:  Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.35,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xff669df4), Color(0xff4e80f3)]),
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30)),
            ),
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top + 20,
              bottom: 10,
              left: 30,
              right: 30,
            ),
            alignment: Alignment.topLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        // Text(
                        //   "${now.hour}:${now.minute}",
                        //   style: TextStyle(
                        //       color: Colors.white, fontSize: 18),
                        // ),
                        SizedBox(
                          height: 2,
                        ),
                        Text(
                          'Hello ',
                              // + widget.fl.user.first_name,
                          style: TextStyle(
                              color: Colors.white, fontSize: 22),
                        ),
                      ],
                    ),
                    CircularProfileAvatar(
                      '',
                      child: setImage == null
                          ? Image.asset('assets/images/blank.png')
                          : setImage,
                      radius: 60,
                      elevation: 5,
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ProfilePage(
                                  // fl: widget.fl,
                                )
                            )
                        ).then((value) => loadImageFromPreferences());

                      },
                      cacheImage: true,
                    ),
                  ],
                ),
                SizedBox(
                  height: 2,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                          border:
                          Border.all(width: 1, color: Colors.white),
                          borderRadius: BorderRadius.circular(25)),
                      child: GestureDetector(
                        child: Icon(
                          Icons.power,
                          color: Colors.white,
                        ),
                        onTap: () {
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) =>
                          //             BillPrediction()));
                        },
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Text(
                              '7.9',
                              style: TextStyle(
                                  color: Colors.white54, fontSize: 15),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              '  Power use for today',
                              style: TextStyle(
                                  color: Colors.white54, fontSize: 15),
                            ),
                            SizedBox(
                              width: 4,
                            )
                          ],
                        )
                      ],
                    )
                  ],
                ),
                _tabbar(context),

              ],

            ),
          ),

        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.blueAccent,
        fixedColor: Colors.black,
        currentIndex: _currentIndex,
        //type: BottomNavigationBarType.fixed,
        items: [
          // widget.fl.map<Widget>((Floor floor){
          //     return   BottomNavigationBarItem(
          //         icon: Icon(Icons.home),
          //         title: Text(floor.f_name),
          //         backgroundColor: Colors.blueAccent);
          // }),

          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              // ignore: deprecated_member_use
              title: Text('home'),
              backgroundColor: Colors.blueAccent),
          BottomNavigationBarItem(
              icon: Icon(Icons.mic),
              title: Text(''),
              backgroundColor: Colors.purple),
          BottomNavigationBarItem(
              icon: Icon(Icons.add),
              title: Text('rm.r_name'),
              backgroundColor: Colors.blue),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              title: Text(''),
              backgroundColor: Colors.purpleAccent),

        ],
        onTap: (int newIndex) {
          setState(() {
            for (int index = 0; index < isSelected.length; index++) {
              if (index == newIndex) {
                isSelected[index] = !isSelected[index];
              } else {
                isSelected[index] = false;
              }
            }
          });
        },
      ),
    );

  }
  Widget _tabbar(BuildContext context) {

    // final FirstScreen choice;
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      scrollDirection: Axis.vertical,
      child: Container(
        // height: MediaQuery.of(context).size.height,
        // width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height - 180,
              child: DefaultTabController(
                length: widget.rm.length,
                child: Scaffold(
                  appBar: TabBar(
                    labelColor: Colors.blueAccent,
                    isScrollable: true,
                      tabs: widget.rm.map<Widget>((RoomType rm) {
                        return Tab(
                          text: rm.rName,
                        );
                      }).toList()
                  ),
                  body: Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,

                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
