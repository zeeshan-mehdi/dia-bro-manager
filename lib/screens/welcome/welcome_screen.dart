import 'package:doctor_app/constants.dart';
import 'package:doctor_app/screens/auth/sign_in_screen.dart';
import 'package:doctor_app/screens/auth/sign_up_screen.dart';
import 'package:doctor_app/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>  with TickerProviderStateMixin{

  var _loading = true;


  @override
  void initState() {
    // TODO: implement initState
    getUser();
    super.initState();
  }

  getUser()async{

    // Obtain shared preferences.
    final prefs = await SharedPreferences.getInstance();

    var username = prefs.getString('username');

    if(username !=null && username !=''){
      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Home()));
    }else{
      //do nothing user is not authenticated.
    }

    setState(() {
      _loading = false;
    });


  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // SvgPicture.asset("assets/icons/splash_bg.svg"),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
              child: Column(
                children: [
                  Spacer(),
                  Text('Welcome To',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30),),

                  Text('Dia Bro Manager',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30),),
                  // SvgPicture.asset(
                  //   "assets/icons/gerda_logo.svg",
                  // ),
                  Spacer(),
                  // As you can see we need more paddind on our btn
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SignUpScreen(),
                        ),
                      ),
                      style: TextButton.styleFrom(
                        backgroundColor: Color(0xFF6CD8D1),
                      ),
                      child: Text("Sign Up"),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: defaultPadding),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SignInScreen(),
                            )),
                        style: TextButton.styleFrom(
                          // backgroundColor: Color(0xFF6CD8D1),
                          elevation: 0,
                          backgroundColor: Colors.transparent,
                          shape: RoundedRectangleBorder(
                            side: BorderSide(color: Color(0xFF6CD8D1)),
                          ),
                        ),
                        child: Text("Sign In",style: TextStyle(color:Theme.of(context).primaryColor),),
                      ),
                    ),
                  ),
                  const SizedBox(height: defaultPadding),
                ],
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
