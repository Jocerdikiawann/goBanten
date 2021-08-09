import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gobanten/Provider/ProviderUser.dart';
import 'package:gobanten/Screens/Signup/signup_screen.dart';
import 'package:gobanten/Screens/Welcome/components/background.dart';
import 'package:gobanten/components/already_have_an_account_acheck.dart';
import 'package:gobanten/components/rounded_button.dart';
import 'package:gobanten/components/rounded_input_field.dart';
import 'package:gobanten/components/rounded_password_field.dart';
import 'package:provider/provider.dart';

class BodyLogin extends StatefulWidget {
  const BodyLogin({
    Key key,
  }) : super(key: key);

  @override
  _BodyLoginState createState() => _BodyLoginState();
}

class _BodyLoginState extends State<BodyLogin> {
  String email, password;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Consumer<AuthService>(builder: (_, a, child) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "LOGIN",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: size.height * 0.03),
              SvgPicture.asset(
                "assets/icons/login.svg",
                height: size.height * 0.35,
              ),
              SizedBox(height: size.height * 0.03),
              RoundedInputField(
                hintText: "Your Email",
                onChanged: (value) {
                  setState(() {
                    email = value;
                  });
                },
              ),
              RoundedPasswordField(
                onChanged: (value) {
                  setState(() {
                    password = value;
                  });
                },
              ),
              RoundedButton(
                text: "LOGIN",
                press: () {
                  a.login(email, password, context);
                },
              ),
              SizedBox(height: size.height * 0.03),
              AlreadyHaveAnAccountCheck(
                press: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return SignUpScreen();
                      },
                    ),
                  );
                },
              ),
            ],
          );
        }),
      ),
    );
  }
}
