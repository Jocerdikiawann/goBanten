import 'package:flutter/material.dart';
import 'package:gobanten/Provider/ProviderUser.dart';
import 'package:gobanten/Screens/Welcome/welcome_screen.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ComponentAccount extends StatefulWidget {
  const ComponentAccount({Key key}) : super(key: key);

  @override
  _ComponentAccountState createState() => _ComponentAccountState();
}

class _ComponentAccountState extends State<ComponentAccount> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AuthService>(builder: (_, a, child) {
      return Stack(
        children: [
          // https://images.unsplash.com/photo-1605462863863-10d9e47e15ee?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=750&q=80
          CachedNetworkImage(
            imageUrl: "http://via.placeholder.com/200x150",
            imageBuilder: (context, imageProvider) => Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            placeholder: (context, url) => CircularProgressIndicator(),
            errorWidget: (context, url, error) => Icon(Icons.error),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: MediaQuery.of(context).size.height / 1.6,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              child: ListView(
                padding: EdgeInsets.all(20),
                children: [
                  Text(
                    a.usermodel.name,
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Icon(Icons.email),
                      SizedBox(width: 10),
                      Text(a.usermodel.email)
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.add_road),
                      SizedBox(width: 10),
                      Container(
                        width: MediaQuery.of(context).size.width - 100,
                        child: Text(
                          'Jl. HOS. Cokroaminoto No.20, RT.11/RW.4, Menteng, Kec. Menteng, Kota Jakarta Pusat, Daerah Khusus Ibukota Jakarta 10310',
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      a.logout();
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => WelcomeScreen(),
                        ),
                      );
                    },
                    child: Text('Logout'),
                  )
                ],
              ),
            ),
          )
        ],
      );
    });
  }
}
