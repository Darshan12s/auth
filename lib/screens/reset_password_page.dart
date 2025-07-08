// screens/reset_password_page.dart
import 'package:auth/screens/auth/auth_page_template.dart';
import 'package:flutter/material.dart';

class ResetPasswordPage extends StatelessWidget {
  const ResetPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthPageTemplate(
      title: 'Reset Password',
      formFields: [
        const Text('E-mail Address'),
        const SizedBox(height: 8),
        TextField(
          decoration: InputDecoration(
            hintText: 'Enter your email',
            border: const OutlineInputBorder(),
            filled: true,
            fillColor: Colors.white,
          ),
        ),
      ],
      actionButtonText: 'Reset Password',
      onActionPressed: () => ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Password reset link sent'))),
      bottomText: 'Back to',
      bottomActionText: 'Login',
      navigateRoute: '/login',
      backgroundImage: 'https://wallpapercave.com/wp/wp5201676.jpg',
    );
  }
}
