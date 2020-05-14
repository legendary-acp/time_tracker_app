import 'package:flutter/widgets.dart';
import 'package:timetrackerapp/services/auth.dart';
import 'dart:async';

class SignInBloc {
  SignInBloc({@required this.auth});

  final AuthBase auth;
  final StreamController<bool> _isLoadingController = StreamController<bool>();

  Stream<bool> get isLoadingStream => _isLoadingController.stream;

  void dispose() {
    _isLoadingController.close();
  }

  void _setIsLoading(bool isLoading) => _isLoadingController.add(isLoading);

  Future<User> _signIn(Future<User> Function() signInMethod) async{
    try{
      _setIsLoading(true);
      return await signInMethod();
    }catch(e){
      _setIsLoading(false);
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
