import 'package:bshop/colors.dart';
import 'package:bshop/pages/loginPage.dart';
import 'package:bshop/userLogin.dart';
import 'package:flutter/material.dart';

class Perfil extends StatefulWidget {
  @override
  State<Perfil> createState() => _PerfilState();
}

bool _visible = true;
int passCont = currentUser == LoggedInUser.user1 ? password1.length : password2.length;

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
                      child: Icon(Icons.person, size: 120, color: Colors.white60,),
                      backgroundColor: kLightPrimareColor,
                      radius: MediaQuery.of(context).size.height * 0.1,
                    ),
                    SizedBox(height: 15),
                    Text(
                    currentUser == LoggedInUser.user1 ? name1 : name2,
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
                      currentUser == LoggedInUser.user1 ? name1 : name2,
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
                      currentUser == LoggedInUser.user1 ? user1 : user2,
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
                   Row(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: [
                       Text(
                         _visible ? ("*" * passCont).toString() :
                         currentUser == LoggedInUser.user1 ? password1 : password2,
                         style: TextStyle(
                           color: Colors.grey.shade700,
                           fontWeight: FontWeight.w600,
                         ),
                         textAlign: TextAlign.start,
                       ),
                       GestureDetector(
                         onTap: (){
                          setState(() {
                            _visible = !_visible;
                            print(_visible);
                          });
                         },
                         child: _visible ?
                         Icon(Icons.visibility, color: Colors.grey) :
                         Icon(Icons.visibility_off, color: Colors.grey),
                       )
                     ],
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
                      currentUser == LoggedInUser.user1 ? telefone1 : telefone2,
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
