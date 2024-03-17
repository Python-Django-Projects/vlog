import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:trend/config/locale/app_localizations.dart';
import '../../../../config/routes/app_routes.dart';
import '../../../../core/utils/toast_utils.dart';
import '../../../../core/utils/validation.dart';
import '../../../../core/widgets/custom_text_form_field.dart';
import '../../../../core/widgets/overlay_loading_page.dart';
import '../../data/models/register_form_data.dart';
import '../bloc/auth_bloc/auth_bloc.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // _usernameController.text = "rabeeomran";
    // _passwordController.text = "rabeeomran";
    // _emailController.text = "rabeeomran2@gmail.com";
    super.initState();
  }

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
            ToastUtils(context).showCustomToast(
                message: "Account has been created, please login.".hardcoded);
            GoRouter.of(context).go(Routes.login);
          }
        },
        builder: (context, state) {
          return OverlayLoadingPage(
            isLoading: state is AuthLoadingState,
            child: Scaffold(
              appBar: AppBar(
                leading: IconButton(
                    onPressed: () {
                      GoRouter.of(context).pop();
                    },
                    icon: Icon(
                      Icons.close,
                      color: Theme.of(context).highlightColor,
                      size: 26.sp,
                    )),
              ),
              body: _buildRegisterForm(state is AuthLoadingState),
            ),
          );
        },
      ),
    );
  }

  Widget _buildRegisterForm(bool isLoading) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(30.sp).copyWith(top: 2.sp),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Text(
                "Create account".hardcoded,
                style: Theme.of(context)
                    .textTheme
                    .displayMedium
                    ?.copyWith(fontWeight: FontWeight.bold, fontSize: 24.sp),
              ),
            ),
            SizedBox(height: 20.sp),
            Center(
              child: Text(
                "Pick a username for your new account. You can always change it later."
                    .hardcoded,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
            SizedBox(height: 80.sp),
            CustomTextFormField(
              labelText: "Username".hardcoded,
              controller: _usernameController,
              keyboardType: TextInputType.name,
              validator: (value) => Validation.validateUsername(value, context),
              textInputAction: TextInputAction.next,
            ),
            SizedBox(height: 20.sp),
            CustomTextFormField(
              labelText: "E-mail".hardcoded,
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              validator: (value) => Validation.validateEmail(value, context),
              textInputAction: TextInputAction.next,
            ),
            SizedBox(height: 20.sp),
            CustomTextFormField(
              controller: _passwordController,
              labelText: "Password".hardcoded,
              obscureText: true,
              textInputAction: TextInputAction.next,
              validator: (value) => Validation.validatePassword(value, context),
            ),
            // SizedBox(height: 20.sp),
            // CustomTextFormField(
            //   prefixIcon: const Icon(Icons.lock),
            //   labelText: "Confirm password",
            //   validator: (value) => Validation.validateConfirmedPassword(
            //       _passwordController.text, value, context),
            //   obscureText: true,
            //   textInputAction: TextInputAction.done,
            // ),
            const SizedBox(height: 30),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    minimumSize: Size(MediaQuery.sizeOf(context).width, 42.sp)),
                onPressed: _onRegister,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.sp),
                  child: Text(
                    "Register".hardcoded,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onRegister() {
    FocusScope.of(context).unfocus();

    if (_formKey.currentState!.validate()) {
      context.read<AuthBloc>().add(RegisterEv(
              formData: RegisterFormData(
            username: _usernameController.text.trim(),
            email: _emailController.text.trim(),
            password: _passwordController.text.trim(),
          )));
    }
  }
}
