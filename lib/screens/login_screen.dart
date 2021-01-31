import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stargazer_mobile_app/models/login_user_model.dart';
import 'package:stargazer_mobile_app/models/registration_user_model.dart';
import 'package:stargazer_mobile_app/screens/main_screen.dart';
import 'package:stargazer_mobile_app/screens/registration_screen.dart';
import 'package:stargazer_mobile_app/services/api_instance.dart';
import 'package:stargazer_mobile_app/services/api_services.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  String phoneNo;

  String password;

  String username;

  final TextEditingController passwordController = TextEditingController();

  final TextEditingController usernameController = TextEditingController();

  final FocusNode passwordFN = FocusNode();

  final FocusNode usernameFN = FocusNode();

  Column _getOtpBtn(context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: RaisedButton(
            elevation: 0.0,
            padding: EdgeInsets.symmetric(vertical: 15),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            color: Colors.blue,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  Icons.phone_android,
                  color: Colors.white,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  'Login',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                      color: Colors.white),
                ),
              ],
            ),
            onPressed: () async {
              if (_formKey.currentState.validate()) {
                var apiServices = APIServices(APIInstance().instance);
                var prefs = await SharedPreferences.getInstance();
                print(usernameController.text.toString());
                print(passwordController.text.toString());
                try {
                  var loginUser = await apiServices.login(LoginUser(
                      name: usernameController.value.text.toString(),
                      password: passwordController.value.text.toString()));

                  prefs.setBool('login', true);
                  prefs.setString('sign', loginUser.sign);
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => MyApp()),
                  );
                } catch (err) {
                  Fluttertoast.showToast(
                      msg: "Error Occured",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      fontSize: 16.0);
                }
              }
            },
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          '----- OR -----',
          style: TextStyle(color: Colors.black, fontSize: 20),
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: RaisedButton(
            elevation: 0.0,
            padding: EdgeInsets.symmetric(vertical: 15),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            color: Colors.green,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  Icons.phone_android,
                  color: Colors.white,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  'Register',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                      color: Colors.white),
                ),
              ],
            ),
            onPressed: () async {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Register()),
              );
            },
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(child: buildRegister(context)));
  }

  Widget buildRegister(context) {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            _getUpperPart(context),
            //otp button
            _getOtpBtn(context),
          ],
        ),
      ),
    );
  }

  Widget _getUpperPart(context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        children: <Widget>[
          //Title
          Image.asset(
            'images/telescope.png',
            width: 100,
            height: 100,
          ),
          Text.rich(
            TextSpan(
              text: 'Stargazer \n',
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
              // default text style
              children: <TextSpan>[
                TextSpan(
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                  ),
                  text: 'A Divination Service App',
                ),
              ],
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 40,
          ),

          //Username
          Container(
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Username',
                  style: Theme.of(context).textTheme.caption,
                ),
                Text(
                  'max of 30 letters',
                  style: Theme.of(context).textTheme.caption,
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 5),
            padding: EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: Colors.grey,
                width: 0.5,
              ),
            ),
            child: TextFormField(
              controller: usernameController,
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value.isEmpty) {
                  return "Enter Username";
                } else {
                  return null;
                }
              },
              focusNode: usernameFN,
              onEditingComplete: () => FocusScope.of(context).nextFocus(),
              inputFormatters: [
                LengthLimitingTextInputFormatter(11),
              ],
              onChanged: (value) {
                phoneNo = value;
              },
            ),
          ),
          SizedBox(
            height: 30,
          ),

          //Phone Number
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'Enter Password',
                style: Theme.of(context).textTheme.caption,
              ),
              Text(
                'max of 20 Digits',
                style: Theme.of(context).textTheme.caption,
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.only(top: 5),
            padding: EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: Colors.grey,
                width: 0.5,
              ),
            ),
            child: TextFormField(
              obscureText: true,
              controller: passwordController,
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value.isEmpty) {
                  return "Enter Password";
                } else if (value.length < 8) {
                  return "Password length too short";
                } else {
                  return null;
                }
              },
              focusNode: passwordFN,
              onEditingComplete: () => FocusScope.of(context).nextFocus(),
              inputFormatters: [
                LengthLimitingTextInputFormatter(11),
              ],
              onChanged: (value) {
                phoneNo = value;
              },
            ),
          ),
          SizedBox(
            height: 30,
          ),

          //Password
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(
                'Enter Date of Birth ',
                style: Theme.of(context).textTheme.caption,
              ),
            ],
          ),

          SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }
}
