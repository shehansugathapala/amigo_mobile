import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

void main() {
  runApp(const App(home: ChatScreen()));
}

@immutable
class App extends StatelessWidget {
  const App({Key? key, this.home}) : super(key: key);

  final Widget? home;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Chat',
      theme: ThemeData.dark(useMaterial3: true),
      home: home,
    );
  }
}

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late IO.Socket socket;
  TextEditingController messageController = TextEditingController();
  List<Message> messages = [];
  bool isConnected = false;
  String serverResponse = '';


  @override
  void initState() {
    super.initState();
    connectToServer();
  }

  void connectToServer() {
    socket = IO.io(
      'http://${Constants.serverIP}:${Constants.serverPort}',
      <String, dynamic>{
        'transports': ['websocket'],
        'autoConnect': false,
      },
    );

    socket.on('connect_error', (_) {
      setState(() {
        isConnected = false;
      });
    });

    socket.on('connect_timeout', (_) {
      setState(() {
        isConnected = false;
      });
    });

    socket.on('connect', (_) {
      setState(() {
        isConnected = true;
      });
    });

    socket.on('disconnect', (_) {
      setState(() {
        isConnected = false;
      });
    });

    socket.on('chat_message', (data) {
      setState(() {
        messages.add(Message(owner: MessageOwner.other, text: data));
      });
    });

    socket.on('admin_message', (data) {
      setState(() {
        messages.add(Message(owner: MessageOwner.admin, text: data));
      });
    });

    socket.on('server_response', (data) {
      setState(() {
        serverResponse = data;
      });
    });

    socket.connect();
  }

  void sendMessage() {
    String message = messageController.text.trim();
    if (message.isNotEmpty) {
      socket.emit('chat_message', message);
      setState(() {
        messages.add(Message(owner: MessageOwner.myself, text: message));
      });
      messageController.clear();

    }
  }
  void saveMessage() {

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isConnected ? 'Chat - Connected' : 'Chat - Disconnected'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              reverse: true,
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final message = messages[index];
                return MessageBubble(
                  message: message,
                  child: Text(message.text),
                );
              },
            ),
          ),
          if (serverResponse.isNotEmpty)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Server Response: $serverResponse',
                style: TextStyle(color: Colors.blue),
              ),
            ),
          BottomAppBar(
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: TextField(
                      controller: messageController,
                      decoration: const InputDecoration(
                        hintText: 'Type your message here...',
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


class Constants {
  static const String serverIP = '51.20.8.67';
  static const int serverPort = 5002;
}

enum MessageOwner { myself, other, admin }

@immutable
class Message {
  const Message({
    required this.owner,
    required this.text,
  });

  final MessageOwner owner;
  final String text;
}

@immutable
class MessageBubble extends StatelessWidget {
  const MessageBubble({
    Key? key,
    required this.message,
    required this.child,
  }) : super(key: key);

  final Message message;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final messageAlignment =
    message.owner == MessageOwner.myself ? Alignment.topRight : Alignment.topLeft;

    return FractionallySizedBox(
      alignment: messageAlignment,
      widthFactor: 0.8,
      child: Align(
        alignment: messageAlignment,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 20.0),
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(16.0)),
            child: BubbleBackground(
              colors: [
                if (message.owner == MessageOwner.myself) ...const [
                  Color(0xFF6C7689),
                  Color(0xFF3A364B),
                ] else ...const [
                  Color(0xFF19B7FF),
                  Color(0xFF491CCB),
                ],
              ],
              child: DefaultTextStyle.merge(
                style: const TextStyle(
                  fontSize: 18.0,
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: child,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

@immutable
class BubbleBackground extends StatelessWidget {
  const BubbleBackground({
    Key? key,
    required this.colors,
    this.child,
  }) : super(key: key);

  final List<Color> colors;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: BubblePainter(
        colors: colors,
      ),
      child: child,
    );
  }
}

class BubblePainter extends CustomPainter {
  BubblePainter({required this.colors}) : super();

  final List<Color> colors;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..shader = ui.Gradient.linear(
        const Offset(0, 0),
        Offset(size.width, size.height),
        colors,
      );

    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(0, 0, size.width, size.height),
        const Radius.circular(16.0),
      ),
      paint,
    );
  }

  @override
  bool shouldRepaint(BubblePainter oldDelegate) {
    return oldDelegate.colors != colors;
  }
}
