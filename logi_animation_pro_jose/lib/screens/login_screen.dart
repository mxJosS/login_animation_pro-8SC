import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

// Cerebro de la lógica de animaciones
class _LoginScreenState extends State<LoginScreen> {
  //StateMachine Controller
  StateMachineController? controller;

  //State Machine Input y es de tipo booleano
  SMIBool? isChecking; //Activa al oso chismoso
  SMIBool? isHandsUp; //tapa los ojos
  SMITrigger? trigSuccess; //para animacion de exito
  SMITrigger? trigFail; //para animacion de fracaso
  SMIInput? numLook;

  bool _obscureText = true; // 👀 estado para mostrar/ocultar contraseña

  @override
  Widget build(BuildContext context) {
    //Para obtener el tamaño de la pantalla del dispositivo
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      //Widget para crear la estructura basica de una pantalla
      //SafeArea para evitar que los elementos se superpongan con la barra de estado o la barra de navegación
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            //Axis o eje vertical
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //Animacion
              SizedBox(
                //Ancho de la pantalla calculado por MediaQuery
                width: size.width,
                height: 200,
                child: RiveAnimation.asset(
                  'animated_login_character.riv',
                  stateMachines: ['Login Machine'],
                  onInit: (artboard) {
                    controller = StateMachineController.fromArtboard(
                      artboard,
                      'Login Machine',
                    );
                    if (controller == null) return;
                    artboard.addController(controller!);

                    //Enlaza la animacion de la app
                    isChecking = controller!.findSMI('isChecking');
                    isHandsUp = controller!.findSMI('isHandsUp');
                    trigSuccess = controller!.findSMI('trigSuccess');
                    trigFail = controller!.findSMI('trigFail');
                    numLook = controller!.findSMI('numLook');
                  },
                ),
              ),

              //Espacio entre la animacion y el texto
              const SizedBox(height: 10),
              TextField(
                onChanged: (value) {
                  //Si el valor del campo de texto es mayor a 0 caracteres
                  if (isHandsUp != null) {
                    isHandsUp!.change(false); //El oso chismoso ve el texto
                  }
                  if (isChecking != null) {
                    isChecking!.change(true);
                  }
                  if (numLook != null) {
                    numLook!.value = value.length.toDouble();
                  }
                },
                //Teclado de tipo email
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  hintText: 'Email',
                  prefixIcon: const Icon(Icons.mail),
                  border: OutlineInputBorder(
                    //Bordes circulares
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),

              const SizedBox(height: 10),
              TextField(
                onChanged: (value) {
                  //Si el valor del campo de texto es mayor a 0 caracteres
                  if (isHandsUp != null) {
                    isHandsUp!.change(
                      true,
                    ); //tapa los ojos al escribir contraseña
                  }
                },
                //Para que se oculte la contraseña
                obscureText: _obscureText,
                decoration: InputDecoration(
                  hintText: 'Password',
                  prefixIcon: const Icon(Icons.lock),
                  border: OutlineInputBorder(
                    //Bordes circulares
                    borderRadius: BorderRadius.circular(12),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureText ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                  ),
                ),
              ),

              const SizedBox(height: 10),
              SizedBox(
                width: size.width,
                child: const Text(
                  "Forgot your password?",
                  textAlign: TextAlign.right,
                  style: TextStyle(decoration: TextDecoration.underline),
                ),
              ),

              const SizedBox(height: 10),
              MaterialButton(
                minWidth: size.width,
                height: 50,
                color: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                onPressed: () {}, //función vacía de momento
                child: const Text(
                  'Login',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              const SizedBox(height: 10),
              SizedBox(
                width: size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't have an account?"),
                    TextButton(
                      onPressed: () {},
                      child: const Text(
                        'Register', //texto del boton de registro
                        style: TextStyle(
                          color: Colors.black, //color del texto
                          fontWeight: FontWeight.bold, //negrita
                          decoration: TextDecoration.underline, //subrayado
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
