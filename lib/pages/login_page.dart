import 'package:bitsdojo_window/bitsdojo_window.dart';
import "package:flutter/material.dart";
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../layout/desktop_scaffold.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool rememberMe = false;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  var _animatedInputBox = Column(
    key: Key("text1"),
    children: [
      TextField(
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: "Email",
          prefixIcon: Icon(Icons.email),
        ),
      ),
      TextField(
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: "Email",
          prefixIcon: Icon(Icons.email),
        ),
      ),
    ],
  );

  void handleRememberMeToggle(bool? state) {
    print(_passwordController.text);
    setState(() {
      rememberMe = !rememberMe;
    });
  }

  void signIn() {
    Navigator.pushNamed(context, "/home");
  }

  // Future signIn() async {
  //   await FirebaseAuth.instance.signInWithEmailAndPassword(
  //     email: _emailController.text.trim(),
  //     password: _passwordController.text.trim(),
  //   );
  // }

  @override
  void initState() {
    super.initState();

    _emailController.addListener(() {
      setState(() {});
    });
    _passwordController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Row(
        children: [
          Expanded(
            flex: 3,
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage("assets/images/LoginImage.jpg"), fit: BoxFit.cover, colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.7), BlendMode.darken)),
              ),
              child: MoveWindow(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Nice to see you again.",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      "Welcome Back".toUpperCase(),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 64,
                        color: Colors.white,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(32.0),
                      child: Text(
                        "This is the official tool to manage all Stratagems provided for the app BattleBre. You will need an account to modify the database. You can also continue as a guest with readonly priviledge.\n\nHappy gaming! 😊",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Column(
              children: [
                WindowTitleBarBox(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Expanded(child: MoveWindow()),
                      const WindowButtons(),
                    ],
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/icons/BattleBreGemsIcon.png',
                        width: 128,
                        height: 128,
                      ),
                      SizedBox(height: 24),
                      Text(
                        "Please sign in or create an account.",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 7,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 25.0,
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              border: Border.all(color: Colors.white),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: TextField(
                              controller: _emailController,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Email",
                                prefixIcon: Icon(Icons.email),
                                suffixIcon: _emailController.text.isNotEmpty
                                    ? IconButton(
                                        onPressed: _emailController.clear,
                                        icon: Icon(Icons.clear),
                                      )
                                    : null,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              border: Border.all(color: Colors.white),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: TextField(
                              controller: _passwordController,
                              obscureText: true,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Password",
                                prefixIcon: Icon(Icons.lock),
                                suffixIcon: _passwordController.text.isNotEmpty
                                    ? IconButton(
                                        onPressed: _passwordController.clear,
                                        icon: Icon(Icons.clear),
                                      )
                                    : null,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 8),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Checkbox(value: rememberMe, onChanged: (state) => handleRememberMeToggle(state)),
                                  Text("Remember me"),
                                ],
                              ),
                              TextButton(
                                onPressed: () {},
                                child: Text("Forgot password?"),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 16),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25.0),
                          child: ElevatedButton(
                            onPressed: signIn,
                            child: const Text("Sign In"),
                          ),
                        ),
                        SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("New here?"),
                            TextButton(
                              onPressed: () {
                                setState(() {
                                  _animatedInputBox = Column(
                                    key: Key("text2"),
                                    children: [
                                      TextField(
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: "Email2",
                                          prefixIcon: Icon(Icons.email),
                                        ),
                                      ),
                                      TextField(
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: "Email2",
                                          prefixIcon: Icon(Icons.email),
                                        ),
                                      ),
                                    ],
                                  );
                                });
                              },
                              child: Text("Create an Account"),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(children: <Widget>[
                            Expanded(
                              child: new Container(
                                  margin: const EdgeInsets.only(left: 10.0, right: 20.0),
                                  child: Divider(
                                    color: Colors.black,
                                    height: 24,
                                  )),
                            ),
                            Text("OR"),
                            Expanded(
                              child: new Container(
                                  margin: const EdgeInsets.only(left: 20.0, right: 10.0),
                                  child: Divider(
                                    color: Colors.black,
                                    height: 24,
                                  )),
                            ),
                          ]),
                        ),
                        SignInButton(
                          Buttons.Google,
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
