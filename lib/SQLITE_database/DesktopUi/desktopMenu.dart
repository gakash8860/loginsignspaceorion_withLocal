import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:loginsignspaceorion/customcolor/customcolors.dart';

class MenuWidget extends StatefulWidget {
  final int selectedIndex;
  final Function(int selectedIndex) onTapped;

  MenuWidget({@required this.onTapped, this.selectedIndex});

  @override
  _MenuWidgetState createState() => _MenuWidgetState();
}

class _MenuWidgetState extends State<MenuWidget> {
  int _selectedItem = 0;

  @override
  void initState() {
    super.initState();
    _selectedItem = widget.selectedIndex;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            width: double.maxFinite,
            height: 150,
            color: CustomColors.blue_gray_dark,
            child: Center(
              child: Text(
                'GenOrion',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'SansitaSwashed',
                  fontSize: 32,
                  letterSpacing: 1,
                ),
              ),
            ),
          ),
          Container(
            height: 5,
            width: double.maxFinite,
            color: Colors.white60,
          ),
          InkWell(
              onTap: () {
                setState(() {
                  _selectedItem = 0;
                  widget.onTapped(_selectedItem);
                });
              },
              child: Item(0, 'Home', _selectedItem, Icons.home)),
          Container(
            height: 5,
            width: double.maxFinite,
            color: Colors.white60,
          ),
          InkWell(
              onTap: () {
                setState(() {
                  _selectedItem = 1;
                  widget.onTapped(_selectedItem);
                });
              },
              child: Item(1, 'Add Place', _selectedItem, Icons.add)),
          Container(
            height: 5,
            width: double.maxFinite,
            color: Colors.white60,
          ),
          InkWell(
              onTap: () {
                setState(() {
                  _selectedItem = 2;
                  widget.onTapped(_selectedItem);
                });
              },
              child: Item(2, 'Sub Access Page', _selectedItem, Icons.people)),
          InkWell(
              onTap: () {
                setState(() {
                  _selectedItem = 3;
                  widget.onTapped(_selectedItem);
                });
              },
              child: Item(2, 'Temp Access Page', _selectedItem, Icons.people)),
          InkWell(
              onTap: () {
                setState(() {
                  _selectedItem = 4;
                  widget.onTapped(_selectedItem);
                });
              },
              child: Item(2, 'Show Temp User', _selectedItem, Icons.people)),
          InkWell(
              onTap: () {
                setState(() {
                  _selectedItem = 5;
                  widget.onTapped(_selectedItem);
                });
              },
              child: Item(2, 'Show Sub User', _selectedItem, Icons.people)),
          InkWell(
              onTap: () {
                setState(() {
                  _selectedItem = 6;
                  widget.onTapped(_selectedItem);
                });
              },
              child: Item(2, 'Bill Prediction', _selectedItem, Icons.power_rounded)),
          InkWell(
              onTap: () {
                setState(() {
                  _selectedItem = 7;
                  widget.onTapped(_selectedItem);
                });
              },
              child: Item(2, 'Schedule Pin', _selectedItem, Icons.schedule)),
          InkWell(
              onTap: () {
                setState(() {
                  _selectedItem = 8;
                  widget.onTapped(_selectedItem);
                });
              },
              child: Item(2, 'Setting Page', _selectedItem, Icons.settings)),
          InkWell(
              onTap: () {
                setState(() {
                  _selectedItem = 9;
                  widget.onTapped(_selectedItem);
                });
              },
              child: Item(2, 'ABout GenOrion', _selectedItem, Icons.help)),
          Container(
            height: 5,
            width: double.maxFinite,
            color: Colors.white60,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0, top: 20.0, bottom: 20.0),
            child: Row(
              children: [
                Icon(Icons.notifications, size: 24, color: CustomColors.neon_green),
                SizedBox(width: 16.0),
                Expanded(child: Text('Add')),
              ],
            ),
          ),
          Container(
            height: 2,
            width: double.maxFinite,
            color: Colors.white24,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0, top: 20.0, bottom: 20.0),
            child: Row(
              children: [
                Icon(Icons.settings, size: 24, color: CustomColors.neon_green),
                SizedBox(width: 16.0),
                Expanded(child: Text('Add')),
              ],
            ),
          ),
          Container(
            height: 2,
            width: double.maxFinite,
            color: Colors.white24,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0, top: 20.0, bottom: 20.0),
            child: Row(
              children: [
                Icon(Icons.info, size: 24, color: CustomColors.neon_green),
                SizedBox(width: 16.0),
                Expanded(child: Text('Add')),
              ],
            ),
          ),
          Container(
            height: 2,
            width: double.maxFinite,
            color: Colors.white24,
          ),
        ],
      ),
    );
  }
}

class Item extends StatefulWidget {
  final int id;
  final String title;
  final int selected;
  final IconData icon;

  Item(this.id, this.title, this.selected, this.icon);

  @override
  _ItemState createState() => _ItemState();
}

class _ItemState extends State<Item> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: widget.selected == widget.id
            ? Border.all(width: 2.0, color: CustomColors.blue_gray)
            : null,
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 16.0, top: 20.0, bottom: 20.0),
        child: Row(
          children: [
            Icon(widget.icon, size: 24, color: CustomColors.neon_green),
            SizedBox(width: 16.0),
            Text(widget.title, style: TextStyle(color: CustomColors.neon_green)),
          ],
        ),
      ),
    );
  }
}
