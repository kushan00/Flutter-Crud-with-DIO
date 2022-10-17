import 'package:flutter/material.dart';
import 'package:practice_2/provider/user_provider.dart';
import 'package:practice_2/views/create_user.dart';
import 'package:practice_2/views/edit_user.dart';
import 'package:practice_2/views/home.dart';
import 'package:provider/provider.dart';
import 'di_container.dart' as di;

void main() async {
   WidgetsFlutterBinding.ensureInitialized();
   await di.init();
   runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => di.sl<UserProvider>()),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Provider<String>(
      create: (BuildContext context) =>  "5",
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
         routes: {
        '/': (context) => const Home(),
        '/add': (context) => const CreateUserAndEdit(),
        '/edit-user': (context) => const EditUserData(),
      },
      ),
    ); 
  }
}
