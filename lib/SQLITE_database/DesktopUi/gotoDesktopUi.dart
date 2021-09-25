import 'package:flutter/material.dart';
import 'package:loginsignspaceorion/models/modeldefine.dart';

import 'desktopMenu.dart';
import 'destination.dart';
import 'destinationview.dart';

class HomeViewLarge extends StatefulWidget {
  PlaceType pt;
  Flat flt;
  FloorType fl;
  List<RoomType> rm;
  List<Device> dv;
  var tabbarState;
  final int currentIndex;
  final Function(int selectedIndex) onTapped;

  HomeViewLarge(this.currentIndex, this.onTapped,{
   this.rm,this.flt,this.fl,this.pt,this.tabbarState,this.dv
  });

  @override
  _HomeViewLargeState createState() => _HomeViewLargeState();
}

class _HomeViewLargeState extends State<HomeViewLarge> {
  int _index = 0;

  @override
  void initState() {
    super.initState();
    print('gotodestop ${widget.flt.fltId}');
    _index = widget.currentIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            flex: 1,
            child: MenuWidget(
              selectedIndex: _index,
              onTapped: (selectedIndex) {
                setState(() {
                  _index = selectedIndex;
                  widget.onTapped(_index);
                });
              },
            ),
          ),
          Expanded(
            flex: 2,
            child: IndexedStack(
              index: _index,
              children: allDestinations.map<Widget>((
                  Destination destination) {
                return DestinationView(destination: destination,pt: widget.pt,fl: widget.fl,flat: widget.flt,rm: widget.rm,tabbarState: widget.tabbarState,dv: widget.dv,);
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
