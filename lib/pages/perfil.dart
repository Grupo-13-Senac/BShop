import 'package:bshop/colors.dart';
import 'package:bshop/pages/loginPage.dart';
import 'package:flutter/material.dart';

class Perfil extends StatefulWidget {
  @override
  State<Perfil> createState() => _PerfilState();
}

class _PerfilState extends State<Perfil> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimareColor,
        title: Text(
          'Perfil',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.3,
                width: double.infinity,
                color: kPrimareColor,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      backgroundColor: kLightPrimareColor,
                      radius: MediaQuery.of(context).size.height * 0.1,
                    ),
                    SizedBox(height: 15),
                    Text(
                      'Nome Usuário',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: MediaQuery.of(context).size.height * 0.025,
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        'Nome Completo',
                        style: TextStyle(color: Colors.grey),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    Text(
                      'lucascostabustamante@gmail.com',
                      style: TextStyle(
                        color: Colors.grey.shade700,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.start,
                    ),
                    Divider(),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        'E-mail',
                        style: TextStyle(color: Colors.grey),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    Text(
                      'lucascostabustamante@gmail.com',
                      style: TextStyle(
                        color: Colors.grey.shade700,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.start,
                    ),
                    Divider(),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        'Senha',
                        style: TextStyle(color: Colors.grey),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    Text(
                      'lucascostabustamante@gmail.com',
                      style: TextStyle(
                        color: Colors.grey.shade700,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.start,
                    ),
                    Divider(),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        'Telefone',
                        style: TextStyle(color: Colors.grey),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    Text(
                      'lucascostabustamante@gmail.com',
                      style: TextStyle(
                        color: Colors.grey.shade700,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.start,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(30),
                      child: Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(kLightPrimareColor)
                              ),
                                onPressed: (){
                                setState(() {
                                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                                      builder: (BuildContext context) => LoginPage()));
                                });
                                },
                                child: Text('Sair',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                  fontSize: 18),)),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
