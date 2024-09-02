import 'dart:io';

import 'package:alamri_adm/admain_feature/domain/entities/type.dart';
import 'package:alamri_adm/admain_feature/presentation/bloc/honey_type_bloc.dart';
import 'package:alamri_adm/admain_feature/presentation/widgets/custom_add_honey_text_form_field.dart';
import 'package:alamri_adm/core/utils/app_colors.dart';
import 'package:alamri_adm/core/utils/functions.dart';
import 'package:path/path.dart';
import 'package:alamri_adm/item_feature/domain/entities/item.dart';
import 'package:alamri_adm/item_feature/presentation/bloc/items_bloc.dart';
import 'package:alamri_adm/item_feature/presentation/widgets/add_item_fram.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

class UpdateItemFormWidget extends StatefulWidget {
  const UpdateItemFormWidget({
    super.key,
    required this.types,
    required this.item,
  });
  final List<HoneyType> types;
  final Item item;

  @override
  State<UpdateItemFormWidget> createState() => _UpdateItemFormWidgetState();
}

class _UpdateItemFormWidgetState extends State<UpdateItemFormWidget> {
  final priceController = TextEditingController();
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  HoneyType? value;
  bool imageUplaoded = false;
  ImagePicker imagePicker = ImagePicker();
  XFile? file;
  File? image;

  @override
  Widget build(BuildContext context) {
    value = widget.types.firstWhere((type) => type.id == widget.item.typeId);
    priceController.text = widget.item.price.toString();
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
                                  margin: EdgeInsets.symmetric(vertical: 10.w),
                                  padding: EdgeInsets.symmetric(
                                      vertical: 10.w, horizontal: 10.w),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(16.w),
                                      color: AppColors.backgroundItemsColor),
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
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            height: .1.sh,
                            decoration: BoxDecoration(
                                color: Colors.white.withOpacity(.9),
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColors.primaryColor,
                                    blurRadius: 3.w,
                                  )
                                ],
                                borderRadius: BorderRadius.circular(10.w))),
                        dropdownStyleData: const DropdownStyleData(
                          maxHeight: 200,
                        ),
                        menuItemStyleData: MenuItemStyleData(height: .1.sh),
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
                                      "please_choose_honey_type", context);
                                }
                                return null;
                              },
                              controller: priceController,
                              decoration: InputDecoration(
                                isDense: true,
                                contentPadding: const EdgeInsets.symmetric(
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
                            return item.value.toString().contains(searchValue);
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
                                  "parse_validator_text_to_int", context);
                            }
                            return null;
                          },
                        ),
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
                            backgroundColor:
                                imageUplaoded ? Colors.green : Colors.yellow,
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
                              getTranslation("update_image", context),
                              style: TextStyle(fontSize: 16.spMax),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 10.h),
                        child: ElevatedButton(
                          onPressed: () {
                            if (file != null) {
                              image = File(file!.path);
                            }
                            if (_globalKey.currentState!.validate()) {
                              if (value != null) {
                                BlocProvider.of<ItemsBloc>(context).add(
                                    UpdateItemEvent(
                                        item: Item(
                                            id: widget.item.id,
                                            image: image == null
                                                ? widget.item.image
                                                : basename(image!.path),
                                            typeId: value!.id,
                                            price:
                                                int.parse(priceController.text),
                                            imagefile: image)));
                              }

                              priceController.clear();
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
                                  getTranslation('update', context),
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
