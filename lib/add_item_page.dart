import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:untitled/data/category_model.dart';
import 'package:untitled/data/hive_boxes.dart';
import 'package:untitled/data/item_model.dart';
import 'package:untitled/my_text_field.dart';
import 'package:untitled/new_catalogs_page.dart';

class AddItemPage extends StatefulWidget {
  const AddItemPage({super.key});

  @override
  State<AddItemPage> createState() => _AddItemPageState();
}

class _AddItemPageState extends State<AddItemPage> {
  bool isOpenSearchCategory = false;

  List<CategoryModel> categoryes = [];
  CategoryModel? currentCategory;
  FocusNode descriptionNode = FocusNode();
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController statusController = TextEditingController();
  Uint8List? _image;
  Future getLostData() async {
    XFile? picker = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picker == null) return;
    List<int> imageBytes = await picker.readAsBytes();
    _image = Uint8List.fromList(imageBytes);
    setState(() {});
  }

  Box<CategoryModel> categoryBox =
      Hive.box<CategoryModel>(HiveBoxes.categoryModel);
  Box<ItemModel> itemBox = Hive.box<ItemModel>(HiveBoxes.itemModel);
  @override
  void initState() {
    super.initState();

    categoryes.addAll(categoryBox.values.toList());

    categoryes.add(CategoryModel(svgPath: "", name: "Add Catalog"));
  }

  // ignore: non_constant_identifier_names
  bool validityCheck() {
    if (_image == null ||
        nameController.text.isEmpty ||
        descriptionController.text.isEmpty ||
        locationController.text.isEmpty ||
        statusController.text.isEmpty ||
        currentCategory == null) {
      return false;
    } else {
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Align(
        alignment: Alignment.topCenter,
        child: Padding(
          padding: EdgeInsets.only(top: MediaQuery.paddingOf(context).top),
          child: KeyboardActions(
            config: KeyboardActionsConfig(
              keyboardActionsPlatform: KeyboardActionsPlatform.ALL,
              nextFocus: false,
              actions: [
                KeyboardActionsItem(
                  focusNode: descriptionNode,
                ),
              ],
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    width: 324.w,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: SvgPicture.asset(
                                "assets/icons/arrow_back.svg")),
                        Text("Add an item",
                            style: GoogleFonts.kronaOne(
                                fontSize: 25.66.sp,
                                fontWeight: FontWeight.w400)),
                        SizedBox(
                          width: 32.w,
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 31.h,
                  ),
                  MyTextField.textFieldForm("Name", 324.w, nameController),
                  SizedBox(
                    height: 18.h,
                  ),
                  MyTextField.descriptionTextFieldForm("Description", 324.w,
                      descriptionController, descriptionNode),
                  SizedBox(
                    height: 18.h,
                  ),
                  Column(
                    children: [
                      SizedBox(
                        width: 324.w,
                        child: Text(
                          "Category",
                          style: GoogleFonts.kronaOne(
                              fontSize: 16.38.sp,
                              color: Colors.black,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      Container(
                        width: 324.w,
                        height: 55.h,
                        padding: EdgeInsets.symmetric(horizontal: 10.w),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(16.38.r)),
                            boxShadow: [
                              BoxShadow(
                                  blurRadius: 3.64.r,
                                  color: Colors.black.withValues(alpha: 0.25))
                            ]),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton2(
                            onChanged: (value) {
                              if (value?.name == "Add Catalog") {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        NewCatalogsPage(
                                      isAddItem: true,
                                    ),
                                  ),
                                ).then((onValue) {
                                  if (onValue is CategoryModel) {
                                    categoryes.insert(
                                        categoryes.length - 1, onValue);
                                    currentCategory = onValue;
                                    setState(() {});
                                  }
                                });
                              } else {
                                setState(() {
                                  currentCategory = value;
                                });
                              }
                            },
                            onMenuStateChange: (isOpen) {
                              isOpenSearchCategory = isOpen;

                              setState(() {});
                            },
                            customButton: Row(
                              children: [
                                Expanded(
                                  child: Text(currentCategory?.name ?? "",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                          fontSize: 18.sp)),
                                ),
                                Icon(isOpenSearchCategory
                                    ? Icons.arrow_drop_up
                                    : Icons.arrow_drop_down),
                              ],
                            ),
                            items: categoryes.map((toElement) {
                              return DropdownMenuItem(
                                value: toElement,
                                child: SizedBox(
                                  width: 355.w,
                                  height: 50.h,
                                  child: Center(
                                    child: Text(
                                      toElement.name,
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 16.sp),
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                            dropdownStyleData: DropdownStyleData(
                              width: 324.w,
                              maxHeight: 300.h,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                color: Colors.white,
                              ),
                              offset: Offset(0.w, 0),
                            ),
                            menuItemStyleData: MenuItemStyleData(
                                customHeights:
                                    List.filled(categoryes.length, 50.h),
                                padding: EdgeInsets.only(
                                    top: 5.h, left: 10.w, right: 10.w)),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 18.h,
                  ),
                  MyTextField.textFieldForm(
                      "Location", 324.w, locationController),
                  SizedBox(
                    height: 18.h,
                  ),
                  MyTextField.textFieldForm("Status", 324.w, statusController),
                  SizedBox(
                    height: 18.h,
                  ),
                  GestureDetector(
                    onTap: () {
                      getLostData();
                    },
                    child: Container(
                      width: 324.w,
                      height: 176.h,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              BorderRadius.all(Radius.circular(16.38.r)),
                          boxShadow: [
                            BoxShadow(blurRadius: 3.64.r, color: Colors.grey)
                          ],
                          image: _image != null
                              ? DecorationImage(
                                  image: MemoryImage(
                                    _image!,
                                  ),
                                  fit: BoxFit.fill)
                              : null),
                      child: _image == null
                          ? Center(
                              child: SvgPicture.asset(
                                  "assets/icons/add_photo.svg"),
                            )
                          : SizedBox.shrink(),
                    ),
                  ),
                  SizedBox(
                    height: 80.h,
                  ),
                  GestureDetector(
                    onTap: () {
                      if (validityCheck()) {
                        itemBox.add(ItemModel(
                            name: nameController.text,
                            description: descriptionController.text,
                            category: currentCategory,
                            location: locationController.text,
                            status: statusController.text,
                            image: _image!));
                        Navigator.pop(context);
                      }
                    },
                    child: Container(
                      width: 324.w,
                      height: 60.h,
                      decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.all(Radius.circular(11.39.r)),
                          color: validityCheck()
                              ? Color(0xFFE48569)
                              : Color(0xFFE48569).withValues(alpha: 0.6)),
                      child: Center(
                        child: Text(
                          "Save",
                          style: GoogleFonts.kronaOne(
                              fontSize: 25.66.sp,
                              fontWeight: FontWeight.w400,
                              color: Color(0xFFDFEBE9)),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
