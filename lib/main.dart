import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold (
        appBar: AppBar(
          title: Text('Validation'),
        ),
        body: Form(
          key: _key,
          child: Column(
            children: [
             textField('First Name'),
              textField('Last Name'),
              textField('E-mail', validation: validateEmail),
              textField('Password', obscure: true, validation: validatePassword),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.save),
          onPressed: (){
            if (_key.currentState!.validate()) {
              print('Form was submitted successfully');
            }
          },
        ),
      ),
    );
  }

  Widget textField(
      String label,
  {bool obscure = false, Function validation = validateText}
      ) {

    return TextFormField(
      decoration: InputDecoration(
        obscureText: obscure,
        validator: validation,
      ),
    );

  }

}

//String нул сейфти ошибка
String? validateText(String formText) {
  if (formText.isEmpty) return 'Field is required';

  return null;
}

String? validateEmail(String formEmail) {
  if (formEmail.isEmpty) return 'E-mail Address is required';

  String pattern = r'\w+@\w+\.\w+';
  RegExp regex = RegExp(pattern);
  if (!regex.hasMatch(formEmail)) return 'Invalid E-Mail Address format';

  return null;
}

String? validatePassword(String formPassword) {
  if (formPassword.isEmpty) return 'Password is required';

  String pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
  RegExp regex = RegExp(pattern);
  if (!regex.hasMatch(formPassword)) return 'должны быть буквы и симпволы 8 шт';

  return null;
}

