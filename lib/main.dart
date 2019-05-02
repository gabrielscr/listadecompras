import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:listacompras/pages/home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _email, _password;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _formKey,
      body: Form(
        child: Column(
          children: <Widget>[
            TextFormField(
              validator: (v) {
                if (v.isEmpty) {
                  return 'E-mail não pode ser vazio';
                }
              },
              onSaved: (v) => {_email = v},
              decoration: InputDecoration(labelText: 'E-mail'),
            ),
            TextFormField(
              validator: (v) {
                if (v.length < 6) {
                  return 'Sua senha precisa ter 6 caracteres';
                }
              },
              onSaved: (v) => {_password = v},
              decoration: InputDecoration(labelText: 'Senha'),
              obscureText: true,
            ),
            RaisedButton(
              onPressed: logar,
              child: Text('Logar'),
            )
          ],
        ),
      ),
    );
  }

  Future<void> logar() async {
    final formState = _formKey.currentState;
    if (formState.validate()) {
      formState.save();
      try {
        FirebaseUser user = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: _email, password: _password);
        Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
      } catch (e) {
        print(e.message);
      }
    }
  }
}
