import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChangePasswordPage extends StatefulWidget {
  final String uid;

  ChangePasswordPage({required this.uid});

  @override
  _ChangePasswordPageState createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController oldPasswordController = TextEditingController();

  final GlobalKey<State> _dialogKey = GlobalKey<State>();

  bool _obscureNewPassword = true;
  bool _obscureConfirmPassword = true;
  bool _obscureOldPassword = true;

  void _toggleNewPasswordVisibility() {
    setState(() {
      _obscureNewPassword = !_obscureNewPassword;
    });
  }

  void _toggleConfirmPasswordVisibility() {
    setState(() {
      _obscureConfirmPassword = !_obscureConfirmPassword;
    });
  }

  void _toggleOldPasswordVisibility() {
  setState(() {
    _obscureOldPassword = !_obscureOldPassword;
  });
}

void changePassword() async {
  String oldPassword = oldPasswordController.text;
  String newPassword = newPasswordController.text;
  String confirmPassword = confirmPasswordController.text;

  if (oldPassword.isEmpty || newPassword.isEmpty || confirmPassword.isEmpty) {
    // Display error dialog for empty fields
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text('Please enter the old password, new password, and confirm password.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
    return;
  }

  if (newPassword != confirmPassword) {
    // Display error dialog for password mismatch
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text('New password and confirm password do not match.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
    return;
  }

  try {
    User? UserCredential = FirebaseAuth.instance.currentUser;
    if (UserCredential != null) {
      AuthCredential credential = EmailAuthProvider.credential(email: UserCredential.email!, password: oldPassword);
      await UserCredential.reauthenticateWithCredential(credential);
      await UserCredential.updatePassword(newPassword);

      // Update password in Firestore collection
      await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.uid)
          .update({'password': newPassword});

      // Password changed successfully
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Success'),
            content: Text('Password changed successfully.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    } else {
      throw Exception('User is null');
    }
  } catch (e) {
    if (e is FirebaseAuthException) {
      // Handle specific FirebaseAuthException errors
      if (e.code == 'wrong-password') {
        // Display error dialog for incorrect old password
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Error'),
              content: Text('Incorrect old password.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      } else {
        // Display generic error dialog for other FirebaseAuthException errors
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Error'),
              content: Text('Failed to change password: ${e.message}'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      }
    } else {
      // Display generic error dialog for other exceptions
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Failed to change password: $e'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }
}




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Change Password'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: oldPasswordController,
              obscureText: _obscureOldPassword,
              decoration: InputDecoration(
                labelText: 'Old Password',
                suffixIcon: IconButton(
                  icon: Icon(_obscureOldPassword
                      ? Icons.visibility_off
                      : Icons.visibility),
                  onPressed: _toggleOldPasswordVisibility,
                ),
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: newPasswordController,
              obscureText: _obscureNewPassword,
              decoration: InputDecoration(
                labelText: 'New Password',
                suffixIcon: IconButton(
                  icon: Icon(_obscureNewPassword
                      ? Icons.visibility_off
                      : Icons.visibility),
                  onPressed: _toggleNewPasswordVisibility,
                ),
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: confirmPasswordController,
              obscureText: _obscureConfirmPassword,
              decoration: InputDecoration(
                labelText: 'Confirm Password',
                suffixIcon: IconButton(
                  icon: Icon(_obscureConfirmPassword
                      ? Icons.visibility_off
                      : Icons.visibility),
                  onPressed: _toggleConfirmPasswordVisibility,
                ),
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: changePassword,
              child: Text('Change Password'),
            ),
          ],
        ),
      ),
    );
  }
}
