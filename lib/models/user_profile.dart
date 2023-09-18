import 'package:flutter/material.dart';
import 'package:mood_match/models/user_profile.dart';

class UserProfile {
  final String username;
  final String profileImageURL;
  final bool isPremium;
  final String name;

  UserProfile({
    required this.username,
    required this.profileImageURL,
    required this.isPremium,
    required this.name,
  });
}

class UserProfileWidget extends StatelessWidget {
  final UserProfile userInfo;

  UserProfileWidget({required this.userInfo});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: Colors.grey),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(userInfo.profileImageURL),
                radius: 30.0,
              ),
              SizedBox(width: 16.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Username:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(userInfo.username),
                ],
              ),
            ],
          ),
          SizedBox(height: 16.0),
          Text('Name: ${userInfo.name}'),
          SizedBox(height: 16.0),
          Row(
            children: [
              Icon(
                Icons.star,
                color: userInfo.isPremium ? Colors.yellow : Colors.grey,
              ),
              SizedBox(width: 8.0),
              Text('Premium', style: TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
        ],
      ),
    );
  }
}
