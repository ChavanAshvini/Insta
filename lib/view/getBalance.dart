import 'package:flutter/material.dart';

class GetBalance extends StatefulWidget {
  @override
  _GetBalanceState createState() => _GetBalanceState();
}

class _GetBalanceState extends State<GetBalance> {
  final _formKey = GlobalKey<FormState>();
  String? _balance; // To hold the balance value
  bool _isBalanceVisible = false; // To manage visibility of the balance field

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200], // Light background
      resizeToAvoidBottomInset: true, // Ensures scrolling when the keyboard appears
      body: SingleChildScrollView( // Make the content scrollable
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              width: 500,
              height: 400,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    blurRadius: 10,
                    spreadRadius: 5,
                  ),
                ],
              ),
              child: Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.all(16.0), // Padding inside the Container
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Username TextField
                      _buildTextField(label: 'Username', icon: Icons.person),
                      SizedBox(height: 20),

                      // Phone Number TextField
                      _buildTextField(
                        label: 'Phone Number',
                        icon: Icons.phone,
                        keyboardType: TextInputType.phone,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your phone number';
                          } else if (!RegExp(r'^\d{10}$').hasMatch(value)) {
                            return 'Phone number must be 10 digits';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20),

                      // UPI ID TextField
                      _buildTextField(label: 'UPI ID', icon: Icons.account_balance_wallet),
                      SizedBox(height: 20),

                      // Get Balance Button
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            // Simulating balance retrieval
                            setState(() {
                              _balance = '₹1,00,000'; // Replace with your logic to get the actual balance
                              _isBalanceVisible = true; // Show the balance field
                            });
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(double.infinity, 50),
                          backgroundColor: Colors.blueAccent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          elevation: 5,
                        ),
                        child: Text("Get Balance"),
                      ),

                      SizedBox(height: 20),

                      // Display the balance field if balance is available
                      if (_isBalanceVisible) ...[
                        TextFormField(
                          enabled: false, // Disable editing
                          decoration: InputDecoration(
                            labelText: 'Balance:',
                            labelStyle: TextStyle(color: Colors.black), // White label for better contrast
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: Colors.transparent), // Remove the border
                            ),
                            filled: true,
                            fillColor: Colors.black12, // Set background color to black
                          ),
                          style: TextStyle(color: Colors.black), // Set text color to white
                          initialValue: _balance, // Set initial value to balance
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Helper method to build text fields
  Widget _buildTextField({
    required String label,
    required IconData icon,
    bool obscureText = false,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        prefixIcon: Icon(icon),
      ),
      obscureText: obscureText,
      keyboardType: keyboardType,
      validator: validator,
    );
  }
}
