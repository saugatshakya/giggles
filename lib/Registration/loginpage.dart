import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:Giggles/services/authService.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String verificationId, smsCode;
  bool codeSent = false;
  final formKey  = new GlobalKey<FormState>();
  String phoneNo;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red[900],
      body:SafeArea(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
                  Colors.deepOrange,
                  Colors.red[900]
                ])
              ),
              child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MediaQuery.of(context).viewInsets.bottom!=0?Container(margin: EdgeInsets.only(top:20),padding:EdgeInsets.only(top:5,bottom:5),decoration:BoxDecoration(border: Border.all(width: 3,color:Colors.white),color:Colors.transparent,borderRadius: BorderRadius.circular(25)),width:30,height:200,
                child:Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                  Text("G",style: TextStyle(fontSize: 20,color:Colors.white)),
                  SizedBox(height:2),
                  Text("i",style: TextStyle(fontSize: 20,color:Colors.white)),
                  SizedBox(height:2),
                  Text("g",style: TextStyle(fontSize: 20,color:Colors.white)),
                  SizedBox(height:2),
                  Text("g",style: TextStyle(fontSize: 20,color:Colors.white)),
                  SizedBox(height:2),
                  Text("l",style: TextStyle(fontSize: 20,color:Colors.white)),
                  SizedBox(height:2),
                  Text("e",style: TextStyle(fontSize: 20,color:Colors.white)),
                  SizedBox(height:2),
                  Text("s",style: TextStyle(fontSize: 20,color:Colors.white)),],)):Container(margin: EdgeInsets.only(top:20),padding:EdgeInsets.only(top:10,bottom:10),decoration:BoxDecoration(border: Border.all(width: 5,color:Colors.white),color:Colors.transparent,borderRadius: BorderRadius.circular(25)),width:50,height:300,
                child:Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                  Text("G",style: TextStyle(fontSize: 30,color:Colors.white)),
                  SizedBox(height:2),
                  Text("i",style: TextStyle(fontSize: 30,color:Colors.white)),
                  SizedBox(height:2),
                  Text("g",style: TextStyle(fontSize: 30,color:Colors.white)),
                  SizedBox(height:2),
                  Text("g",style: TextStyle(fontSize: 30,color:Colors.white)),
                  SizedBox(height:2),
                  Text("l",style: TextStyle(fontSize: 30,color:Colors.white)),
                  SizedBox(height:2),
                  Text("e",style: TextStyle(fontSize: 30,color:Colors.white)),
                  SizedBox(height:2),
                  Text("s",style: TextStyle(fontSize: 30,color:Colors.white)),],)),
                Form(
                key: formKey,
                child:Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                    Container(
                    padding: EdgeInsets.all(10),
                    child: TextFormField(
                      keyboardType: TextInputType.phone,
                      style: TextStyle(color:Colors.white,fontSize:18),
                      decoration: InputDecoration(enabledBorder: const OutlineInputBorder(borderSide: const BorderSide(color: Colors.white, width:2)),disabledBorder: const OutlineInputBorder(borderSide: const BorderSide(color: Colors.white, width:2)),focusedBorder: OutlineInputBorder(borderRadius:BorderRadius.circular(20),borderSide: const BorderSide(color: Colors.white, width:2)),hintText: "Enter Phone Number",hintStyle: TextStyle(color:Colors.white,fontSize:20,letterSpacing:2),border:OutlineInputBorder(borderRadius: BorderRadius.circular(15))),
                      onChanged: (val) 
                      {
                        setState(() {
                          this.phoneNo = val;
                        });
                      },),
                      ),
                codeSent ? Container(
                    padding: EdgeInsets.all(10),
                    child: TextFormField(
                      keyboardType: TextInputType.phone,
                      style: TextStyle(color:Colors.white,fontSize:18),
                      decoration: InputDecoration(enabledBorder: const OutlineInputBorder(borderSide: const BorderSide(color: Colors.white, width:2)),disabledBorder: const OutlineInputBorder(borderSide: const BorderSide(color: Colors.white, width:2)),focusedBorder: OutlineInputBorder(borderRadius:BorderRadius.circular(20),borderSide: const BorderSide(color: Colors.white, width:2)),hintText: "Enter OTP",hintStyle: TextStyle(color:Colors.white,fontSize:20,letterSpacing:2),border:OutlineInputBorder(borderRadius: BorderRadius.circular(15))),
                      onChanged: (val) 
                      {
                        setState(() {
                          this.smsCode = val;
                        });
                      },),
                      ):Container(),
                Container(
                decoration: BoxDecoration(border: Border.all(color:Colors.white,width:2),borderRadius: BorderRadius.circular(15)),
                width:300,
                height:50,
                child: FlatButton(child:codeSent ? Text("Login",style: TextStyle(color:Colors.white,fontSize:25,letterSpacing:5)):Text("Verify",style: TextStyle(color:Colors.white,fontSize:25,letterSpacing:5)),onPressed:(){
                  codeSent? AuthService().signInWithOTP(smsCode, verificationId):verifyPhone(phoneNo);
                }),
                  ),
                SizedBox(height:20)],
                )
          ),
        ]),
            ),
      )
    );
  }
  
Future<void> verifyPhone(phoneNo) async {
  final PhoneVerificationCompleted verified = (AuthCredential authResult) {
    AuthService().signIn(authResult);
  };

  final PhoneVerificationFailed verificationfailed = (AuthException authException) {
    print('${authException.message}');
  };

  final PhoneCodeSent smsSent = (String verId, [int forceResend]) {
    this.verificationId = verId;
    setState(() {this.codeSent = true;});
  };

  final PhoneCodeAutoRetrievalTimeout autoTimeout = (String verId) {
    this.verificationId = verId;
  };

  await FirebaseAuth.instance.verifyPhoneNumber(
    phoneNumber: phoneNo,
    timeout:const Duration(seconds: 5),
    verificationCompleted: verified,
    verificationFailed: verificationfailed,
    codeSent: smsSent,
    codeAutoRetrievalTimeout:autoTimeout
  );
}
}