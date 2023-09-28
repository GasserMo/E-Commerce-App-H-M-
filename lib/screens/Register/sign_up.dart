import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:store/constants.dart';
import 'package:store/screens/HomeScreen/home_screen.dart';
import 'package:store/screens/profileScreen/profile_screen.dart';

final _firebaseAuth = FirebaseAuth.instance;

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

bool _isLogin = true;

class _SignUpState extends State<SignUp> {
  final formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final TextEditingController _emailController = TextEditingController();
    final TextEditingController _usernameController = TextEditingController();
    final TextEditingController _passwordController = TextEditingController();
    void submit() async {
      if (formkey.currentState!.validate()) {
        formkey.currentState!.save();

        if (_isLogin) {
          try {
            final UserCredential =
                await _firebaseAuth.signInWithEmailAndPassword(
                    email: _emailController.text,
                    password: _passwordController.text);
            final snackBar = SnackBar(content: Text('Account Logged'));
            ScaffoldMessenger.of(context).showSnackBar(snackBar);

            Navigator.of(context).pop();
          } on FirebaseAuthException catch (error) {
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(error.message ?? 'auth failed')));
          }
        } else {
          try {
            final userCredentials =
                await _firebaseAuth.createUserWithEmailAndPassword(
                    email: _emailController.text,
                    password: _passwordController.text);
            final snackBar = SnackBar(content: Text('Account Created'));
            await FirebaseFirestore.instance
                .collection('users')
                .doc(userCredentials.user!.uid)
                .set({
              'email': _emailController.text,
              'username': _usernameController.text
            });
       
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
            Navigator.of(context).pop();
          } on FirebaseAuthException catch (error) {
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(error.message ?? 'auth failed')));
          }
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
          'Sign In/Up',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontSize: 20,
          ),
        ),
      ),
      backgroundColor: backgroundColor,
      body: Form(
        key: formkey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: _isLogin
                    ? Text(
                        'Sign In',
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                      )
                    : Text(
                        'Sign Up',
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                      )),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 30,
            ),
            if (!_isLogin)
              RegisterTextFormField(
                labelText: 'Username',
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'enter a valid username';
                  }
                  return null;
                },
                onSaved: (value) {
                  _usernameController.text = value!;
                },
              ),
            SizedBox(
              height: 30,
            ),
            RegisterTextFormField(
              labelText: 'email',
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
            SizedBox(
              height: 30,
            ),
            RegisterTextFormField(
              labelText: 'password',
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'enter a valid password';
                }
                return null;
              },
              onSaved: (value) {
                _passwordController.text = value!;
              },
            ),
            SizedBox(
              height: 20,
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
                      child: _isLogin
                          ? Text(
                              'Sign In',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            )
                          : Text(
                              'Sign Up',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            )),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _isLogin
                    ? Text(
                        'Don\'t have an account? ',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                        ),
                      )
                    : Text(
                        'Already Have an Account? ',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                        ),
                      ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _isLogin = !_isLogin;
                    });
                  },
                  child: _isLogin
                      ? Text(
                          'Sign Up',
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 15,
                          ),
                        )
                      : Text(
                          'Sign in',
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 15,
                          ),
                        ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class RegisterTextFormField extends StatelessWidget {
  RegisterTextFormField(
      {super.key,
      required this.labelText,
      required this.validator,
      required this.onSaved});

  final String labelText;
  String? Function(String?)? validator;
  void Function(String?)? onSaved;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: TextFormField(
          decoration: InputDecoration(
            fillColor: Colors.white,
            label: Text(labelText),
            labelStyle: TextStyle(color: Colors.black.withOpacity(0.5)),
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
