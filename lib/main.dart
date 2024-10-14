import 'package:flutter/material.dart';
import 'components/base_screen.dart';
import 'components/asset_card.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MainScreen(),
    );
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
                assetIcon: 'assets/logo_vmu.png'),
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
