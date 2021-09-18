import 'package:contactus/contactus.dart';
import 'package:flutter/material.dart';

void main()=>runApp(MaterialApp(
  home: ContactPage(),
));

class ContactPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return
      LayoutBuilder(
        builder: (BuildContext context, BoxConstraints viewportConstraints) {
      if (viewportConstraints.maxWidth > 600) {
        return Scaffold(

          body: Center(
            child: Container(
              width: 400,
              child: ContactUs(
                logo: AssetImage('assets/images/genLogo.png'),
                email: 'contact@genorion.com',
                companyName: 'Genorion',
                phoneNumber: '+919911757588',
                // dividerThickness: 2,
                website: 'https://genorion.com/',
                linkedinURL: 'https://www.linkedin.com/company/spaceorion/',
                tagLine: 'Automation',
                twitterHandle: 'https://twitter.com/GENORION1',
                emailText: 'contact@genorion.com',
                phoneNumberText: '919911757588',
                companyColor: Colors.black,

                // instagramUserName: '_abhishek_doshi',
              ),
            ),
          )
        );
      }else{
        return Scaffold(
          appBar: AppBar(
            title: Text('Contact '),
          ),
            body:  Column(
              children: [
                SizedBox(height: 16,),
                ContactUs(
                  logo: AssetImage('assets/images/genLogo.png'),
                  email: 'contact@genorion.com',
                  companyName: 'Genorion',
                  phoneNumber: '+919911757588',
                  // dividerThickness: 2,
                  website: 'https://genorion.com/',
                  linkedinURL: 'https://www.linkedin.com/company/spaceorion/',
                  tagLine: 'Automation',
                  twitterHandle: 'https://twitter.com/GENORION1',
                  // instagramUserName: '_abhishek_doshi',
                ),
              ],
            ),
        );
      }
        }
    );
  }
}