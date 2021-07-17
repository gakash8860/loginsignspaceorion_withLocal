import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loginsignspaceorion/components/animated_toogle.dart';
import 'package:loginsignspaceorion/modelProviders/theme_providers.dart';
import 'package:provider/provider.dart';



class HomeTheme extends StatefulWidget {
  @override
  _HomeThemeState createState() => _HomeThemeState();
}

class _HomeThemeState extends State<HomeTheme>with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 800));
    super.initState();
  }


  changedThemeMode(bool theme){
    if(!theme){
      _animationController.forward(from: 0.0);
    }else{
      _animationController.reverse(from: 1.0);
    }
  }
  @override
  Widget build(BuildContext context) {
    final themeProvider=Provider.of<ThemeProvider>(context);
    double height=MediaQuery.of(context).size.height;
    double width=MediaQuery.of(context).size.width;
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('GenOrion'),
      ),
      body: SafeArea(
        child: Container(
          alignment: Alignment.center,
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: height*0.1),
                height: height*0.35,
                width: width*0.35,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: themeProvider.themeMode().gradient,
                    begin: Alignment.bottomLeft,
                    end: Alignment.topRight
                  )
                ),
              ),
              Transform.translate(offset: Offset(40,0),child: ScaleTransition(scale: _animationController.drive(Tween<double>(begin: 0.0,end: 0.0)
                  .chain(CurveTween(curve: Curves.decelerate))),
                    alignment: Alignment.topRight,
                    child: Container(
                      height: width*26,
                      width: width*.26,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: themeProvider.isLightTheme?Colors.white:Color(0xFF26242e)
                      ),
                    ),
              ),),
              SizedBox(height: height*0.1),
              Text('Choose a style',style: TextStyle(fontSize: width*0.06,fontWeight: FontWeight.bold),),
              SizedBox(height: height*0.3),
              Container(
                width: width*0.6,
                  child: Text('Day or night . Customize your interface',textAlign: TextAlign.center,)
              ),
              ZAnimatedToggle(
                values: ['Light','Dark'],onToggleBack: (v)async{
                  await themeProvider.toggleThemeData();
                  setState(() {
                      changedThemeMode(themeProvider.isLightTheme);
                  });
              },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
