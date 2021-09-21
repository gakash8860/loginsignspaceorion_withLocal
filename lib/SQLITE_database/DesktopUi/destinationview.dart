import 'package:flutter/material.dart';
import 'package:loginsignspaceorion/Add%20SubUser/showSubUser.dart';
import 'package:loginsignspaceorion/InformationPageWeb/aboutWeb.dart';
import 'package:loginsignspaceorion/ProfilePage.dart';
import 'package:loginsignspaceorion/Setting_Page.dart';
import 'package:loginsignspaceorion/SubAccessPage/singlePageForSubAccess.dart';
import 'package:loginsignspaceorion/TempAccessPage/tempaccess.dart';
import 'package:loginsignspaceorion/TemporaryUser/showTempUser.dart';
import 'package:loginsignspaceorion/about_Genorion.dart';
import 'package:loginsignspaceorion/BillUsage/bill_estimation.dart';
import 'package:loginsignspaceorion/models/modeldefine.dart';
import 'package:loginsignspaceorion/schedulePin/schedulPin.dart';

import '../../dropdown1.dart';
import '../../dropdown2.dart';
import 'HomeDesktopUi.dart';
import 'contact.dart';
import 'destination.dart';

class DestinationView extends StatefulWidget {
  PlaceType pt;
  FloorType fl;
  Flat flat;
  List<RoomType> rm;
var tabbarState;
  Destination destination;

  DestinationView({this.destination, this.rm, this.flat, this.fl, this.pt,this.tabbarState});

  @override
  State<DestinationView> createState() => _DestinationViewState();
}

class _DestinationViewState extends State<DestinationView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        alignment: Alignment.center,
        child: widget.destination.id == 0 ? DesktopHome(pt: widget.pt,fl: widget.fl,flt: widget.flat,rm: widget.rm,tabbarState: widget.tabbarState,) : widget.destination.id == 1? DropDown1():widget.destination.id == 2?SubAccessSinglePage():
        widget.destination.id == 3?TempAccessPage(): widget.destination.id == 4?ShowTempUser(): widget.destination.id == 5?ShowSubUser(): widget.destination.id == 6?BillEstimation():
        widget.destination.id ==7 ?ScheduledPin(): widget.destination.id == 8?SettingPage(): widget.destination.id == 9?AboutWebPage():Container()
      ),
    );
  }
}
