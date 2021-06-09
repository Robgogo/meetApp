import 'package:flutter/material.dart';

import '../../services/room_service.dart';
import '../../services/profile_service.dart';
import '../../services/auth_service.dart';
import '../../widgets/chatroom/users_list.dart';

class ChatRoomDetailScreen extends StatelessWidget {
  static const routeName = '/room';
  final _roomService = RoomService();
  final _authService = AuthService();
  final _profileService = ProfileService();
  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context).settings.arguments as String;
    return StreamBuilder(
      stream: _roomService.roomsnapshot(id),
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        final document = snapshot.data.data();
        final me = _authService.getCurrentUser();
        return Scaffold(
          appBar: AppBar(
            title: Text(document['name']),
            actions: [
              Row(
                // crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                      "${document['joined'].toString()}/${document['capacity'].toString()}"),
                  IconButton(onPressed: () {}, icon: Icon(Icons.face)),
                ],
              ),
            ],
          ),
          body: UsersList(
              document: document, profileService: _profileService, me: me),
        );
      },
    );
  }
}
