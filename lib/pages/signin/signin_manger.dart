import 'package:flutter/widgets.dart';
import 'package:timetrackerapp/services/auth.dart';
import 'dart:async';

class SignInManager {
  SignInManager({@required this.auth, @required this.isLoading});

  final AuthBase auth;
  final ValueNotifier<bool> isLoading;

  Future<User> _signIn(Future<User> Function() signInMethod) async{
    try{
      isLoading.value = true;
      return await signInMethod();
    }catch(e){
      isLoading.value = false;
      rethrow;
    }
  }

  Future<void> signInAnonymously() async {
    await _signIn(auth.signInAnonymously);
  }

  Future<void> signInWithGoogle() async {
    await _signIn(auth.signInWithGoogle);
  }

  Future<void> signInWithFacebook() async {
    await _signIn(auth.signInWithFacebook);
  }
}
