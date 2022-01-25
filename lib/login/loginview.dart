import 'package:flutter/material.dart';
import 'package:flutterapipost/home/clienthome.dart';
import 'package:flutterapipost/home/workerhome.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'apiservices.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  LoginRequestModel? loginRequestModel;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  // shared instance variable
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
// variable to save
  int? userid;
  int? usertype;
  String? usertoken;
  int? userstatus;

  @override
  void initState() {
    super.initState();
    loginRequestModel = LoginRequestModel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Form(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 20,
              ),
              TextFormField(
                onSaved: (input) => loginRequestModel!.phone = input,
                onChanged: (input) => loginRequestModel!.phone = input,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.phone),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                  ),
                  labelText: 'الهاتف',
                ),
              ),
              const SizedBox(
                height: 14,
              ),
              TextFormField(
                //for password
                obscureText: true,

                onSaved: (input) => loginRequestModel!.pass = input,
                onChanged: (input) => loginRequestModel!.pass = input,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.lock),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                  ),
                  labelText: 'كلمة المرور',
                ),
              ),
              ElevatedButton.icon(
                onPressed: () {
                  setState(() {
                    // confirm data
                    print(loginRequestModel!.toJson());
// postdata to log in
                    APIService apiService = new APIService();
                    apiService.login(loginRequestModel!).then((value) {
                      if (value != null) {
                        if (value.token!.isNotEmpty) {
                          print("Login Successful");
                          //save
                          userid = value.user;
                          usertype = value.type;
                          usertoken = value.token;
                          userstatus = value.status;
                          //save data
                          _saveLoginData();

                          //goto
                          //we can use if or switch
                          if (usertype == 0) {
                            //remove this and write block navigation code
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const ClientHome()),
                            );
                          } else if (usertype == 1) {
                            //remove this and write block navigation code
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const WorkerHome()),
                            );
                          }
                          print("user type 1 go to client");
                        } else {
                          print("03 error");
                        }
                      }
                    });
                  });
                },
                icon: const Icon(Icons.account_box_outlined),
                label: const Text("تسجيل دخول"),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _saveLoginData() async {
    final SharedPreferences prefs = await _prefs;
    prefs.setInt('userid', userid!);
    prefs.setInt('usertoken', usertype!);
    prefs.setString('userid', usertoken!);
    prefs.setInt('userstatus', userstatus!);
    // confirm data
    print("data saved to shared _pref");
  }
}
