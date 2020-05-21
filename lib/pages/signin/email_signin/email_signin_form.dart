import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:timetrackerapp/custom_widget/platform_alert_dialog.dart';
import 'package:timetrackerapp/services/auth.dart';
import 'package:timetrackerapp/custom_widget/button.dart';
import 'package:timetrackerapp/pages/signin/email_signin/email_signin_model.dart';

class EmailSignInForm extends StatefulWidget {
  EmailSignInForm({@required this.model});

  final EmailSignInModel model;

  static Widget create(BuildContext context) {
    final AuthBase auth = Provider.of<AuthBase>(context);
    return ChangeNotifierProvider<EmailSignInModel>(
      create: (context) => EmailSignInModel(auth: auth),
      child: Consumer<EmailSignInModel>(
        builder: (context, model, _) => EmailSignInForm(model: model),
      ),
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
      await widget.model.submit();
      Navigator.of(context).pop();
    } on PlatformException catch (e) {
      PlatformAlertDialog(
        title: 'Sign in failed',
        content: e.message,
        defaultActionText: 'OK',
      ).show(context);
    }
  }

  void _emailEditingComplete() {
    final newFocus = widget.model.emailValidator.isValid(widget.model.email)
        ? _passwordFocusNode
        : _emailFocusNode;
    FocusScope.of(context).requestFocus(newFocus);
  }

  void _toggleFormType() {
    widget.model.toggleFormType();
    _emailController.clear();
    _passwordController.clear();
  }

  List<Widget> _buildChildren() {
    if (widget.model.isLoading == false) {
      return [
        _buildEmailTextField(),
        SizedBox(height: 8.0),
        _buildPasswordTextField(),
        SizedBox(height: 8.0),
        signin_custom_button(
          child: Text(
            widget.model.primaryButtonText,
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.white,
            ),
          ),
          height: 40.0,
          color: Colors.indigo,
          onpress: widget.model.canSubmit ? _submit : null,
        ),
        SizedBox(height: 8.0),
        FlatButton(
          child: Text(widget.model.secondaryButtonText),
          onPressed: !widget.model.isLoading ? _toggleFormType : null,
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
    return TextField(
      controller: _passwordController,
      focusNode: _passwordFocusNode,
      decoration: InputDecoration(
        labelText: 'Password',
        errorText: widget.model.passwordErrorText,
        enabled: widget.model.isLoading == false,
      ),
      obscureText: true,
      textInputAction: TextInputAction.done,
      onChanged: widget.model.updatePassword,
      onEditingComplete: widget.model.submit,
    );
  }

  TextField _buildEmailTextField() {
    return TextField(
      controller: _emailController,
      focusNode: _emailFocusNode,
      decoration: InputDecoration(
        labelText: 'Email',
        hintText: 'test@test.com',
        errorText: widget.model.emailErrorText,
        enabled: widget.model.isLoading == false,
      ),
      autocorrect: false,
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      onChanged: widget.model.updateEmail,
      onEditingComplete: () => _emailEditingComplete(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: _buildChildren(),
      ),
    );
  }
}
