import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:trend/config/locale/app_localizations.dart';
import '../../../../config/routes/app_routes.dart';
import '../../../../core/utils/toast_utils.dart';
import '../../../../core/utils/validation.dart';
import '../../../../core/widgets/custom_text_form_field.dart';
import '../../../../core/widgets/full_logo.dart';
import '../../../../core/widgets/overlay_loading_page.dart';
import '../bloc/auth_bloc/auth_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _obscurePassword = true;
  String _email = '';
  String _password = '';
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthErrorState) {
          ToastUtils(context).showCustomToast(
            message: state.message,
            iconData: Icons.error_outline,
          );
        } else if (state is AuthLoadedState) {
          GoRouter.of(context).go(Routes.initialPage);
        }
      },
      builder: (context, state) {
        return OverlayLoadingPage(
          isLoading: state is AuthLoadingState,
          child: Scaffold(
            body: _buildLoginForm(),
          ),
        );
      },
    );
  }

  Widget _buildLoginForm() {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(
                height: 100,
                child: FullLogo(),
              ),
              const SizedBox(height: 40),
              CustomTextFormField(
                labelText: "E-mail".hardcoded,
                prefixIcon: const Icon(Icons.email),
                onChange: (value) {
                  _email = value.trim();
                },
                keyboardType: TextInputType.emailAddress,
                validator: (value) => Validation.validateEmail(_email, context),
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: 20),
              CustomTextFormField(
                labelText: "Password".hardcoded,
                prefixIcon: const Icon(Icons.lock),
                suffixIcon: IconButton(
                  onPressed: () => setState(() {
                    _obscurePassword = !_obscurePassword;
                  }),
                  icon: Icon(
                    _obscurePassword ? Icons.visibility_off : Icons.visibility,
                  ),
                ),
                obscureText: _obscurePassword,
                onChange: (value) {
                  _password = value.trim();
                },
                validator: (value) =>
                    Validation.validatePassword(_password, context),
                onFieldSubmitted: (value) {
                  _onLogin();
                },
              ),
              const SizedBox(height: 30),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      minimumSize: Size(MediaQuery.sizeOf(context).width, 45)),
                  onPressed: _onLogin,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text("Login".hardcoded),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              // TextButton(
              //     onPressed: () {
              //       Navigator.push(
              //         context,
              //         MaterialPageRoute(
              //           builder: (context) => ForgetPassword(),
              //         ),
              //       );
              //     },
              //     child: Text(
              //       'Forget password?',
              //       style: Theme.of(context).textTheme.bodyMedium,
              //     )),
              TextButton(
                child: RichText(
                    text: TextSpan(
                        text: 'Don\'t have an account?',
                        style: Theme.of(context).textTheme.bodyMedium,
                        children: [
                      TextSpan(
                        text: " Sign Up".hardcoded,
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(color: Theme.of(context).primaryColor),
                      )
                    ])),
                onPressed: () {
                  GoRouter.of(context).push(Routes.signUp);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onLogin() {
    FocusScope.of(context).unfocus();
    if (_formKey.currentState!.validate()) {
      context.read<AuthBloc>().add(LoginEv(
            email: _email,
            password: _password,
          ));
    }
  }
}
