import 'package:flutter/material.dart';

///Importaciones
import 'package:logi_animation_pro_jose/screens/login_screen.dart';

void main() {
  ///Función principal
  runApp(const MyApp());

  ///Ejecuta la aplicación
}

class MyApp extends StatelessWidget {
  ///Extends es herencias ; StatelessWidget es un widget sin estado
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  ///Anotación que indica que se está sobrescribiendo un método de la clase padre
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const LoginScreen(),
    );
  }
}
