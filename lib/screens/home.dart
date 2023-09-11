import 'package:flutter/material.dart';
import 'package:mood_match/widgets/custom_app_bar.dart';
import 'package:mood_match/models/user_profile.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    UserProfile currentUser = UserProfile(
      username: 'Pantalon para tiendas',
      profileImageURL: 'https://scontent.faqp3-1.fna.fbcdn.net/v/t39.30808-6/339503929_806646187547091_3439436179842089405_n.png?_nc_cat=103&ccb=1-7&_nc_sid=49d041&_nc_eui2=AeETPh7bx-iKZRJxg3CvJdvBSv6uzWP2Yy9K_q7NY_ZjL7CbCfOkbejeKfzFM6g-u4WeU44igbhbtUyRSkVL4il6&_nc_ohc=2TU5r22kOgUAX9x5bs-&_nc_ht=scontent.faqp3-1.fna&oh=00_AfCq2_1UICdSoNXkya2I97Q2HkyD0Fvl4_2-pZx6F-xl5A&oe=65039C07',
    );

    int numberOfRecommendations = 10;
    String lastRecommendation = "The Big Bang Theory";

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: CustomAppBar(),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircleAvatar(
              backgroundImage: NetworkImage(currentUser.profileImageURL),
              radius: 100,
            ),
            SizedBox(height: 20),
            Text(
              currentUser.username,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Recomendaciones Hechas:',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(width: 10),
                    Text(
                      '$numberOfRecommendations',
                      style: TextStyle(fontSize: 20, color: Colors.blue),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Última Recomendación:',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(width: 10),
                    Text(
                      '$lastRecommendation',
                      style: TextStyle(fontSize: 20, color: Colors.blue),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/index');
              },
              child: Text(
                'Comencemos',
                style: TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
