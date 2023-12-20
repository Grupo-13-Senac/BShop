import 'package:bshop/colors.dart';
import 'package:bshop/itens.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Minha Lista',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MinhaLista(),
    );
  }
}

class MinhaLista extends StatefulWidget {
  @override
  _MinhaListaState createState() => _MinhaListaState();
}

class _MinhaListaState extends State<MinhaLista> {
  List<String> itens = [];
  List<int> itensMarcados = [];
  TextEditingController _controller = TextEditingController();

  _adicionarItem(String item) {
    if (!itens.contains(item)) {
      setState(() {
        itens.add(item);
        if (itensMarcados.contains(itens.length - 1)) {
          itensMarcados.remove(itens.length - 1);
        }
      });
      _saveList(); // Salvar a lista após adicionar um item
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('O item já está na lista!')),
      );
    }
    _controller.clear();
    Navigator.pop(context);
  }

  _saveList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('itens', itens);
  }

  _loadList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? savedList = prefs.getStringList('itens');
    if (savedList != null) {
      setState(() {
        itens = savedList;
      });
    }
  }
  _saveCheckedItems() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('checkedItems', itensMarcados.map((e) => e.toString()).toList());
  }

  _loadCheckedItems() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? checkedItems = prefs.getStringList('checkedItems');
    if (checkedItems != null) {
      setState(() {
        itensMarcados = checkedItems.map((e) => int.parse(e)).toList();
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _loadList();
    _loadCheckedItems(); // Carregar a lista de itens marcados quando o widget é criado
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: kPrimareColor,
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Adicionar Item'),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Autocomplete<String>(
                      optionsBuilder: (TextEditingValue textEditingValue) {
                        if (textEditingValue.text == '') {
                          return const Iterable<String>.empty();
                        }
                        return sugestoes.where((String option) {
                          return option.toLowerCase().contains(textEditingValue.text.toLowerCase());
                        });
                      },
                      onSelected: _adicionarItem,
                      fieldViewBuilder: (BuildContext context, TextEditingController _controller, FocusNode _focusNode, VoidCallback onFieldSubmitted) {
                        return TextField(
                          controller: _controller,
                          focusNode: _focusNode,
                          decoration: InputDecoration(
                            hintText: 'Digite o item',
                          ),
                          onSubmitted: (_) => onFieldSubmitted(),
                        );
                      },
                    ),
                    SizedBox(height: 16.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text('Cancelar'),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          );
        },
        child: Icon(Icons.playlist_add_sharp, color: Colors.white),
      ),
      appBar: AppBar(
        backgroundColor: kPrimareColor,
        title: Text(
          'Minha Lista',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView.separated(
        itemCount: itens.length,
        separatorBuilder: (context, index) => Divider(),
        itemBuilder: (context, index) {
          return Dismissible(
            key: Key(itens[index]),
            direction: DismissDirection.endToStart,
            background: Container(
              color: Colors.red,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 20.0),
                    child: Text(
                      'Excluir',
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
            onDismissed: (direction) {
              setState(() {
                itens.removeAt(index);
                itensMarcados = itensMarcados.map((e) => e > index ? e - 1 : e).toList();
                _saveList();
                _saveCheckedItems(); // Adicione esta linha para salvar a lista de itens marcados
              });
            },
            child: ListTile(
              title: Text(itens[index]),
              trailing: IconButton(
                icon: itensMarcados.contains(index)
                    ? Icon(Icons.check, color: kPrimareColor)
                    : Icon(Icons.circle_outlined),
                onPressed: () {
                  setState(() {
                    if (itensMarcados.contains(index)) {
                      itensMarcados.remove(index);
                    } else {
                      itensMarcados.add(index);
                    }
                    _saveCheckedItems(); // Adicione esta linha para salvar a lista de itens marcados
                  });
                },

              ),
            ),
          );
        },
      ),
    );
  }
}
