import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:store/blocs/cart/bloc/cart_bloc.dart';
import 'package:store/blocs/checkout/bloc/checkout_bloc.dart';
import 'package:store/blocs/favorite/bloc/favorite_bloc.dart';
import 'package:store/constants.dart';
import 'package:store/models/cart.dart';
import 'package:store/models/product_model.dart';
import 'package:store/repositiries/checkout/repository.dart';
import 'package:store/repositiries/local%20storage/Cart%20storage/cart_storage_repository.dart';
import 'package:store/repositiries/local%20storage/Fav%20storage/fav_storage_repository.dart';
import 'package:store/repositiries/local%20storage/Cart%20storage/cart_repositiry.dart';
import 'package:store/screens/controlview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
 await Hive.initFlutter();
  Hive.registerAdapter(ProductAdapter());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              FavoriteBloc(fireStoreFavorite: FireStoreFavorite())
                ..add(LoadFavorite()),
        ),
        BlocProvider(
          create: (context) => CartBloc(
           fireStoreCart: FireStoreCart()
           )..add(LoadCart()),
        ),
        BlocProvider(
            create: (context) =>
                CheckoutBloc(firebaseRepository: FirestoreRepository()))
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        home: Scaffold(
          body: ControlView(),
        ),
      ),
    );
  }
}
