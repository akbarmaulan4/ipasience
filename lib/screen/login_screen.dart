import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:materi_ipa/bloc/auth_bloc.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  AuthBloc bloc = AuthBloc();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    bloc.dataLogin.listen((event) {
      if(event != null){
        Navigator.pushNamed(context, '/home');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 15,vertical: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Login', style: GoogleFonts.alike(fontSize: 35),),
              Text('ke Science IPA', style: GoogleFonts.alike(fontSize: 40)),
              SizedBox(height: size.height * 0.07),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  color: Colors.grey.shade200
                ),
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: TextField(
                  controller: bloc.edtUserName,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    labelText: 'Username',
                      suffixIcon: Icon(Icons.person)
                  ),
                ),
              ),
              SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    color: Colors.grey.shade200
                ),
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: TextField(
                  controller: bloc.edtPass,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    labelText: 'Password',
                    suffixIcon: Icon(Icons.lock)
                  ),
                  obscureText: true,
                ),
              ),
              // SizedBox(height: 10),
              SizedBox(height: 30),
              InkWell(
                onTap: ()=>bloc.validation(),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(25)),
                      color: Colors.teal
                  ),
                  padding: EdgeInsets.symmetric(vertical: 17, horizontal: 20),
                  child: Center(
                    child: Text('Login', style: GoogleFonts.alike(fontSize: 18, color: Colors.white),),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
