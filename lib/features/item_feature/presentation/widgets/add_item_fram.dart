import 'dart:html' as html;
import 'package:alamri_adm/core/widgets/custom_loading_widget.dart';
import 'package:alamri_adm/features/honey_type/domain/entities/type.dart';
import 'package:alamri_adm/features/honey_type/presentation/widgets/custom_add_honey_text_form_field.dart';
import 'package:alamri_adm/al_amri_enjection.dart';
import 'package:alamri_adm/config/routes/app_routes.dart';
import 'package:alamri_adm/core/utils/app_colors.dart';
import 'package:alamri_adm/core/utils/functions.dart';
import 'package:alamri_adm/core/widgets/custom_error_widget.dart';
import 'package:alamri_adm/features/item_feature/domain/entities/item.dart';
import 'package:alamri_adm/features/item_feature/presentation/bloc/items_bloc.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

class AddItemFram extends StatefulWidget {
  const AddItemFram({super.key, required this.types});
  final List<HoneyType> types;

  @override
  State<AddItemFram> createState() => _AddItemFramState();
}

class _AddItemFramState extends State<AddItemFram> {
  bool isUpdate = false;
  final priceController = TextEditingController();
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  // this is code
  HoneyType? value;
  bool imageUplaoded = false;
  ImagePicker imagePicker = ImagePicker();
  bool isLoading = false;
  late html.File image;
  @override
  Widget build(BuildContext context) {
    return BlocListener<ItemsBloc, ItemsState>(
      listener: (context, state) {
        if (state is ItemsLoadingState) {
          setState(() {
            isLoading = true;
          });
        } else if (state is ItemsErrorState) {
          setState(() {
            isLoading = false;
          });
          CustomErrorWidget(
              content: 'هنالك خطا ما من فضلك حاول مره اخرا',
              ontap: () {
                Navigator.pop(context);
              },
              title: 'خطا');
        } else if (state is ItmesLoadedState) {
          setState(() {
            isLoading = false;
          });
          Navigator.pushReplacementNamed(context, Routes.inisialRoute,
              arguments: 1);
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("تم اضافة المنتج بنجاح"),
            backgroundColor: Colors.green,
          ));
        }
      },
      child: isLoading
          ? const CustomLoadingWidget()
          : Form(
              key: _globalKey,
              child: Center(
                child: SizedBox(
                  width: ScreenUtil().screenWidth < 600 ? .8.sw : 550,
                  child: SingleChildScrollView(
                    child: IntrinsicHeight(
                      child: Card(
                        shadowColor: AppColors.secondColor,
                        elevation: 5,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 20.w, horizontal: 20.w),
                          child: Column(
                            children: [
                              DropdownButtonHideUnderline(
                                  child: DropdownButton2<HoneyType>(
                                isExpanded: true,
                                hint: Text(
                                  getTranslation("select_honey_type", context),
                                  style: TextStyle(
                                    fontSize: 18,
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
                                              color: AppColors
                                                  .backgroundItemsColor),
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
                                                    width: 40,
                                                    height: 40,
                                                  ),
                                                  const SizedBox(
                                                    width: 40,
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
                                    height: 200,
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
                                // dropdownStyleData: DropdownStyleData(
                                //   maxHeight: 200,
                                // ),
                                menuItemStyleData:
                                    const MenuItemStyleData(height: 200),
                                dropdownSearchData: DropdownSearchData(
                                  searchController: priceController,
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
                                      controller: priceController,
                                      decoration: InputDecoration(
                                        isDense: true,
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                          horizontal: 10,
                                          vertical: 8,
                                        ),
                                        hintText: 'Search for an item...',
                                        hintStyle:
                                            const TextStyle(fontSize: 12),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
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
                                  validator: (String? value) {
                                    if (value!.isEmpty) {
                                      return getTranslation(
                                          "empty_validator_text", context);
                                    } else if (int.tryParse(value) == null) {
                                      return getTranslation(
                                          "parse_validator_text_to_int",
                                          context);
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () async {
                                  html.FileUploadInputElement uploadInput =
                                      html.FileUploadInputElement();
                                  uploadInput.accept = 'image/*';
                                  uploadInput.click();
                                  uploadInput.onChange.listen((event) {
                                    final files = uploadInput.files;
                                    if (files!.isNotEmpty) {
                                      setState(() {
                                        image = files.first;
                                        imageUplaoded = true;
                                      });
                                    }
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
                                      width: 30.h,
                                      height: 30.h,
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
                                  onPressed: () async {
                                    if (_globalKey.currentState!.validate()) {
                                      if (value != null) {
                                        BlocProvider.of<ItemsBloc>(context).add(
                                            AddItemEvent(
                                                item: Item(
                                                    id: 1,
                                                    image: 'image',
                                                    typeId: value!.id,
                                                    imagefile: image,
                                                    price: int.parse(
                                                        priceController
                                                            .text))));
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                          content: Text('من فضلك اختر نوع عسل'),
                                          backgroundColor: Colors.red,
                                        ));
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
                                          'Save',
                                          style: TextStyle(
                                              fontSize: 16.sp,
                                              color: Colors.blue),
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
            ),
    );
  }
}

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
