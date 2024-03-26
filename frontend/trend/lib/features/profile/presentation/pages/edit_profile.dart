import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:trend/config/locale/app_localizations.dart';
import 'package:trend/core/resources/color_manager.dart';
import 'package:trend/core/utils/media_picker_utils.dart';
import '../../../../core/utils/validation.dart';
import '../../../../core/widgets/custom_cached_image.dart';
import '../../../../core/widgets/custom_text_form_field.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  String? fileUrl;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit profile'.hardcoded),
        actions: [
          TextButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {}
            },
            child: Text(
              "Save".hardcoded,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.sp),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.sp),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    width: 150.sp,
                    height: 150.sp,
                  ),
                  CustomCachedImageWidget(
                    addBorder: true,
                    size: 120.sp,
                    radius: 100.sp,
                    imageUrl:
                        "https://www.thefashionisto.com/wp-content/uploads/2021/03/Attractive-Man-Selfie-Sunglasses-Smiling.jpg",
                    fileUrl: fileUrl,
                  ),
                  Positioned(
                    bottom: 20.sp,
                    right: 20.sp,
                    child: GestureDetector(
                      onTap: () async {
                        await _pickImage(context);
                      },
                      child: CircleAvatar(
                        radius: 14.sp,
                        backgroundColor: Theme.of(context).primaryColor,
                        child: Center(
                          child: Icon(
                            Icons.edit,
                            color: kWhiteColor,
                            size: 15.sp,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Gap(20.sp),
              CustomTextFormField(
                labelText: 'Username'.hardcoded,
                controller: _usernameController,
                validator: (value) =>
                    Validation.validateUsername(value, context),
              ),
              Gap(20.sp),
              CustomTextFormField(
                labelText: 'Email'.hardcoded,
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                validator: (value) => Validation.validateEmail(value, context),
              ),
              Gap(20.sp),
              CustomTextFormField(
                maxLines: 3,
                labelText: 'Bio'.hardcoded,
                controller: _bioController,
                validator: (value) {
                  // Bio can be empty
                  return null;
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _pickImage(BuildContext context) async {
    final pickedImage =
        await MediaPickerUtils().showImageSourceModalThenPick(context);
    if (pickedImage != null) {
      fileUrl = pickedImage.path;
      setState(() {});
    }
  }
}
