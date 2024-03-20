import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class MyHomePageUser extends StatefulWidget {
  const MyHomePageUser({super.key});

  @override
  State<MyHomePageUser> createState() => _MyHomePageUserState();
}

class _MyHomePageUserState extends State<MyHomePageUser> {
  @override
  Widget build(BuildContext context) {
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
                        'Good Morning',
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(color: Colors.white54),
                      ),
                      trailing: const CircleAvatar(
                        radius: 30,
                        backgroundImage: AssetImage('assets/images/awab5.jpg'),
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
                      itemDashboard('Register Area', CupertinoIcons.map_fill,
                          Colors.green, () {
                        // Navigate to subscription page when item is clicked
                        Navigator.pushNamed(context, '/subscription');
                      }),
                      itemDashboard(
                          'Feedback', CupertinoIcons.mail_solid, Colors.purple,
                          () {
                        // Navigate to subscription page when item is clicked
                        Navigator.pushNamed(context, '/feedback_page');
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
                      SizedBox(height: 0.0),
                      SizedBox(height: 0.0),
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
}