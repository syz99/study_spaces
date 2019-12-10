import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:study_spaces/util/authentication.dart';

class LoginSignupScreen extends StatefulWidget {
  LoginSignupScreen({this.auth, this.loginCallback});

  final BaseAuth auth;
  final VoidCallback loginCallback;

  @override
  State<StatefulWidget> createState() => LoginSignupScreenState();
}

class LoginSignupScreenState extends State<LoginSignupScreen> {
  final _formKey = new GlobalKey<FormState>();

  String _email;
  String _password;
  String _errorMessage;

  bool _isLoginForm;
  bool _isLoading;

  /// Validates user entered input in login/signup
  void validateAndSubmit() async {
    setState(() {
      _errorMessage = "";
      _isLoading = true;
    });

    if (validateAndSave()) {
      String userId = "";
      print("pre try catch");
      try {
        if (_isLoginForm) {
          print("_isLoginForm true");
          userId = await widget.auth.signIn(_email, _password);
          print('Signed in: $userId');
        } else {
          userId = await widget.auth.signUp(_email, _password);
          toggleFormMode();
          print('Signed up user: $userId');
        }

        setState(() {
          _isLoading = false;
        });

        if (userId.length > 0 && userId != null && _isLoginForm) {
          widget.loginCallback();
        }
      } catch (e) {
        print('Error: $e');
        setState(() {
          _isLoading = false;
          _errorMessage = e.message;
          _formKey.currentState.reset();
        });
      }
    }
  }

  /// Validates the form login/singup inputs
  bool validateAndSave() {
    final form = _formKey.currentState;
    print("pre validate()");
    if (form.validate()) {
      form.save();
      print("validate hit");
      return true;
    }
    return false;
  }

  /// initializes variables
  @override
  void initState() {
    _errorMessage = "";
    _isLoginForm = true;
    _isLoading = false;
    super.initState();
  }

  /// resets UI data
  void resetForm() {
    _formKey.currentState.reset();
    _errorMessage = "";
  }

  /// Toggles state of _isLoginForm (if not then it is sign up mode)
  void toggleFormMode() {
    resetForm();
    setState(() {
      _isLoginForm = !_isLoginForm;
    });
  }

  /// overridden build function
  @override
  Widget build(BuildContext context) {
    return new CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: new Text("Study Spaces Login"),
      ),
      child: Stack(
        children: <Widget>[
          showForm(),
          showCircularProgress(),
        ],
      ),
    );
  }

  /// Builds entire Login/Signup UI
  Widget showForm() {
    return new Container(
      padding: EdgeInsets.fromLTRB(45.0, 20.0, 45.0, 0.0),
      child: new Form(
        key: _formKey,
        child: new ListView(
          shrinkWrap: true,
          children: <Widget>[
            showLogo(),
            showEmailInput(),
            showPasswordInput(),
            showPrimaryButton(),
            showSecondaryButton(),
            showErrorMessage(),
          ],
        ),
      ),
    );
  }

  // WRITTEN BY JOSE: TESTS TO SEE IF FIELDS ARE EMPTY
  bool fieldsAreEmpty(){
    return (_myEmailField.text.isEmpty | _myPasswordField.text.isEmpty);
  }

  TextEditingController _myEmailField = TextEditingController();

  /// Builds TextFormField for email inputs
  Widget showEmailInput() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 100.0, 0.0, 0.0),
      child: new CupertinoTextField(
        controller: _myEmailField,
        prefix: Icon(Icons.mail, color: Colors.grey),
        placeholder: "Email",
        maxLines: 1,
        // input cannot exceed 1 line
        keyboardType: TextInputType.emailAddress,
        autofocus: false,
        decoration: BoxDecoration(
          border: Border(
              bottom:
                  BorderSide(width: 0.0, color: CupertinoColors.inactiveGray)),
        ),
        //validator: (value) => value.isEmpty ? 'Email can\'t be empty' : null,
        //onSaved: (value) => _email = value.trim(),
      ),
    );
  }

  /// Builds primary button for logging in/signing up
  Widget showPrimaryButton() {
    return new Padding(
      padding: EdgeInsets.fromLTRB(0.0, 45.0, 0.0, 0.0),
      child: SizedBox(
        height: 40.0,
        child: new RaisedButton(
          elevation: 5.0,
          shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(30.0),
          ),
          color: Colors.blue,
          child: new Text(_isLoginForm ? 'Login' : 'Create Account',
              style: new TextStyle(fontSize: 20.0, color: Colors.white)),
          onPressed: () {
            if(fieldsAreEmpty()){
              showCupertinoDialog(
                  context: context,
                  builder: (context) {
                    return CupertinoAlertDialog(
                      title: Text('error'),
                      content: Text('Email or Password are empty'),
                      actions: <Widget>[
                        FlatButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text('ok'))
                      ],
                    );
                  });
            }
            else {
              _email = _myEmailField.text.trim();
              _password = _myPasswordField.text.trim();
              validateAndSubmit();
            }
          },
        ),
      ),
    );
  }

  /// Builds secondary button for toggling between login/signup modes
  Widget showSecondaryButton() {
    return new FlatButton(
        child: new Text(
          _isLoginForm ? 'Create an account' : 'Have an account? Sign in',
          style: new TextStyle(fontSize: 18.0, fontWeight: FontWeight.w300),
        ),
        onPressed: () {
          if(fieldsAreEmpty()){
            showCupertinoDialog(
                context: context,
                builder: (context) {
                  return CupertinoAlertDialog(
                    title: Text('error'),
                    content: Text('Email or Password are empty'),
                    actions: <Widget>[
                      FlatButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text('ok'))
                    ],
                  );
                });
          } else {
            _email = _myEmailField.text.trim();
            _password = _myPasswordField.text.trim();
            toggleFormMode();
          }
        });
  }

  /// Builds error messages from Firebase or invalid input
  Widget showErrorMessage() {
    if (_errorMessage.length > 0 && _errorMessage != null) {
      return new Text(
        _errorMessage,
        style: TextStyle(
          fontSize: 13.0,
          color: Colors.red,
          height: 1.0,
          fontWeight: FontWeight.w300,
        ),
      );
    } else {
      return new Container(
        height: 0.0,
      );
    }
  }

  TextEditingController _myPasswordField = TextEditingController();

  /// Builds TextFormField for password inputs
  Widget showPasswordInput() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
      child: new CupertinoTextField(
        controller: _myPasswordField,
        prefix: Icon(Icons.lock, color: Colors.grey),
        maxLines: 1,
        placeholder: "Password",
        obscureText: true,
        autofocus: false,
        decoration: BoxDecoration(
          border: Border(
              bottom:
                  BorderSide(width: 0.0, color: CupertinoColors.inactiveGray)),
        ),
        //validator: (value) => value.isEmpty ? 'Password can\'t be empty' : null,
        //onSaved: (value) => _password = value.trim(),
      ),
    );
  }

  /// Returns Logo on Signup page
  Widget showLogo() {
    return new Hero(
      tag: 'hero',
      child: Padding(
        padding: EdgeInsets.fromLTRB(0.0, 70.0, 0.0, 0.0),
        child: CircleAvatar(
          backgroundColor: Colors.transparent,
          radius: 48.0,
          child: Image.asset('images/dukelogo.png'),
        ),
      ),
    );
  }

  /// Returns CircularProgresIndicator if loading is true
  Widget showCircularProgress() {
    if (_isLoading) {
      return Center(child: CircularProgressIndicator());
    }
    return Container(
      height: 0.0,
      width: 0.0,
    );
  }
}
