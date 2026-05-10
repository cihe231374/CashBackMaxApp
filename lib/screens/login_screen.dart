import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import '../utils/app_colors.dart';
import '../utils/app_routes.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_input.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final email = TextEditingController();
  final password = TextEditingController();
  final auth = AuthService();

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }

  void _login() {
    auth.login(
      email: email.text.trim(),
      password: password.text,
    );
    Navigator.pushReplacementNamed(context, AppRoutes.home);
  }

  // ================= SOCIAL LOGIN =================

  void _showSocialLogin(BuildContext context, String provider) {
    final accounts = [
      {'name': 'Alex Johnson', 'email': 'alex@email.com'},
      {'name': 'John Smith', 'email': 'john@gmail.com'},
    ];

    int selectedIndex = 0;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.bg2,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      builder: (_) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Padding(
              padding: const EdgeInsets.fromLTRB(24, 24, 24, 30),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 42,
                    height: 4,
                    decoration: BoxDecoration(
                      color: AppColors.text3.withOpacity(.4),
                      borderRadius: BorderRadius.circular(99),
                    ),
                  ),

                  const SizedBox(height: 24),

                  Container(
                    height: 70,
                    width: 70,
                    decoration: BoxDecoration(
                      color: AppColors.accent.withOpacity(.15),
                      borderRadius: BorderRadius.circular(22),
                    ),
                    child: Icon(
                      provider == 'Apple'
                          ? Icons.apple
                          : Icons.g_mobiledata,
                      size: 42,
                      color: AppColors.accent,
                    ),
                  ),

                  const SizedBox(height: 16),

                  Text(
                    'Choose $provider Account',
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w900,
                    ),
                  ),

                  const SizedBox(height: 20),

                  ...List.generate(accounts.length, (index) {
                    final acc = accounts[index];

                    return GestureDetector(
                      onTap: () {
                        setState(() => selectedIndex = index);
                      },
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: selectedIndex == index
                              ? AppColors.accent.withOpacity(.12)
                              : AppColors.bg,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: selectedIndex == index
                                ? AppColors.accent
                                : AppColors.bg3,
                          ),
                        ),
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 20,
                              child: Text(acc['name']![0]),
                            ),
                            const SizedBox(width: 12),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  acc['name']!,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                                Text(
                                  acc['email']!,
                                  style: const TextStyle(
                                    color: AppColors.text2,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                            const Spacer(),
                            if (selectedIndex == index)
                              const Icon(
                                Icons.check_circle,
                                color: AppColors.accent,
                              ),
                          ],
                        ),
                      ),
                    );
                  }),

                  TextButton.icon(
                    onPressed: () {
                      Navigator.pop(context);
                      _showAddAccount(context, provider);
                    },
                    icon: const Icon(Icons.add),
                    label: const Text('Use another account'),
                  ),

                  const SizedBox(height: 10),

                  CustomButton(
                    text: 'Continue',
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.pushReplacementNamed(
                          context, AppRoutes.home);
                    },
                  ),

                  const SizedBox(height: 10),

                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text(
                      'Cancel',
                      style: TextStyle(color: AppColors.text2),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  void _showAddAccount(BuildContext context, String provider) {
    final emailController = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.bg2,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      builder: (_) {
        return Padding(
          padding: EdgeInsets.fromLTRB(
            24,
            24,
            24,
            MediaQuery.of(context).viewInsets.bottom + 24,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 42,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.text3.withOpacity(.4),
                  borderRadius: BorderRadius.circular(99),
                ),
              ),

              const SizedBox(height: 20),

              Text(
                'Add $provider Account',
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w900,
                ),
              ),

              const SizedBox(height: 16),

              CustomInput(
                label: 'Email',
                hint: 'your@email.com',
                controller: emailController,
              ),

              const SizedBox(height: 16),

              CustomButton(
                text: 'Add & Continue',
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pushReplacementNamed(
                      context, AppRoutes.home);
                },
              ),

              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel'),
              ),
            ],
          ),
        );
      },
    );
  }

  // ================= RESET =================

  void _showReset(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.bg2,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      builder: (_) {
        return Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Reset Password'),
              CustomInput(
                label: 'Email',
                hint: 'you@email.com',
                controller: email,
              ),
              CustomButton(
                text: 'Send Reset Link',
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
        );
      },
    );
  }

  // ================= UI =================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(24),
          children: [
            const SizedBox(height: 40),

            const Text(
              'Sign in',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 20),

            CustomInput(
              label: 'Email',
              hint: 'you@email.com',
              controller: email,
            ),

            CustomInput(
              label: 'Password',
              hint: '••••••••',
              controller: password,
              obscureText: true,
            ),

            const SizedBox(height: 10),

            CustomButton(
              text: 'Sign In',
              onPressed: _login,
            ),

            const SizedBox(height: 20),

            Row(
              children: const [
                Expanded(child: Divider()),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: Text('or'),
                ),
                Expanded(child: Divider()),
              ],
            ),

            const SizedBox(height: 20),

            Row(
              children: [
                Expanded(
                  child: _SocialButton(
                    icon: Icons.g_mobiledata,
                    label: 'Google',
                    onTap: () =>
                        _showSocialLogin(context, 'Google'),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _SocialButton(
                    icon: Icons.apple,
                    label: 'Apple',
                    onTap: () =>
                        _showSocialLogin(context, 'Apple'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _SocialButton extends StatelessWidget {
  const _SocialButton({
    required this.label,
    required this.onTap,
    this.icon,
  });

  final String label;
  final IconData? icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onTap,
      icon: Icon(icon),
      label: Text(label),
    );
  }
}