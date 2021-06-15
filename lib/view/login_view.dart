// import 'dart:html';
import 'dart:convert' as convert;
import 'dart:convert';

// import 'package:flutter/cupertino.dart';
import 'package:cinematna_verification/controller/login_action.dart';
import 'package:cinematna_verification/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:cinematna_verification/view/ticket_checking_view.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';



class Login extends StatefulWidget {
  static final routeName = "/";

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> with TickerProviderStateMixin {
  final TextEditingController userFieldController = TextEditingController();
  final TextEditingController passFieldController = TextEditingController();
  String hiddenTxt = "";
  bool showSpinner = false;

  @override
  void dispose() {
    showSpinner = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ModalProgressHUD(
            inAsyncCall: showSpinner,
            child: SingleChildScrollView(

              child: Container(
                padding: EdgeInsets.all(32),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset("lib/img/Ticketcher.png",width: 200,),
                    TextField(
                      controller: userFieldController,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextField(
                      controller: passFieldController,
                    ),
                    SizedBox(
                      height: 35,
                    ),
                    FlatButton(
                      onPressed: () async {
                        if(userFieldController.text.isEmpty || passFieldController.text.isEmpty){
                          setState(() {
                            hiddenTxt = "Enter all fields";
                          });
                          return;
                        }
                        setState(() {
                          showSpinner = true;
                        });
                        final resp = await loginUser(
                            userFieldController.text, passFieldController.text);

                        setState(() {
                          showSpinner = false;
                        });
                        // User_Model user
                        if (resp[0] != null) {
                          setState(() {
                            hiddenTxt = "";
                          });
                          // print(resp[0].admin_id);
                          Navigator.push(
                              context, MaterialPageRoute(builder: (context) => ticket_checking_screen(loggedInAdmin: resp[0],)));
                          //logged in
                        } else if(resp[1] == 400){
                          //login again
                          setState(() {
                            hiddenTxt = "Wrong user or pass, Try again.";
                          });
                        }else{
                          //ERROR
                          setState(() {
                            hiddenTxt = "Error happened!";
                          });
                        }
                        // print(await loginUser("1111", "123"));
                      },
                      child: Text('Login'),
                    ),
                    SizedBox(
                      height: 35,
                    ),
                    Text(hiddenTxt,style: TextStyle(color: Colors.red),),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
