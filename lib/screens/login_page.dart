import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:watchlist_app/animations/background_painter.dart';
import 'package:watchlist_app/config.dart';

enum Mode { signIn, signUp }

class LoginPage extends StatefulWidget {
  static String routeName = "/login_page";
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  bool passError = false;
  bool emailError = false;
  bool wrongPassEmail = false;
  bool isSignin;
  AnimationController _controller;

  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 2));
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void processAuth(context) async {
    if (this._formKey.currentState.validate()) {
      FirebaseAuth.instance.authStateChanges().listen((user) {
        print("listened");
        if (user != null) {
          print(user);
          Navigator.of(context).pushNamedAndRemoveUntil(
            '/home_page',
            (Route<dynamic> route) => false,
          );
        }
      });
      print(emailController.text);
      print(passwordController.text);
      if (mode == Mode.signIn) {
        try {
          await FirebaseAuth.instance.signInWithEmailAndPassword(
              email: emailController.text, password: passwordController.text);
        } on FirebaseAuthException catch (e) {
          print("Catched error");
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(e.code),
          ));
        }
      } else {
        try {
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
              email: emailController.text, password: passwordController.text);
        } on FirebaseAuthException catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(e.code),
          ));
        }
      }
    }
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final auth = FirebaseAuth.instance;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  Mode mode = Mode.signIn;
  bool noshowpass = true;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(body: Builder(
      builder: (BuildContext context) {
        return Stack(
          children: [
            SizedBox.expand(
                child: CustomPaint(
              painter: BackgroundPainter(
                animation: _controller.view,
              ),
            )),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  physics: ScrollPhysics(),
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: size.height * 0.2),
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Text(
                            mode == Mode.signIn
                                ? "Welcome\nBack"
                                : "Create Account",
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 34,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.2,
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding:
                                const EdgeInsets.only(left: 20.0, bottom: 8),
                            child: Text(
                              "Email",
                              style: TextStyle(
                                fontFamily: 'MackinacBook',
                                fontSize: 16,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: TextFormField(
                            controller: emailController,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              hintText: "example@gmail.com",
                              prefixIcon: Icon(Icons.email),
                              errorMaxLines: 2,
                              hintStyle: TextStyle(
                                fontSize: 16,
                                color: Colors.grey[350],
                                fontWeight: FontWeight.w600,
                                fontFamily: 'MackinacBook',
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 17, horizontal: 25),
                              focusColor: Color(0xff0962ff),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide:
                                    BorderSide(color: Color(0xff0962ff)),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  color: Colors.grey[350],
                                ),
                              ),
                            ),
                            validator: (String value) {
                              Pattern pattern =
                                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9\-]+\.[a-zA-Z]+";
                              RegExp regex = RegExp(pattern);
                              if (!regex.hasMatch(value)) {
                                return "Email is invalid";
                              } else {
                                return null;
                              }
                            },
                          ),
                        ),
                        emailError
                            ? Padding(
                                padding: const EdgeInsets.only(left: 16),
                                child: Text(
                                  "Email field cannot be empty",
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: Colors.red,
                                    fontFamily: "MackinacBook",
                                  ),
                                ),
                              )
                            : SizedBox(),
                        wrongPassEmail
                            ? Padding(
                                padding: const EdgeInsets.only(left: 16),
                                child: Text(
                                  "Incorrect email or password",
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: Colors.red,
                                    fontFamily: "MackinacBook",
                                  ),
                                ),
                              )
                            : SizedBox(),
                        SizedBox(
                          height: size.height * 0.03,
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding:
                                const EdgeInsets.only(left: 20.0, bottom: 8),
                            child: Text(
                              "Password",
                              style: TextStyle(
                                fontFamily: 'MackinacBook',
                                fontSize: 16,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: TextFormField(
                            controller: passwordController,
                            obscureText: noshowpass,
                            decoration: InputDecoration(
                              hintStyle: TextStyle(
                                fontSize: 16,
                                color: Colors.grey[350],
                                fontWeight: FontWeight.w600,
                                fontFamily: 'MackinacBook',
                              ),
                              hintText: "password",
                              prefixIcon: Icon(Icons.security),
                              suffixIcon: IconButton(
                                icon: Icon(Icons.remove_red_eye),
                                color: this.noshowpass
                                    ? Colors.grey
                                    : Colors.black,
                                onPressed: () {
                                  setState(
                                      () => this.noshowpass = !this.noshowpass);
                                },
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 17, horizontal: 25),
                              focusColor: Color(0xff0962ff),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide:
                                    BorderSide(color: Color(0xff0962ff)),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  color: Colors.grey[350],
                                ),
                              ),
                            ),
                          ),
                        ),
                        passError
                            ? Padding(
                                padding: const EdgeInsets.only(left: 16),
                                child: Text(
                                  "Password field cannot be empty",
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: Colors.red,
                                    fontFamily: "MAckinacBook",
                                  ),
                                ),
                              )
                            : SizedBox(),
                        wrongPassEmail
                            ? Padding(
                                padding: const EdgeInsets.only(left: 16),
                                child: Text(
                                  "Incorrect email or password",
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: Colors.red,
                                    fontFamily: "MAckinacBook",
                                  ),
                                ),
                              )
                            : SizedBox(),
                        Padding(
                          padding: const EdgeInsets.only(left: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: InkWell(
                                    splashColor: Colors.white,
                                    onTap: () {
                                      this.setState(() {
                                        if (mode == Mode.signIn) {
                                          _controller.forward(from: 0);
                                          mode = Mode.signUp;
                                        } else {
                                          _controller.reverse(from: 1);
                                          mode = Mode.signIn;
                                        }
                                      });
                                    },
                                    child: Text(
                                        mode == Mode.signIn
                                            ? 'Sign Up'
                                            : "Sign In",
                                        style: TextStyle(
                                          fontSize: 16,
                                          decoration: TextDecoration.underline,
                                          color: config.lightGreenishBlue,
                                        ))),
                              ),
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16.0),
                                    child: InkWell(
                                      onTap: () async {
                                        print("below is email controller");
                                        print(emailController.text.isEmpty);
                                        if (emailController.text.isEmpty ==
                                            true) {
                                          this.setState(() {
                                            emailError = true;
                                          });
                                        }
                                        if (passwordController.text.isEmpty ==
                                            true) {
                                          this.setState(() {
                                            passError = true;
                                          });
                                        }
                                        if (emailController.text.isEmpty !=
                                            true) {
                                          this.setState(() {
                                            emailError = false;
                                          });
                                        }
                                        if (passwordController.text.isEmpty !=
                                            true) {
                                          this.setState(() {
                                            passError = false;
                                          });
                                        }

                                        if (passError == false &&
                                            emailError == false) {
                                          processAuth(context);
                                        }
                                      },
                                      child: Container(
                                        width: size.width / 3,
                                        margin:
                                            EdgeInsets.symmetric(vertical: 16),
                                        height: 58,
                                        decoration: BoxDecoration(
                                          color: Color(0xff651511),
                                          borderRadius:
                                              BorderRadius.circular(16),
                                        ),
                                        child: Center(
                                          child: Text(
                                            mode == Mode.signIn
                                                ? 'Sign In'
                                                : "Sign Up",
                                            style: TextStyle(
                                              fontFamily: 'MackinacBook',
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    ));
  }
}
