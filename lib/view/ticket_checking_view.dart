import 'package:cinematna_verification/controller/check_ticket.dart';
import 'package:cinematna_verification/model/ticket_model.dart';
import 'package:cinematna_verification/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:qrscan/qrscan.dart' as scanner;
import 'package:permission_handler/permission_handler.dart';

class ticket_checking_screen extends StatefulWidget {
  final User_Model loggedInAdmin;
  static final routeName = "/ticket_checking";

  const ticket_checking_screen({Key key, this.loggedInAdmin}) : super(key: key);

  @override
  _ticket_checking_screenState createState() => _ticket_checking_screenState();
}

class _ticket_checking_screenState extends State<ticket_checking_screen> {
  String hiddenTxt = "";
  String reservationName = "";
  String partyDay = "";
  String partyTime = "";
  List seats = [];
  bool showSpinner = false;
  final TextEditingController ticketFieldController = TextEditingController();

  void searchTicker(String ticket) async {
    if (ticketFieldController.text.isEmpty) {
      setState(() {
        hiddenTxt = "Enter all fields";
      });
      return;
    }
    setState(() {
      showSpinner = true;
    });

    final TicketModel model = await checkTicket(ticket);
    if(model != null){
      setState(() {
        reservationName = model.bookingName;
        partyDay = model.partyDate.toString();
        seats = model.seatsLetters;
        partyTime = model.partyStart;

      });
    }else{
      setState(() {
        hiddenTxt = "ERROR";
      });
    }
    setState(() {
      showSpinner = false;
    });
    // User_Model user

    // print(await loginUser("1111", "123"));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    showSpinner = false;
    super.dispose();
  }

  @override
  // print(await checkTicket("736335"));
  Widget build(BuildContext context) {
    print(widget.loggedInAdmin.admin_id);
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
                    // Image.asset("lib/img/Ticketcher.png",width: 200,),
                    TextField(
                      controller: ticketFieldController,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(children: <Widget>[
                      Expanded(
                        child: new Container(
                            margin:
                                const EdgeInsets.only(left: 10.0, right: 20.0),
                            child: Divider(
                              color: Colors.black,
                              height: 36,
                            )),
                      ),
                      Text("OR"),
                      Expanded(
                        child: new Container(
                            margin:
                                const EdgeInsets.only(left: 20.0, right: 10.0),
                            child: Divider(
                              color: Colors.black,
                              height: 36,
                            )),
                      ),
                    ]),
                    FlatButton(
                        onPressed: () async {
                          print('plawdwad');
                          await Permission.camera.request();
                          String cameraScanResult = await scanner.scan();

                            ticketFieldController.text = cameraScanResult;
                            searchTicker(cameraScanResult);
                          // }else if (status.isUndetermined) {
                          //   Permission.camera.request();
                          // }
                          // Permission.camera.request();
                        },
                        child: Text('Scan Code')),
                    FlatButton(
                      onPressed: () async {
                        String cameraScanResult = ticketFieldController.text;
                        searchTicker(cameraScanResult);
                      },
                      child: Text('Check Ticket'),
                    ),
                    SizedBox(
                      height: 35,
                    ),
                    Text(
                      hiddenTxt,
                      style: TextStyle(color: Colors.red),
                    ),
                    Text(reservationName != ""?reservationName+", Day: "+partyDay:""),
                    Text(reservationName != ""?"Party Time: "+partyTime:""),
                    Text(reservationName != ""?seats.toString():"")
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
// String reservationName = "";
// String partyDay = "";
// String partyTime = "";
// List Seats = [];