# 1. Visão Geral do Aplicativo
O aplicativo de lista de compras foi desenvolvido utilizando o framework Flutter. Ele possui a capacidade de interagir com beacons baseados em ESP32, instalados nos corredores do mercado. O objetivo é proporcionar uma experiência personalizada ao usuário, indicando a localização dos itens da lista nos corredores do mercado.

# 2. Funcionalidades Principais
## 2.1 Lista de Compras
- ### 2.1.1 Adição de Itens
  - Os usuários podem adicionar itens à lista de compras.
- ### 2.1.2 Remoção de Itens
  - Exclusão de itens da lista, se necessário.

## 2.2 Integração com Beacons
- ### 2.2.1 Registro de Beacons
  - Cada item da lista é vinculado a um beacon correspondente no corredor do mercado.
- ### 2.2.2 Mapeamento de Itens
  - A lista de compras é automaticamente atualizada com base na proximidade dos beacons.

# 3. Integração com Beacons (ESP32)
## 3.1 Hardware
- ### 3.1.1 Dispositivos Beacon
  - Beacons baseados em ESP32 são instalados nos corredores do mercado.
  - Configuração de identificadores exclusivos para cada beacon.
## 3.2 Comunicação
- ### 3.2.1 Bluetooth Low Energy (BLE)
  - O aplicativo utiliza BLE para se comunicar com os beacons ESP32.
- ### 3.2.2 Proximidade
  - A proximidade entre o dispositivo do usuário e os beacons é monitorada para determinar a localização.

# 4. Fluxo de Funcionamento
- Adição de Itens à Lista:
  - Usuário adiciona itens à lista na página principal.
- Atualização Automática:
  - Ao entrar no mercado, o aplicativo detecta a proximidade dos beacons e atualiza a lista de compras com a localização dos itens.
- Indicação de Corredor:
  - O aplicativo informa ao usuário em qual corredor encontrar os itens restantes da lista.
