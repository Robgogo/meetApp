import 'package:flutter/material.dart';
import '../../services/profile_service.dart';
import '../profile/profile.dart';

class ChatRoomScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _profileService = ProfileService();
    return FutureBuilder(
        future: _profileService.checkUserInfo(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting)
            return Center(
              child: CircularProgressIndicator(),
            );
          return Container(
            child: Center(
              child:
                  snapshot.data ? Text("Complete profile first") : Text("Room"),
            ),
          );
        });
  }
}
