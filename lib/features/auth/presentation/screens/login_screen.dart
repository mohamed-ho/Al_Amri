import 'package:alamri_adm/config/routes/app_routes.dart';
import 'package:alamri_adm/core/utils/app_colors.dart';
import 'package:alamri_adm/core/widgets/custom_error_widget.dart';
import 'package:alamri_adm/features/auth/domain/entities/admin.dart';
import 'package:alamri_adm/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController userNameController = TextEditingController();

  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> globalKey = GlobalKey();
  bool hidePassword = false;
  bool isLoading = false;

  @override
  void dispose() {
    super.dispose();
    userNameController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthLoadingState) {
            setState(() {
              isLoading = true;
            });
          } else if (state is AuthUnCorrectAccountState) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('هنالك خطا فى  اسم المستخدم او كلمة المرور'),
              backgroundColor: Colors.red,
            ));
            setState(() {
              isLoading = false;
            });
          } else if (state is AuthErrorState) {
            setState(() {
              isLoading = false;
            });
            CustomErrorWidget(
              content: 'هنالك خطا اثناء تسجيل الدخول',
              ontap: () {},
              title: "خطا فى تسجيل الدخول",
            );
          } else if (state is AuthCorrectAccountState) {
            setState(() {
              isLoading = false;
            });
            Navigator.pushNamedAndRemoveUntil(
              context,
              Routes.inisialRoute,
              (route) => true,
            );
          }
        },
        child: isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Center(
                child: Container(
                  decoration: BoxDecoration(boxShadow: const [
                    BoxShadow(
                        blurRadius: 3, color: Colors.grey, spreadRadius: 5)
                  ], color: AppColors.newLogoBackgroundColors),
                  height: .5.sh,
                  width: ScreenUtil().screenWidth > 1000 ? .5.sw : .8.sw,
                  child: Form(
                    key: globalKey,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Text(
                              'Login',
                              style: TextStyle(
                                  fontSize: 28.sp, fontWeight: FontWeight.bold),
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'من فضلك ادخل اسم المستخدم';
                              }
                              return null;
                            },
                            controller: userNameController,
                            decoration: InputDecoration(
                              label: const Text(
                                'اسم المستخدم ',
                                style: TextStyle(fontSize: 18),
                              ),
                              floatingLabelAlignment:
                                  FloatingLabelAlignment.start,
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(9),
                                  borderSide:
                                      const BorderSide(color: Colors.white)),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(9),
                                  borderSide:
                                      const BorderSide(color: Colors.white)),
                              fillColor: Colors.white,
                              filled: true,
                            ),
                          ),
                          const SizedBox(
                            height: 34,
                          ),
                          TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'من فضلك ادخل كلمة المرور';
                              }
                              return null;
                            },
                            controller: passwordController,
                            decoration: InputDecoration(
                                label: const Text(
                                  'كلمة المرور',
                                  style: TextStyle(fontSize: 18),
                                ),
                                floatingLabelAlignment:
                                    FloatingLabelAlignment.start,
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(9),
                                    borderSide:
                                        const BorderSide(color: Colors.white)),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(9),
                                    borderSide:
                                        const BorderSide(color: Colors.white)),
                                fillColor: Colors.white,
                                filled: true,
                                suffixIcon: hidePassword
                                    ? IconButton(
                                        onPressed: () => setState(() {
                                              hidePassword = !hidePassword;
                                            }),
                                        icon: const Icon(Icons.visibility_off))
                                    : IconButton(
                                        onPressed: () => setState(() {
                                              hidePassword = !hidePassword;
                                            }),
                                        icon: const Icon(Icons.visibility))),
                            obscureText: hidePassword,
                          ),
                          const SizedBox(
                            height: 60,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              if (globalKey.currentState!.validate()) {
                                BlocProvider.of<AuthBloc>(context).add(
                                    AuthLoginEvent(
                                        admin: Admin(
                                            userName: userNameController.text,
                                            password:
                                                passwordController.text)));
                              }
                            },
                            style: ElevatedButton.styleFrom(),
                            child: Text(
                              'Login',
                              style: TextStyle(fontSize: 16.spMax),
                            ),
                          )
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
