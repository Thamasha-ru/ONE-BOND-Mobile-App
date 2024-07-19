import 'package:crypto_app/screens/buyTokens.dart';
import 'package:crypto_app/screens/homeScreen.dart';
import 'package:crypto_app/screens/onboadingScreen.dart';
import 'package:crypto_app/screens/profilepage.dart';
import 'package:crypto_app/screens/splash_screen.dart';
import 'package:crypto_app/services%20/walletService.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';



// Future<void> main() async{
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   if(kIsWeb){
//     await Firebase.initializeApp(
//     options: const FirebaseOptions
//     (apiKey: "AIzaSyCmyjamMfBnLAkr7s3MTqdgkhoHNXtsByQ", 
//     appId: "1:61800313627:web:bf7d22e0fa25874f3e99be", 
//     messagingSenderId:"61800313627", 
//     projectId: "one-bond-app"));
//   }
//      else {
//     await Firebase.initializeApp();
//   }
void main() =>
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => WalletService()),
      ],
      child: MyApp(),
    ),
  );
// }

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ONE BOND WALLET APP',
      theme: ThemeData(
             textTheme: const TextTheme(
          bodyText1: TextStyle(fontFamily: 'Poppins'),
          bodyText2: TextStyle(fontFamily: 'Poppins'),
          headline1: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.bold),
        ),
        primarySwatch: Colors.yellow,
         scaffoldBackgroundColor: Colors.black,
      ),
      //  home: SplashScreen(),
      // home: HomeScreen(),
      home: OnboardingScreen(),
      // home: ProfilePage(),
      // home:BuyTokensPage(),
    );
  }
}
