import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:splash_and_functions/Screens/admin_screen.dart';
import 'package:splash_and_functions/Screens/student_screen.dart';
import 'package:splash_and_functions/Screens/teacher_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String? selectedItem;
  final List<String> dropdownList = ['Admin' , 'Teacher' , 'Student'];

  final emailController = TextEditingController();
  final ageController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up'),
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.green,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextFormField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                    labelText: 'Email',
                    hintText: 'Enter your email address',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                    )),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: ageController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                    labelText: 'Age',
                    hintText: 'Enter your Age',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                    )),
              ),
              DropdownButton(
                borderRadius: BorderRadius.circular(45),
                value: selectedItem,
                  hint: const Text('Select User Type'),
                  items: dropdownList.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(), onChanged: (String? newValue){
                  setState(() {
                    selectedItem = newValue;
                  });
              }),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                    labelText: 'Password',
                    hintText: 'Enter your Password',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                    )),
              ),
              const SizedBox(
                height: 40,
              ),
              InkWell(
                onTap: () async {
                  // SharedPreferences sp = await SharedPreferences.getInstance();
                  // sp.setString('name', 'Basit Ali');
                  // sp.setInt('age', 21);
                  // sp.setBool('isLogin', false);
                  //
                  // print(sp.getString('name'));
                  // print(sp.getInt('age').toString());
                  // print(sp.getBool('isLogin'));
                  //
                  // sp.remove('name');
                  // print(sp.getString('name'));
                  SharedPreferences sp = await SharedPreferences.getInstance();
                  sp.setString('email', emailController.text.toString());
                  sp.setString('age', ageController.text.toString());

                  // Admin , Student , Teacher
                  sp.setString('type', selectedItem.toString());
                  sp.setBool('isLogIn', true);

                  if(sp.getString('type') == 'Teacher'){
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const TeacherScreen()));
                  }else if(sp.getString('type') == 'Student'){
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const StudentScreen()));
                  }else if(sp.getString('type') == 'Admin'){
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const AdminScreen()));
                  }
                  else {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Error'),
                        content: const Text('Invalid User Type'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text('Ok'),
                          ),
                        ],
                      ),
                    );
                  }

                },
                child: Container(
                  height: 50,
                  width: double.infinity,
                  color: Colors.green,
                  child: const Center(
                    child: Text('Sign Up'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
