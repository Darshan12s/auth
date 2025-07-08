// screens/auth/auth_page_template.dart
import 'package:auth/routes/app_routes.dart';
import 'package:flutter/material.dart';

class AuthPageTemplate extends StatelessWidget {
  final String title;
  final List<Widget> formFields;
  final String actionButtonText;
  final VoidCallback? onActionPressed;
  final String bottomText;
  final String bottomActionText;
  final String navigateRoute;
  final String backgroundImage;

  const AuthPageTemplate({
    super.key,
    required this.title,
    required this.formFields,
    required this.actionButtonText,
    this.onActionPressed,
    required this.bottomText,
    required this.bottomActionText,
    required this.navigateRoute,
    required this.backgroundImage,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(backgroundImage),
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Dark Overlay
          Container(color: Colors.black.withAlpha(102)),

          // Content
          LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: IntrinsicHeight(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Column(
                        children: [
                          const Spacer(),
                          // Form Container
                          Container(
                            width: double.infinity,
                            constraints: BoxConstraints(
                              maxWidth: 500, // Maximum width for larger screens
                            ),
                            margin: const EdgeInsets.only(bottom: 0),

                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  title,
                                  style: const TextStyle(
                                    fontSize: 28,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 24),
                                ...formFields,
                                const SizedBox(height: 24),
                                SizedBox(
                                  width: double.infinity,
                                  height: 30,
                                  child: ElevatedButton(
                                    onPressed: onActionPressed,
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.green[700],
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                    child: Text(
                                      actionButtonText,
                                      style: const TextStyle(
                                        fontSize: 18,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 20),
                                Row(
                                  children: [
                                    const Expanded(child: Divider()),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8,
                                      ),
                                      child: Text(
                                        'or Sign in with',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                    const Expanded(child: Divider()),
                                  ],
                                ),
                                const SizedBox(height: 20),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        Navigator.pushNamed(
                                          context,
                                          AppRoutes.signup,
                                        );
                                      },
                                      icon: Image.network(
                                        'https://tse1.mm.bing.net/th/id/OIP.w673MhZjEuw92ta8WuljMAHaH8?pid=Api&P=0&h=180',
                                        width: 40,
                                      ),
                                    ),
                                    const SizedBox(width: 16),
                                    IconButton(
                                      onPressed: () {
                                        Navigator.pushNamed(
                                          context,
                                          AppRoutes.login,
                                        );
                                      },
                                      icon: Image.network(
                                        'https://tse1.mm.bing.net/th/id/OIP.FbU3g7vhPU6hP7Zr-h0aEwHaHg?pid=Api&P=0&h=180',
                                        width: 40,
                                      ),
                                    ),
                                    const SizedBox(width: 16),
                                    IconButton(
                                      onPressed: () {
                                        Navigator.pushNamed(
                                          context,
                                          AppRoutes.otpLogin,
                                        );
                                      },
                                      icon: Image.network(
                                        'https://static.vecteezy.com/system/resources/previews/019/136/458/original/apple-logo-apple-icon-free-free-vector.jpg',
                                        width: 40,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          // Bottom Navigation Text
                          Padding(
                            padding: const EdgeInsets.only(bottom: 40),
                            child: Center(
                              child: TextButton(
                                onPressed: () => Navigator.pushReplacementNamed(
                                  context,
                                  navigateRoute,
                                ),
                                child: RichText(
                                  text: TextSpan(
                                    text: '$bottomText ',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                    ),
                                    children: [
                                      TextSpan(
                                        text: bottomActionText,
                                        style: TextStyle(
                                          color: Colors.green[300],
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
