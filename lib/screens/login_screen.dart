import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dashboard_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _rememberMe = false;

  @override
  void initState() {
    super.initState();
    _loadSavedCredentials();
  }

  // Load saved credentials
  Future<void> _loadSavedCredentials() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _usernameController.text = prefs.getString('username') ?? "";
      _passwordController.text = prefs.getString('password') ?? "";
      _rememberMe = prefs.getBool('rememberMe') ?? false;
    });
  }

  // Save credentials
  Future<void> _saveCredentials() async {
    final prefs = await SharedPreferences.getInstance();
    if (_rememberMe) {
      await prefs.setString('username', _usernameController.text);
      await prefs.setString('password', _passwordController.text);
      await prefs.setBool('rememberMe', true);
    } else {
      await prefs.remove('username');
      await prefs.remove('password');
      await prefs.setBool('rememberMe', false);
    }
  }

  // Show login popup
  void _showLoginPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Stack(
            children: [
              // Blur Effect
              BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                child: Container(color: Colors.transparent),
              ),
              // Login Box
              Container(
                // padding: EdgeInsets.all(25),
                // decoration: BoxDecoration(
                //   color: Colors.white.withOpacity(0),
                //   borderRadius: BorderRadius.circular(20),
                // ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  // mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("Smart Kitchen World",
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white)),
                    SizedBox(height: 20),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            controller: _usernameController,
                            decoration: InputDecoration(
                              labelText: "Username",
                              labelStyle: TextStyle(
                                color: Colors.white,
                              ),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              filled: true,
                              fillColor: Colors.white.withOpacity(0.3),
                            ),
                            style: TextStyle(color: Colors.white),
                            validator: (value) =>
                                value == "demo" ? null : "Invalid username",
                          ),
                          SizedBox(height: 10),
                          TextFormField(
                            controller: _passwordController,
                            decoration: InputDecoration(
                              labelText: "Password",
                              labelStyle: TextStyle(color: Colors.white),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              filled: true,
                              fillColor: Colors.white.withOpacity(0.3),
                            ),
                            obscureText: true,
                            style: TextStyle(color: Colors.white),
                            validator: (value) =>
                                value == "demo1234" ? null : "Invalid password",
                          ),
                          SizedBox(height: 10),
                          // Remember Me Checkbox
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Checkbox(
                                    value: _rememberMe,
                                    onChanged: (value) {
                                      setState(() {
                                        _rememberMe = value!;
                                      });
                                    },
                                  ),
                                  Text("Remember Me",
                                      style: TextStyle(color: Colors.white)),
                                ],
                              ),
                              TextButton(
                                onPressed: () {},
                                child: Text("Forgot Password?",
                                    style: TextStyle(color: Colors.white)),
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
                          // Login Button
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 50, vertical: 10),
                              backgroundColor:
                                  const Color.fromARGB(96, 17, 117, 4)
                                      .withOpacity(0.7),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50)),
                            ),
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                _saveCredentials();
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            DashboardScreen()));
                              }
                            },
                            child: Text("Login",
                                style: TextStyle(
                                  fontSize: 24,
                                  color: Colors.white,
                                  shadows: [
                                    Shadow(
                                        color:
                                            const Color.fromARGB(255, 0, 0, 0),
                                        offset: Offset(2, 2),
                                        blurRadius: 5),
                                  ],
                                )),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background Image with Gradient
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/background.jpg"),
                fit: BoxFit.cover,
              ),
              gradient: LinearGradient(
                colors: [Colors.black.withOpacity(0.6), Colors.transparent],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          // Center Content
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // App Title
              Text(
                "Smart Kitchen\nWorld", // add \n to break line
                textAlign: TextAlign.center, // Ensures text is centered
                style: TextStyle(
                  fontFamily: "cursive",
                  fontSize: 56,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  shadows: [
                    Shadow(
                        color: Colors.black87,
                        offset: Offset(5, 5),
                        blurRadius: 5),
                  ],
                ),
              ),
              SizedBox(height: 20), // Space before button

              // Login Button
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                  backgroundColor:
                      const Color.fromARGB(255, 0, 0, 0).withOpacity(0.7),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50)),
                ),
                onPressed: () => _showLoginPopup(context),
                child: Text("Login",
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                      shadows: [
                        Shadow(
                            color: Colors.black87,
                            offset: Offset(2, 2),
                            blurRadius: 5),
                      ],
                    )),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
