import 'dart:async';
import 'package:bshop/itens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Importações necessárias para o código
import 'package:bshop/colors.dart';

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
      _saveList();
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

  bool popupDisplayed = false;
  int rssiValue = 0;
  late Timer periodicTimer;  // Timer para verificações periódicas

  _checkBluetoothResults(List<ScanResult> scanResults) {
    bool esp32Found = false;
    List<String> foundItems = [];

    for (var result in scanResults) {
      if (result.device.name?.toLowerCase() == 'esp32 beacon test' && result.rssi >= -50) {
        esp32Found = true;
        rssiValue = result.rssi;
        itens = itens.map((item) => item.toLowerCase()).toList();

        if (itens.contains('molho de tomate') && !itensMarcados.contains(itens.indexOf('molho de tomate'))) {
          foundItems.add('molho de tomate');
        }
        if (itens.contains('macarrão parafuso') && !itensMarcados.contains(itens.indexOf('macarrão parafuso'))) {
          foundItems.add('macarrão parafuso');
        }

        break;
      }
    }

    if (esp32Found && foundItems.isNotEmpty) {
      if (!popupDisplayed) {
        _showDeviceFoundPopup(foundItems);
        popupDisplayed = true;
      }
    } else {
      popupDisplayed = false;
    }

    // Atualiza a AppBar com o valor rssi
    setState(() {});
  }

  _showDeviceFoundPopup(List<String> itemsToMark) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Opa!', style: TextStyle(color: kPrimareColor, fontWeight: FontWeight.bold),),
            ],
          ),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Neste corredor tem os seguintes itens da sua lista:',
                style: TextStyle(
                    color: kSecondaryColor,
                    fontSize: 14, fontWeight: FontWeight.w500
                ),),
              for (String item in itemsToMark) Text('- $item'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);

                // Marca automaticamente os itens encontrados
                for (String item in itemsToMark) {
                  int index = itens.indexOf(item);
                  if (index != -1 && !itensMarcados.contains(index)) {
                    itensMarcados.add(index);
                  }
                }

                // Salva a lista atualizada
                _saveCheckedItems();

                // Força a reconstrução da árvore de widgets
                setState(() {});
              },
              child: Text('Adicionar',style: TextStyle(fontWeight: FontWeight.bold,
                  color: kPrimareColor, fontSize: 17)),
            ),
          ],
        );
      },
    ).then((value) {
      // Resetar a variável popupDisplayed quando o pop-up for fechado
      popupDisplayed = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadList();
    _loadCheckedItems();
    Get.put(BleController());

    // Inicia o timer para verificações periódicas
    periodicTimer = Timer.periodic(Duration(seconds: 3), (Timer timer) {
      if (!popupDisplayed) {
        Get.find<BleController>().scanDevices();
      }
    });

    Get.find<BleController>().scanResults.listen((List<ScanResult> scanResults) {
      _checkBluetoothResults(scanResults);
    });
  }

  @override
  void dispose() {
    // Cancela o timer quando a tela é descartada
    periodicTimer.cancel();
    super.dispose();
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
          'Minha Lista - RSSI: $rssiValue',
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
                _saveCheckedItems();
              });
            },
            child: ListTile(
              title: Text(itens[index]),
              trailing: IconButton(
                icon: itensMarcados.contains(index)
                    ? Icon(Icons.check, color: kPrimareColor) // Substituí por uma cor padrão, substitua conforme necessário
                    : Icon(Icons.circle_outlined, color: kSecondaryColor,),
                onPressed: () {
                  setState(() {
                    if (itensMarcados.contains(index)) {
                      itensMarcados.remove(index);
                    } else {
                      itensMarcados.add(index);
                    }
                    _saveCheckedItems();
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

class BleController extends GetxController {
  final FlutterBlue flutterBlue = FlutterBlue.instance;

  Future<bool> _requestPermissions() async {
    final bluetoothStatus = await Permission.bluetoothScan.status;
    if (bluetoothStatus.isDenied) {
      return await Permission.bluetoothScan.request().isGranted &&
          await Permission.bluetoothConnect.request().isGranted;
    }
    return true;
  }

  Future<void> scanDevices() async {
    if (await _requestPermissions()) {
      flutterBlue.startScan(timeout: Duration(seconds: 4));
    } else {
      print("Permissões Bluetooth não concedidas.");
    }
  }

  Stream<List<ScanResult>> get scanResults => flutterBlue.scanResults;

  Future<void> stopScan() async {
    await flutterBlue.stopScan();
  }
}
