import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:trend/config/locale/app_localizations.dart';
import 'package:trend/core/widgets/outline_app_button.dart';
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
    return SafeArea(
      top: true,
      bottom: true,
      child: BlocConsumer<AuthBloc, AuthState>(
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
              bottomNavigationBar: Padding(
                padding: EdgeInsets.all(30.sp),
                child: OutlineAppButton(
                  text: "Create new account".hardcoded,
                  onTap: () {
                    GoRouter.of(context).push(Routes.signUp);
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildLoginForm() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(30.sp),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 100.sp),
            SizedBox(height: 76.sp, child: const FullLogo()),
            SizedBox(height: 80.sp),
            CustomTextFormField(
              labelText: "E-mail".hardcoded,
              onChange: (value) {
                _email = value.trim();
              },
              keyboardType: TextInputType.emailAddress,
              validator: (value) => Validation.validateEmail(_email, context),
              textInputAction: TextInputAction.next,
            ),
            SizedBox(height: 20.sp),
            CustomTextFormField(
              labelText: "Password".hardcoded,
              suffixIcon: IconButton(
                onPressed: () => setState(() {
                  _obscurePassword = !_obscurePassword;
                }),
                icon: Icon(
                  _obscurePassword ? Icons.visibility_off : Icons.visibility,
                  color: Theme.of(context).hintColor,
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
            SizedBox(height: 20.sp),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    minimumSize: Size(MediaQuery.sizeOf(context).width, 42.sp)),
                onPressed: _onLogin,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.sp),
                  child: Text(
                    "Log in".hardcoded,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            SizedBox(height: 12.sp),
            TextButton(
                onPressed: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => ForgetPassword(),
                  //   ),
                  // );
                },
                child: Text(
                  'Forget password?',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(fontWeight: FontWeight.w500, fontSize: 14.sp),
                )),
          ],
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
