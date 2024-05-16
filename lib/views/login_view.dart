import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../view_components/primary_button.dart';
import '../view_models/login_view_model.dart';
import '../resources/constants.dart';

class LoginView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<LoginViewModel>(
      builder: (context, model, child) => Scaffold(
        body: Container(
          decoration: AppViewBackgrounds.mainViewBackground,
          child: SafeArea(
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
                Padding(
                  padding: const EdgeInsets.only(
                    top: AppPadding.small,
                    left: AppPadding.large,
                    right: AppPadding.large,
                  ), 
                  child: Column (
                    children: [
                      TextField(
                        onChanged: (value) => model.setUsermame(value),
                        decoration: const InputDecoration(labelText: 'Phone number'),
                      ),
                      TextField(
                        onChanged: (value) => model.setPassword(value),
                        decoration: const InputDecoration(labelText: 'Password'),
                        obscureText: true,
                      ),
                      const SizedBox(height: AppPadding.large),
                      PrimaryButton(
                        text: 'Login', 
                        onPressed: () async {
                          bool success = await model.login();
                          if (success) {
                            Navigator.pop(context);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                              content: 
                                Text('Login failed')
                              ),
                            );
                          }
                        }
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}