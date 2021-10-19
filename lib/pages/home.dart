import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _channel = WebSocketChannel.connect(
    Uri.parse('wss://localhost:8080'),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () {
                   _channel.sink.add("Hello");
                },
                icon: const Icon(Icons.send))
          ],
        ),
        body: StreamBuilder(
          stream: _channel.stream,
          builder: (context, snapshot) {
            return Center(
              child: Text(snapshot.hasData ? '${snapshot.data}' : 'Nothing'),
            );
          },
        ));
  }

  @override
  void dispose() {
    _channel.sink.close();
    super.dispose();
  }
}
