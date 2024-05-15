import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../view_models/login_view_model.dart';

class LoginView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => LoginViewModel(),
      child: Consumer<LoginViewModel>(
        builder: (context, model, child) => Scaffold(
          body: SafeArea(
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    BackButton(
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                TextField(
                  onChanged: (value) => model.setEmail(value),
                  decoration: InputDecoration(labelText: 'Email'),
                ),
                TextField(
                  onChanged: (value) => model.setPassword(value),
                  decoration: InputDecoration(labelText: 'Password'),
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (await model.login()) {
                      Navigator.pushReplacementNamed(context, '/home');
                    } else {
                      // Show error
                    }
                  },
                  child: Text('Login'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}