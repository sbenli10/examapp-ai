import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/utils/constants/colors.dart';
import '../../../../core/utils/constants/numbers.dart';
import '../../../../core/utils/extensions/snack_bar_extension.dart';
import '../../../../core/utils/functions/calculate_max_width.dart';
import '../../data/repositories/authentication_repository.dart';

@RoutePage()
class AuthPage extends StatefulHookWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _fadeAnimation = CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeInOut,
    );
    _fadeController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    super.dispose();
  }

  static final _emailRegex = RegExp(r'^[\w\-.]+@([\w-]+\.)+[\w-]{2,4}$');
  static final _nicknameRegex = RegExp(r'^[a-zA-Z0-9_.]+$');

  @override
  Widget build(BuildContext context) {
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();
    final nicknameController = useTextEditingController();

    final isSignIn = useState<bool>(true);
    final isLoading = useState<bool>(false);
    final obscurePassword = useState<bool>(true);

    final theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: kLargePadding),
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: Container(
                width: calculateMaxWidth(context),
                padding: const EdgeInsets.all(kHugePadding),
                decoration: BoxDecoration(
                  color: theme.colorScheme.surface,
                  borderRadius: BorderRadius.circular(kDefaultBorderRadius),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.08),
                      blurRadius: 24,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // App icon / branding
                      Container(
                        width: 72,
                        height: 72,
                        decoration: BoxDecoration(
                          color: AppColors.primary.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(18),
                        ),
                        child: const Icon(
                          Icons.school_rounded,
                          size: 40,
                          color: AppColors.primary,
                        ),
                      ),
                      const SizedBox(height: kLargePadding),
                      Text(
                        isSignIn.value ? 'Welcome Back' : 'Create Account',
                        style: theme.textTheme.titleLarge,
                      ),
                      const SizedBox(height: kSmallPadding),
                      Text(
                        isSignIn.value
                            ? 'Sign in to continue learning'
                            : 'Start your exam preparation journey',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                        ),
                      ),
                      const SizedBox(height: kHugePadding),

                      // Email field
                      TextFormField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          labelText: 'Email',
                          hintText: 'you@example.com',
                          prefixIcon: const Icon(Icons.email_outlined),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                              kDefaultBorderRadius,
                            ),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Please enter your email';
                          }
                          if (!_emailRegex.hasMatch(value.trim())) {
                            return 'Please enter a valid email';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: kDefaultPadding),

                      // Password field
                      TextFormField(
                        controller: passwordController,
                        obscureText: obscurePassword.value,
                        textInputAction: isSignIn.value
                            ? TextInputAction.done
                            : TextInputAction.next,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          prefixIcon: const Icon(Icons.lock_outline),
                          suffixIcon: IconButton(
                            icon: Icon(
                              obscurePassword.value
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined,
                            ),
                            onPressed: () {
                              obscurePassword.value = !obscurePassword.value;
                            },
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                              kDefaultBorderRadius,
                            ),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          }
                          if (!isSignIn.value && value.length < 6) {
                            return 'Password must be at least 6 characters';
                          }
                          return null;
                        },
                      ),

                      // Nickname field (sign-up only)
                      if (!isSignIn.value) ...[
                        const SizedBox(height: kDefaultPadding),
                        TextFormField(
                          controller: nicknameController,
                          keyboardType: TextInputType.name,
                          textInputAction: TextInputAction.done,
                          decoration: InputDecoration(
                            labelText: 'Nickname',
                            hintText: 'e.g. john_doe',
                            prefixIcon: const Icon(Icons.person_outline),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                kDefaultBorderRadius,
                              ),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Please enter a nickname';
                            }
                            if (value.trim().length < 3) {
                              return 'Nickname must be at least 3 characters';
                            }
                            if (value.trim().length > 20) {
                              return 'Nickname must be at most 20 characters';
                            }
                            if (!_nicknameRegex.hasMatch(value.trim())) {
                              return 'Only letters, numbers, _ and . allowed';
                            }
                            return null;
                          },
                        ),
                      ],

                      const SizedBox(height: kHugePadding),

                      // Submit button
                      SizedBox(
                        width: double.infinity,
                        height: 52,
                        child: ElevatedButton(
                          onPressed: isLoading.value
                              ? null
                              : () => _handleSubmit(
                                    context: context,
                                    isSignIn: isSignIn.value,
                                    isLoading: isLoading,
                                    email: emailController.text.trim(),
                                    password: passwordController.text,
                                    nickname: nicknameController.text.trim(),
                                  ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            foregroundColor: Colors.black87,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                kDefaultBorderRadius,
                              ),
                            ),
                            elevation: 0,
                          ),
                          child: isLoading.value
                              ? const SizedBox(
                                  width: 24,
                                  height: 24,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2.5,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.black54,
                                    ),
                                  ),
                                )
                              : Text(
                                  isSignIn.value ? 'Sign In' : 'Sign Up',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                        ),
                      ),

                      const SizedBox(height: kLargePadding),

                      // Toggle sign-in / sign-up
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            isSignIn.value
                                ? "Don't have an account?"
                                : 'Already have an account?',
                            style: theme.textTheme.bodyMedium,
                          ),
                          TextButton(
                            onPressed: isLoading.value
                                ? null
                                : () {
                                    isSignIn.value = !isSignIn.value;
                                    _formKey.currentState?.reset();
                                  },
                            child: Text(
                              isSignIn.value ? 'Sign Up' : 'Sign In',
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
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

  Future<void> _handleSubmit({
    required BuildContext context,
    required bool isSignIn,
    required ValueNotifier<bool> isLoading,
    required String email,
    required String password,
    required String nickname,
  }) async {
    if (!_formKey.currentState!.validate()) return;

    isLoading.value = true;
    try {
      if (isSignIn) {
        await AuthenticationRepositoryImpl().signIn(
          email: email,
          password: password,
        );
      } else {
        await AuthenticationRepositoryImpl().signUp(
          email: email,
          password: password,
          nickname: nickname,
        );
      }
    } on AuthApiException catch (e) {
      if (context.mounted) {
        context.showSnackBar(message: e.message);
      }
    } catch (e) {
      if (context.mounted) {
        context.showSnackBar(message: 'An unexpected error occurred.');
      }
    } finally {
      if (context.mounted) {
        isLoading.value = false;
      }
    }
  }
}
