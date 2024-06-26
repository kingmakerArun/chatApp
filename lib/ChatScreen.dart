import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Chat App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: ChatScreen(),
    );
  }
}

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();

  void _sendMessage() {
    if (_controller.text.isNotEmpty) {
      FirebaseFirestore.instance.collection('chats').add({
        'type': 'text',
        'content': _controller.text,
        'createdAt': Timestamp.now(),
      });
      _controller.clear();
    }
  }

  Future<void> _pickAndUploadImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final file = File(pickedFile.path);
      final fileName = DateTime.now().toString() + '.jpg';

      // Upload image to Firebase Storage
      final ref = firebase_storage.FirebaseStorage.instance
          .ref()
          .child('chats')
          .child(fileName);

      final uploadTask = ref.putFile(file);

      // Get download URL after upload completes
      await uploadTask.whenComplete(() async {
        final imageUrl = await ref.getDownloadURL();

        // Send message with image URL
        FirebaseFirestore.instance.collection('chats').add({
          'type': 'image',
          'content': imageUrl,
          'createdAt': Timestamp.now(),
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Chat App'),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('chats')
                  .orderBy('createdAt', descending: true)
                  .snapshots(),
              builder: (ctx, AsyncSnapshot<QuerySnapshot> chatSnapshot) {
                if (chatSnapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                final chatDocs = chatSnapshot.data!.docs;
                return ListView.builder(
                  reverse: true,
                  itemCount: chatDocs.length,
                  itemBuilder: (ctx, index) {
                    final message = chatDocs[index];
                    final messageType = message['type'];
                    final messageContent = message['content'];

                    // Display different widgets based on message type
                    Widget messageWidget;
                    if (messageType == 'text') {
                      messageWidget = MessageBubble(messageContent);
                    } else if (messageType == 'image') {
                      messageWidget = ImageMessageBubble(messageContent);
                    } else {
                      messageWidget = Text('Unsupported message type');
                    }

                    return Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: messageWidget,
                      ),
                    );
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(labelText: 'Send a message...'),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: _sendMessage,
                ),
                IconButton(
                  icon: Icon(Icons.image),
                  onPressed: _pickAndUploadImage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MessageBubble extends StatelessWidget {
  final String message;

  MessageBubble(this.message);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(12),
      ),
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      child: Text(
        message,
        style: TextStyle(
          color: Colors.black,
        ),
      ),
    );
  }
}

class ImageMessageBubble extends StatelessWidget {
  final String imageUrl;

  ImageMessageBubble(this.imageUrl);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(12),
      ),
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      child: Image.network(imageUrl),
    );
  }
}
