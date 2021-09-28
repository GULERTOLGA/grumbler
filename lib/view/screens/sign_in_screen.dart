import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grumbler/bloc/authentication_bloc.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: (ctx, state) {
        if (state is AuthenticationLoadingState) {
          return const Center(
            child: SizedBox(
              height: 50,
              child: CircularProgressIndicator(),
            ),
          );
        }

        return buildLoginScreen(ctx);
      }),
    );
  }

  Column buildLoginScreen(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 90, 16, 0),
          child: _buildForm(),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: _buildDivider(),
        ),
        Expanded(
          child: _buildSocialMediaButtons(context),
        ),
      ],
    );
  }

  Widget _buildForm() {
    return LayoutBuilder(builder: (context, box) {
      return Form(
        child: Wrap(
          spacing: 20,
          crossAxisAlignment: WrapCrossAlignment.start,
          direction: Axis.vertical,
          children: [
            SizedBox(
              width: box.maxWidth,
              child: Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                    onPressed: () {}, child: const Text("Yeni Üyelik")),
              ),
            ),
            SizedBox(
              width: box.maxWidth,
              child: const TextField(
                  decoration: InputDecoration(
                      prefixIcon: Icon(CupertinoIcons.mail),
                      hintText: "E-Posta adresiniz")),
            ),
            SizedBox(
              width: box.maxWidth,
              child: const TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                      prefixIcon: Icon(CupertinoIcons.lock),
                      suffixIcon: Icon(CupertinoIcons.eye),
                      hintText: "Şifreniz")),
            ),
            SizedBox(
              width: box.maxWidth,
              child: Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                    onPressed: () {}, child: const Text("Şifremi Unuttum")),
              ),
            ),
            ElevatedButton(
                onPressed: () {},
                style:
                    ElevatedButton.styleFrom(fixedSize: Size(box.maxWidth, 50)),
                child: const Text("Giriş")),
          ],
        ),
      );
    });
  }

  Widget _buildDivider() {
    return Row(children: <Widget>[
      Expanded(
        child: Container(
            margin: const EdgeInsets.only(left: 10.0, right: 15.0),
            child: const Divider(
              color: Colors.grey,
              height: 40,
            )),
      ),
      const Text("veya"),
      Expanded(
        child: Container(
            margin: const EdgeInsets.only(left: 15.0, right: 10.0),
            child: const Divider(
              color: Colors.grey,
              height: 40,
            )),
      ),
    ]);
  }

  Widget _buildSocialMediaButtons(BuildContext context) {
    AuthenticationBloc authenticationBloc =
        BlocProvider.of<AuthenticationBloc>(context);

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: LayoutBuilder(builder: (context, box) {
          var buttonHeight = 46.0;
          return Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            direction: Axis.vertical,
            spacing: 10,
            children: [
              ElevatedButton.icon(
                onPressed: () => authenticationBloc
                    .add(SignInEvent(authProvider: AuthProvider.google)),
                style: ElevatedButton.styleFrom(
                    fixedSize: Size(box.maxWidth, buttonHeight),
                    primary: const Color(0xFF4285F4)),
                icon: Container(
                    color: Colors.white,
                    height: 32,
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Image.asset("assets/graphics/google-logo.png"),
                    )),
                label: const Text("Google ile devam et"),
              ),
              ElevatedButton.icon(
                onPressed: () => authenticationBloc
                    .add(SignInEvent(authProvider: AuthProvider.facebook)),
                style: ElevatedButton.styleFrom(
                    fixedSize: Size(box.maxWidth, buttonHeight),
                    primary: const Color(0xFF1877F2)),
                icon: SizedBox(
                    height: 32,
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Image.asset(
                          "assets/graphics/flogo-HexRBG-Wht-100.png"),
                    )),
                label: const Text("Facebook ile devam et"),
              ),
              ElevatedButton.icon(
                onPressed: () => {},
                style: ElevatedButton.styleFrom(
                  fixedSize: Size(box.maxWidth, buttonHeight),
                  textStyle: const TextStyle(color: Colors.red),
                  primary: const Color(0xFFE7E7E7),
                ),
                icon: Padding(
                  padding: const EdgeInsets.all(0),
                  child: Image.asset("assets/graphics/Twitter_Logo_Blue.png"),
                ),
                label: const Text(
                  "Twitter ile devam et",
                  style: TextStyle(
                      color: Colors.black54, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
