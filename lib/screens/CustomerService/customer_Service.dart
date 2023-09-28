import 'package:flutter/material.dart';
import 'package:store/constants.dart';
import 'package:store/screens/CustomerService/contact_us.dart';

class CustomerService extends StatelessWidget {
  const CustomerService({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar:AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        elevation: 0,
        title: Text(
          'Customer Service',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontSize: 20,
          ),
        ),
      ),
      body: Column(
        children: [
          CustomListTile( onTap: () {
           Navigator.of(context).push(MaterialPageRoute(builder: (context){
           return ContactUs();
           }));
          }, title: 'Contact Us'),
        ],
      ),
    );
  }

  Widget CustomListTile({required Function()? onTap, required String title}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(
            color: Colors.black.withOpacity(0.2), // Change the color of the line as needed
            width: 1.0, // Adjust the width of the line as needed
          ),
        ),
      ),
      child: ListTile(
        onTap: onTap,
        title: Text(title,
        style: TextStyle(
         fontSize: 15,
         fontWeight: FontWeight.bold
        ),),
        trailing: Icon(Icons.arrow_right),
      ),
    );
  }
}
