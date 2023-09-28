import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:store/constants.dart';
import 'package:store/repositiries/local%20storage/Cart%20storage/cart_storage_repository.dart';
import 'package:store/screens/AboutUs/about_us.dart';
import 'package:store/screens/CustomerService/customer_Service.dart';
import 'package:store/screens/widgets/user_signed_out.dart';

final firebaseAuth = FirebaseAuth.instance;
final firebaseStore = FirebaseFirestore.instance;

class ProfileScreen extends StatefulWidget {
  ProfileScreen({Key? key}) : super(key: key);
  static const String routeName = '/profile';

  static Route route() {
    return MaterialPageRoute(
        settings: RouteSettings(name: routeName),
        builder: (context) {
          return ProfileScreen();
        });
  }

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  User? currentUser = firebaseAuth.currentUser;
  late String userName = '';
  bool isLogin = true;
  Future<DocumentSnapshot?> fetchUserData() async {
    if (currentUser != null) {
      try {
        return await FirebaseFirestore.instance
            .collection('users')
            .doc(currentUser!.uid)
            .get();
      } catch (error) {
        print('Error fetching user data: $error');
        return null;
      }
    }
    return null;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'My Account',
                style: TextStyle(color: Colors.black),
              )
            ],
          ),
        ),
        body: StreamBuilder<User?>(
            stream: firebaseAuth.userChanges(),
            builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (!snapshot.hasData || snapshot.data == null) {
                return Column(
                  children: [
                    UserSignedOut(),
                    AccountDetails(),
                  ],
                );
              } else {
                return FutureBuilder<DocumentSnapshot?>(
                  future: fetchUserData(),
                  builder: (BuildContext context,
                      AsyncSnapshot<DocumentSnapshot?> firestoreSnapshot) {
                    if (firestoreSnapshot.connectionState ==
                        ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (firestoreSnapshot.hasError) {
                      return Text('Error: ${firestoreSnapshot.error}');
                    } else if (firestoreSnapshot.hasData &&
                        firestoreSnapshot.data != null) {
                      final userData = firestoreSnapshot.data!;
                      final username = userData['username'] ?? '';
                      final firstChar = username.isNotEmpty ? username[0] : '';
                      return Column(
                        children: [
                          CircleAvatar(
                            radius: 40,
                            backgroundColor: Colors.white,
                            child: CircleAvatar(
                              radius: 35,
                              child: Text(
                                firstChar,
                                style: TextStyle(color: Colors.white),
                              ),
                              backgroundColor: Colors.black,
                            ),
                          ),
                          AccountDetails(),
                          ListTile(
                            onTap: () {
                              firebaseAuth.signOut();
                            },
                            title: Text('Sign out'),
                            leading: Icon(Icons.logout),
                            trailing: Icon(Icons.arrow_right),
                          ),
                          // Rest of your UI using userData
                          // ...
                        ],
                      );
                    }
                    return Text('');
                  },
                );
              }
            }));
  }
}

class AccountDetails extends StatelessWidget {
  const AccountDetails({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              return CustomerService();
            }));
          },
          title: Text('Customer Service'),
          leading: Icon(Icons.help_center),
          trailing: Icon(Icons.arrow_right),
        ),
        ListTile(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              return AboutUS();
            }));
          },
          title: Text('About us'),
          leading: Icon(Icons.info_outline),
          trailing: Icon(Icons.arrow_right),
        ),
      ],
    );
  }
}

class CustomButton extends StatelessWidget {
  CustomButton(
      {super.key,
      required this.text,
      required this.textColor,
      required this.backgroundColor,
      required this.onTap});
  final String text;
  final Color textColor;
  void Function()? onTap;
  final Color backgroundColor;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(top: 20.0),
        child: Container(
          width: MediaQuery.of(context).size.width * 0.4,
          height: MediaQuery.of(context).size.height * 0.05,
          decoration: BoxDecoration(
              color: backgroundColor, border: Border.all(color: Colors.black)),
          child: Center(
            child: Text(
              text,
              style: TextStyle(color: textColor, fontSize: 15),
            ),
          ),
        ),
      ),
    );
  }
}
