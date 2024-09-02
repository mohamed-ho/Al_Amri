import 'dart:io';
import 'package:alamri_adm/admain_feature/domain/entities/type.dart';
import 'package:alamri_adm/admain_feature/presentation/widgets/custom_add_honey_text_form_field.dart';
import 'package:alamri_adm/core/utils/app_colors.dart';
import 'package:alamri_adm/core/utils/functions.dart';
import 'package:alamri_adm/offer_feature/domain/entities/offer.dart';
import 'package:alamri_adm/offer_feature/presentation/bloc/offer_bloc.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

class AddOfferFormWidget extends StatefulWidget {
  const AddOfferFormWidget({super.key, required this.types});
  final List<HoneyType> types;
  @override
  State<AddOfferFormWidget> createState() => _AddOfferFormWidgetState();
}

class _AddOfferFormWidgetState extends State<AddOfferFormWidget> {
  bool isUpdate = false;
  final priceController = TextEditingController();
  final numberOfJarController = TextEditingController();
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final discountController = TextEditingController();

  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _localKey = GlobalKey<FormState>();

  @override
  void dispose() {
    priceController.dispose();
    numberOfJarController.dispose();
    titleController.dispose();
    descriptionController.dispose();
    discountController.dispose();
    super.dispose();
  }

  // this is code
  HoneyType? value;
  bool imageUplaoded = false;
  ImagePicker imagePicker = ImagePicker();
  XFile? file;
  File? image;
  List<HoneyType> selectedTypes = [];
  List<int> numberOfJar = [];
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _globalKey,
      child: Center(
        child: SizedBox(
          width: .8.sw,
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
                          webIcon: Image.asset('assets/icons/item.png'),
                          textEditingController: titleController,
                          lable: getTranslation("title", context),
                          validator: (text) {
                            if (text!.isEmpty) {
                              return getTranslation(
                                  "empty_validator_text", context);
                            }
                            return null;
                          }),
                      CustomAddHoneyTextFormField(
                          webIcon: Image.asset('assets/icons/description.png'),
                          textEditingController: descriptionController,
                          lable: getTranslation("description", context),
                          validator: (text) {
                            if (text!.isEmpty) {
                              return getTranslation(
                                  "empty_validator_text", context);
                            }

                            return null;
                          }),
                      Form(
                        key: _localKey,
                        child: Column(
                          children: [
                            DropdownButtonHideUnderline(
                                child: DropdownButton2<HoneyType>(
                              isExpanded: true,
                              hint: Text(
                                getTranslation("select_honey_type", context),
                                style: TextStyle(
                                  fontSize: 14.spMax,
                                  color: Theme.of(context).hintColor,
                                ),
                              ),
                              items: widget.types
                                  .map((HoneyType e) => DropdownMenuItem(
                                      value: e,
                                      child: Container(
                                        margin: EdgeInsets.symmetric(
                                            vertical: 10.w),
                                        padding: EdgeInsets.symmetric(
                                            vertical: 10.w, horizontal: 10.w),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(16.w),
                                            color:
                                                AppColors.backgroundItemsColor),
                                        child: Column(
                                          children: [
                                            Text(
                                              e.name,
                                              style: const TextStyle(
                                                  color: Colors.black),
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Image.asset(
                                                  'assets/icons/weight.png',
                                                  width: 30.w,
                                                  height: 30.w,
                                                ),
                                                SizedBox(
                                                  width: 30.w,
                                                ),
                                                Text(
                                                  "${getTranslation("weight", context)}  ${e.jarQuantity}  ${getTranslation("gram", context)}",
                                                  style: const TextStyle(
                                                      color: Colors.black),
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                      )))
                                  .toList(),
                              value: value,
                              onChanged: (v) {
                                setState(() {
                                  value = v;
                                });
                              },
                              buttonStyleData: ButtonStyleData(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16),
                                  height: .1.sh,
                                  decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(.9),
                                      boxShadow: [
                                        BoxShadow(
                                          color: AppColors.primaryColor,
                                          blurRadius: 3.w,
                                        )
                                      ],
                                      borderRadius:
                                          BorderRadius.circular(10.w))),
                              dropdownStyleData: const DropdownStyleData(
                                maxHeight: 200,
                              ),
                              menuItemStyleData:
                                  MenuItemStyleData(height: .1.sh),
                              dropdownSearchData: DropdownSearchData(
                                searchInnerWidget: Container(
                                  height: .1.sh,
                                  padding: const EdgeInsets.only(
                                    top: 8,
                                    bottom: 4,
                                    right: 8,
                                    left: 8,
                                  ),
                                  child: TextFormField(
                                    expands: true,
                                    maxLines: null,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return getTranslation(
                                            "please_choose_honey_type",
                                            context);
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      isDense: true,
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                        horizontal: 10,
                                        vertical: 8,
                                      ),
                                      hintText: 'Search for an item...',
                                      hintStyle: const TextStyle(fontSize: 12),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                  ),
                                ),
                                searchInnerWidgetHeight: .1.sh,
                                searchMatchFn: (item, searchValue) {
                                  return item.value
                                      .toString()
                                      .contains(searchValue);
                                },
                              ),
                              onMenuStateChange: (isOpen) {
                                if (!isOpen) {
                                  priceController.clear();
                                }
                              },
                            )),
                            CustomAddHoneyTextFormField(
                                webIcon: Image.asset(
                                    'assets/icons/number_of_jar.png'),
                                textEditingController: numberOfJarController,
                                lable: getTranslation(
                                    "lable_honey_type_number_of_jar", context),
                                validator: (text) {
                                  if (value == null) {
                                    return getTranslation(
                                        "please_choose_honey_type", context);
                                  }
                                  if (int.tryParse(text!) == null) {
                                    return getTranslation(
                                        "parse_validator_text_to_int", context);
                                  }
                                  if (int.parse(text) > value!.numberOfJar) {
                                    return getTranslation(
                                        "number_of_jar_Less_than", context);
                                  }
                                  return null;
                                }),
                            Visibility(
                                visible: selectedTypes.isNotEmpty,
                                child: SizedBox(
                                  height: 100.h,
                                  child: ListView.builder(
                                      itemCount: selectedTypes.length,
                                      itemBuilder: (context, index) {
                                        return Column(
                                          children: [
                                            Text(
                                              selectedTypes[index].name,
                                              style: const TextStyle(
                                                  color: Colors.black),
                                            ),
                                            Row(
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Image.asset(
                                                      'assets/icons/weight.png',
                                                      width: 30.w,
                                                      height: 30.w,
                                                    ),
                                                    SizedBox(
                                                      width: 30.w,
                                                    ),
                                                    Text(
                                                      "${getTranslation("weight", context)}  ${selectedTypes[index].jarQuantity}  ${getTranslation("gram", context)}",
                                                      style: const TextStyle(
                                                          color: Colors.black),
                                                    )
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    Image.asset(
                                                      'assets/icons/number_of_jar.png',
                                                      height: 30.w,
                                                      width: 30.w,
                                                    ),
                                                    Text(
                                                        "${getTranslation("lable_honey_type_number_of_jar", context)}  ${numberOfJar[index]} ${getTranslation('jar', context)}")
                                                  ],
                                                )
                                              ],
                                            )
                                          ],
                                        );
                                      }),
                                )),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    if (_localKey.currentState!.validate()) {
                                      selectedTypes.add(value!);
                                      numberOfJar.add(int.parse(
                                          numberOfJarController.text));

                                      value = null;
                                      numberOfJarController.clear();
                                      setState(() {});
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.green,
                                      foregroundColor: Colors.white),
                                  child: Row(
                                    children: [
                                      Text(getTranslation("add_type", context)),
                                      Icon(
                                        Icons.add,
                                        size: 30.w,
                                      )
                                    ],
                                  ),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    selectedTypes = [];
                                    numberOfJar = [];
                                    numberOfJarController.clear();
                                    value = null;
                                    setState(() {});
                                  },
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.red,
                                      foregroundColor: Colors.white),
                                  child: Row(
                                    children: [
                                      Text(getTranslation("delete", context)),
                                      Icon(Icons.delete_forever, size: 30.w)
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 10.h),
                        child: CustomAddHoneyTextFormField(
                          lable: getTranslation("enter_price", context),
                          textEditingController: priceController,
                          webIcon: Image.asset(
                            'assets/icons/price.png',
                            width: 30.w,
                            height: 30.w,
                          ),
                          validator: (text) {
                            if (int.tryParse(text!) == null) {
                              return getTranslation(
                                  "parse_validator_text_to_int", context);
                            }
                            return null;
                          },
                        ),
                      ),
                      CustomAddHoneyTextFormField(
                        lable: getTranslation("disCount", context),
                        textEditingController: discountController,
                        webIcon: Image.asset(
                          'assets/icons/offer.png',
                          width: 30.w,
                          height: 30.w,
                        ),
                        validator: (text) {
                          if (int.tryParse(text!) == null) {
                            return getTranslation(
                                "parse_validator_text_to_int", context);
                          }
                          return null;
                        },
                      ),
                      ElevatedButton(
                        onPressed: () {
                          showModalBottomSheet(
                              context: context,
                              builder: (context) {
                                return SizedBox(
                                  height: .25.sh,
                                  child: Column(
                                    children: [
                                      Text(
                                        getTranslation(
                                            "choose_image_from", context),
                                        style: TextStyle(
                                            fontSize: 18.spMax,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      ChooseImageButton(
                                        title: getTranslation(
                                            "choose_image_from_camera",
                                            context),
                                        image: "assets/icons/camera.png",
                                        onPressed: () async {
                                          file = await imagePicker.pickImage(
                                              source: ImageSource.camera);
                                          if (file != null) {
                                            imageUplaoded = true;
                                          }
                                          setState(() {});
                                        },
                                      ),
                                      ChooseImageButton(
                                        title: getTranslation(
                                            "choose_image_from_gallery",
                                            context),
                                        image: "assets/icons/gallery.png",
                                        onPressed: () async {
                                          file = await imagePicker.pickImage(
                                              source: ImageSource.gallery);
                                          if (file != null) {
                                            imageUplaoded = true;
                                          }
                                          setState(() {});
                                        },
                                      )
                                    ],
                                  ),
                                );
                              });
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: isUpdate && imageUplaoded
                                ? Colors.green
                                : isUpdate
                                    ? Colors.yellow
                                    : imageUplaoded
                                        ? Colors.green
                                        : Colors.red,
                            foregroundColor: Colors.white),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              "assets/icons/upload.png",
                              width: 30.w,
                              height: 30.w,
                            ),
                            const SizedBox(
                              width: 30,
                            ),
                            Text(
                              getTranslation("upload_image", context),
                              style: TextStyle(fontSize: 16.spMax),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 10.h),
                        child: ElevatedButton(
                          onPressed: () {
                            file != null
                                ? image = File(file!.path)
                                : ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                        backgroundColor: Colors.red,
                                        elevation: 5,
                                        padding: EdgeInsets.all(10.w),
                                        content: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Image.asset(
                                              'assets/icons/error.png',
                                              width: 22,
                                              height: 22,
                                            ),
                                            Text(getTranslation(
                                                "please_choose_the_image",
                                                context)),
                                          ],
                                        )));
                            if (_globalKey.currentState!.validate()) {
                              if (selectedTypes.isNotEmpty && image != null) {
                                BlocProvider.of<OfferBloc>(context).add(
                                    AddOfferEvent(
                                        offer: Offer(
                                            id: 1,
                                            title: titleController.text,
                                            description:
                                                descriptionController.text,
                                            typesId: _convertTypesToTypesId(
                                                selectedTypes),
                                            price:
                                                int.parse(priceController.text),
                                            discount: int.parse(
                                                discountController.text),
                                            quantity: numberOfJar,
                                            image: "image",
                                            imageFile: image)));
                                priceController.clear();
                                titleController.clear();
                                descriptionController.clear();
                                priceController.clear();
                                discountController.clear();
                                selectedTypes = [];
                                numberOfJar = [];
                                value = null;
                              } else if (selectedTypes.isEmpty) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                        backgroundColor: Colors.red,
                                        elevation: 5,
                                        padding: EdgeInsets.all(10.w),
                                        content: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Image.asset(
                                              'assets/icons/error.png',
                                              width: 22,
                                              height: 22,
                                            ),
                                            Text(getTranslation(
                                                "please_choose_honey_type",
                                                context)),
                                          ],
                                        )));
                              }
                            }
                          },
                          style: const ButtonStyle(
                              elevation: WidgetStatePropertyAll(4),
                              shadowColor:
                                  WidgetStatePropertyAll(Colors.yellow),
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
                                  getTranslation("add_type", context),
                                  style: TextStyle(
                                      fontSize: 16.sp, color: Colors.blue),
                                )
                              ],
                            ),
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

List<int> _convertTypesToTypesId(List<HoneyType> types) {
  List<int> res = [];
  for (var e in types) {
    res.add(e.id);
  }
  return res;
}

// ignore: must_be_immutable
class ChooseImageButton extends StatelessWidget {
  ChooseImageButton(
      {super.key,
      required this.image,
      required this.title,
      required this.onPressed});
  final String image;
  final String title;
  Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.w),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.w)),
            backgroundColor: Colors.white.withOpacity(.5),
            elevation: 5,
            shadowColor: AppColors.primaryColor),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20.w, horizontal: 10.w),
          child: Row(
            children: [
              Image.asset(
                image,
                width: 30.w,
                height: 30.w,
              ),
              Text(title)
            ],
          ),
        ),
      ),
    );
  }
}
