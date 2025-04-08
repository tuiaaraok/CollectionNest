import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:untitled/add_item_page.dart';
import 'package:untitled/catalog_page.dart';
import 'package:untitled/search_page.dart';
import 'package:url_launcher/url_launcher.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  String version = "";
  @override
  void initState() {
    super.initState();
    getVersion().then((onValue) {
      version = onValue;
      setState(() {});
    });
  }

  Future<String> getVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return packageInfo.version;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      backgroundColor: Color(0xFF749992),
      drawer: Container(
        width: 237.w,
        height: 874.h,
        alignment: Alignment.topCenter,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(20.r),
                bottomRight: Radius.circular(20.r)),
            color: Color(0xFFE48569)),
        child: SafeArea(
          child: SizedBox(
            width: 180.w,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () {
                      _key.currentState!.closeDrawer();
                    },
                    child: Icon(
                      Icons.cancel_outlined,
                      size: 20.w,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(
                  height: 60.h,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Help Center",
                      style: GoogleFonts.kronaOne(
                          fontWeight: FontWeight.w400,
                          fontSize: 16.06.sp,
                          color: Colors.white),
                    ),
                    SizedBox(
                      height: 19.h,
                    ),
                    GestureDetector(
                      onTap: () async {
                        String? encodeQueryParameters(
                            Map<String, String> params) {
                          return params.entries
                              .map((MapEntry<String, String> e) =>
                                  '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
                              .join('&');
                        }

                        // ···
                        final Uri emailLaunchUri = Uri(
                          scheme: 'mailto',
                          path: 'ahmetpayakalmaz@icloud.com',
                          query: encodeQueryParameters(<String, String>{
                            '': '',
                          }),
                        );
                        try {
                          if (await canLaunchUrl(emailLaunchUri)) {
                            await launchUrl(emailLaunchUri);
                          } else {
                            throw Exception("Could not launch $emailLaunchUri");
                          }
                        } catch (e) {
                          log('Error launching email client: $e'); // Log the error
                        }
                      },
                      child: Row(
                        children: [
                          SvgPicture.asset("assets/icons/contact.svg"),
                          SizedBox(
                            width: 8.h,
                          ),
                          Text(
                            "Contact us",
                            style: GoogleFonts.kronaOne(
                                fontWeight: FontWeight.w400,
                                fontSize: 15.42.sp,
                                color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 19.h,
                    ),
                    GestureDetector(
                      onTap: () async {
                        final Uri url = Uri.parse(
                            'https://docs.google.com/document/d/1PuHT380e5A5UUQrsAEukV6PARPz7300bqhYRCpmj9kw/mobilebasic');
                        if (!await launchUrl(url)) {
                          throw Exception('Could not launch $url');
                        }
                      },
                      child: Row(
                        children: [
                          SvgPicture.asset("assets/icons/privacy.svg"),
                          SizedBox(
                            width: 8.h,
                          ),
                          Expanded(
                            child: Text(
                              "Privacy policy",
                              style: GoogleFonts.kronaOne(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 15.42.sp,
                                  color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 19.h,
                    ),
                    GestureDetector(
                      onTap: () {
                        InAppReview.instance.openStoreListing(
                          appStoreId: '6744366188',
                        );
                        // 6744366188
                      },
                      child: Row(
                        children: [
                          SvgPicture.asset("assets/icons/rate.svg"),
                          SizedBox(
                            width: 8.h,
                          ),
                          Text(
                            "Rate us",
                            style: GoogleFonts.kronaOne(
                                fontWeight: FontWeight.w400,
                                fontSize: 15.42.sp,
                                color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 30.h,
                ),
                Divider(
                  height: 2.w,
                  color: Colors.white,
                ),
                Spacer(),
                Text(
                  textAlign: TextAlign.center,
                  "About the app: Version: $version",
                  style: GoogleFonts.kronaOne(
                      fontSize: 15.42.sp, color: Colors.white),
                )
              ],
            ),
          ),
        ),
      ),
      body: SizedBox(
        width: double.infinity,
        child: SafeArea(
          child: Column(
            children: [
              SizedBox(
                width: 324.w,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: GestureDetector(
                      onTap: () {
                        _key.currentState!.openDrawer();
                      },
                      child: SvgPicture.asset("assets/icons/menu.svg")),
                ),
              ),
              SizedBox(
                height: 22.h,
              ),
              Container(
                width: 402.w,
                height: 300.h,
                decoration: BoxDecoration(
                    image:
                        DecorationImage(image: AssetImage("assets/menu.png"))),
              ),
              SizedBox(
                height: 45.h,
              ),
              SizedBox(
                width: 324.w,
                height: 270.h,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute<void>(
                            builder: (BuildContext context) =>
                                const CatalogPage(),
                          ),
                        );
                      },
                      child: MenuElemWidget(
                        title: "Catalogs",
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute<void>(
                            builder: (BuildContext context) =>
                                const AddItemPage(),
                          ),
                        );
                      },
                      child: MenuElemWidget(
                        title: "Add an item",
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute<void>(
                            builder: (BuildContext context) =>
                                const SearchPage(),
                          ),
                        );
                      },
                      child: MenuElemWidget(
                        title: "Search",
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class MenuElemWidget extends StatelessWidget {
  const MenuElemWidget({super.key, required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 71.h,
      decoration: BoxDecoration(
          color: Color(0xFFDFEBE9),
          borderRadius: BorderRadius.all(Radius.circular(18.r))),
      child: Center(
        child: Text(
          title,
          style: GoogleFonts.kronaOne(
              fontSize: 25.66.sp, fontWeight: FontWeight.w400),
        ),
      ),
    );
  }
}
