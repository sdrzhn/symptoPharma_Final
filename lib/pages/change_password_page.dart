import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:symptopharm/pages/profile_page.dart';

class ChangePasswordPage extends StatefulWidget {
  @override
  _ChangePasswordPageState createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _currentPasswordController =
      TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  String? _currentPasswordError;
  String? _newPasswordError;
  String? _confirmPasswordError;

void _changePassword() async {
  final User? user = FirebaseAuth.instance.currentUser;
  if (user == null) {
    // User not authenticated
    return;
  }

  setState(() {
    _currentPasswordError = null;
    _newPasswordError = null;
    _confirmPasswordError = null;
  });

  if (_formKey.currentState!.validate()) {
    try {
      // Reauthenticate user with current password
      final AuthCredential credential = EmailAuthProvider.credential(
        email: user.email!,
        password: _currentPasswordController.text,
      );
      await user.reauthenticateWithCredential(credential);

      // Change password
      await user.updatePassword(_newPasswordController.text);

      // Password changed successfully
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Success'),
            content: Text('Your password has been changed.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    } catch (e) {
      setState(() {
        if (e is FirebaseAuthException) {
          switch (e.code) {
            case 'wrong-password':
              _currentPasswordError = 'Incorrect current password.';
              break;
            default:
              _currentPasswordError =
                  'An error occurred. Please try again later.';
              break;
          }
        } else {
          _currentPasswordError =
              'An error occurred. Please try again later.';
        }
      });
    }
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 1,
        leading: IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfilePages()),
              );
            },
            icon: Icon(Icons.arrow_back, color: Color(0xff6ebe81))),
        centerTitle: true,
        title: Text(
          'Change Password',
          style: TextStyle(
            color: Colors.black, // Set the text color to black
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _currentPasswordController,
                obscureText: true,
                decoration: InputDecoration(labelText: 'Current Password'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your current password.';
                  }
                  return _currentPasswordError;
                },
              ),
              TextFormField(
                controller: _newPasswordController,
                obscureText: true,
                decoration: InputDecoration(labelText: 'New Password'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a new password.';
                  }
                  return _newPasswordError;
                },
              ),
              TextFormField(
                controller: _confirmPasswordController,
                obscureText: true,
                decoration: InputDecoration(labelText: 'Confirm New Password'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please confirm your new password.';
                  }
                  if (value != _newPasswordController.text) {
                    return 'Passwords do not match.';
                  }
                  return _confirmPasswordError;
                },
              ),
              SizedBox(height: 16),
               ElevatedButton(
              onPressed: (){},
              child: Text("Change Password"),
              style: ElevatedButton.styleFrom(
                                  backgroundColor: Color(0xff6ebe81),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                      20,
                                    ),
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
