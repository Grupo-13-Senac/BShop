import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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
              height: 50,
            ),
            ElevatedButton(
                onPressed: (){},
                child: Text("Login")),
            TextButton(
                onPressed: (){},
                child: Text(
                  "Criar conta"
                ))
          ],
        ),
      ),
    );
  }
}
