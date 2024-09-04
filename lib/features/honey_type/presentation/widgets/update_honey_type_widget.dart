import 'package:alamri_adm/core/utils/app_colors.dart';
import 'package:alamri_adm/core/utils/functions.dart';
import 'package:alamri_adm/features/honey_type/domain/entities/type.dart';
import 'package:alamri_adm/features/honey_type/presentation/bloc/honey_type_bloc.dart';
import 'package:alamri_adm/features/honey_type/presentation/widgets/custom_add_honey_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UpdateHoneyTypeWidget extends StatefulWidget {
  const UpdateHoneyTypeWidget({
    super.key,
    required this.honeyType,
  });
  final HoneyType honeyType;
  @override
  State<UpdateHoneyTypeWidget> createState() => _UpdateHoneyTypeWidgetState();
}

class _UpdateHoneyTypeWidgetState extends State<UpdateHoneyTypeWidget> {
  final nameController = TextEditingController();

  final descriptionController = TextEditingController();

  final numberOfJarController = TextEditingController();

  final weightOfJarController = TextEditingController();

  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    nameController.text = widget.honeyType.name;
    numberOfJarController.text = widget.honeyType.numberOfJar.toString();
    weightOfJarController.text = widget.honeyType.jarQuantity.toString();
    descriptionController.text = widget.honeyType.description;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _globalKey,
      child: Center(
        child: SizedBox(
          width: .6.sw,
          child: SingleChildScrollView(
            child: IntrinsicHeight(
              child: Card(
                shadowColor: AppColors.secondColor,
                elevation: 5,
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 20.w, horizontal: 20.w),
                  child: Column(
                    children: [
                      CustomAddHoneyTextFormField(
                        lable: getTranslation('lable_honey_type_name', context),
                        textEditingController: nameController,
                        webIcon: Image.asset(
                          'assets/icons/name.png',
                          width: 30.w,
                          height: 30.w,
                        ),
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return getTranslation(
                                "empty_validator_text", context);
                          }
                          return null;
                        },
                      ),
                      CustomAddHoneyTextFormField(
                        webIcon: Image.asset('assets/icons/number_of_jar.png'),
                        textEditingController: numberOfJarController,
                        lable: getTranslation(
                            'lable_honey_type_number_of_jar', context),
                        validator: (String? value) {
                          if (value == null) {
                            return getTranslation(
                                "empty_validator_text", context);
                          }
                          if (int.tryParse(value) == null) {
                            return getTranslation(
                                "parse_validator_text_to_int", context);
                          }
                          return null;
                        },
                        // keyboardType: TextInputType.number,
                      ),
                      CustomAddHoneyTextFormField(
                        webIcon: Image.asset('assets/icons/weight.png'),
                        validator: (String? value) {
                          if (value == null) {
                            return getTranslation(
                                "empty_validator_text", context);
                          }
                          if (int.tryParse(value) == null) {
                            return getTranslation(
                                "parse_validator_text_to_int", context);
                          }
                          return null;
                        },
                        textEditingController: weightOfJarController,
                        lable: getTranslation(
                            'lable_honey_type_jar_quantity', context),
                        // keyboardType: TextInputType.number,
                      ),
                      CustomAddHoneyTextFormField(
                        minlines: 5,
                        lable: getTranslation(
                            'lable_honey_type_description', context),
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return getTranslation(
                                "empty_validator_text", context);
                          }
                          return null;
                        },
                        textEditingController: descriptionController,
                        webIcon: Image.asset(
                          'assets/icons/description.png',
                          width: 30.w,
                          height: 30.w,
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          if (_globalKey.currentState!.validate()) {
                            print(numberOfJarController.text);
                            BlocProvider.of<HoneyTypeBloc>(context).add(
                              UpdateHoneyTypeEvent(
                                honeyType: HoneyType(
                                    id: widget.honeyType.id,
                                    name: nameController.text,
                                    numberOfJar:
                                        int.parse(numberOfJarController.text),
                                    jarQuantity:
                                        int.parse(weightOfJarController.text),
                                    description: descriptionController.text),
                              ),
                            );
                            nameController.clear();
                            numberOfJarController.clear();
                            weightOfJarController.clear();
                            descriptionController.clear();
                          }
                        },
                        style: const ButtonStyle(
                            elevation: WidgetStatePropertyAll(4),
                            shadowColor: WidgetStatePropertyAll(Colors.yellow),
                            backgroundColor: WidgetStatePropertyAll(
                                Color.fromARGB(255, 236, 225, 127))),
                        child: IntrinsicWidth(
                          child: Row(
                            children: [
                              Image.asset(
                                "assets/icons/save.png",
                                width: 30.w,
                                height: 30.w,
                              ),
                              Text(
                                getTranslation('update', context),
                                style: TextStyle(
                                    fontSize: 16.sp, color: Colors.blue),
                              )
                            ],
                          ),
                        ),
                      )
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
}
