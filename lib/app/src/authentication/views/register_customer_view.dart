import 'package:flaury_mobile/app/config/size_config.dart';
import 'package:flaury_mobile/app/routes/app_routes.dart';
import 'package:flaury_mobile/app/shared/app_colors.dart';
import 'package:flaury_mobile/app/shared/app_text_style.dart';
import 'package:flaury_mobile/app/shared/custom_padding.dart';
import 'package:flaury_mobile/app/shared/util/images_icons_illustration.dart';
import 'package:flaury_mobile/app/shared/util/validator.dart';
import 'package:flaury_mobile/app/shared/widgets/textfield.dart';
import 'package:flaury_mobile/app/shared/widgets/custom_button.dart';
import 'package:flaury_mobile/app/src/authentication/providers/provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class RegisterCustomerView extends StatefulHookConsumerWidget {
  const RegisterCustomerView({super.key});

  @override
  ConsumerState<RegisterCustomerView> createState() =>
      _RegisterCustomerViewState();
}

class _RegisterCustomerViewState extends ConsumerState<RegisterCustomerView> {
  final GlobalKey _formkey = GlobalKey<FormState>();
  final TextEditingController _namecontroller = TextEditingController();
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _passwordcontroller = TextEditingController();
  final TextEditingController _phonecontroller = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _emailcontroller.dispose();
    _namecontroller.dispose();
    _passwordcontroller.dispose();
    _phonecontroller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final obscurePassword = ref.watch(passwordvisible);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.background,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          child: SafeArea(
            child: Form(
              key: _formkey,
              child: SymetricPadding(
                h: 20,
                v: 0,
                child: Column(
                  children: [
                    // appbar
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const ImageIcon(AssetImage(back), size: 20),
                        ),
                        SizedBox(
                          width: SizeConfig.fromDesignHeight(context, 4),
                        ),
                        AppTextBold(text: 'Create your account', fontSize: 24)
                      ],
                    ),

                    SizedBox(
                      height: SizeConfig.fromDesignHeight(context, 20),
                    ),

                    //name textfield
                    AuthTextfield(
                      hintext: 'Becca Braunch',
                      obscureText: false,
                      validator: Validator.nameValidator,
                      controller: _namecontroller,
                      label: 'Name',
                    ),

                    SizedBox(
                      height: SizeConfig.fromDesignHeight(context, 20),
                    ),

                    //email textfield
                    AuthTextfield(
                      hintext: 'info@flaury.email.com',
                      obscureText: false,
                      validator: Validator.emailValidator,
                      controller: _emailcontroller,
                      label: 'Email Address',
                      keyboardType: TextInputType.emailAddress,
                    ),
                    SizedBox(
                      height: SizeConfig.fromDesignHeight(context, 20),
                    ),

                    //phone number textfield
                    AuthTextfield(
                      hintext: '08012345678',
                      obscureText: false,
                      validator: Validator.validatePhoneNumber,
                      controller: _phonecontroller,
                      label: 'Phone Number',
                      keyboardType: TextInputType.number,
                    ),

                    SizedBox(
                      height: SizeConfig.fromDesignHeight(context, 20),
                    ),

                    //password field

                    AuthTextfield(
                        hintext: 'Enter Your Password',
                        obscureText: obscurePassword.isPasswordVisible,
                        validator: Validator.passwordValidator,
                        controller: _passwordcontroller,
                        label: 'Password',
                        suffixIcon: GestureDetector(
                          onTap: () {
                            obscurePassword.visiblePassword();
                          },
                          child: Icon(obscurePassword.isPasswordVisible
                              ? Icons.visibility_off
                              : Icons.visibility),
                        )),

                    SizedBox(
                      height: SizeConfig.fromDesignHeight(context, 20),
                    ),

                    //terms and condition text
                    AppTextBold(
                      textAlign: TextAlign.center,
                      text:
                          'Clicking the “continue” button means I agree to the Terms & Conditions and Privacy Policy of FLAURY',
                      fontSize: 10,
                      color: AppColors.primary,
                    ),

                    SizedBox(
                      height: SizeConfig.fromDesignHeight(context, 29),
                    ),

                    //sign up button
                    ListenableBuilder(
                        listenable: Listenable.merge([
                          _emailcontroller,
                          _namecontroller,
                          _phonecontroller,
                          _passwordcontroller,
                        ]),
                        builder: (context, child) {
                          final enable = _emailcontroller.text.isNotEmpty &&
                              _namecontroller.text.isNotEmpty &&
                              _passwordcontroller.text.isNotEmpty &&
                              _phonecontroller.text.isNotEmpty;

                          return enable
                              ? LargeButon(
                                  label: "Sign up",
                                  ontap: () {
                                    // sign in logic
                                  },
                                )
                              : const LargeButonDisabled(
                                  label: 'Sign up', ontap: null);
                        }),

                    SizedBox(
                      height: SizeConfig.fromDesignHeight(context, 27),
                    ),

                    //this routes to the sign in page

                    SizedBox(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AppTextSemiBold(
                            text: "Don’t have an account?  ",
                            fontSize: 14,
                            color: AppColors.grey,
                          ),
                          GestureDetector(
                              onTap: () {
                                //logic goes here
                                Navigator.pushNamed(
                                    context, AppRoutes.signupView);
                              },
                              child: AppTextBold(
                                  text: 'Sign Up',
                                  fontSize: 16,
                                  color: AppColors.primary)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
