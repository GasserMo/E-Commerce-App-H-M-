import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:store/screens/Register/sign_up.dart';
import 'package:store/screens/profileScreen/profile_screen.dart';
import 'package:store/screens/widgets/offers.dart';
final firebaseAuth=FirebaseAuth.instance;

class UserSignedOut extends StatelessWidget {
  const UserSignedOut({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.yellow.withOpacity(0.1),
      height: MediaQuery.of(context).size.height * 0.5,
      width: MediaQuery.of(context).size.width,
      child:
          Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Container(
          color: Colors.white,
          child: Image.asset(
            'assets/images/model.webp',
            fit: BoxFit.fill,
            height: MediaQuery.of(context).size.height * 0.15,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Welcome to H&M',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 18,
              ),
              Text(
                'Reister or login to personalize your experience and access special offer',
                style: TextStyle(color: Colors.black, fontSize: 15),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Icon(Icons.percent),
                  Text('Recieve 10% discound code')
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  Icon(Icons.shopping_bag_outlined),
                  Text('Recieve 10% discound code')
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  Icon(Icons.notification_add_outlined),
                  Text('Recieve 10% discound code')
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomButton(
                    onTap: () {
                      modalBottomSheet(context);
                    },
                    text: 'Sign in',
                    backgroundColor: Colors.black,
                    textColor: Colors.white,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  CustomButton(
                    onTap: () {
                      modalBottomSheet(context);
                    },
                    text: 'Register',
                    backgroundColor: Colors.white,
                    textColor: Colors.black,
                  )
                ],
              ),
            ],
          ),
        )
      ]),
    );
  }

  Future<void> modalBottomSheet(BuildContext context) async {
    await showModalBottomSheet(
      
      context: context,
      builder: (BuildContext context) {
        return Stack(
        children: [
          Image.asset(
            'assets/images/men/men2.jpg',
            fit: BoxFit.fill,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
          ),
          Positioned(
            right: 10,
            child: IconButton(onPressed: (){
              Navigator.pop(context);
            }, icon: Icon(Icons.close)),
          ),
          Positioned(
           bottom: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10.0, top: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Want to get access to exclusive offers?',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Register now and enjoy your tailored experience!',
                        style: TextStyle(),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Some of our perks',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      OfferText(
                        icon: Icons.card_giftcard,
                        text: 'Recieve offers tailored to you',
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      OfferText(
                        icon: Icons.save_sharp,
                        text: 'Recieve offers tailored to you',
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      OfferText(
                        icon: Icons.fire_truck,
                        text: 'Recieve offers tailored to you',
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20,),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return SignUp();
                      
                    }));
                  },
                  child: Container(
                    height: 50,
                    margin: EdgeInsets.all(5),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(color: Colors.black),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.email_outlined,
                            size: 30,
                            color: Colors.grey,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Continue with email',
                            style:
                                TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      );
      },
    );
  }
}
