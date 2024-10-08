import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'admin_panel_page.dart'; // Ensure this import is correct

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _isSignUp = false;

  Future<void> _authenticate() async {
    try {
      final email = _emailController.text;
      final password = _passwordController.text;

      if (_isSignUp) {
        if (password != _confirmPasswordController.text) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Passwords do not match')),
          );
          return;
        }
        final response = await Supabase.instance.client.auth.signUp(
          email: email,
          password: password,
        );
        if (response.user != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Sign Up successful!')),
          );
        }
      } else {
        final response = await Supabase.instance.client.auth.signInWithPassword(
          email: email,
          password: password,
        );
        if (response.user != null) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => AdminPanelPage()),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Login failed. Please check your credentials.')),
          );
        }
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $error')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            elevation: 10,
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: IconButton(
                      icon: Icon(Icons.close),
                      onPressed: () {
                        Navigator.pop(context); // Return to the previous page
                      },
                    ),
                  ),
                  Text(
                    _isSignUp ? 'Sign Up' : 'Login',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 16),
                  TextField(
                    controller: _emailController,
                    decoration: InputDecoration(labelText: 'Email'),
                  ),
                  SizedBox(height: 16),
                  TextField(
                    controller: _passwordController,
                    decoration: InputDecoration(labelText: 'Password'),
                    obscureText: true,
                  ),
                  if (_isSignUp) ...[
                    SizedBox(height: 16),
                    TextField(
                      controller: _confirmPasswordController,
                      decoration: InputDecoration(labelText: 'Confirm Password'),
                      obscureText: true,
                    ),
                  ],
                  SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: _authenticate,
                    child: Text(_isSignUp ? 'Sign Up' : 'Login'),
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        _isSignUp = !_isSignUp;
                      });
                    },
                    child: Text(_isSignUp
                        ? 'Already have an account? Login'
                        : 'Don\'t have an account? Sign up'),
                  ),
                  SizedBox(height: 10),
                  TextButton(
                    onPressed: () {
                      // Add Google sign-in functionality
                    },
                    child: Text('Sign in with Google'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }
}
