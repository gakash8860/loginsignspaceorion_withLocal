import 'package:flutter/material.dart';


void main()=>runApp(MaterialApp(
  home: QueryPage(),
));
class QueryPage extends StatefulWidget {
  const QueryPage({Key key}) : super(key: key);

  @override
  _QueryPageState createState() => _QueryPageState();
}

class _QueryPageState extends State<QueryPage> {
  TextEditingController firstNameController= TextEditingController();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints viewportConstraints) {
      if (viewportConstraints.maxWidth > 600) {
        return Scaffold();
      }else{
        return Scaffold(
          appBar: AppBar(
            title: Text('Query Page'),
          ),
          body: Center(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 105,top: 95),
              child: Card(
          shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(35.0)),
          color: Colors.yellow,
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 20,),
                      ListTile(
                        title:  TextFormField(
                          autofocus: true,
                          textInputAction: TextInputAction.next,
                          autovalidateMode:
                          AutovalidateMode.onUserInteraction,
                          // validator: nameValid,
                          // onSaved: (String value) {
                          //   this.data.fname = value;
                          // },
                          controller: firstNameController,
                          style:
                          TextStyle(fontSize: 18, color: Colors.black54),
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.person),
                            filled: true,
                            fillColor: Colors.white,
                            hintText: 'Name',
                            contentPadding: const EdgeInsets.all(15),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(50),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(50),
                            ),
                          ),
                        ),
                      )
                  ],
                ),
              ),
            )
          ),
        );
      }
        }
    );
  }
}
