import 'package:flutter/material.dart';

class AssetCard extends StatelessWidget {
  final String assetName;
  final String amount;
  final String assetIcon;

  AssetCard(
      {required this.assetName, required this.amount, required this.assetIcon});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 5,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(assetIcon, width: 40, height: 40),
            SizedBox(height: 8),
            Text(
              assetName,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 4),
            Text(
              'Amount: $amount',
              style: TextStyle(fontSize: 16, color: Colors.grey[700]),
            ),
          ],
        ),
      ),
    );
  }
}
