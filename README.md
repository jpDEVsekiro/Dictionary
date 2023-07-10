![Dictionary](https://github.com/jpDEVsekiro/Dictionary/assets/71463029/90220123-37cf-4855-bc32-dd4c505861fd)

# Dictionary
![prints](https://github.com/jpDEVsekiro/Dictionary/assets/71463029/7b8ac6fc-d5cd-4fa8-96b3-492714666150)

Olá, bem vindo ao meu projeto! 

Dictionary é um aplicativo desenvolvido em Flutter com uso de Firebase. O app permite que usuários perquisem palavras e visualizem seu significado, pronúncia e sinônimos. Além de contar com funções de login, favorito e histórico. Organizando palavras em um aplicativo simples e intuitivo.

# Gerenciador de Estado e Injetor de Dependências 
Dicionary utiliza GetX (https://github.com/jonataslaw/getx) como gerenciador e injetor de dependências. GetX é uma solução leve e rápida para Flutter, que permite criar um projeto organizado e com código limpo.

# Listagem de Palavras

O aplicativo conta com um sistema de rolagem de palavras inteligente e perfomática, ultilizando o plugin infinite_scroll_pagination (https://pub.dev/packages/infinite_scroll_pagination). Permitindo que o app carregue somente o necessário para mostrar ao usuário, sem consumir mais memória RAM do que necessário.

![device-2023-07-09-221107](https://github.com/jpDEVsekiro/Dictionary/assets/71463029/c882dff9-7135-4ff5-8497-b4df1386eaab)

# Banco de Dados 

Dictionary ultiliza firebase para armazenar informações como a lista de favoritos e histórico do usuário. O firebase é uma das soluções mais rápidas e simples para Flutter entregando um back-end completo com autenticação de usuário, criação de contas e armazenamento de informações em tempo real.

![2023-07-10 08-41-32](https://github.com/jpDEVsekiro/Dictionary/assets/71463029/3fd90fdc-30cd-4d00-a025-310955fb6f95)

# Pronuncia das Palavras

Ultilzando plugin flutter_tts (https://pub.dev/packages/flutter_tts), Dictionary conta com a função de pronunciar as palavras para que usuário consiga verificar a pronuncia, flutter_tts permite a repodução de áudio de qual quer texto de forma offline e simples.

[device-2023-07-10-092214.webm](https://github.com/jpDEVsekiro/Dictionary/assets/71463029/f1aa0f4f-a703-43cb-b17e-4e23fd6508d5)
