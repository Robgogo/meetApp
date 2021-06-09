import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../screens/profile/profile.dart';
import '../../services/profile_service.dart';

class UsersList extends StatefulWidget {
  const UsersList({
    Key key,
    @required this.document,
    @required ProfileService profileService,
    @required this.me,
  })  : _profileService = profileService,
        super(key: key);

  final document;
  final ProfileService _profileService;
  final User me;

  @override
  _UsersListState createState() => _UsersListState();
}

class _UsersListState extends State<UsersList> {
  List<Profile> _profile;
  var _isLoading = true;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.document['users'].length,
      itemBuilder: (ctx, i) {
        return FutureBuilder(
          future:
              widget._profileService.getUserInfo(widget.document['users'][i]),
          builder: (ctx, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            var profile = snapshot.data;
            return Column(
              children: [
                ListTile(
                  title: widget.document['users'][i] == widget.me.uid
                      ? Text("Me")
                      : Text(profile.name),
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(profile.image),
                    radius: 40,
                  ),
                ),
                Divider(),
              ],
            );
          },
        );
      },
    );
  }
}
