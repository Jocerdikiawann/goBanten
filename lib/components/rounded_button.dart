import 'package:flutter/material.dart';
import 'package:gobanten/Provider/ProviderUser.dart';
import 'package:gobanten/Utils/constants.dart';
import 'package:provider/provider.dart';

class RoundedButton extends StatelessWidget {
  final String text;
  final Function press;
  final Color color, textColor;
  const RoundedButton({
    Key key,
    this.text,
    this.press,
    this.color = kPrimaryColor,
    this.textColor = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      width: size.width * 0.8,
      child: ClipRRect(
          borderRadius: BorderRadius.circular(29),
          child: Consumer<AuthService>(
            builder: (_, a, child) {
              return FlatButton(
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                  color: color,
                  onPressed: press,
                  child: (a.isloading)
                      ? CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.white),
                        )
                      : Text(
                          text,
                          style: TextStyle(color: textColor),
                        ));
            },
          )),
    );
  }
}
