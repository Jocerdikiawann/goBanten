import 'package:flutter/material.dart';
import 'package:gobanten/Provider/ProviderUser.dart';
import 'package:gobanten/Screens/Welcome/welcome_screen.dart';
import 'package:provider/provider.dart';

class ScreensHome extends StatefulWidget {
  const ScreensHome({Key key}) : super(key: key);

  @override
  _ScreensHomeState createState() => _ScreensHomeState();
}

class _ScreensHomeState extends State<ScreensHome> {
  String url;
  void initState() {
    super.initState();
    url =
        'https://images.unsplash.com/photo-1628307585477-a5acf1ac6630?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=400&q=80';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Consumer<AuthService>(
      builder: (_, a, child) {
        return Stack(
          children: [
            Image.network(
              url,
              fit: BoxFit.fitHeight,
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                  height: MediaQuery.of(context).size.height / 1.5,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () async {
                          a.logout();
                          await Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => WelcomeScreen(),
                            ),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Text(
                            'List Wisata',
                            style:
                                Theme.of(context).textTheme.headline5.copyWith(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 20,
                                    ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          padding: EdgeInsets.only(top: 15, left: 10),
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: 80,
                                        height: 80,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          image: DecorationImage(
                                            fit: BoxFit.fill,
                                            image: NetworkImage(
                                                'https://images.unsplash.com/photo-1628307585477-a5acf1ac6630?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=400&q=80'),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width -
                                                100,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Taman Lawang',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline5
                                                  .copyWith(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 15,
                                                  ),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              'Lokasi: Jl. HOS. Cokroaminoto No.20, RT.11/RW.4, Menteng, Kec. Menteng, Kota Jakarta Pusat, Daerah Khusus Ibukota Jakarta 10310',
                                              maxLines: 3,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            );
                          },
                          itemCount: 3,
                        ),
                      ),
                    ],
                  )),
            )
          ],
        );
      },
    ));
  }
}
