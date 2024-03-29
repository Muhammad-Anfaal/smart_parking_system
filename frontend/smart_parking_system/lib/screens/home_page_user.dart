import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:image/image.dart' as ImageLib;
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

String img = '';

Future getImage() async {
  img = await loadProfile('h@gmail.com');
  print(
      "????????????????????????????????????????????????????????????????????????????????????");
  print(img);
}

Future<String> loadProfile(String email) async {
  String ipAddress = '192.168.137.1'; // lan adapter ip address
  final url = Uri.parse('http://$ipAddress:3000/user/users/$email');

  final response = await http.get(url);
  if (response.statusCode == 200) {
    Map<dynamic, dynamic> data = jsonDecode(response.body);
    print(data);
    String bs4str = data['userImage'];
    // String base64String = bs4str.substring(2, bs4str.length - 1);
    Uint8List bytes = base64Decode(bs4str);
    String dir = (await getApplicationDocumentsDirectory()).path;
    File file = File('$dir/profile.jpg');
    File decodedimgfile = await file.writeAsBytes(bytes);
    return decodedimgfile.path;
  } else {
    throw Exception('Failed to load profile');
  }
}

class MyHomePageUser extends StatefulWidget {
  const MyHomePageUser({Key? key});

  @override
  State<MyHomePageUser> createState() => _MyHomePageUserState();
}

class _MyHomePageUserState extends State<MyHomePageUser> {
  String _greeting = '';

  @override
  void initState() {
    super.initState();
    _updateGreeting();
  }

  void _updateGreeting() {
    final currentTime = DateTime.now();
    final hour = currentTime.hour;

    setState(() {
      if (hour >= 6 && hour < 12) {
        _greeting = 'Good Morning';
      } else if (hour >= 12 && hour < 18) {
        _greeting = 'Good Afternoon';
      } else {
        _greeting = 'Good Night';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    getImage();
    return Scaffold(
      backgroundColor: Colors.blue[600],
      body: SafeArea(
        child: Container(
          color: Colors.white,
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.blue[700],
                  borderRadius: const BorderRadius.only(
                    bottomRight: Radius.circular(50),
                  ),
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 50),
                    ListTile(
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 30),
                      title: Text(
                        'Hello Awab!',
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall
                            ?.copyWith(color: Colors.white),
                      ),
                      subtitle: Text(
                        _greeting,
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(color: Colors.white54),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.exit_to_app), // Log-out icon
                            color: Colors.white,
                            onPressed: () {
                              // Log out functionality
                              _logOut();
                            },
                          ),
                          CircleAvatar(
                            radius: 30,
                            backgroundImage: File(img).existsSync()
                                ? FileImage(File(img))
                                : const AssetImage('assets/images/profile.png')
                                    as ImageProvider<Object>,
                            // MemoryImage(ImageLib.encodeJpg(img!)),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 30)
                  ],
                ),
              ),
              Container(
                color: Colors.blue[700],
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.only(topLeft: Radius.circular(200))),
                  child: GridView.count(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    crossAxisSpacing: 40,
                    mainAxisSpacing: 30,
                    children: [
                      itemDashboard('Reserve Slot', CupertinoIcons.calendar,
                          Colors.deepOrange, () {
                        // Navigate to ReservationPage when item is clicked
                        Navigator.pushNamed(context, '/reservation_page');
                      }),
                      itemDashboard('Subscription', CupertinoIcons.person_2_alt,
                          Colors.brown, () {
                        // Navigate to subscription page when item is clicked
                        Navigator.pushNamed(context, '/subscription');
                      }),
                      itemDashboard('Car Details', CupertinoIcons.car_detailed,
                          Colors.indigo, () {
                        // Navigate to subscription page when item is clicked
                        Navigator.pushNamed(context, '/car_registration');
                      }),
                      itemDashboard(
                          'Feedback', CupertinoIcons.mail_solid, Colors.purple,
                              () {
                            // Navigate to subscription page when item is clicked
                            Navigator.pushNamed(context, '/feedback_page');
                          }),
                      const SizedBox(height: 0.0),
                      const SizedBox(height: 0.0),
                      const SizedBox(height: 0.0),
                      const SizedBox(height: 0.0),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  itemDashboard(String title, IconData iconData, Color background,
          VoidCallback onTap) =>
      GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                offset: const Offset(0, 5),
                color: Theme.of(context).primaryColor.withOpacity(.2),
                spreadRadius: 2,
                blurRadius: 5,
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: background,
                  shape: BoxShape.circle,
                ),
                child: Icon(iconData, color: Colors.white),
              ),
              const SizedBox(height: 8),
              Text(title.toUpperCase(),
                  style: Theme.of(context).textTheme.titleMedium)
            ],
          ),
        ),
      );

  // Log-out functionality
  void _logOut() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear(); // Clear all stored data
    // Navigate to the login page or any other initial page
    Navigator.pushNamedAndRemoveUntil(context, '/log_in', (route) => false);
  }
}
