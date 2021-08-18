import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gobanten/Provider/ProviderWisata.dart';
import 'package:gobanten/components/shimmer/ShimmerListWisata.dart';
import 'package:provider/provider.dart';

class ComponentHome extends StatefulWidget {
  const ComponentHome({Key key}) : super(key: key);

  @override
  _ComponentHomeState createState() => _ComponentHomeState();
}

class _ComponentHomeState extends State<ComponentHome> {
  String url;
  void initState() {
    super.initState();
    url =
        "https://firebasestorage.googleapis.com/v0/b/gobanten-e2df9.appspot.com/o/Taman-Kota.jpg?alt=media&token=145dd9fd-9643-4321-823b-21759855b2ee";
  }

  @override
  Widget build(BuildContext context) {
    var _data = Provider.of<ProviderWisata>(context, listen: false).getWisata();
    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl: url,
          imageBuilder: (context, imageProvider) => Container(
            decoration: BoxDecoration(
              image:
                  DecorationImage(image: imageProvider, fit: BoxFit.fitHeight),
            ),
          ),
          placeholder: (context, url) => CircularProgressIndicator(),
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
              height: MediaQuery.of(context).size.height / 1.5,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10), color: Colors.white),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      'List Wisata',
                      style: Theme.of(context).textTheme.headline5.copyWith(
                            fontWeight: FontWeight.w500,
                            fontSize: 20,
                          ),
                    ),
                  ),
                  Expanded(
                    child: FutureBuilder(
                        future: _data,
                        builder: (context, snapshot) {
                          print(snapshot.data);
                          print(snapshot.hasData);
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return ShimmerListWisata();
                          } else {
                            if (snapshot.hasData) {
                              return ListView.builder(
                                padding: EdgeInsets.only(top: 0, left: 10),
                                itemCount: snapshot.data.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding:
                                        const EdgeInsets.only(bottom: 10.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            CachedNetworkImage(
                                              imageUrl: snapshot.data[index]
                                                  ['image'],
                                              imageBuilder:
                                                  (context, imageProvider) =>
                                                      Container(
                                                height: 80,
                                                width: 80,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                  image: DecorationImage(
                                                      image: imageProvider,
                                                      fit: BoxFit.fill),
                                                ),
                                              ),
                                              placeholder: (context, url) =>
                                                  CircularProgressIndicator(),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      Icon(Icons.error),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width -
                                                  100,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    snapshot.data[index]
                                                        ['nama'],
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .headline5
                                                        .copyWith(
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 15,
                                                        ),
                                                  ),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  Text(
                                                    snapshot.data[index]
                                                        ['alamat'],
                                                    maxLines: 3,
                                                    overflow:
                                                        TextOverflow.ellipsis,
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
                              );
                            } else {
                              return Center(
                                child: Text('No Connection'),
                              );
                            }
                          }
                        }),
                  ),
                ],
              )),
        )
      ],
    );
  }
}
