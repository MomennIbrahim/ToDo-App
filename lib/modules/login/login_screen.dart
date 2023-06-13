import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/layout/cubit.dart';
import 'package:to_do_app/layout/layout_screen.dart';
import 'package:to_do_app/modules/login/login_cubit.dart';
import 'package:to_do_app/modules/login/login_state.dart';
import '../../share/components.dart';
import '../../share/const.dart';
import '../../share/local/cache_helper.dart';
import '../register/register_screen.dart';


class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  var emailController = TextEditingController();
  var passController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ToDoLoginCubit(),
      child: BlocConsumer<ToDoLoginCubit, ToDoLoginState>(
        listener: (context, state) {
          
          if (state is ToDoLoginSuccessState) {
            CacheHelper.saveData(key: 'uId', value: state.uId).then((value) {
              navigateAndFinish(context, const LayoutScreen());
              uId = state.uId;
              ToDoCubit.get(context).getUserData();
              ToDoCubit.get(context).getTodoList();
              successSnackBar(context: context, text: 'Login Successfully');
            });
          } else if (state is ToDoLoginErrorState) {
            if (state.error.toString() ==
                '[firebase_auth/invalid-email] The email address is badly formatted.') {
              errorSnackBar(
                  context: context,
                  text: 'The email address is badly formatted');
            } else if (state.error.toString() ==
                '[firebase_auth/user-not-found] There is no user record corresponding to this identifier. The user may have been deleted.') {
              errorSnackBar(
                  context: context,
                  text:
                      'here is no user record corresponding to this identifier');
            } else if (state.error.toString() ==
                '[firebase_auth/wrong-password] The password is invalid or the user does not have a password.') {
              errorSnackBar(context: context, text: 'The password is invalid');
            }else if (state.error.toString()=='[firebase_auth/network-request-failed] A network error (such as timeout, interrupted connection or unreachable host) has occurred.'){
              errorSnackBar(context: context, text: 'Check your internet connection');
            }
          }
        },
        builder: (context, state) {
          return Scaffold(
            body: GestureDetector(
              onTap: () {
                // requestFocus(context);
              },
              child: Container(
                height: double.infinity,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/greenImage.jpg'),
                        fit: BoxFit.cover)),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(
                            height: 50.0,
                          ),
                          defaultText(
                              text: 'User Login',
                              size: 30,
                              color: Colors.white),
                          const SizedBox(
                            height: 10,
                          ),
                          const Icon(
                            Icons.login,
                            size: 50.0,
                            color: Colors.white,
                          ),
                          const SizedBox(
                            height: 70.0,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.0),
                                color: Colors.white70),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                children: [
                                  defaultTextFormField(
                                    controller: emailController,
                                    context: context,
                                    keyBoardTyp: TextInputType.emailAddress,
                                    text: 'email address',
                                    prefixIcon: const Icon(Icons.email),
                                    validateText: 'email field is empty',
                                    onSubmitted: () {},
                                  ),
                                  const SizedBox(
                                    height: 20.0,
                                  ),
                                  defaultTextFormField(
                                    controller: passController,
                                    context: context,
                                    keyBoardTyp: TextInputType.visiblePassword,
                                    text: 'password',
                                    obscure:
                                        ToDoLoginCubit.get(context).isPassword,
                                    prefixIcon: const Icon(Icons.lock),
                                    validateText: 'password field is empty',
                                    suffixIcon: IconButton(
                                        onPressed: () {
                                          ToDoLoginCubit.get(context)
                                              .isChange();
                                        },
                                        icon: Icon(ToDoLoginCubit.get(context)
                                            .suffix)),
                                    onSubmitted: () {},
                                  ),
                                  const SizedBox(
                                    height: 30.0,
                                  ),
                                  state is ToDoLoginLoadingState? const Center(child: CircularProgressIndicator(strokeWidth: 1.5,)):
                                  defaultMaterialButton(
                                      onPressed: () {
                                        if (formKey.currentState!.validate()) {
                                          ToDoLoginCubit.get(context).userLogin(
                                            email: emailController.text,
                                            password: passController.text,
                                          );
                                        }
                                      },
                                      text: 'login',
                                      isUpperCase: true),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        child: defaultText(
                                            text: 'don\'t have an account?',
                                            size: 12.0),
                                      ),
                                      defaultTextButton(
                                          onPressed: () {
                                            navigateAndReplace(context,
                                                const RegisterScreen());
                                          },
                                          text: 'Register',
                                          fontWeight: FontWeight.bold,
                                          size: 16.0),
                                    ],
                                  ),
                                ],
                              ),
                            ),
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
