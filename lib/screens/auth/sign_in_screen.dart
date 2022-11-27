import 'dart:convert';

import 'package:doctor_app/Api/api.dart';
import 'package:doctor_app/screens/auth/sign_up_screen.dart';
import 'package:doctor_app/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants.dart';
import 'components/sign_in_form.dart';
import 'components/sign_up_form.dart';

class SignInScreen extends StatefulWidget {
  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> with TickerProviderStateMixin {
  // It's time to validat the text field
  final _formKey = GlobalKey<FormState>();

  late String _email, _password;

  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    // But still same problem, let's fixed it
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        fit: StackFit.expand,
        children: [
          // SvgPicture.asset(
          //   "assets/icons/Sign_Up_bg.svg",
          //   height: MediaQuery.of(context).size.height,
          //   width: MediaQuery.of(context).size.width,
          //   // Now it takes 100% of our height
          // ),
          Padding(
            padding:
                EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.1),
            child: SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Sign In",
                      style: Theme.of(context)
                          .textTheme
                          .headline5!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    Row(
                      children: [
                        Text("Don't have an account?"),
                        TextButton(
                          onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SignUpScreen(),
                            ),
                          ),
                          child: Text(
                            "Sign Up!",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: defaultPadding * 2),
                    Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextFieldName(text: "Family Name"),
                          TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(hintText: "e.g thost"),
                            validator: RequiredValidator(errorText: "Family Name is required"),
                            onSaved: (email) => _email = email!,
                          ),
                          const SizedBox(height: defaultPadding),
                          TextFieldName(text: "Password"),
                          TextFormField(
                            // We want to hide our password
                            obscureText: true,
                            decoration: InputDecoration(hintText: "******"),
                            validator: passwordValidator,
                            onSaved: (password) => _password = password!,
                          ),
                          const SizedBox(height: defaultPadding),
                        ],
                      ),
                    ),
                    const SizedBox(height: defaultPadding * 2),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () async{
                          if (_formKey.currentState!.validate()) {

                            setState(() {
                              _loading = true;
                            });

                            // Sign up form is done
                            // It saved our inputs
                            _formKey.currentState!.save();

                            var api = Api();

                            var response = await api.getPatientById(_email, _password);

                            if(response.statusCode == 200 || response.statusCode == 202){

                              var body = json.decode(response.body);

                              if(body['total'] >0){

                                // Obtain shared preferences.
                                final prefs = await SharedPreferences.getInstance();

                                await prefs.setString('username', _email);
                                await prefs.setString('password', _email+_password);

                                await prefs.setString('id', body['id']);


                                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Home()));
                              }
                            }else {
                              print('something went wrong');
                              print(response.body);
                            }

                            setState(() {
                              _loading = false;
                            });
                            //  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Home()));
                            //  Sign in also done
                          }
                        },
                        child: Text("Sign In"),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          Center(child: _loading ? SpinKitSquareCircle(
            color: Theme.of(context).primaryColor,
            size: 50.0,
            controller: AnimationController( duration: const Duration(milliseconds: 1200), vsync: this),
          ):Container())


        ],
      ),
    );
  }
}
