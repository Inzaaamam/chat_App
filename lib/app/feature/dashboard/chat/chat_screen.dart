import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import '../../../sdk/style/color/color.dart';
import 'chat_cubit.dart';
import 'chat_state.dart';

class ChatScreen extends StatelessWidget {
  final String receiverId;
  final String receiverEmail;

  ChatScreen({Key? key, required this.receiverId, required this.receiverEmail})
      : super(key: key);

  final TextEditingController _textEditingController = TextEditingController();

  String _getChatId(String currentUserId) {
    return currentUserId.hashCode <= receiverId.hashCode
        ? "${currentUserId}_$receiverId"
        : "${receiverId}_$currentUserId";
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = FirebaseAuth.instance.currentUser;
    final chatId = _getChatId(currentUser!.uid);

    return BlocProvider(
      create: (context) => ChatCubit(chatId)..fetchMessages(),
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          appBar: AppBar(
            surfaceTintColor: Colors.transparent,
            iconTheme: const IconThemeData(color: AppColor.textColor),
            backgroundColor: AppColor.primaryColor,
            title: Text(
              receiverEmail,
              style: const TextStyle(color: AppColor.textColor),
            ),
          ),
          body: Column(
            children: [
              Expanded(child: _buildMessagesList()),
              _buildMessageInput(context, currentUser.uid),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMessagesList() {
    return BlocBuilder<ChatCubit, ChatState>(
      builder: (context, state) {
        if (state.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state.error != null) {
          return Center(child: Text("Error: ${state.error}"));
        }
        if (state.messages.isEmpty) {
          return const Center(child: Text("No messages yet."));
        }
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (context.read<ChatCubit>().scrollController.hasClients) {
            context.read<ChatCubit>().scrollToBottom();
          }
        });
        final reversedMessages = state.messages.reversed.toList();
        return ListView.builder(
          controller: context.read<ChatCubit>().scrollController,
          itemCount: reversedMessages.length,
          itemBuilder: (context, index) {
            final message = reversedMessages[index].data();
            final isMe = message['senderId'] == FirebaseAuth.instance.currentUser!.uid;
            return Align(
              alignment: isMe ? Alignment.topRight : Alignment.topLeft,
              child: Container(
                margin: isMe
                    ? const EdgeInsets.only(top: 15, bottom: 6, left: 60, right: 10)
                    : const EdgeInsets.only(top: 15, bottom: 6, left: 10, right: 60),
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                decoration: BoxDecoration(
                  color: isMe ? AppColor.chatSenderColor : Colors.grey[300],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      message['text'],
                      style: TextStyle(
                        fontSize: 16,
                        color: isMe ? AppColor.textPrimaryColor : Colors.black,
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        message['timestamp'] != null
                            ? DateFormat('hh:mm a')
                                .format((message['timestamp'] as Timestamp).toDate())
                            : "Now",
                        style: const TextStyle(fontSize: 10, color: Colors.black54),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildMessageInput(BuildContext context, String senderId) {
    return Builder(builder: (context) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                maxLines: 4,
                minLines: 1,
                controller: _textEditingController,
                decoration: InputDecoration(
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none),
                  filled: true,
                  hintText: 'Type a message...',
                ),
              ),
            ),
            const SizedBox(width: 5),
            Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25), color: AppColor.primaryColor),
              child: IconButton(
                icon: const Icon(Icons.send, size: 24, color: Colors.white),
                onPressed: () {
                  final text = _textEditingController.text.trim();
                  if (text.isNotEmpty) {
                    context.read<ChatCubit>().sendMessage(senderId, receiverId, text);
                    _textEditingController.clear();
                  }
                },
              ),
            ),
          ],
        ),
      );
    });
  }
}
