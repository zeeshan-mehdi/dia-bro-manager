import 'package:date_time_picker/date_time_picker.dart';
import 'package:doctor_app/Api/api.dart';
import 'package:doctor_app/constants.dart';
import 'package:doctor_app/screens/auth/sign_in_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../home.dart';
import 'components/sign_up_form.dart';

class SignUpScreen extends StatefulWidget {
  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> with TickerProviderStateMixin {
  // It's time to validat the text field
  final _formKey = GlobalKey<FormState>();

  final focusNode = FocusNode();

  late String _userName, _givenName, _password, _phoneNumber,_gender = 'male',_dob;

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
          //   // Now it takes 100% of our height
          // ),
          Center(
            child: SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Create Account",
                      style: Theme.of(context)
                          .textTheme
                          .headline5!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    Row(
                      children: [
                        Text("Already have an account?"),
                        TextButton(
                          onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SignInScreen(),
                              )),
                          child: Text(
                            "Sign In!",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: defaultPadding ),
                    Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextFieldName(text: "Given Name"),
                          TextFormField(
                            focusNode: focusNode,
                            decoration: InputDecoration(hintText: "Martin"),
                            validator: RequiredValidator(errorText: "Given Name is required"),
                            // Let's save our username
                            onSaved: (username) => _givenName = username!,
                          ),
                          const SizedBox(height: defaultPadding),
                          // We will fixed the error soon
                          // As you can see, it's a email field
                          // But no @ on keybord

                          TextFieldName(text: "Family Name"),
                          TextFormField(
                            decoration: InputDecoration(hintText: "Thost"),
                            validator: RequiredValidator(errorText: "Family Name is required"),
                            // Let's save our username
                            onSaved: (username) => _userName = username!,
                          ),

                          TextFieldName(text: "Date of Birth"),
                          // TextFormField(
                          //   decoration: InputDecoration(hintText: "Pick your date of birth"),
                          //   validator: RequiredValidator(errorText: "Family Name is required"),
                          //   // Let's save our username
                          //   onSaved: (username) => _userName = username!,
                          // ),

                        DateTimePicker(
                          initialValue: '',
                          firstDate: DateTime(1900),
                          lastDate: DateTime(2100),
                          dateLabelText: 'Date',
                          onChanged: (val) => print(val),
                          validator: (val) {
                            _dob = val??'';
                            print(val);
                            return null;
                          },
                          onSaved: (val) => print(val),
                        ),

                          TextFieldName(text: "Gender"),

                          DropdownButton<String>(
                            // Step 3.
                            value: _gender,
                            isExpanded: true,
                            // Step 4.
                            items: <String>['male','female','other','unknown']
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,

                                child: Text(
                                  value,
                                  style: TextStyle(fontSize: 14),
                                ),
                              );
                            }).toList(),
                            // Step 5.
                            onChanged: (String? newValue) {
                              setState(() {
                                _gender = newValue!;
                              });
                            },
                          ),


                          const SizedBox(height: defaultPadding),
                          TextFieldName(text: "Password"),

                          TextFormField(
                            // We want to hide our password
                            obscureText: true,
                            decoration: InputDecoration(hintText: "******"),
                            validator: passwordValidator,
                            onSaved: (password) => _password = password!,
                            // We also need to validate our password
                            // Now if we type anything it adds that to our password
                            onChanged: (pass) => _password = pass,
                          ),
                          const SizedBox(height: defaultPadding),
                          // TextFieldName(text: "Confirm Password"),
                          // TextFormField(
                          //   obscureText: true,
                          //   decoration: InputDecoration(hintText: "*****"),
                          //   validator: (pass) => MatchValidator(errorText: "Password do not  match").validateMatch(pass!, _password),
                          // ),

                        ],
                      ),
                    ),
                    const SizedBox(height: defaultPadding),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () async{
                          if (_formKey.currentState!.validate()) {
                            // Sign up form is done
                            // It saved our inputs
                            _formKey.currentState!.save();

                            print(_formKey.currentState);

                            setState(() {
                              _loading = true;
                            });

                            Api api = new Api();

                            try {
                              var response = await api.createPatient(
                                  _givenName, _userName, _gender, _dob,
                                  _password);

                              // Obtain shared preferences.
                              final prefs = await SharedPreferences.getInstance();

                              await prefs.setString('username', _userName);
                              await prefs.setString('givenname', _givenName);
                              await prefs.setString('password', _userName+_password);

                              if (response.statusCode == 200 ||
                                  response.statusCode == 201) {
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>Home(username: _userName)));
                              } else {
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>Home(username: _userName)));

                              }

                              setState(() {
                                _loading = false;
                              });
                            }catch(e){
                              setState(() {
                                _loading = false;
                              });
                            }


                          }
                        },
                        child: Text("Sign Up"),
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
