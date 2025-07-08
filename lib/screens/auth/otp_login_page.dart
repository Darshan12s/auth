// screens/auth/otp_login_page.dart
import 'package:flutter/material.dart';
import 'auth_page_template.dart';

class OtpLoginPage extends StatefulWidget {
  const OtpLoginPage({super.key});

  @override
  State<OtpLoginPage> createState() => _OtpLoginPageState();
}

class _OtpLoginPageState extends State<OtpLoginPage> {
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();
  bool _showOtpField = false;
  bool _isLoading = false;
  final _phoneFormKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _phoneController.dispose();
    _otpController.dispose();
    super.dispose();
  }

  Future<void> _sendOtp() async {
    if (!_phoneFormKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
    });

    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));

    setState(() {
      _isLoading = false;
      _showOtpField = true;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('OTP sent to +91 ${_phoneController.text}'),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  Future<void> _verifyOtp() async {
    if (_otpController.text.isEmpty || _otpController.text.length != 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a valid 6-digit OTP')),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    // Simulate verification delay
    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      _isLoading = false;
    });

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('OTP verified successfully!')));

    // Navigate to home after verification
    // Navigator.pushReplacementNamed(context, '/home');
  }

  InputDecoration _inputDecoration({
    required String hintText,
    Widget? prefix,
    Widget? suffixIcon,
    String? counterText,
    TextStyle? hintStyle,
  }) {
    return InputDecoration(
      hintText: hintText,
      hintStyle:
          hintStyle ?? const TextStyle(color: Colors.black, fontSize: 14),
      prefix: prefix,
      suffixIcon: suffixIcon,
      counterText: counterText,
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Colors.grey),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Colors.grey),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Colors.blue, width: 2),
      ),
      contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AuthPageTemplate(
      title: _showOtpField ? 'Verify OTP' : 'Phone Number Login',
      formFields: [
        AnimatedCrossFade(
          duration: const Duration(milliseconds: 300),
          crossFadeState: _showOtpField
              ? CrossFadeState.showSecond
              : CrossFadeState.showFirst,
          firstChild: Form(
            key: _phoneFormKey,
            child: Column(
              children: [
                const Text(
                  'Enter your phone number',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _phoneController,
                  keyboardType: TextInputType.phone,
                  maxLength: 10,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter phone number';
                    }
                    if (value.length != 10) {
                      return 'Phone number must be 10 digits';
                    }
                    if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                      return 'Only numbers are allowed';
                    }
                    return null;
                  },
                  decoration: _inputDecoration(
                    hintText: 'XXXXXXXXXX',
                    prefix: const Padding(
                      padding: EdgeInsets.only(right: 4.0),
                      child: Text('+91 ', style: TextStyle(fontSize: 16)),
                    ),
                    suffixIcon: Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: TextButton(
                        onPressed: _isLoading ? null : _sendOtp,
                        child: _isLoading
                            ? const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    Colors.green,
                                  ),
                                ),
                              )
                            : const Text(
                                'Send OTP',
                                style: TextStyle(
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                      ),
                    ),
                    counterText: '',
                  ),
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Enter 10-digit mobile number without country code',
                  style: TextStyle(fontSize: 12, color: Colors.black),
                ),
              ],
            ),
          ),
          secondChild: Column(
            children: [
              Text(
                'We sent a code to +91 ${_phoneController.text}',
                style: const TextStyle(fontSize: 14),
              ),
              const SizedBox(height: 20),
              const Text(
                'Enter OTP',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _otpController,
                decoration: _inputDecoration(hintText: '6-digit code').copyWith(
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 16,
                    horizontal: 8,
                  ),
                ),
                style: const TextStyle(fontSize: 18, letterSpacing: 4),
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                maxLength: 6,
                obscureText: true,
              ),
              const SizedBox(height: 8),
              TextButton(
                onPressed: _isLoading ? null : _sendOtp,
                child: const Text(
                  'Resend OTP',
                  style: TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
      actionButtonText: _showOtpField ? 'Verify OTP' : 'Continue',
      onActionPressed: _showOtpField ? _verifyOtp : _sendOtp,
      bottomText: 'Back to',
      bottomActionText: 'Login',
      navigateRoute: '/login',
      backgroundImage: 'https://wallpapercave.com/wp/wp5201676.jpg',
    );
  }
}
