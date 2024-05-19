import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../resources/constants.dart';
import '../view_models/home_view_model.dart';
import '../view_components/primary_button.dart';


class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeViewModel>(
      builder: (context, model, child) => Container(
        decoration: AppViewBackgrounds.mainViewBackground,
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                model.isLoggedIn
                ? PrimaryButton(
                  text: '👤 Profile', 
                  onPressed: () {
                    if (kDebugMode) {
                        print('Profile button pressed');
                      }
                    Navigator.pushNamed(context, '/profile');
                  },
                )
                : PrimaryButton(
                  text: '🔑 Login', 
                  onPressed: () {
                    if (kDebugMode) {
                        print('Login button pressed');
                      }
                    Navigator.pushNamed(context, '/login');
                  },
                ),
              ],
            )    
          ),
          body: const Center(
            child: SafeArea(
              child: Column(
                children: <Widget>[
                  SizedBox(height: AppPadding.small),
                  Text(
                    'Welcome to Kraftig!',
                    style: AppTextStyles.title
                  ),
                  SizedBox(height: AppPadding.medium),
                  Text(
                    'Home page', 
                    style: AppTextStyles.headline,
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