import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class ViewingThingPage extends StatefulWidget {
  const ViewingThingPage({super.key});

  @override
  State<ViewingThingPage> createState() => _ViewingThingPageState();
}

class _ViewingThingPageState extends State<ViewingThingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Align(
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
                        child: SvgPicture.asset("assets/icons/arrow_back.svg")),
                    Text("Viewing a thing",
                        style: GoogleFonts.kronaOne(
                            fontSize: 25.66.sp, fontWeight: FontWeight.w400)),
                    SizedBox(
                      width: 32.w,
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 38.h,
              ),
              Container(
                width: 345.w,
                padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
                decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 4.26.r,
                          color: Colors.black.withValues(alpha: 0.25))
                    ],
                    borderRadius: BorderRadius.all(Radius.circular(10.r))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 62.82.w,
                          height: 97.73.h,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image: AssetImage("assets/default.png")),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12.r))),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 15.97.w),
                          child: SizedBox(
                            width: 233.w,
                            height: 85.11.h,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Name",
                                      style: GoogleFonts.kronaOne(
                                          fontSize: 12.22.sp,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.grey),
                                    ),
                                    Text(
                                      "Master and Margarita",
                                      style: GoogleFonts.kronaOne(
                                          fontSize: 15.71.sp,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black),
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Category",
                                      style: GoogleFonts.kronaOne(
                                          fontSize: 12.22.sp,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.grey),
                                    ),
                                    Text(
                                      "Books",
                                      style: GoogleFonts.kronaOne(
                                          fontSize: 15.71.sp,
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
                    SizedBox(
                      height: 10.h,
                    ),
                    Text(
                      "Description",
                      style: GoogleFonts.kronaOne(
                          fontSize: 12.22.sp,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey),
                    ),
                    Text(
                      "Mikhail Bulgakov's classic novel about love, magic and fate in Moscow in the 1930s.",
                      style: GoogleFonts.kronaOne(
                          fontSize: 15.71.sp,
                          fontWeight: FontWeight.w400,
                          color: Colors.black),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Text(
                      "Location",
                      style: GoogleFonts.kronaOne(
                          fontSize: 12.22.sp,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey),
                    ),
                    Text(
                      "The closet in the living room",
                      style: GoogleFonts.kronaOne(
                          fontSize: 15.71.sp,
                          fontWeight: FontWeight.w400,
                          color: Colors.black),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
