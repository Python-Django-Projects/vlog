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
    _usernameController.text = "rabeeomran";
    _passwordController.text = "rabeeomran";
    _emailController.text = "rabeeomran2@gmail.com";
    super.initState();
  }

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
              title: Text("Sign Up".hardcoded),
            ),
            body: _buildRegisterForm(state is AuthLoadingState),
          ),
        );
      },
    );
  }

  Widget _buildRegisterForm(bool isLoading) {
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
                labelText: "Username".hardcoded,
                prefixIcon: const Icon(Icons.email),
                controller: _usernameController,
                keyboardType: TextInputType.name,
                validator: (value) =>
                    Validation.validateUsername(value, context),
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: 20),
              CustomTextFormField(
                labelText: "E-mail".hardcoded,
                prefixIcon: const Icon(Icons.email),
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                validator: (value) => Validation.validateEmail(value, context),
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: 20),
              CustomTextFormField(
                controller: _passwordController,
                labelText: "Password".hardcoded,
                prefixIcon: const Icon(Icons.lock),
                obscureText: true,
                textInputAction: TextInputAction.next,
                validator: (value) =>
                    Validation.validatePassword(value, context),
              ),
              const SizedBox(height: 20),
              CustomTextFormField(
                prefixIcon: const Icon(Icons.lock),
                labelText: "Confirm password",
                validator: (value) => Validation.validateConfirmedPassword(
                    _passwordController.text, value, context),
                obscureText: true,
                textInputAction: TextInputAction.done,
              ),
              const SizedBox(height: 30),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      minimumSize: Size(MediaQuery.sizeOf(context).width, 45)),
                  onPressed: _onRegister,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text("Register".hardcoded),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              TextButton(
                child: RichText(
                    text: TextSpan(
                        text: 'Already have account? ',
                        style: Theme.of(context).textTheme.bodyMedium,
                        children: [
                      TextSpan(
                        text: "Login".hardcoded,
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(color: Theme.of(context).primaryColor),
                      )
                    ])),
                onPressed: () {
                  GoRouter.of(context).pop();
                },
              ),
            ],
          ),
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



// import 'package:flutter/material.dart';
// import 'package:trend/features/authentication/data/data_source/remote_data_source.dart';
// import 'package:trend/features/authentication/presentation/pages/login_page.dart';

// class RegisterPage extends StatefulWidget {
//   const RegisterPage({super.key});

//   @override
//   State<RegisterPage> createState() => _RegisterPageState();
// }

// TextEditingController emailController = TextEditingController();
// TextEditingController usernameController = TextEditingController();
// TextEditingController passwordController = TextEditingController();
// TextEditingController confirmPasswordController = TextEditingController();

// class _RegisterPageState extends State<RegisterPage> {
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         body: Center(
//           child: Container(
//             width: 300,
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Spacer(flex: 2),
//                 Container(
//                   height: 50, // Set the desired height here
//                   child: TextField(
//                     controller: emailController,
//                     decoration: InputDecoration(
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                       focusedBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(10),
//                         borderSide: BorderSide(
//                             color: Colors
//                                 .blue), // Set the desired border color here
//                       ),
//                       labelText: 'email',
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: 20),
//                 Container(
//                   height: 50, // Set the desired height here
//                   child: TextField(
//                     controller: usernameController,
//                     decoration: InputDecoration(
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                       focusedBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(10),
//                         borderSide: const BorderSide(color: Colors.blue),
//                       ),
//                       labelText: 'username',
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 20),
//                 Container(
//                   height: 50,
//                   child: TextField(
//                     controller: passwordController,
//                     decoration: InputDecoration(
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                       focusedBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(10),
//                         borderSide: BorderSide(
//                             color: Colors
//                                 .blue), // Set the desired border color here
//                       ),
//                       labelText: 'password',
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: 20),
//                 Container(
//                   height: 50, // Set the desired height here
//                   child: TextField(
//                     controller: confirmPasswordController,
//                     decoration: InputDecoration(
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                       focusedBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(10),
//                         borderSide: BorderSide(
//                             color: Colors
//                                 .blue), // Set the desired border color here
//                       ),
//                       labelText: 'confirm password',
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: 20),
//                 SizedBox(
//                   width: double.infinity,
//                   // Set the desired width here
//                   child: ElevatedButton(
//                     onPressed: () {
//                       createAccount(
//                           emailController.text.toString(),
//                           usernameController.text.toString(),
//                           passwordController.text.toString(),
//                           passwordController.text.toString());
//                       // Navigator.push(
//                       //   context,
//                       //   MaterialPageRoute(
//                       //     builder: (context) => HomePage(),
//                       //   ),
//                       // );
//                     },
//                     style: ElevatedButton.styleFrom(
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                       backgroundColor:
//                           Colors.blue, // Set the desired color here
//                     ),
//                     child: const Text(
//                       'Register',
//                       style: TextStyle(
//                           fontSize: 16,
//                           color: Colors.white,
//                           fontWeight: FontWeight.bold),
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: 20),
//                 Row(
//                   children: [
//                     Expanded(
//                       child: Container(
//                         height: 1,
//                         color: Colors.grey,
//                       ),
//                     ),
//                     SizedBox(width: 10),
//                     Text('OR'),
//                     SizedBox(width: 10),
//                     Expanded(
//                       child: Container(
//                         height: 1,
//                         color: Colors.grey,
//                       ),
//                     ),
//                   ],
//                 ),
//                 Spacer(),
//                 Container(
//                   width: double.infinity,
//                   child: ElevatedButton(
//                     onPressed: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => RegisterPage(),
//                         ),
//                       );
//                     },
//                     child: Text(
//                       'back to login',
//                       style: TextStyle(fontWeight: FontWeight.bold),
//                     ),
//                     style: ElevatedButton.styleFrom(
//                       foregroundColor: Colors.black,
//                       backgroundColor: Color.fromARGB(255, 240, 240, 240),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: 20),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
