import 'package:flutter/material.dart';
import 'package:iot_flutter_app/screens/forgot_password.dart';
import 'package:iot_flutter_app/screens/login.dart';
import 'package:iot_flutter_app/screens/login2.dart';
import 'package:iot_flutter_app/screens/main_2.dart';
import 'package:iot_flutter_app/screens/register.dart';
import 'package:iot_flutter_app/screens/list_wifi.dart';
import 'package:iot_flutter_app/screens/user_1.dart';

import 'components/base_screen.dart';
import 'components/asset_card.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // return MaterialApp(
    //   home: LoginScreen(),
    // );
    return MaterialApp(initialRoute: '/', routes: {
      '/': (context) => UserNguoiDung(),
      '/home': (context) => LoginScreen(),
      '/register': (context) => RegisterScreen(),
      '/forgot_password': (context) => ForgotPasswordScreen(),
      '/list-wifi': (context) => WiFiListScreen(),
      '/main-chinh': (context) => MainChinh(),
      '/user-1': (context) => UserNguoiDung(),
    });
  }
}

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      title: 'My Wallet',
      child: Padding(
        padding: EdgeInsets.all(16),
        child: GridView.count(
          crossAxisCount: 2,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          children: [
            AssetCard(
                assetName: 'BTC',
                amount: '0.48',
                assetIcon: 'assets/images/logo_vmu.png'),
            // AssetCard(
            //     assetName: 'LTC', amount: '5.08', assetIcon: 'assets/ltc.png'),
            // AssetCard(
            //     assetName: 'SOL', amount: '0.02', assetIcon: 'assets/sol.png'),
            // AssetCard(
            //     assetName: 'MATIC',
            //     amount: '2.54',
            //     assetIcon: 'assets/matic.png'),
          ],
        ),
      ),
    );
  }
}
