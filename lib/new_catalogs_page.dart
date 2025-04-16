import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:untitled/data/category_model.dart';
import 'package:untitled/data/hive_boxes.dart';
import 'package:untitled/my_text_field.dart';

// ignore: must_be_immutable
class NewCatalogsPage extends StatefulWidget {
  NewCatalogsPage({super.key, this.isAddItem = false});
  bool isAddItem;
  @override
  State<NewCatalogsPage> createState() => _NewCatalogsPageState();
}

class _NewCatalogsPageState extends State<NewCatalogsPage> {
  Box<CategoryModel> categoryBox =
      Hive.box<CategoryModel>(HiveBoxes.categoryModel);

  TextEditingController nameController = TextEditingController();
  String svgPath = "";
  @override
  void initState() {
    super.initState();
    nameController.addListener(_printLatestValue);
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the widget tree.
    // This also removes the _printLatestValue listener.
    nameController.dispose();
    super.dispose();
  }

  void _printLatestValue() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Align(
          alignment: Alignment.topCenter,
          child: SizedBox(
            width: 341.w,
            child: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: SvgPicture.asset(
                                "assets/icons/arrow_back.svg")),
                        Text("New catalog",
                            style: GoogleFonts.kronaOne(
                                fontSize: 25.66.sp,
                                fontWeight: FontWeight.w400)),
                        SizedBox(
                          width: 32.w,
                        )
                      ],
                    ),
                    SizedBox(
                      height: 38.h,
                    ),
                    Container(
                      width: 341.w,
                      padding: EdgeInsets.only(
                        top: 31.52.h,
                        bottom: 24.76.h,
                      ),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(blurRadius: 4.5.r, color: Colors.grey),
                          ],
                          borderRadius: BorderRadius.circular(20.r)),
                      child: Column(
                        children: [
                          Text(
                            "Add a new catalog",
                            style: GoogleFonts.kronaOne(
                                fontSize: 20.26.sp,
                                fontWeight: FontWeight.w400),
                          ),
                          SizedBox(
                            height: 26.h,
                          ),
                          MyTextField.textFieldForm(
                              "Name of the catalog", 279.w, nameController),
                          SizedBox(
                            height: 22.h,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Select an icon",
                                style: GoogleFonts.kronaOne(
                                    fontSize: 16.38.sp,
                                    fontWeight: FontWeight.w400),
                              ),
                              Container(
                                width: 279.w,
                                padding: EdgeInsets.symmetric(vertical: 10.h),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                          blurRadius: 4.5.r,
                                          color: Colors.grey),
                                    ],
                                    borderRadius: BorderRadius.circular(20.r)),
                                child: Center(
                                  child: Wrap(
                                    spacing: 5.w,
                                    runSpacing: 9.h,
                                    children: [
                                      for (int i = 15; i < 27; i++) ...[
                                        GestureDetector(
                                          onTap: () {
                                            svgPath =
                                                "assets/icons/category/Group 21$i.svg";

                                            setState(() {});
                                          },
                                          child: Container(
                                            width: 38.w,
                                            height: 38.h,
                                            decoration: BoxDecoration(
                                                color: svgPath ==
                                                        "assets/icons/category/Group 21$i.svg"
                                                    ? Color(0xFFE48569)
                                                    : Colors.transparent,
                                                border: Border.all(
                                                    color: Colors.black,
                                                    width: 2.w),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(12.r))),
                                            child: Center(
                                              child: SvgPicture.asset(
                                                "assets/icons/category/Group 21$i.svg",
                                              ),
                                            ),
                                          ),
                                        ),
                                      ]
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 22.h,
                              ),
                              SizedBox(
                                width: 275.73.w,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: 131.93.w,
                                      height: 38.11.h,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(11.39.r)),
                                          color: Color(0xFFD9D9D9)),
                                      child: Center(
                                        child: Text(
                                          "Cancel",
                                          style: GoogleFonts.kronaOne(
                                              fontSize: 16.24.sp,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.black),
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        if (svgPath.isNotEmpty &&
                                            nameController.text.isNotEmpty) {
                                          categoryBox.add(CategoryModel(
                                              svgPath: svgPath,
                                              name: nameController.text));
                                          if (widget.isAddItem == false) {
                                            Navigator.pop(context);
                                          } else {
                                            Navigator.pop(
                                                context,
                                                CategoryModel(
                                                    svgPath: svgPath,
                                                    name: nameController.text));
                                          }
                                        }
                                      },
                                      child: Container(
                                        width: 131.93.w,
                                        height: 38.11.h,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(11.39.r)),
                                            color: svgPath.isNotEmpty &&
                                                    nameController
                                                        .text.isNotEmpty
                                                ? Color(0xFFE48569)
                                                : Color(0xFFE48569)
                                                    .withValues(alpha: 0.6)),
                                        child: Center(
                                          child: Text(
                                            "Save",
                                            style: GoogleFonts.kronaOne(
                                                fontSize: 16.24.sp,
                                                fontWeight: FontWeight.w400,
                                                color: Color(0xFFDFEBE9)),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
