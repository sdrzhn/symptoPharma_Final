// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:symptopharm/pages/profile_page.dart';

// class EditProfilePages extends StatefulWidget {
//   @override
//   _EditProfilePagesState createState() => _EditProfilePagesState();
// }

// class _EditProfilePagesState extends State<EditProfilePages> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Theme.of(context).scaffoldBackgroundColor,
//         elevation: 1,
//         leading: IconButton(
//             onPressed: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => ProfilePages()),
//               );
//             },
//             icon: Icon(Icons.arrow_back, color: Color(0xff6ebe81))),
//         actions: [
//           IconButton(
//               onPressed: () {},
//               icon: Icon(
//                 Icons.settings,
//                 color: Color(0xff6ebe81),
//               ))
//         ],
//       ),
//       body: Container(
//         padding: EdgeInsets.only(left: 20, top: 35, right: 20),
//         child: ListView(
//           children: [
//             Text('Edit Profile',
//             style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class EditProfilePages extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePages> {
  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Load user data when the page is initialized
    loadUserData();
  }

  Future<void> loadUserData() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();
      Map<String, dynamic>? userData = snapshot.data() as Map<String, dynamic>?;
      if (userData != null) {
        fullNameController.text = userData['full_name'];
        emailController.text = userData['email'];
        phoneController.text = userData['phone'];
        addressController.text = userData['address'];
      }
    }
  }

  Future<void> updateProfile() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await FirebaseFirestore.instance.collection('users').doc(user.uid).update({
        'full_name': fullNameController.text,
        'email': emailController.text,
        'phone': phoneController.text,
        'address': addressController.text,
      });
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Information"),
          content: Text("Profile updated successfully"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("OK"),
            )
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Profile"),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: fullNameController,
              decoration: InputDecoration(labelText: 'Full Name'),
            ),
            TextFormField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email Address'),
            ),
            TextFormField(
              controller: phoneController,
              decoration: InputDecoration(labelText: 'Phone'),
            ),
            TextFormField(
              controller: addressController,
              decoration: InputDecoration(labelText: 'Home Address'),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: updateProfile,
              child: Text("Save Changes"),
            ),
          ],
        ),
      ),
    );
  }
}

