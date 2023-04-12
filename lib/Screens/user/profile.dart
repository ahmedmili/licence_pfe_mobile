import 'package:flutter/material.dart';

class ProfileUser extends StatefulWidget {
  const ProfileUser({super.key});

  @override
  State<ProfileUser> createState() => _ProfileUserState();
}

class _ProfileUserState extends State<ProfileUser> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  const Icon(Icons.arrow_back),
                  const SizedBox(
                    width: 100,
                  ),
                  const Text(
                    "My Profile",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  )
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Text(
                "My Account Details ",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20,
              ),
              Stack(
                children: <Widget>[
                  Container(
                    height: 50,
                    width: 500,
                    padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                    child: Material(
                      elevation: 5.0,
                      borderRadius: BorderRadius.circular(20.0),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 17),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            const SizedBox(
                              height: 15,
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.person,
                                  color: Colors.green[800],
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "Name :",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Stack(
                children: <Widget>[
                  Container(
                    height: 50,
                    width: 500,
                    padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                    child: Material(
                      elevation: 5.0,
                      borderRadius: BorderRadius.circular(20.0),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 17),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            const SizedBox(
                              height: 15,
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.email,
                                  color: Colors.green[800],
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "Email :",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Stack(
                children: <Widget>[
                  Container(
                    height: 50,
                    width: 500,
                    padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                    child: Material(
                      elevation: 5.0,
                      borderRadius: BorderRadius.circular(20.0),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 17),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            const SizedBox(
                              height: 15,
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.phone,
                                  color: Colors.green[800],
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                const Text(
                                  "Phone :",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => const ProfileUser(),
                      ));
                },
                child: Padding(
                  padding: EdgeInsets.only(left: 240.0),
                  child: Text(
                    'Edit Your Profile ?',
                    style: TextStyle(
                        color: Colors.green[800], fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
