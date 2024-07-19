import 'package:crypto_app/services%20/walletService.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:web3dart/web3dart.dart';
import 'package:flutter/foundation.dart' show kIsWeb, defaultTargetPlatform, TargetPlatform;
import 'dart:io' show Platform;

class HomeScreen extends StatelessWidget {
  Future<void> _connectWallet(BuildContext context) async {
    const String dappUrl =
        //  'http://192.168.8.192:3000';
    'chrome-extension://nkbihfbeogaeaoehlefnkodbefgpgknn/home.html#';
    // Construct MetaMask URLs
    const String mobileUrl = 'https://metamask.app.link/dapp/$dappUrl';
    final String desktopUrl = dappUrl; // Directly use the extension URL for desktop

    // Check platform
    final String url;
    if (kIsWeb) {
      // Web environment, cannot check platform
      url = desktopUrl; // Default to the desktop URL
    } else if (defaultTargetPlatform == TargetPlatform.iOS ||
        defaultTargetPlatform == TargetPlatform.android) {
      url = mobileUrl;
    } else {
      url = desktopUrl;
    }

    // Attempt to launch the URL
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      _showErrorDialog(context, url);
    }
  }

  void _showErrorDialog(BuildContext context, String url) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text('Could not launch $url'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final walletService = Provider.of<WalletService>(context);
    final currentBalance = walletService.balance != null
        ? walletService.balance!.getValueInUnit(EtherUnit.ether).toString()
        : 'Loading...';
    final marketValue = walletService.userAddress != null
        ? walletService.getMarketValue()
        : Future.value(0.0);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 60),
            Text(
              'Welcome Back',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'ONE BOND',
                  style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                Image.asset(
                  'assets/images/bitcoin-removebg-preview.png',
                  width: 50,
                  height: 50,
                ),
              ],
            ),
            SizedBox(height: 20),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Container(
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.black, Color(0xFFF5C249)],
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                  ),
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Text(
                              'OBC',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 35,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              'Balance',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              '$currentBalance',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 28,
                              ),
                            ),
                            Image.asset(
                              'assets/images/bitcoin-removebg-preview.png',
                              width: 50,
                              height: 50,
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FutureBuilder<double>(
                          future: marketValue,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Text(
                                'Loading...',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                ),
                              );
                            } else if (snapshot.hasError) {
                              return Text(
                                'Error',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                ),
                              );
                            } else {
                              return Row(
                                children: [
                                  Text(
                                    'Current Price',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Text(
                                    '\$${snapshot.data} USD',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                    ),
                                  ),
                                ],
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () => _connectWallet(context),
                  child: Text(
                    'Connect Wallet',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.black,
                    backgroundColor: Color(0xFFF5C249),
                    padding:
                    EdgeInsets.symmetric(vertical: 16.0, horizontal: 50.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Add functionality for buying tokens
                  },
                  child: Text(
                    'Buy Tokens',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.black,
                    backgroundColor: Color(0xFFF5C249),
                    padding:
                    EdgeInsets.symmetric(vertical: 16.0, horizontal: 50.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 40),
            Text(
              'Recent Transactions',
              style:
              TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: 5, // Replace with actual transaction count
                itemBuilder: (context, index) {
                  // Example transaction data
                  String transactionName = 'Transaction $index';
                  String transactionDate =
                      '2024-07-01'; // Replace with actual date
                  String transactionMethod =
                      'Method'; // Replace with actual method
                  String transactionStatus =
                      'Success'; // Replace with actual status

                  return Card(
                    color: Colors.black,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            transactionName,
                            style: TextStyle(color: Colors.white),
                          ),
                          Text(
                            transactionDate,
                            style: TextStyle(color: Colors.white38),
                          ),
                          Text(transactionMethod,
                              style: TextStyle(color: Colors.white)),
                          Text(transactionStatus,
                              style: TextStyle(color: Colors.greenAccent)),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}















// import 'package:crypto_app/services%20/walletService.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:url_launcher/url_launcher.dart';
// import 'package:web3dart/web3dart.dart';

// class HomeScreen extends StatelessWidget {
//   Future<void> _connectWallet(BuildContext context) async {
//     // Replace with your dApp's actual URL
//     const String dappUrl =
//         'chrome-extension://nkbihfbeogaeaoehlefnkodbefgpgknn/home.html#';
//     // 'http://localhost:8000';  // Local URL for testing
//     // For production, you might use something like 'https://my-dapp-url.com'

//     // Construct MetaMask mobile and desktop URLs
//     const String mobileUrl = 'https://metamask.app.link/dapp/$dappUrl';
//     const String desktopUrl = 'https://metamask.app.link/dapp/$dappUrl';

//     // Check the platform and select the appropriate URL
//     final String url = (Theme.of(context).platform == TargetPlatform.iOS ||
//             Theme.of(context).platform == TargetPlatform.android)
//         ? mobileUrl
//         : desktopUrl;

//     // Attempt to launch the URL
//     if (await canLaunch(url)) {
//       await launch(url);
//     } else {
//       throw 'Could not launch $url';
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final walletService = Provider.of<WalletService>(context);
//     final currentBalance = walletService.balance != null
//         ? walletService.balance!.getValueInUnit(EtherUnit.ether).toString()
//         : 'Loading...';
//     final marketValue = walletService.userAddress != null
//         ? walletService.getMarketValue()
//         : Future.value(0.0);

//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Home Screen"),
//         backgroundColor: Colors.black,
//         foregroundColor: Colors.white,
//         actions: [
//           TextButton.icon(
//             icon: Icon(Icons.account_balance_wallet, color: Colors.white),
//             label:
//                 Text("Connect Wallet", style: TextStyle(color: Colors.white)),
//             onPressed: () => _connectWallet(context),
//           ),
//         ],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             SizedBox(height: 60),
//             Card(
//               child: ListTile(
//                 title: Text('Current Wallet Balance'),
//                 subtitle: Text('$currentBalance ETH'),
//               ),
//             ),
//             SizedBox(height: 10),
//             FutureBuilder<double>(
//               future: marketValue,
//               builder: (context, snapshot) {
//                 if (snapshot.connectionState == ConnectionState.waiting) {
//                   return Card(
//                     child: ListTile(
//                       title: Text('Market Value'),
//                       subtitle: Text('Loading...'),
//                     ),
//                   );
//                 } else if (snapshot.hasError) {
//                   return Card(
//                     child: ListTile(
//                       title: Text('Market Value'),
//                       subtitle: Text('Error'),
//                     ),
//                   );
//                 } else {
//                   return Card(
//                     child: ListTile(
//                       title: Text('Market Value'),
//                       subtitle: Text('\$${snapshot.data} per ETH'),
//                     ),
//                   );
//                 }
//               },
//             ),
//             SizedBox(height: 40),
//             Center(
//               child: ElevatedButton.icon(
//                 onPressed: () {
//                   _connectWallet(context);
//                 },
//                 icon: Icon(Icons.open_in_browser, color: Colors.black),
//                 label: Text('Go to Website'),
//                 style: ElevatedButton.styleFrom(
//                   foregroundColor: Colors.black,
//                   backgroundColor: Color(0xFFF5C249),
//                   padding:
//                       EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(8.0),
//                   ),
//                 ),
//               ),
//             ),
//             SizedBox(height: 20),
//             Text(
//               'Recent Transactions',
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//             // Implement recent transactions here
//             Expanded(
//               child: ListView.builder(
//                 itemCount: 0, // Replace with actual transaction count
//                 itemBuilder: (context, index) {
//                   // Implement transaction display here
//                   return Card(
//                     child: ListTile(
//                       title: Text('Transaction Type'),
//                       subtitle: Text('Transaction Date'),
//                       trailing: Text('Transaction Amount ETH'),
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

















// class HomeScreen extends StatelessWidget {
//   Future<void> _connectWallet(BuildContext context) async {
//     // Define URLs for mobile and desktop
//     const String dappUrl = 'YOUR_APP_URL';  // Replace with your dApp's URL
//     const String mobileUrl = 'https://metamask.app.link/dapp/$dappUrl';
//     const String desktopUrl = 'https://metamask.app.link/dapp/$dappUrl';

//     // Check the platform and select the appropriate URL
//     final String url = (Theme.of(context).platform == TargetPlatform.iOS ||
//             Theme.of(context).platform == TargetPlatform.android)
//         ? mobileUrl
//         : desktopUrl;

//     // Attempt to launch the URL
//     if (await canLaunch(url)) {
//       await launch(url);
//     } else {
//       throw 'Could not launch $url';
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final walletService = Provider.of<WalletService>(context);
//     final currentBalance = walletService.balance != null
//         ? walletService.balance!.getValueInUnit(EtherUnit.ether).toString()
//         : 'Loading...';
//     final marketValue = walletService.userAddress != null
//         ? walletService.getMarketValue()
//         : Future.value(0.0);

//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Home Screen"),
//         backgroundColor: Colors.black,
//         foregroundColor: Colors.white,
//         actions: [
//           TextButton.icon(
//             icon: Icon(Icons.account_balance_wallet, color: Colors.white),
//             label: Text("Connect Wallet", style: TextStyle(color: Colors.white)),
//             onPressed: () => _connectWallet(context),
//           ),
//         ],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             SizedBox(height: 60),
//             Card(
//               child: ListTile(
//                 title: Text('Current Wallet Balance'),
//                 subtitle: Text('$currentBalance ETH'),
//               ),
//             ),
//             SizedBox(height: 10),
//             FutureBuilder<double>(
//               future: marketValue,
//               builder: (context, snapshot) {
//                 if (snapshot.connectionState == ConnectionState.waiting) {
//                   return Card(
//                     child: ListTile(
//                       title: Text('Market Value'),
//                       subtitle: Text('Loading...'),
//                     ),
//                   );
//                 } else if (snapshot.hasError) {
//                   return Card(
//                     child: ListTile(
//                       title: Text('Market Value'),
//                       subtitle: Text('Error'),
//                     ),
//                   );
//                 } else {
//                   return Card(
//                     child: ListTile(
//                       title: Text('Market Value'),
//                       subtitle: Text('\$${snapshot.data} per ETH'),
//                     ),
//                   );
//                 }
//               },
//             ),
//             SizedBox(height: 40),
//             Center(
//               child: ElevatedButton.icon(
//                 onPressed: () {
//                   _connectWallet(context);
//                 },
//                 icon: Icon(Icons.open_in_browser, color: Colors.black),
//                 label: Text('Go to Website'),
//                 style: ElevatedButton.styleFrom(
//                   foregroundColor: Colors.black,
//                   backgroundColor: Color(0xFFF5C249),
//                   padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(8.0),
//                   ),
//                 ),
//               ),
//             ),
//             SizedBox(height: 20),
//             Text(
//               'Recent Transactions',
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//             // Implement recent transactions here
//             Expanded(
//               child: ListView.builder(
//                 itemCount: 0, // Replace with actual transaction count
//                 itemBuilder: (context, index) {
//                   // Implement transaction display here
//                   return Card(
//                     child: ListTile(
//                       title: Text('Transaction Type'),
//                       subtitle: Text('Transaction Date'),
//                       trailing: Text('Transaction Amount ETH'),
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
