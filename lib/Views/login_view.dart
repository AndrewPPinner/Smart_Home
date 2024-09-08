import 'package:aa_smart_home/Services/api_service.dart';
import 'package:aa_smart_home/main.dart';
import 'package:flutter/material.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key, required this.title});

  final String title;

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  static final _apiService = APIService();

  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  var _errorMessage = "";
  bool? isChecked = false;

  Future<bool> _login(String user, String pass) async {
    var isLoggedIn = false;
    var errorMessage = "";
    try {
      isLoggedIn = await _apiService.loginUser(user, pass, isChecked);
    } on Exception catch (e) {
      errorMessage = e.toString();
    }

    setState(() {
      _errorMessage = errorMessage;
    });
    return isLoggedIn;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                AutofillGroup(
                    child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 16),
                      child: TextFormField(
                        controller: _usernameController,
                        autofillHints: const <String>[AutofillHints.username],
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "Username"),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your username';
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 16),
                      child: TextFormField(
                        controller: _passwordController,
                        obscureText: true,
                        autofillHints: const <String>[AutofillHints.password],
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "Password"),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 16),
                        child: Row(children: [
                          const Text("Stay Signed In?"),
                          Center(
                            child: Checkbox(
                              value: isChecked,
                              onChanged: (bool? value) {
                                setState(() {
                                  isChecked = value;
                                });
                              },
                            ),
                          ),
                        ])),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 16.0),
                      child: Center(
                        child: ElevatedButton(
                          onPressed: () async {
                            var isSuccess = await _login(
                                _usernameController.text,
                                _passwordController.text);
                            if (context.mounted) {
                              if (_formKey.currentState!.validate() &&
                                  isSuccess) {
                                // Navigate the user to the Home page
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const MyHomePage(
                                            title: "Dashboard",
                                          )),
                                );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text(_errorMessage)));
                              }
                            }
                          },
                          child: const Text('Submit'),
                        ),
                      ),
                    ),
                  ],
                ))
              ],
            ),
          ),
        ));
  }
}
