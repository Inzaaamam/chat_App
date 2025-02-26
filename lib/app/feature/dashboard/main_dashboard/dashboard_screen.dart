import 'package:chat_app/app/feature/dashboard/main_dashboard/dashboard_cubit.dart';
import 'package:chat_app/app/sdk/extension/padding_exten.dart';
import 'package:chat_app/app/sdk/style/color/color.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../sdk/enum/loading_status.dart';
import '../chat/chat_screen.dart';
import 'dashboard_state.dart';

class DashBoardScreen extends StatelessWidget {
  DashBoardScreen({super.key});
  final TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: BlocProvider(
        create: (context) => DashCubit()..fetchUsers(),
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              toolbarHeight: 130,
              backgroundColor: AppColor.primaryColor,
              title: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  BlocBuilder<DashCubit, DashState>(
                    builder: (context, state) {
                      return SizedBox(
                        height: 55,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                              color: AppColor.textColor,
                              borderRadius: BorderRadius.circular(30)),
                          child: TextFormField(
                            controller: _controller,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 16, horizontal: 10),
                              hintText: "Search Email",
                              filled: false,
                              fillColor: AppColor.textColor,
                              border: InputBorder.none,
                              prefixIcon: const Icon(Icons.search,
                                  size: 30, color: AppColor.primaryColor),
                              suffixIcon: state.searchQuery.isNotEmpty
                                  ? IconButton(
                                      icon: const Icon(Icons.clear, color: Colors.black),
                                      onPressed: () {
                                        _controller.clear();
                                        context.read<DashCubit>().clearSearch();
                                      },
                                    )
                                  : null,
                            ),
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.done,
                            onChanged: (value) {
                              context.read<DashCubit>().searchUsers(value);
                            },
                          ),
                        ),
                      );
                    },
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Chats',
                        style: TextStyle(color: AppColor.textColor, fontSize: 20),
                      ),
                      Text(
                        'Calls',
                        style: TextStyle(color: AppColor.textColor, fontSize: 20),
                      ),
                    ],
                  ).padOnly(left: 60, right: 60, top: 20, bottom: 20),
                ],
              ),
            ),
            body: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                return ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: 200,
                    maxHeight: constraints.maxHeight,
                  ),
                  child: BlocBuilder<DashCubit, DashState>(
                    builder: (context, state) {
                      if (state.status == Status.isLoading) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      if (state.filterContact.isEmpty) {
                        return const Center(
                            child: Text(
                          'No user found',
                          style: TextStyle(fontSize: 20),
                        ));
                      }
                      return ListView.builder(
                        scrollDirection: Axis.vertical,
                        reverse: false,
                        itemCount: state.filterContact.length,
                        itemBuilder: (context, index) {
                          final user = state.filterContact[index];
                          return Card(
                            elevation: 0,
                            margin:
                                const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                            child: ListTile(
                              leading: const Icon(Icons.person, size: 40),
                              title: Text(user['email'] ?? "No email"),
                              trailing: Text(
                                user['createdAt'] != null
                                    ? DateFormat.Hm()
                                        .format((user['createdAt'] as Timestamp).toDate())
                                    : "N/A",
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ChatScreen(
                                      receiverId: user['uid'],
                                      receiverEmail: user['email'] ?? "No email",
                                    ),
                                  ),
                                );
                              },
                            ),
                          );
                        },
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
