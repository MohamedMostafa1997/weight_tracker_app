import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weight_tracker_app/features/auth/business_logic/cubit/auth_cubit.dart';
import 'package:weight_tracker_app/core/routing/routes.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [Color(0xFFB983FF) , Color(0xFF8A6EFF)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter
          
        ),
      ),
      child: SafeArea(child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.fitness_center,size: 90,color: Colors.white,),
          SizedBox(height: 30,),
          Text("Welcome to Weight Tracker" , 
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold 
          ),
          ),
          Text("Track your progress and stay motivated" , 
          style: TextStyle(
            color: Colors.white70
          ),
          ),
          SizedBox(height: 60,),
          BlocConsumer<AuthCubit,AuthState>(
            listener: (context,state){
              if (state is AuthSuccess){
                Navigator.pushReplacementNamed(context, Routes.weight);
              } else if (state is AuthFailure){
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
              }
            },
            builder: (context , state) {
              if ( state is AuthLoading){
                return CircularProgressIndicator(
                  color: Colors.white,
                );
              }
              return ElevatedButton.icon(
                onPressed : () {
                  context.read<AuthCubit>().signInWithGoogle();
                },
                icon: Image.asset("resources/images/google.png" , height: 24,),
                label: Text("Sign in with Google", style: TextStyle(fontSize: 16 , fontWeight: FontWeight.w600),),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black87,
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                  shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(12))

                ),

                
                ) ;
            },
            )
        ],
      )),
      )
    );
  }
}