import 'package:flutter/material.dart';
import 'package:kraftig/view_models/home_view_model.dart';
import 'package:provider/provider.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeViewModel>(
      create: (_) => HomeViewModel(),
      child:  Consumer<HomeViewModel>(
        builder: (context, model, child) => Scaffold(
          appBar: AppBar(
            title: 
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        print('Login button pressed');
                        Navigator.pushNamed(context, '/login');
                      },
                      child: Text('Login'),
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Color(0xFFfff19b), 
                        backgroundColor: Color(0xFA35FFE2))
                    ),
              ],
            )    
          ),
          body: Center(
            child: SafeArea(
              child: Column(
                children: <Widget>[
                  Title(
                    color: Colors.black,
                    child: 
                      Text('Welcome to Kraftig')
                  ),
                  Text('Home Page'),
                ],
              ), 
            )
            
          ),
        ),
      ),
    );
  }
}