import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'login_state.dart';

class ToDoLoginCubit extends Cubit<ToDoLoginState> {
  ToDoLoginCubit() : super(InitialLoginState());

  static ToDoLoginCubit get(context) => BlocProvider.of(context);

  bool isPassword = true;
  IconData suffix = Icons.remove_red_eye;

  void isChange() {
    isPassword = !isPassword;
    isPassword
        ? suffix = Icons.remove_red_eye
        : suffix = Icons.remove_red_eye_outlined;
    emit(ShowPassState());
  }


  void userLogin({
    required String email,
    required String password,
}) {
    emit(ToDoLoginLoadingState());
    FirebaseAuth.instance
        .signInWithEmailAndPassword(
        email: email,
        password: password)
        .then((value) {
          emit(ToDoLoginSuccessState(value.user!.uid));
    })
        .catchError((error) {
      emit(ToDoLoginErrorState(error.toString()));
      print(error.toString());
    });
  }


  // final googleSignIn = GoogleSignIn();
  // GoogleSignInAccount? _user;
  // GoogleSignInAccount get user => _user!;
  //
  // Future googleLogin() async {
  //   final googleUser = await googleSignIn.signIn();
  //   if(googleUser == null) return;
  //   _user = googleUser;
  //
  //   final googleAuth = await googleUser.authentication;
  //   final credential = GoogleAuthProvider.credential(
  //     accessToken: googleAuth.accessToken,
  //     idToken: googleAuth.idToken,
  //   );
  //
  //   await FirebaseAuth.instance.signInWithCredential(credential);
  //   emit(CreateUsersWithGoogleSuccessState());
  // }
}
