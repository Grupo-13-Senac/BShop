import 'package:bshop/Design/colors.dart';
import 'package:bshop/pages/homePage.dart';
import 'package:bshop/Design/splashScreen.dart';
import 'package:bshop/userLogin.dart';
import 'package:flutter/material.dart';

// globals.dart

enum LoggedInUser { user1, user2 }

LoggedInUser? currentUser;


class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

TextEditingController _controllerUser = TextEditingController();
TextEditingController _controllerPass = TextEditingController();

class _LoginPageState extends State<LoginPage> {

  bool _visible = true;
  bool _conected = false;
  String loginerror = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 100),
             Image.asset("assets/logo_text.png"),
              SizedBox(height: 50),
              Align(
                alignment: Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                        "Conectando Mercados",
                      style: TextStyle(
                        fontSize: 20
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      "Login",
                      style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 50,
              ),
              TextField(
                controller: _controllerUser,
                cursorColor: Colors.grey,
                decoration: InputDecoration(
                  labelText: 'Email',
                  suffixIcon: Icon(
                    Icons.person,
                    color: Colors.grey,
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  labelStyle: TextStyle(color: Colors.black), // Define a cor do texto do rótulo (label)
                  // Define a cor do texto do campo quando não está focado
                  // (pode ser redundante, mas garante que a cor permaneça consistente)
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                ),
                style: TextStyle(color: Colors.black), // Define a cor do texto do campo
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                controller: _controllerPass,
                cursorColor: Colors.grey,
                obscureText: _visible,
                decoration: InputDecoration(
                  labelText: 'Password',
                  suffixIcon: IconButton(
                    icon: Icon(
                      _visible ? Icons.visibility : Icons.visibility_off,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        _visible = !_visible;
                      });
                    },
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  labelStyle: TextStyle(color: Colors.black),

                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                ),
                style: TextStyle(color: Colors.black),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: Row(
                  children: [
                    Text('Manter conectado'),
                    IconButton(
                      icon: _conected
                          ? Icon(Icons.check_box, color: kPrimareColor) // Substituí por uma cor padrão, substitua conforme necessário
                          : Icon(Icons.check_box_outline_blank, color: kSecondaryColor,),
                      onPressed: () {
                        setState(() {
                          _conected = !_conected;

                        });
                      },
                    )
                  ],
                ),
              ),
              Text(loginerror, style: TextStyle(color: Colors.red,
              fontWeight: FontWeight.w400),),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(kPrimareColor)

                        ),
                          onPressed: () {
                            setState(() {
                              if (_controllerPass.text == password1 && _controllerUser.text == user1) {
                                currentUser = LoggedInUser.user1;
                                Navigator.of(context).pushReplacement(MaterialPageRoute(
                                    builder: (BuildContext context) => SplashScreen()));
                                _controllerPass.clear();
                                _controllerUser.clear();
                                loginerror = "";
                              } else if (_controllerPass.text == password2 && _controllerUser.text == user2) {
                                currentUser = LoggedInUser.user2;
                                Navigator.of(context).pushReplacement(MaterialPageRoute(
                                    builder: (BuildContext context) => SplashScreen()));
                                _controllerPass.clear();
                                _controllerUser.clear();
                                loginerror = "";
                              }else{
                                setState(() {
                                  loginerror = "Usuário ou Senha inválidos";
                                });
                              }
                            });
                          },

                          child: Text("Login", style: TextStyle(color: Colors.white),)),
                    ),
                  ],
                ),
              ),
              TextButton(
                  onPressed: (){},
                  child: Text(
                    "Criar conta", style: TextStyle(color: kSecondaryColor),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
