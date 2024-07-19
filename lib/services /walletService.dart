import 'package:flutter/material.dart';
import 'package:web3dart/web3dart.dart';
import 'package:http/http.dart'; // For HTTP requests

class WalletService with ChangeNotifier {
  final String _bscRpcUrl = 'https://bsc-dataseed.binance.org/'; // Binance Smart Chain RPC URL
  late Web3Client _client;
  late String _privateKey; // Your private key
  late Credentials _credentials;
  EthereumAddress? _userAddress;
  EtherAmount? _balance;

  WalletService() {
    _client = Web3Client(_bscRpcUrl, Client());
    _privateKey = '0x38065f35B02BfDFCEc56E13A13c9eC2D35421BF2'; // Replace with your private key
    _credentials = EthPrivateKey.fromHex(_privateKey);
  }

  Future<void> connectWallet() async {
    _userAddress = await _credentials.extractAddress();
    await getBalance();
    notifyListeners();
  }

  Future<void> getBalance() async {
    _balance = await _client.getBalance(_userAddress!);
    notifyListeners();
  }

  EthereumAddress? get userAddress => _userAddress;

  EtherAmount? get balance => _balance;

  Web3Client get client => _client;

  getMarketValue() {}
}























// import 'package:cloud_firestore/cloud_firestore.dart';

// class WalletService {
//   final CollectionReference walletCollection = FirebaseFirestore.instance.collection('wallets');

//   // Get balance
//   Future<double> getBalance(String userId) async {
//     DocumentSnapshot snapshot = await walletCollection.doc(userId).get();
//     return snapshot['balance'];
//   }

//   // Add transaction
//   Future<void> addTransaction(String userId, double amount, String type) async {
//     await walletCollection.doc(userId).update({
//       'balance': FieldValue.increment(amount),
//       'transactions': FieldValue.arrayUnion([{
//         'amount': amount,
//         'type': type,
//         'date': DateTime.now()
//       }])
//     });
//   }

//   // Get transaction history
//   Future<List<dynamic>> getTransactionHistory(String userId) async {
//     DocumentSnapshot snapshot = await walletCollection.doc(userId).get();
//     return snapshot['transactions'];
//   }
// }
