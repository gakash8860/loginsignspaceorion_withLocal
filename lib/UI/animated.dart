import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(context) =>
      MaterialApp(
          home: LoginPage()
      );
}

class LoginPage extends StatelessWidget {
  @override
  Widget build(context) =>
      Scaffold(
          body: Container(
            decoration:BoxDecoration(
              image: DecorationImage(
                image: NetworkImage("https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.istockphoto.com%2Fphotos%2Fsmart-home&psig=AOvVaw3Th3mxC6p13_e1E0owFIB4&ust=1628839639758000&source=images&cd=vfe&ved=0CAsQjRxqFwoTCJjH66b7qvICFQAAAAAdAAAAABAD")
              )
            ) ,
            child: LayoutBuilder(
                builder: (context, constraints) {
                  return AnimatedContainer(

                      duration: Duration(milliseconds: 500),
                      color: Colors.lightGreen[200],
                      padding: constraints.maxWidth < 500 ? EdgeInsets.zero : const EdgeInsets.all(30.0),
                      child: Center(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 30.0, horizontal: 25.0
                          ),
                          constraints: BoxConstraints(
                            maxWidth: 500,
                          ),
                          decoration: BoxDecoration(

                            // color: Colors.white,
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Container(

                                    width: 250,
                                    child: Center(child: Image.asset('assets/images/genLogo.png'))),
                                TextField(
                                    decoration: InputDecoration(
                                        labelText: "username"
                                    )
                                ),
                                TextField(
                                    obscureText: true,
                                    decoration: InputDecoration(
                                        labelText: "password"
                                    )
                                ),
                                RaisedButton(
                                    color: Colors.blue,
                                    child: Text("Log in", style: TextStyle(color: Colors.white)),
                                    onPressed: () {}
                                )
                              ]
                          ),
                        ),
                      )
                  );
                }
            ),
          )
      );
}