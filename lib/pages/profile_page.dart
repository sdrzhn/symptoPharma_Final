import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:symptopharm/pages/edit_profile_page.dart';
import 'package:symptopharm/pages/login_page.dart';
import 'package:symptopharm/widget/general_logo_space.dart';
import 'change_password_page.dart';

class ProfilePages extends StatefulWidget {
  const ProfilePages({Key? key}) : super(key: key);

  @override
  State<ProfilePages> createState() => _ProfilePagesState();
}

class _ProfilePagesState extends State<ProfilePages> {
  User? _user;
  late CollectionReference<Map<String, dynamic>> _userCollection;

  @override
  void initState() {
    super.initState();
    _user = FirebaseAuth.instance.currentUser;
    _userCollection = FirebaseFirestore.instance.collection('users');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 1,
        centerTitle: true,
        title: Text(
          'Profile',
          style: TextStyle(
            color: Colors.black, // Set the text color to black
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0),
          child: Column(
            children: [
              Container(
                child: GeneralLogoSpace(
                  child: Column(children: [
                    SizedBox(
                      height: 1,
                    ),
                  ]),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: StreamBuilder<DocumentSnapshot>(
                  stream: _userCollection.doc(_user?.uid).snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    }

                    if (!snapshot.hasData || !snapshot.data!.exists) {
                      return Text('User not found');
                    }

                    var userData =
                        snapshot.data!.data() as Map<String, dynamic>;
                    var name = userData['full_name'] as String?;
                    var email = userData['email'] as String?;
                    var address = userData['address'] as String?;
                    var phone = userData['phone'] as String?;

                    return Column(
                      children: [
                        itemProfile('Name', name ?? '', CupertinoIcons.person),
                        SizedBox(height: 10),
                        itemProfile('Email', email ?? '', CupertinoIcons.mail),
                        SizedBox(height: 10),
                        itemProfile(
                            'Address', address ?? '', CupertinoIcons.home),
                        SizedBox(height: 10),
                        itemProfile('Phone', phone ?? '', CupertinoIcons.phone),
                        SizedBox(height: 20),
                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => EditProfilePages(),
                                    ),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Color(0xff6ebe81),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                      20,
                                    ),
                                  ),
                                ),
                                child: const Text('Edit Profile'),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () async {
                                  await FirebaseAuth.instance.signOut();
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => LoginPages(),
                                    ),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Color(0xff6ebe81),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                      20,
                                    ),
                                  ),
                                ),
                                child: const Text('Sign Out'),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          width: 200, // Set the desired width
                          child: ElevatedButton(
                            onPressed: () async {
                              await FirebaseAuth.instance.signOut();
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ChangePasswordPage(),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xff6ebe81),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            child: const Text('Change password'),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  itemProfile(String title, String subtitle, IconData iconData) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
              offset: Offset(0, 5),
              color: Color(0xff6ebe81).withOpacity(.2),
              spreadRadius: 4,
              blurRadius: 14),
        ],
      ),
      // SizedBox(height: 5,)
      child: ListTile(
        title: Text(title),
        subtitle: Text(subtitle),
        leading: Icon(iconData, color: Color(0xff6ebe81)),
        trailing: Icon(Icons.arrow_forward, color: Color(0xff6ebe81)),
        tileColor: Colors.white,
      ),
    );
  }
}
