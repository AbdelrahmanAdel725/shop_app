// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, must_be_immutable, prefer_const_literals_to_create_immutables, avoid_print, avoid_unnecessary_containers

import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_projects/layout/shop_app/login/cubit/cubit.dart';
import 'package:flutter_projects/layout/shop_app/login/cubit/states.dart';
import 'package:flutter_projects/layout/shop_app/shop_layout.dart';
import 'package:flutter_projects/modules/shop_app/products/products_screen.dart';
import 'package:flutter_projects/modules/shop_app/register/shop_register_screen.dart';
import 'package:flutter_projects/shared/components/components.dart';
import 'package:flutter_projects/shared/network/local/cache_helper.dart';
import 'package:flutter_projects/shared/styles/colors.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ShopLoginScreen extends StatelessWidget {
  var emailController = TextEditingController();
  var passController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit, ShopLoginStates>(
        listener: (BuildContext context, Object? state)
        {
          if(state is ShopLoginSuccessState)
          {
             if(state.loginModel.status!)
             {
               print(state.loginModel.message);
               print(state.loginModel.data?.token);
               CacheHelper.saveData(key: 'token', value: state.loginModel.data?.token).then((value)
               {
                 Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>ShopLayout()));
               });
               showToast(msg: state.loginModel.message!, state: ToastStates.SUCCESS);
               
             }else
             {
               print(state.loginModel.message);
               showToast(msg: state.loginModel.message!, state: ToastStates.ERROR);
             }
          }

        },
        builder: (BuildContext context, Object? state) {
          return Scaffold(
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
                          Text('LOGIN',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  ?.copyWith(
                                    fontSize: 70,
                                  )),
                          Text(
                            'Login now to browse our hot offers',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1
                                ?.copyWith(color: Colors.grey, fontSize: 25),
                          ),
                          SizedBox(
                            height: 25.0,
                          ),
                          TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Email must not be empty';
                              }
                              return null;
                            },
                            onFieldSubmitted: (String value) {
                              print(value);
                            },
                            onChanged: (String value) {
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
                          SizedBox(
                            height: 15.0,
                          ),
                          TextFormField(
                            onChanged: (value){print(value);},
                            onFieldSubmitted: (value) {
                              if (formKey.currentState!.validate()) {
                                ShopLoginCubit.get(context).userLogin(
                                    email: emailController.text,
                                    password: passController.text);
                                print(value);
                              }
                            },
                            keyboardType: TextInputType.text,
                            validator: (String? value) {
                              if (value!.isEmpty) {
                                return 'Password is too short';
                              }
                              return null;
                            },
                            controller: passController,
                            obscureText: ShopLoginCubit.get(context).isPassword,
                            decoration: InputDecoration(
                              suffixIcon: IconButton(onPressed: (){
                                ShopLoginCubit.get(context).changePasswordVisibility();
                              }, icon: Icon(Icons.visibility),),
                              prefixIcon: Icon(Icons.lock),
                              labelText: 'Password',
                              border: OutlineInputBorder(),
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(5.0)),
                            child: ConditionalBuilder(
                              condition: state is! ShopLoginLoadingState,
                              builder: (context) => TextButton(
                                  onPressed: () {
                                    if (formKey.currentState!.validate()) {
                                      ShopLoginCubit.get(context).userLogin(
                                          email: emailController.text,
                                          password: passController.text);}
                                    navigateAndFinish(context, ShopLayout());},
                                  child: Text(
                                    'Login'.toUpperCase(),
                                    style: TextStyle(color: Colors.white),
                                  )),
                              fallback: (context) =>
                                  Center(child: CircularProgressIndicator()),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Don\'t have an account ?'),
                              SizedBox(
                                width: 1.0,
                              ),
                              textButton(
                                  function: () {navigateTo(context, RegisterScreen());},
                                  text: 'register'.toUpperCase()),
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
