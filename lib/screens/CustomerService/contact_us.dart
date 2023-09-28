import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:store/constants.dart';
import 'package:store/screens/profileScreen/profile_screen.dart';

final _firebaseAuth = FirebaseAuth.instance;

class ContactUs extends StatefulWidget {
  ContactUs({Key? key}) : super(key: key);

  @override
  State<ContactUs> createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  final formkey = GlobalKey<FormState>();

  final currentUser = firebaseAuth.currentUser;
  int selectedValue = 1; // Variable to store the selected radio value

  @override
  Widget build(BuildContext context) {
    final TextEditingController _emailController = TextEditingController();
    final TextEditingController _nameController = TextEditingController();
    final TextEditingController _mobileController = TextEditingController();
    final TextEditingController _addressController = TextEditingController();
    final TextEditingController _problemController = TextEditingController();
    final TextEditingController _orderNumberController =
        TextEditingController();

    void submit() async {
      if (formkey.currentState!.validate()) {
        formkey.currentState!.save();

        try {
          await FirebaseFirestore.instance
              .collection('problems')
              .doc(currentUser!.uid)
              .set({
            'email': _emailController.text,
            'name': _nameController.text,
            'address': _addressController.text,
            'Problem': _problemController.text,
            'Mobile': _mobileController.text,
            'order Number': _orderNumberController.text
          });
          final snackBar =
              SnackBar(content: Text('We will review your problem'));

          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        } catch (error) {
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(error.toString() ?? 'auth failed')));
        }
      }
    }

    return Scaffold(
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
          'Contact Us',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontSize: 20,
          ),
        ),
      ),
      backgroundColor: backgroundColor,
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Form(
          key: formkey,
          child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0, left: 20),
                    child: Text(
                      'Select your preferred communication channel',
                      style: TextStyle(fontSize: 15, color: Colors.black),
                    ),
                  ),
                  Row(
                    children: [
                      Radio(
                        activeColor: Colors.black,
                        value: 1,
                        groupValue: selectedValue,
                        onChanged: (value) {
                          setState(() {
                            selectedValue = value as int;
                          });
                        },
                      ),
                      Text('Email')
                    ],
                  ),
                  Row(
                    children: [
                      Radio(
                        activeColor: Colors.black,
                        value: 2,
                        groupValue: selectedValue,
                        onChanged: (value) {
                          setState(() {
                            selectedValue = value as int;
                          });
                        },
                      ),
                      Text('Mobile')
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Title(title: 'Name'),
                  SizedBox(
                    height: 20,
                  ),
                  RegisterTextFormField(
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'enter a valid name';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _nameController.text = value!;
                    },
                  ),
                  Visibility(
                      visible: selectedValue == 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          Title(title: 'Email'),
                          SizedBox(
                            height: 20,
                          ),
                          RegisterTextFormField(
                            validator: (value) {
                              if (value == null ||
                                  value.trim().isEmpty ||
                                  !value.contains('@')) {
                                return 'enter a valid email';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _emailController.text = value!;
                            },
                          ),
                        ],
                      )),
                  Visibility(
                      visible: selectedValue == 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          Title(title: 'Mobile'),
                          SizedBox(
                            height: 20,
                          ),
                          RegisterTextFormField(
                            keyboard: TextInputType.number,
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'enter a valid mobile';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _mobileController.text = value!;
                            },
                          ),
                        ],
                      )),
                  SizedBox(
                    height: 20,
                  ),
                  Title(title: 'Address'),
                  SizedBox(
                    height: 20,
                  ),
                  RegisterTextFormField(
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'enter a valid address';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _addressController.text = value!;
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Title(title: 'Problem'),
                  SizedBox(
                    height: 20,
                  ),
                  RegisterTextFormField(
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return null;
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _problemController.text = value!;
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Title(title: 'Order Number'),
                  SizedBox(
                    height: 20,
                  ),
                  RegisterTextFormField(
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return null;
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _orderNumberController.text = value!;
                    },
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Divider(
                thickness: 2,
              ),
              SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: submit,
                child: Container(
                  height: 50,
                  margin: EdgeInsets.all(5),
                  width: MediaQuery.of(context).size.width * 0.9,
                  decoration: BoxDecoration(color: Colors.black),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Center(
                        child: Text(
                      'Submit',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    )),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget Title({required String title}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 15,
        ),
      ),
    );
  }
}

class RegisterTextFormField extends StatelessWidget {
  RegisterTextFormField(
      {super.key,
      required this.validator,
      required this.onSaved,
      this.keyboard = TextInputType.emailAddress});
  TextInputType? keyboard;
  String? Function(String?)? validator;
  void Function(String?)? onSaved;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: TextFormField(
          keyboardType: keyboard,
          decoration: InputDecoration(
            fillColor: Colors.white,
            filled: true,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.horizontal(),
              borderSide: BorderSide(
                  color: Colors.grey
                      .withOpacity(0.7)), // Border color when not focused
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.horizontal(),
              borderSide: BorderSide(
                  color: Colors.black
                      .withOpacity(0.5)), // Border color when focused
            ),
          ),
          validator: validator,
          onSaved: onSaved),
    );
  }
}
