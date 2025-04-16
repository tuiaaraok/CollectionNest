import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:untitled/data/category_model.dart';
import 'package:untitled/data/hive_boxes.dart';
import 'package:untitled/new_catalogs_page.dart';

class CatalogPage extends StatefulWidget {
  const CatalogPage({super.key});

  @override
  State<CatalogPage> createState() => _CatalogPageState();
}

class _CatalogPageState extends State<CatalogPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Align(
          alignment: Alignment.bottomCenter,
          child: ValueListenableBuilder(
              valueListenable:
                  Hive.box<CategoryModel>(HiveBoxes.categoryModel).listenable(),
              builder: (context, Box<CategoryModel> box, _) {
                return SizedBox(
                  width: 341.w,
                  child: SafeArea(
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
                            Text("Catalogs",
                                style: GoogleFonts.kronaOne(
                                    fontSize: 25.66.sp,
                                    fontWeight: FontWeight.w400)),
                            GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute<void>(
                                      builder: (BuildContext context) =>
                                          NewCatalogsPage(),
                                    ),
                                  );
                                },
                                child: SvgPicture.asset("assets/icons/add.svg"))
                          ],
                        ),
                        SizedBox(
                          height: 46.h,
                        ),
                        SizedBox(
                          width: 310.w,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("My catalogs",
                                  style: GoogleFonts.kronaOne(
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.w400)),
                              SizedBox(
                                height: 12.h,
                              ),
                              Wrap(
                                spacing: 10.w,
                                runSpacing: 10.h,
                                children: box.values
                                    .toList()
                                    .asMap()
                                    .entries
                                    .map((entry) {
                                  final index =
                                      entry.key; // Получаем индекс элемента
                                  final e =
                                      entry.value; // Сам элемент CategoryModel
                                  final color = _getColorForIndex(
                                      index); // Определяем цвет

                                  return Container(
                                    width: 149.w,
                                    height: 93.h,
                                    decoration: BoxDecoration(
                                      color: color,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20.r)),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        SvgPicture.asset(
                                          e.svgPath,
                                          color: Colors.white,
                                        ),
                                        SizedBox(
                                          height: 9.h,
                                        ),
                                        Text(
                                          e.name,
                                          maxLines: 2,
                                          style: GoogleFonts.kronaOne(
                                            color: Colors.white,
                                            fontSize: 18.sp,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }).toList(),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                );
              })),
    );
  }

  Color _getColorForIndex(int index) {
    // Шаблон: 0 -> цвет A, 1-2 -> цвет B, 3 -> цвет A, 4-5 -> цвет B, ...
    if (index == 0) return const Color(0xFF749992);
    if ((index - 1) % 3 == 0 || (index - 2) % 3 == 0) {
      return const Color(0xFFE48569);
    }
    return const Color(0xFF749992);
  }
}
