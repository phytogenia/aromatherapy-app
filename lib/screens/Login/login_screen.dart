import 'package:aromatherapy/components/primary_sign_button.dart';
import 'package:aromatherapy/components/primary_textformfield.dart';
import 'package:aromatherapy/screens/ForgotPassword/ForgotPassword.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';

import '../../components/platform_exception_alert_dialog.dart';
import '../../components/primary_socialmedia_button.dart';
import '../../components/url_text.dart';
import '../../services/auth_service.dart';

abstract class SignType {
  static int get login => 0;
  static int get signup => 1;
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordConfirmController =
      TextEditingController();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  final FocusNode _passwordConfirmFocusNode = FocusNode();

  String get _email => _emailController.text;
  set _email(String value) {
    _emailController.text = value;
  }

  String get _password => _passwordController.text;
  set _password(String value) {
    _passwordController.text = value;
  }

  String get _passwordRepeat => _passwordConfirmController.text;
  set _passwordRepeat(String value) {
    _passwordConfirmController.text = value;
  }

  void _onAuth(BuildContext context, Function authMethod) async {
    try {
      setState(() => _isLoading = true);
      await authMethod(context);
    } on PlatformException catch (e) {
      if (e.code != 'ERROR_MISSING_GOOGLE_TOKEN' &&
          e.code != 'ERROR_MISSING_FACEBOOK_TOKEN') {
        _showErrorDialog(context: context, exception: e);
        setState(() => _isLoading = false);
      }
      print(e);
    } finally {
      if (authMethod == _emailAuth) {
        setState(() => _isLoading = false);
      }
    }
  }

  void _showErrorDialog(
      {String title = 'Sign in Failed',
      required PlatformException exception,
      required BuildContext context}) {
    PlatformExceptionAlertDialog(
      title: title,
      exception: exception,
    ).show(context);
  }

  void _anonymousAuth(BuildContext context) async {
    final authProvider = context.read<AuthService>();
    await authProvider.signInAnonymously();
  }

  void _googleAuth(BuildContext context) async {
    final authProvider = context.read<AuthService>();
    await authProvider.signInWithGoogle();
  }

  _facebookAuth(BuildContext context) async {
    final authProvider = context.read<AuthService>();
    await authProvider.signInWithFacebook();
  }

  _emailAuth(BuildContext context, String email, String password) async {
    //TODO:: implement
  }

