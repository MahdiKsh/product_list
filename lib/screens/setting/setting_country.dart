import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rebix_test_project/components/components.dart';
import 'package:http/http.dart' as http;
import 'package:toast/toast.dart';


class SettingCountry extends StatefulWidget {
  const SettingCountry({Key? key}) : super(key: key);

  @override
  State<SettingCountry> createState() => SettingCountryState();
}

class SettingCountryState extends State<SettingCountry> {
  CountryModel? country;
  bool pageLoading = true;

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    var response = await getCountry();
    if(response['status'] == "success"){
      country = CountryModel.fromJson(response);
      setState(() {
        pageLoading = false;
      });
    } else {
      Toast.show("Err", duration: Toast.lengthShort, gravity:  Toast.bottom);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("select_country".tr,
          style: CustomTextStyle.headline6(context).copyWith(color: Colors.white),
        ), // تنظیمات
        elevation: 0,
        leading: GestureDetector(
          onTap: (){
            Navigator.of(context).pop();
          },
          child: Container(
            // height: 30.sp, width: 30.sp,
            margin: EdgeInsets.all(8.sp),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.sp),
              border: Border.all(width: 1, color: Colors.white),
            ),
            child: Center(
              child: Icon(Icons.arrow_back, size: 30.sp),
            ),
          ),
        ),
      ),

      body: pageLoading
        ? const Center(child: CircularProgressIndicator())
        :
            Padding(
              padding: EdgeInsets.all(16.sp),
              child: Column(
                children: [
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.sp),
                    ),
                    elevation: 4,
                    child: Padding(
                      padding: EdgeInsets.all(16.sp),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // ردیف کشور و کد کشور
                          Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Text("${"country2".tr} : ${country!.country}",
                                  style: CustomTextStyle.bodyText1(context),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Text("${"country_code".tr} : ${country!.countryCode}",
                                  style: CustomTextStyle.bodyText1(context),
                                ),
                              ),
                            ],
                          ),

                          // ردیف منطقه و نام منطقه
                          Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Text("${"region".tr} : ${country!.region}",
                                  style: CustomTextStyle.bodyText1(context),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Text("${"region_name".tr} : ${country!.regionName}",
                                  style: CustomTextStyle.bodyText1(context),
                                ),
                              ),
                            ],
                          ),

                          // ردیف شهر و منطقه زمانی
                          Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Text("${"city".tr} : ${country!.city}",
                                  style: CustomTextStyle.bodyText1(context),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Text("${"timezone".tr} : ${country!.timezone}",
                                  style: CustomTextStyle.bodyText1(context),
                                ),
                              ),
                            ],
                          ),

                          Text("${"zip"} : ${country!.zip}",
                            style: CustomTextStyle.bodyText1(context),
                          ),

                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text("${"lat"} : ${country!.lat.toString()}",
                                  style: CustomTextStyle.bodyText1(context),
                                ),

                                Text("${"lon"} : ${country!.lon.toString()}",
                                  style: CustomTextStyle.bodyText1(context),
                                ),

                                Text("${"isp"} : ${country!.isp}",
                                  style: CustomTextStyle.bodyText1(context),
                                ),

                                Text("${"org"} : ${country!.org}",
                                  style: CustomTextStyle.bodyText1(context),
                                ),

                                Text("${"as"} : ${country!.as}",
                                  style: CustomTextStyle.bodyText1(context),
                                ),

                                Text("${"query"} : ${country!.query}",
                                  style: CustomTextStyle.bodyText1(context),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}

class CountryModel{
  String country = "";
  String countryCode = "";
  String region = "";
  String regionName = "";
  String city = "";
  String zip = "";
  double lat = 0.0;
  double lon = 0.0;
  String timezone = "";
  String isp = "";
  String org = "";
  String as = "";
  String query = "";

  CountryModel.fromJson(Map<String, dynamic> parsedJson){
    country = parsedJson["country"] ?? "";
    countryCode = parsedJson["countryCode"] ?? "";
    region = parsedJson["region"] ?? "";
    regionName = parsedJson["regionName"] ?? "";
    city = parsedJson["city"] ?? "";
    zip = parsedJson["zip"] ?? "";
    lat = parsedJson["lat"] ?? 0.0;
    lon = parsedJson["lon"] ?? 0.0;
    timezone = parsedJson["timezone"] ?? "";
    isp = parsedJson["isp"] ?? "";
    org = parsedJson["org"] ?? "";
    as = parsedJson["as"] ?? "";
    query = parsedJson["query"] ?? "";
  }
}


Future getCountry() async {
  final response = await http.get(Uri.parse("http://ip-api.com/json"));
  var responseBody = json.decode(response.body);
  return responseBody;
}
