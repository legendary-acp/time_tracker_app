import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:timetrackerapp/pages/signin/email_signin/email_signin_bloc.dart';
import 'package:timetrackerapp/services/auth.dart';
import 'package:timetrackerapp/services/validator.dart';
import 'package:timetrackerapp/custom_widget/button.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'email_signin_model.dart';


class EmailSignInForm extends StatefulWidget with EmailAndPasswordValidators {
  EmailSignInForm({@required this.bloc});

  final EmailSignInBloc bloc;

  static Widget create(BuildContext context) {
    final AuthBase auth = Provider.of<AuthBase>(context);
    return Provider<EmailSignInBloc>(
        create: (context) => EmailSignInBloc(auth: auth),
        child: Consumer<EmailSignInBloc>(
          builder: (context, bloc, _) => EmailSignInForm(bloc: bloc),
        ),
        dispose: (context, bloc) => bloc.dispose(),
    );
  }

  @override
  _EmailSignInFormState createState() => _EmailSignInFormState();
}

class _EmailSignInFormState extends State<EmailSignInForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  void _submit() async {

    try {
      final auth=Provider.of<AuthBase>(context, listen: false);
      if (_formType == EmailSignInFormType.signIn) {
        await auth.signInWithEmailAndPassword(_email, _password);
      } else {
        await auth.createUserWithEmailAndPassword(_email, _password);
      }
      Navigator.of(context).pop();
    } on PlatformException catch (e) {
      PlatformAlertDialog(
        title: 'Sigin failed',
        content: e.message,
        defaultActionText: 'OK',
      ).show(context);
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _emailEditingComplete() {
    final newFocus = widget.emailValidator.isValid(widget.bloc.email)
        ? _passwordFocusNode
        : _emailFocusNode;
    FocusScope.of(context).requestFocus(newFocus);
  }

  void _toggleFormType() {

    widget.bloc.updateWith(submitted: false,formType : widget.bloc.formType == EmailSignInFormType.signIn
        ? EmailSignInFormType.register
        : EmailSignInFormType.signIn)
    _emailController.clear();
    _passwordController.clear();
  }

  List<Widget> _buildChildren() {
    final primaryText = _formType == EmailSignInFormType.signIn
        ? 'Sign in'
        : 'Create an account';
    final secondaryText = _formType == EmailSignInFormType.signIn
        ? 'Need an account? Register'
        : 'Have an account? Sign in';

    bool submitEnabled = widget.emailValidator.isValid(_email) &&
        widget.passwordValidator.isValid(_password) &&
        !_isLoading;

    if (_isLoading == false) {
      return [
        _buildEmailTextField(),
        SizedBox(height: 8.0),
        _buildPasswordTextField(),
        SizedBox(height: 8.0),
        signin_custom_button(
          child: Text(
            primaryText,
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.white,
            ),
          ),
          height: 40.0,
          color: Colors.indigo,
          onpress: submitEnabled ? widget.bloc.submit : null,
        ),
        SizedBox(height: 8.0),
        FlatButton(
          child: Text(secondaryText),
          onPressed: !_isLoading ? _toggleFormType : null,
        ),
      ];
    } else {
      return [
        Column(
          children: <Widget>[
            SizedBox(height: 250),
            Center(
              child: SpinKitWave(
                color: Colors.blueGrey,
                size: 30.0,
              ),
            ),
          ],
        )
      ];
    }
  }

  TextField _buildPasswordTextField() {
    bool showErrorText =
        _submitted && !widget.passwordValidator.isValid(_password);
    return TextField(
      controller: _passwordController,
      focusNode: _passwordFocusNode,
      decoration: InputDecoration(
        labelText: 'Password',
        errorText: showErrorText ? widget.invalidPasswordErrorText : null,
        enabled: _isLoading == false,
      ),
      obscureText: true,
      textInputAction: TextInputAction.done,
      onChanged: (password) => _updateState(),
      onEditingComplete: widget.bloc.submit,
    );
  }

  TextField _buildEmailTextField() {
    bool showErrorText = _submitted && !widget.emailValidator.isValid(_email);
    return TextField(
      controller: _emailController,
      focusNode: _emailFocusNode,
      decoration: InputDecoration(
        labelText: 'Email',
        hintText: 'test@test.com',
        errorText: showErrorText ? widget.invalidEmailErrorText : null,
        enabled: _isLoading == false,
      ),
      autocorrect: false,
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      onChanged: (email) => _updateState(),
      onEditingComplete: _emailEditingComplete,
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<EmailSignInModel>(
        stream: widget.bloc.modelStream,
        builder: (context, snapshot) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: _buildChildren(),
            ),
          );
        }
    );
  }

  void _updateState() {
    setState(() {});
  }
}