  @override
  void dispose() {
    _emailController.dispose();
    _emailFocusNode.dispose();
    _passwordController.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  bool _isFormSubmitted = false;
  bool _isLoading = false;

  bool isObscure = true;
  int selectedSignType = SignType.login;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      body: SafeArea(
        bottom: false,
        top: false,
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.3,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.vertical(
                        bottom: Radius.elliptical(
                            MediaQuery.of(context).size.width, 130.0)),
                    image: DecorationImage(
                        colorFilter: ColorFilter.mode(
                            Color(0xff61BB46).withOpacity(.8),
                            BlendMode.srcOver),
                        image: const AssetImage('assets/images/pictop.jpg'),
                        fit: BoxFit.cover)),
                child: Center(
                  child: Image.asset('assets/images/intersect.png'),
                ),
              ),
              Positioned(
                  bottom: 0,
                  right: 0,
                  child: Image.asset('assets/images/picbottom.png')),
              Positioned(
                left: 20,
                right: 20,
                top: MediaQuery.of(context).size.height * 0.2,
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.65,
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey,
                            offset: Offset(2, 2),
                            blurRadius: 16)
                      ]),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 30),
                    child: SingleChildScrollView(child: _bodyContent(context)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _bodyContent(BuildContext context) {
    String _textSubmitButton =
        (selectedSignType == SignType.login) ? 'Login' : 'Sign Up';

    return Column(
      children: [
        Image.asset('assets/images/logo2.png'),
        const SizedBox(height: 8),
        DefaultTabController(
          initialIndex: selectedSignType,
          length: 2,
          child: Container(
            height: 40,
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(100)),
                border:
                    Border.all(color: Colors.grey.withOpacity(.4), width: 1)),
            child: TabBar(
              onTap: (int index) {
                isObscure = true;
                selectedSignType = index;
                _updateState();
              },
              //indicatorColor: Color(0xff61BB46),
              tabs: const [
                Tab(
                  text: "Log in",
                ),
                Tab(
                  text: "Sign up",
                ),
              ],
              unselectedLabelColor: const Color(0xff61BB46),
              labelColor: Colors.white,
              indicator: RectangularIndicator(
                color: const Color(0xff61BB46),
                bottomLeftRadius: 100,
                bottomRightRadius: 100,
                topLeftRadius: 100,
                topRightRadius: 100,
              ),
            ),
          ),
        ),
        const SizedBox(height: 30),
        selectedSignType == SignType.login
            ? _buildLoginForm()
            : _buildSignupForm(),
        const SizedBox(height: 20),
        Align(
          alignment: Alignment.topRight,
          child: InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ForgotPassword()));
            },
            child: const Text(
              'Forgot your password ?',
              style: TextStyle(
                  color: Color(0xff61BB46), fontWeight: FontWeight.bold),
            ),
          ),
        ),
        const SizedBox(height: 20),
        PrimarySignButton(
          onTap: _submit,
          text: _textSubmitButton,
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Expanded(
                child: Divider(
              indent: 70,
            )),
            SizedBox(width: 5),
            Text(
              'Or',
              style: TextStyle(color: Colors.grey),
            ),
            SizedBox(width: 5),
            Expanded(
                child: Divider(
              endIndent: 70,
            ))
          ],
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            PrimarySocialMediaButton(
              imagePath: 'assets/images/facebook.png',
              onTap: () => () => _onAuth(context, _googleAuth), //TODO: facebook
            ),
            const SizedBox(width: 15),
            PrimarySocialMediaButton(
              imagePath: 'assets/images/apple.png',
              onTap: () => () => _onAuth(context, _googleAuth), //TODO: facebook
            ),
            const SizedBox(width: 15),
            PrimarySocialMediaButton(
              imagePath: 'assets/images/google.png',
              onTap: () => _onAuth(context, _googleAuth),
            ),
          ],
        ),
        const SizedBox(height: 25),
        _buildFooter(),
      ],
    );
  }

  Widget _buildFooter() {
    return Column(children: [
      const Text(
        'By segning up, you agree to Aromatherapy\'s',
      ),
      Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          UrlText(
            text: 'Terms of Service',
            url: 'https://google.com/', //TODO:: to replace
          ),
          const Text(
            ' and ',
          ),
          UrlText(
            text: 'Privacy Policy',
            url: 'https://google.com/', //TODO:: to replace
          ),
        ],
      )
    ]);
  }

  Form _buildLoginForm() {
    return Form(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          PrimaryTextFormField(
            labelText: 'Email',
            hintText: 'Enter you Email',
            focusNode: _emailFocusNode,
            onEditingComplete: _onCompleteEmailEditing,
            controller: _emailController,
          ),
          PrimaryTextFormField(
            isPasswordField: true,
            labelText: 'Password',
            hintText: 'Enter you password',
            focusNode: _passwordFocusNode,
            onEditingComplete: _onCompletePasswordEditing,
            controller: _passwordController,
            keyboardType: TextInputType.visiblePassword,
          ),
        ],
      ),
    );
  }

  Form _buildSignupForm() {
    return Form(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          PrimaryTextFormField(
            labelText: 'Email',
            hintText: 'Enter you Email',
            isPasswordField: false,
            focusNode: _emailFocusNode,
            onEditingComplete: _onCompleteEmailEditing,
            controller: _emailController,
          ),
          PrimaryTextFormField(
            isPasswordField: true,
            labelText: 'Password',
            hintText: 'Enter you password',
            focusNode: _passwordFocusNode,
            onEditingComplete: _onCompletePasswordEditing,
            controller: _passwordController,
            keyboardType: TextInputType.visiblePassword,
          ),
          PrimaryTextFormField(
            isPasswordField: true,
            labelText: 'Confirm Password',
            hintText: 'Confirm your password',
            focusNode: _passwordConfirmFocusNode,
            onEditingComplete: _onCompletePasswordConfirmEditing,
            controller: _passwordConfirmController,
            keyboardType: TextInputType.visiblePassword,
          ),
        ],
      ),
    );
  }

  void _onCompleteEmailEditing() {
    // var _newFocus = widget.emailValidator.isNotEmptyValidation(_email)
    //     ? _passwordFocusNode
    //     : _emailFocusNode;
    FocusScope.of(context).requestFocus(_passwordFocusNode);
  }

  void _onCompletePasswordEditing() {
    if (selectedSignType == SignType.login) {
      _submit();
    } else {
      // var _newFocus = widget.passwordValidator.isNotEmptyValidation(_password)
      //     ? _passwordRepeatFocusNode
      //     : _passwordFocusNode;
      FocusScope.of(context).requestFocus(_passwordFocusNode);
    }
  }

  void _onCompletePasswordConfirmEditing() {
    if (selectedSignType == SignType.login) {
      _submit();
    }
  }

  void _updateState() {
    setState(() {});
  }

  void _submit() async {
    final authProvider = context.read<AuthService>();

    // setState(() {
    //   _isLoading = true;
    //   _isFormSubmitted = true;
    // });
    try {
      if (selectedSignType == SignType.login) {
        await authProvider.signInWithEmailAndPassword(
            _email, _password); // TODO:: validation
      } else {
        await authProvider.createUserWithEmailAndPassword(_email,
            _password); //TODO:: validation + confirm password validation
      }
    } on PlatformException catch (error) {
      const String errorTitle = 'Authentication Error';
      PlatformExceptionAlertDialog(
        title: errorTitle,
        exception: error,
      ).show(context);
    } catch (error) {
      print(error.toString());
    } finally {
      // _isLoading = false;
      // _updateState();
    }
  }
}
