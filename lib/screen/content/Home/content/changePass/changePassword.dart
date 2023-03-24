import 'package:flutter/material.dart';

class ChangePass extends StatelessWidget {
  bool _secureText = true;
  showhide() {}

  final _formKey = GlobalKey<FormState>();
  // TextEditingController emailController = TextEditingController();
  // TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.black,
          onPressed: () => Navigator.pop(context, false),
        ),
        title: Text(
          'Ubah Password',
          style: TextStyle(color: Colors.black87),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black87),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: TextFormField(
                  // controller: emailController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    labelText: "Old Password",
                    hintText: "Enter your old password",
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your Old Password !';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: TextFormField(
                  // controller: passwordController,
                  obscureText: _secureText,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    labelText: "New Password",
                    hintText: "Enter your new password",
                    prefixIcon: Icon(
                      Icons.lock,
                      size: 18,
                    ),
                    suffixIcon: IconButton(
                        icon: Icon(
                          _secureText ? Icons.visibility : Icons.visibility_off,
                          size: 20,
                        ),
                        onPressed: () {}),
                  ),

                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your New Password';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16.0),
                child: TextFormField(
                  obscureText: _secureText,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    labelText: "Confirm Password ",
                    hintText: "Confirm password",
                    prefixIcon: Icon(
                      Icons.lock,
                      size: 18,
                    ),
                    suffixIcon: IconButton(
                        icon: Icon(
                          _secureText ? Icons.visibility : Icons.visibility_off,
                          size: 20,
                        ),
                        onPressed: () {}),
                  ),
                  // bingungg anjirr lah
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Confirm your Password !';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16.0),
                child: Center(
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // navigate the user to the Home page
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text(
                            'Please fill input !!',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          )),
                        );
                      }
                    },
                    child: Text('Change'),
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
