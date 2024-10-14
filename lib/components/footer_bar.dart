import 'package:flutter/material.dart';

class FooterBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Colors.transparent,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home, color: Colors.white),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.account_balance_wallet, color: Colors.white),
          label: 'Wallet',
        ),
      ],
    );
  }
}
