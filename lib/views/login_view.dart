import 'package:flutter/material.dart';
import 'package:kraftig/view_components/text_link.dart';
import 'package:provider/provider.dart';

import '../view_components/primary_button.dart';
import '../view_models/login_view_model.dart';
import '../resources/constants.dart';

class LoginView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<LoginViewModel>(
      builder: (context, model, child) => Container(
        decoration: AppViewBackgrounds.mainViewBackground,
        child: Scaffold (
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            centerTitle: true,
            leading: BackButton(
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            backgroundColor: Colors.transparent,
            title: 
              const Text(
                'Login', 
                style: AppTextStyles.headLine,
              ),
          ),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(
                top: AppPadding.small,
                left: AppPadding.extraLarge,
                right: AppPadding.extraLarge,
              ), 
              child: Column (
                children: [
                  Expanded(
                    child: Column(
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
                            if (!context.mounted) return;
                            if (success) {
                              Navigator.pop(context);
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: 
                                  Text(model.errorMessage?? 'Login failed'),
                                ),
                              );
                            }
                          }
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Don\'t have an acoount yet?'),
                      TextLink(
                        text: 'Sign up', 
                        onPressed: () {
                          Navigator.popAndPushNamed(context, '/signup');
                        }
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}