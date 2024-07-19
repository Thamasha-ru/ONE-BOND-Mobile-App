import 'package:crypto_app/services%20/walletService.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web3dart/web3dart.dart';

class WalletScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final walletService = Provider.of<WalletService>(context);
    final userAddress = walletService.userAddress?.hex ?? 'Not connected';
    final balance = walletService.balance != null
        ? walletService.balance!.getValueInUnit(EtherUnit.ether).toString()
        : 'Loading...';

    return Scaffold(
      appBar: AppBar(
        title: Text('Wallet'),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Text(
              'Ethereum Address:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              userAddress,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Text(
              'Balance:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              '$balance ETH',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}






// import 'package:crypto_app/services%20/walletService.dart';
// import 'package:flutter/material.dart';


// class WalletScreen extends StatefulWidget {
//   @override
//   _WalletScreenState createState() => _WalletScreenState();
// }

// class _WalletScreenState extends State<WalletScreen> {
//   final WalletService _walletService = WalletService();
//   double _balance = 0.0;

//   @override
//   void initState() {
//     super.initState();
//     _fetchBalance();
//   }

//   _fetchBalance() async {
//     double balance = await _walletService.getBalance('user_id');
//     setState(() {
//       _balance = balance;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Wallet'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Text('Balance: \$$_balance'),
//             ElevatedButton(
//               onPressed: () {
//                 // Navigate to transfer funds screen
//               },
//               child: Text('Transfer Funds'),
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 // Navigate to transaction history screen
//               },
//               child: Text('Transaction History'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
