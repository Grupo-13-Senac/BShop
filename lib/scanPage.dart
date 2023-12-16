import 'dart:async';

import 'package:bshop/ble_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:get/get.dart';

class ScanPage extends StatefulWidget {
  const ScanPage({super.key});
  @override
  State<ScanPage> createState() => _ScanPageState();
}
class _ScanPageState extends State<ScanPage> {
  late Timer _timer; // Adiciona uma variável de temporizador

  @override
  void initState() {
    super.initState();

    // Inicia o temporizador ao criar o estado
    _timer = Timer.periodic(Duration(seconds: 3), (Timer timer) {
      // Chama a função a cada 3 segundos
      Get.find<BleController>().scanDevices();
    });
  }

  @override
  void dispose() {
    // Cancela o temporizador ao descartar o estado para evitar vazamentos de memória
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("BLE SCANNER"),
        centerTitle: true,
      ),
      body: GetBuilder<BleController>(
        init: BleController(),
        builder: (controller) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 15,
                ),
                StreamBuilder<List<ScanResult>>(
                  stream: controller.scanResults,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          final data = snapshot.data![index];

                          if (data.device.name != null &&
                              data.device.name.toLowerCase().contains('esp32')) {
                            return Card(
                              elevation: 2,
                              child: ListTile(
                                title: Text(data.device.name),
                                subtitle: Text(data.device.id.id),
                                trailing: Text(data.rssi.toString()),
                              ),
                            );
                          } else {
                            return Container();
                          }
                        },
                      );
                    } else {
                      return Center(child: Text("No Device Found"));
                    }
                  },
                ),
                SizedBox(
                  height: 15,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}