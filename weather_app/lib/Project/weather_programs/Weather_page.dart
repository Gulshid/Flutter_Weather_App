// ignore_for_file: unnecessary_string_interpolations, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:weather/weather.dart';
import 'package:weather_app/Project/Weather_Service/Weather_service.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
// ignore: camel_case_types
class Weather_app extends StatefulWidget {
  const Weather_app({super.key});

  @override
  State<Weather_app> createState() => _Weather_appState();
}

// ignore: camel_case_types
class _Weather_appState extends State<Weather_app> {
  final WeatherFactory _wf = WeatherFactory(OPENWEATHER_API_KEY);
  Weather? _weather;

  @override

  
  void initState() {
    super.initState();
    _wf.currentWeatherByCityName('Peshawar').then((w) {
      setState(() {
        
        _weather = w;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: _buildUI());
  }

  Widget _buildUI() {
    if (_weather == null) {
      return Center(child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Weather App',style: GoogleFonts.agbalumo(fontSize:20.sp ,color: Colors.black)),
          const SpinKitFadingCircle(color: Colors.blue,size: 50,),
        ],
      ));
    } else {
      return SizedBox(
        width: MediaQuery.sizeOf(context).width,
        height: MediaQuery.sizeOf(context).height,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _locationheader(),
            SizedBox(height: 20.h),

            _date_Time(),
            SizedBox(height: 15.h),

            _weather_icon(),
            SizedBox(height: 15.h),

            _current_temp(),
             SizedBox(height: 15.h),

             _extra_info(),
          ],
        ),
      );
    }
  }

  //for location
  Widget _locationheader() {
    return Text(
      _weather?.areaName ?? "",
      style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
    );
  }

  //for date and time
  Widget _date_Time() {
    DateTime now = _weather!.date!;
    return Column(
      children: [
        Text(
          DateFormat("h.mm.a").format(now),
          style: TextStyle(fontSize: 30.sp),
        ),

        SizedBox(height: 10.h),

        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              DateFormat("EEEE").format(now),
              style: TextStyle(fontSize: 15.sp),
            ),
            SizedBox(width: 5.w),
            Text(
              ("${DateFormat("dd.mm.yy").format(now)}"),
              style: TextStyle(fontSize: 20.sp),
            ),
          ],
        ),
      ],
    );
  }

  //for weather icon
  Widget _weather_icon() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: 120.h,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(
                
                'https://openweathermap.org/img/wn/${_weather?.weatherIcon}@4x.png',
                
              ),
            ),
          ),
        ),
        Text(_weather?.weatherDescription ?? ""),
      ],
    );
  }

  //for current tempreture
  Widget _current_temp() {
    return Text("${_weather?.temperature?.celsius?.toStringAsFixed(0)}* C",style: 
    
    TextStyle(
      color: Colors.black,
      fontSize: 60.sp,
      fontWeight: FontWeight.w500,
    ),);
  }
//for extra information
   Widget  _extra_info() {
    return Container(
      height: 180.h,
      width: 300.w,
      decoration: BoxDecoration(
        color:Colors.deepPurple,
        borderRadius: BorderRadius.circular(12.r),
      ),
      padding:const EdgeInsets.all(20
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text("Max:${_weather?.tempMax?.celsius?.toStringAsFixed(0)} C",style: 
                TextStyle(
                  color: Colors.white,
                  fontSize: 15.sp,
                )
                ,),
                SizedBox(width: 35.w,),
                 Text("Min:${_weather?.tempMin?.celsius?.toStringAsFixed(0)} C",style: 
                TextStyle(
                  color: Colors.white,
                  fontSize: 15.sp,
                )
                ,),
              ],
            ),

            Row(
             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text("Wind:${_weather?.windSpeed?.toStringAsFixed(0)}m/s",style: 
                TextStyle(
                  color: Colors.white,
                  fontSize: 15.sp,
                )
                ,),
                SizedBox(width: 35.w,),
                 Text("Humudity:${_weather?.humidity?.toStringAsFixed(0)}%",style: 
                TextStyle(
                  color: Colors.white,
                  fontSize: 15.sp,
                )
                ,),
              ],
            ),
        ],
      ),
    );
}
}