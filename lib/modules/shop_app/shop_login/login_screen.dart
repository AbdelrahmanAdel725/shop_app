// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, must_be_immutable, prefer_const_literals_to_create_immutables, avoid_print, avoid_unnecessary_containers

import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_projects/layout/shop_app/login/cubit/cubit.dart';
import 'package:flutter_projects/layout/shop_app/login/cubit/states.dart';
import 'package:flutter_projects/modules/shop_app/register/shop_register_screen.dart';
import 'package:flutter_projects/shared/components/components.dart';
import 'package:flutter_projects/shared/styles/colors.dart';

class ShopLoginScreen extends StatelessWidget {
  var emailController = TextEditingController();
  var passController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (BuildContext context) => ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit,ShopLoginStates>(
        listener: (BuildContext context, Object? state) {  },
        builder: (BuildContext context, Object? state) {
          return  Scaffold(
            appBar: AppBar(),
            body: Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Center(
                  child: SingleChildScrollView(
                    child: Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('LOGIN',style: Theme.of(context).textTheme.bodyText1?.copyWith(
                            fontSize: 70,
                          )),
                          Text('Login now to browse our hot offers',
                            style: Theme.of(context).textTheme.bodyText1?.copyWith(color: Colors.grey,fontSize: 25),),
                          SizedBox(
                            height: 25.0,
                          ),
                          TextFormField(
                            validator: (value)
                            {
                              if(value!.isEmpty)
                              {
                                 return 'Email must not be empty';
                              }
                              return null;
                            },
                            onFieldSubmitted: (String value)
                            {
                              print(value);
                            },
                            onChanged: (String value)
                            {
                              print(value);
                            },
                            keyboardType: TextInputType.emailAddress,
                            controller: emailController,
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.email),
                              labelText: 'Email Address',
                              border: OutlineInputBorder(),
                            ),
                          ),
                          SizedBox(height: 15.0,),
                          TextFormField(
                            keyboardType: TextInputType.text,
                            validator: (String? value)
                            {
                              if(value!.isEmpty)
                              {
                                return 'Password is to short';
                              }
                              return null;
                            },
                            controller:passController,
                            decoration: InputDecoration(
                              suffixIcon: Icon(Icons.remove_red_eye),
                              prefixIcon: Icon(Icons.lock),
                              labelText: 'Password',
                              border: OutlineInputBorder(),
                            ),
                          ),
                          SizedBox(height: 30,),
                          Container(

                            width: double.infinity,
                            decoration: BoxDecoration(color: Colors.blue,borderRadius: BorderRadius.circular(5.0)
                            ),
                            child: ConditionalBuilder(
                              condition: state is! ShopLoginLoadingState,
                              builder: (context) => TextButton(
                                  onPressed: ()
                                  {
                                    if(formKey.currentState!.validate())
                                    {
                                      ShopLoginCubit.get(context).userLogin(
                                          email: emailController.text,
                                          password: passController.text
                                      );
                                    }
                                  },
                                  child: Text('Login'.toUpperCase(),style: TextStyle(color: Colors.white),)
                              ),
                              fallback: (context) => Center(child: CircularProgressIndicator()),
                            ),
                          ),
                          SizedBox(height: 15,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children:
                            [
                              Text('Don\'t have an account ?'),
                              SizedBox(width: 1.0,),
                              textButton(function: (){}, text: 'LOGIN'.toUpperCase()),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },

      ),
    );
  }
}
