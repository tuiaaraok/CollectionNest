import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:untitled/data/hive_boxes.dart';
import 'package:untitled/data/item_model.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController searchController = TextEditingController();
  bool isOpenSearchCategory = false;
  String cuttentCategory = "All";

  String searchText = '';

  @override
  void initState() {
    super.initState();
    searchController.addListener(() {
      setState(() {
        searchText = searchController.text.toLowerCase();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Align(
        alignment: Alignment.topCenter,
        child: Padding(
          padding: EdgeInsets.only(top: MediaQuery.paddingOf(context).top),
          child: ValueListenableBuilder(
              valueListenable:
                  Hive.box<ItemModel>(HiveBoxes.itemModel).listenable(),
              builder: (context, Box<ItemModel> box, _) {
                List categoryes = ["All"];
                final places = box.values.where((item) {
                  categoryes.insert(0, item.category?.name);
                  final matchesCategory = cuttentCategory == "All" ||
                      item.category?.name == cuttentCategory;
                  final matchesSearch =
                      item.name.toLowerCase().contains(searchText);

                  return matchesCategory && matchesSearch;
                }).toList();
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        width: 345.w,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: SvgPicture.asset(
                                    "assets/icons/arrow_back.svg")),
                            Text("Search",
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
                        height: 30.h,
                      ),
                      Container(
                        width: 345.w,
                        height: 53.08.h,
                        padding: EdgeInsets.symmetric(horizontal: 10.w),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.r))),
                        child: Row(
                          children: [
                            SvgPicture.asset("assets/icons/search.svg"),
                            SizedBox(
                              width: 10.w,
                            ),
                            Expanded(
                              child: TextField(
                                controller: searchController,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    hintText: 'Search',
                                    hintStyle: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey,
                                        fontSize: 18.sp)),
                                keyboardType: TextInputType.text,
                                cursorColor: Colors.black,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.sp),
                                onChanged: (text) {
                                  // Additional functionality can be added here
                                },
                              ),
                            ),
                            DropdownButtonHideUnderline(
                              child: DropdownButton2(
                                onChanged: (value) {
                                  setState(() {
                                    cuttentCategory = value.toString();
                                  });
                                  setState(() {});
                                },
                                onMenuStateChange: (isOpen) {
                                  isOpenSearchCategory = isOpen;

                                  setState(() {});
                                },
                                customButton: Row(
                                  children: [
                                    Text(cuttentCategory,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.grey,
                                            fontSize: 18.sp)),
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
                                          toElement,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 16.sp),
                                        ),
                                      ),
                                    ),
                                  );
                                }).toList(),
                                dropdownStyleData: DropdownStyleData(
                                  width: 345.w,
                                  maxHeight: 300.h,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                    color: Colors.white,
                                  ),
                                  offset: Offset(-290.w, 0),
                                ),
                                menuItemStyleData: MenuItemStyleData(
                                    customHeights:
                                        List.filled(categoryes.length, 50.h),
                                    padding: EdgeInsets.only(
                                        top: 5.h, left: 10.w, right: 10.w)),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 31.46.h,
                      ),
                      for (var item in places)
                        Container(
                          width: 345.w,
                          height: 117.13.h,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                    blurRadius: 4.26.r,
                                    color: Colors.black.withValues(alpha: 0.25))
                              ],
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.r))),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 62.82.w,
                                height: 97.73.h,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        fit: BoxFit.fill,
                                        image: MemoryImage(item.image)),
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(12.r))),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 15.97.w),
                                child: SizedBox(
                                  width: 233.w,
                                  height: 85.11.h,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Name",
                                            style: GoogleFonts.kronaOne(
                                                fontSize: 13.01.sp,
                                                fontWeight: FontWeight.w400,
                                                color: Colors.grey),
                                          ),
                                          Text(
                                            item.name,
                                            style: GoogleFonts.kronaOne(
                                                fontSize: 13.01.sp,
                                                fontWeight: FontWeight.w400,
                                                color: Colors.black),
                                          ),
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Category",
                                            style: GoogleFonts.kronaOne(
                                                fontSize: 13.01.sp,
                                                fontWeight: FontWeight.w400,
                                                color: Colors.grey),
                                          ),
                                          Text(
                                            item.category?.name ?? "",
                                            style: GoogleFonts.kronaOne(
                                                fontSize: 13.01.sp,
                                                fontWeight: FontWeight.w400,
                                                color: Colors.black),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                    ],
                  ),
                );
              }),
        ),
      ),
    );
  }
}
