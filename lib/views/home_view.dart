import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:kraftig/resources/constants.dart';
import 'package:kraftig/view_models/home_view_model.dart';
import 'package:kraftig/view_components/primary_button.dart';
import 'package:provider/provider.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<HomeViewModel>(
      builder: (context, model, child) => Container(
        decoration: AppViewBackgrounds.mainViewBackground,
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            title: 
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  PrimaryButton(
                    text: 'Login', 
                    onPressed: () {
                      if (kDebugMode) {
                          print('Login button pressed');
                        }
                        Navigator.pushNamed(context, '/login');
                    }
                  )
              ],
            )    
          ),
          body: Center(
            child: SafeArea(
              child: Column(
                children: <Widget>[
                  const SizedBox(height: AppPadding.small),
                  Title(
                    color: AppColors.textHighEmphasis,
                    child: 
                      const Text(
                        'Welcome to Kraftig!',
                        style: AppTextStyles.title
                      )
                  ),
                  const SizedBox(height: AppPadding.medium),
                  const Text(
                    'Home page', 
                    style: AppTextStyles.headLine,
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