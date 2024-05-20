import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../resources/constants.dart';
import '../view_components/primary_button.dart';
import '../view_models/signup_view_model.dart';

class SignupView extends StatelessWidget {
  const SignupView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SignupViewModel>(
      builder: (context, model, child) => Container(
        decoration: AppViewBackgrounds.mainViewBackground,
        child: Scaffold(
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
                'Create an account', 
                style: AppTextStyles.headline,
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
                  TextField(
                    onChanged: (value) => model.setUsername(value),
                    decoration: InputDecoration(
                      labelText: 'Phone number',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(AppBorderRadius.medium),
                      ),
                    ),
                    style: AppTextStyles.body,
                    keyboardType: TextInputType.phone,
                  ),
                  const SizedBox(height: AppPadding.medium),
                  TextField(
                    onChanged: (value) => model.setPassword(value),
                    decoration: InputDecoration(
                      labelText: 'Password',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(AppBorderRadius.medium),
                      ),
                    ),
                    style: AppTextStyles.body,
                    obscureText: true,
                  ),
                  const SizedBox(height: AppPadding.large),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      PrimaryButton(
                        text: 'Sign Up', 
                        onPressed: () async {
                          bool success = await model.signup();
                          if (!context.mounted) return;
                          if (success) {
                            Navigator.pop(context);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: 
                                Text(model.errorMessage?? 'Sign up failed'),
                              ),
                            );
                          }
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