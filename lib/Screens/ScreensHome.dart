import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gobanten/Provider/ProviderWisata.dart';
import 'package:gobanten/components/ComponentAccount.dart';
import 'package:gobanten/components/ComponentListOrder.dart';
import 'package:gobanten/Utils/color_constant.dart';
import 'package:gobanten/components/ComponentHome.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ScreensHome extends StatefulWidget {
  const ScreensHome({Key key}) : super(key: key);

  @override
  _ScreensHomeState createState() => _ScreensHomeState();
}

class _ScreensHomeState extends State<ScreensHome> {
  String url;
  int _selectedIndex;

  var bottomTextStyle =
      GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w500);

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    _selectedIndex = 0;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<ProviderWisata>(context, listen: false).getWisata();
    });
  }

  final List<Widget> _children = [
    ComponentHome(),
    ComponentListOrder(),
    ComponentAccount(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        height: 64,
        decoration: BoxDecoration(
          color: mFillColor,
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 2,
                blurRadius: 15,
                offset: Offset(0, 5))
          ],
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
        ),
        child: BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: _selectedIndex == 0
                  ? new SvgPicture.asset('assets/icons/home_colored.svg')
                  : new SvgPicture.asset('assets/icons/home.svg'),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: _selectedIndex == 1
                  ? new SvgPicture.asset('assets/icons/order_colored.svg')
                  : new SvgPicture.asset('assets/icons/order.svg'),
              label: 'My Order',
            ),
            BottomNavigationBarItem(
              icon: _selectedIndex == 3
                  ? new SvgPicture.asset('assets/icons/account_colored.svg')
                  : new SvgPicture.asset('assets/icons/account.svg'),
              label: 'Account',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: mBlueColor,
          unselectedItemColor: mSubtitleColor,
          onTap: _onItemTapped,
          backgroundColor: Colors.transparent,
          type: BottomNavigationBarType.fixed,
          selectedFontSize: 12,
          showUnselectedLabels: true,
          elevation: 0,
        ),
      ),
      body: _children[_selectedIndex],
    );
  }
}
