import 'package:bshop/pages/homePage.dart';
import 'package:bshop/splashScreen.dart';
import 'package:bshop/userLogin.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

TextEditingController _controllerUser = TextEditingController();
TextEditingController _controllerPass = TextEditingController();

class _LoginPageState extends State<LoginPage> {
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
                decoration: InputDecoration(
                  labelText: 'Password',
                  suffixIcon: Icon(
                    Icons.remove_red_eye,
                    color: Colors.grey,
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

              SizedBox(
                height: 50,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(Color(0xffeb89b5))

                        ),
                          onPressed: (){
                          setState(() {
                            if(_controllerPass.text == password && _controllerUser.text == user){
                              Navigator.of(context).pushReplacement(MaterialPageRoute(
                                  builder: (BuildContext context) => SplashScreen()));
                              _controllerPass.clear();
                              _controllerUser.clear();
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
                    "Criar conta"
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
