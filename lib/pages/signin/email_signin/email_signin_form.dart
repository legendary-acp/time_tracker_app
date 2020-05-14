import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:timetrackerapp/custom_widget/platform_alert_dialog.dart';
import 'package:timetrackerapp/pages/signin/email_signin/email_signin_bloc.dart';
import 'package:timetrackerapp/services/auth.dart';
import 'package:timetrackerapp/custom_widget/button.dart';
import 'package:timetrackerapp/pages/signin/email_signin/email_signin_model.dart';

class EmailSignInForm extends StatefulWidget {
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
      await widget.bloc.submit();
      Navigator.of(context).pop();
    } on PlatformException catch (e) {
      PlatformAlertDialog(
        title: 'Sigin failed',
        content: e.message,
        defaultActionText: 'OK',
      ).show(context);
    }
  }

  void _emailEditingComplete(EmailSignInModel model) {
    final newFocus = model.emailValidator.isValid(model.email)
        ? _passwordFocusNode
        : _emailFocusNode;
    FocusScope.of(context).requestFocus(newFocus);
  }

  void _toggleFormType() {
    widget.bloc.toggleFormType();
    _emailController.clear();
    _passwordController.clear();
  }

  List<Widget> _buildChildren(EmailSignInModel model) {
    if (model.isLoading == false) {
      return [
        _buildEmailTextField(model),
        SizedBox(height: 8.0),
        _buildPasswordTextField(model),
        SizedBox(height: 8.0),
        signin_custom_button(
          child: Text(
            model.primaryButtonText,
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.white,
            ),
          ),
          height: 40.0,
          color: Colors.indigo,
          onpress: model.canSubmit ? _submit : null,
        ),
        SizedBox(height: 8.0),
        FlatButton(
          child: Text(model.secondaryButtonText),
          onPressed: !model.isLoading ? _toggleFormType : null,
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

  TextField _buildPasswordTextField(EmailSignInModel model) {
    return TextField(
      controller: _passwordController,
      focusNode: _passwordFocusNode,
      decoration: InputDecoration(
        labelText: 'Password',
        errorText: model.passwordErrorText,
        enabled: model.isLoading == false,
      ),
      obscureText: true,
      textInputAction: TextInputAction.done,
      onChanged: widget.bloc.updatePassword,
      onEditingComplete: widget.bloc.submit,
    );
  }

  TextField _buildEmailTextField(EmailSignInModel model) {
    return TextField(
      controller: _emailController,
      focusNode: _emailFocusNode,
      decoration: InputDecoration(
        labelText: 'Email',
        hintText: 'test@test.com',
        errorText: model.emailErrorText,
        enabled: model.isLoading == false,
      ),
      autocorrect: false,
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      onChanged: widget.bloc.updateEmail,
      onEditingComplete: () => _emailEditingComplete(model),
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<EmailSignInModel>(
        stream: widget.bloc.modelStream,
        initialData: EmailSignInModel(),
        builder: (context, snapshot) {
          final EmailSignInModel model = snapshot.data;
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: _buildChildren(model),
            ),
          );
        });
  }
}
