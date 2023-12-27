// Importações necessárias para o código
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

// Controller para a funcionalidade BLE (Bluetooth Low Energy)
class BleController extends GetxController {
  final FlutterBlue flutterBlue = FlutterBlue.instance;

  // Método para solicitar permissões relacionadas ao Bluetooth
  Future<bool> _requestPermissions() async {
    final bluetoothStatus = await Permission.bluetoothScan.status;
    if (bluetoothStatus.isDenied) {
      // Solicita permissões de varredura e conexão Bluetooth se ainda não foram concedidas
      return await Permission.bluetoothScan.request().isGranted &&
          await Permission.bluetoothConnect.request().isGranted;
    }
    return true;
  }

  // Método para iniciar a varredura de dispositivos BLE
  Future<void> scanDevices() async {
      flutterBlue.startScan(timeout: Duration(seconds: 4));
  }

  // Stream para obter os resultados da varredura
  Stream<List<ScanResult>> get scanResults => flutterBlue.scanResults;

  Future<void> stopScan() async {
    await flutterBlue.stopScan();
  }
}

// Página para exibir a varredura BLE
class ScanPage extends StatefulWidget {
  const ScanPage({Key? key}) : super(key: key);

  @override
  State<ScanPage> createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    // Inicia um timer para periodicamente solicitar a varredura de dispositivos
    _timer = Timer.periodic(Duration(seconds: 3), (_) {
      Get.find<BleController>().scanDevices();
    });
  }

  @override
  void dispose() {
    // Cancela o timer quando o widget é descartado
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("BLE SCANNER"),  // Título da barra de aplicativo
        centerTitle: true,
      ),
      body: GetBuilder<BleController>(
        init: BleController(),
        builder: (controller) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 15),  // Espaçamento superior
              // Constrói a lista de dispositivos encontrados
              StreamBuilder<List<ScanResult>>(
                stream: controller.scanResults,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    // Filtra dispositivos com o nome "esp32"
                    final esp32Devices = snapshot.data!
                        .where((data) => data.device.name?.toLowerCase().contains('esp32') ?? false)
                        .toList();

                    if (esp32Devices.isNotEmpty) {
                      // Mostra a lista de dispositivos ESP32
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: esp32Devices.length,
                        itemBuilder: (context, index) => Card(
                          elevation: 2,
                          child: ListTile(
                            title: Text(esp32Devices[index].device.name ?? ''),
                            subtitle: Text(esp32Devices[index].device.id.id),
                            trailing: Text(esp32Devices[index].rssi.toString()),
                          ),
                        ),
                      );
                    } else {


                      _timer.cancel();
                      _timer = Timer.periodic(Duration(seconds: 3), (_) {
                        Get.find<BleController>().scanDevices();
                      });

                      return Center(child: Text("Nenhum dispositivo ESP32 encontrado"));

                    }
                  } else {
                    // Mostra uma mensagem durante a varredura
                    return Center(child: Text("Varrendo..."));
                  }
                },
              ),
              SizedBox(height: 15),  // Espaçamento inferior
            ],
          ),
        ),
      ),
    );
  }
}
