import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:foodstoreapp/models/categoryModel.dart';
import 'package:foodstoreapp/models/diet_model.dart';
import 'package:foodstoreapp/models/popular_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<CategoryModel> categories = [];
  List<DietModel> diets = [];
  List<PopularDietsModel> popularDiets = [];

  void _getInitialInfo() {
    categories = CategoryModel.getCategories();
    diets = DietModel.getDiets();
    popularDiets = PopularDietsModel.getPopularDiets();
  }

  @override
  Widget build(BuildContext context) {
    _getInitialInfo();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBar(),
      body: ListView(
        children: [
          _searchFieldForm(),
          SizedBox(height: 10.h),
          _CategoriesSection(),
          SizedBox(height: 10.h),
          _dietSection(),
          SizedBox(height: 10.h),
          _popularSection(),
        ],
      ),
    );
  }

  Column _popularSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 20.w),
          child: Text(
            'Popular',
            style: TextStyle(
              color: Colors.black,
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        SizedBox(height: 10.h),
        ListView.separated(
          itemCount: popularDiets.length,
          shrinkWrap: true,
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          separatorBuilder: (context, index) => SizedBox(
            height: 20.h,
          ),
          itemBuilder: (context, index) {
            return Container(
              height: 100.h,
              decoration: BoxDecoration(
                color: popularDiets[index].boxIsSelected
                    ? Colors.white
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(16.sp),
                boxShadow: [
                  BoxShadow(
                    color: Color(0xff1d1617).withOpacity(0.3),
                    offset: Offset(0, 10),
                    blurRadius: 40.r,
                    spreadRadius: 0.r,
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SvgPicture.asset(
                    popularDiets[index].iconPath,
                    height: 65.h,
                    width: 65.w,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        popularDiets[index].name,
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                          fontSize: 16.sp,
                        ),
                      ),
                      Text(
                        popularDiets[index].level +
                            '|' +
                            popularDiets[index].duration +
                            '|' +
                            popularDiets[index].calorie,
                        style: TextStyle(
                          color: Color(0xff7b6f72),
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: SvgPicture.asset(
                      'assets/icons/button.svg',
                      width: 30.w,
                      height: 30.h,
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ],
    );
  }

  Column _dietSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 20.w),
          child: Text(
            'Recommendation\nfor Diet',
            style: TextStyle(
              color: Colors.black,
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        SizedBox(height: 10.h),
        Container(
          height: 210.h,
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: diets.length,
            separatorBuilder: (context, index) {
              return SizedBox(
                width: 20.w,
              );
            },
            itemBuilder: (context, index) {
              return Container(
                width: 200.w,
                decoration: BoxDecoration(
                  color: diets[index].boxColor.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(15.r),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SvgPicture.asset(diets[index].iconPath),
                    Text(
                      diets[index].name,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                        fontSize: 16.sp,
                      ),
                    ),
                    Text(
                      diets[index].level +
                          '|' +
                          diets[index].duration +
                          '|' +
                          diets[index].calorie,
                      style: TextStyle(
                        color: Color(0xff7b6f72),
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          diets[index].viewIsSelected;
                        });
                      },
                      child: Container(
                        height: 45.h,
                        width: 130.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50.r),
                          gradient: LinearGradient(
                            colors: [
                              diets[index].viewIsSelected
                                  ? Color(0xff9dceff)
                                  : Colors.transparent,
                              diets[index].viewIsSelected
                                  ? Color(0xff92a3fd)
                                  : Colors.transparent,
                            ],
                          ),
                        ),
                        child: Center(
                          child: Text(
                            'View',
                            style: TextStyle(
                              color: diets[index].viewIsSelected
                                  ? Colors.white
                                  : Color(0xffc58bf2),
                              fontWeight: FontWeight.w600,
                              fontSize: 14.sp,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Column _CategoriesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 20.w),
          child: Text(
            'Category',
            style: TextStyle(
              color: Colors.black,
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        SizedBox(height: 10.h),
        Container(
          height: 100.h,
          child: ListView.separated(
            separatorBuilder: (context, index) {
              return SizedBox(
                width: 20.w,
              );
            },
            scrollDirection: Axis.horizontal,
            itemCount: categories.length,
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            itemBuilder: (context, index) {
              return Container(
                width: 100.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  color: categories[index].boxColor.withOpacity(0.3),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      height: 50.h,
                      width: 50.w,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(8.sp),
                        child: SvgPicture.asset(categories[index].icon),
                      ),
                    ),
                    Text(
                      categories[index].name,
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                          fontSize: 14.sp),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Container _searchFieldForm() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 40.h, horizontal: 20.w),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Color(0xff1d1617).withOpacity(0.11),
            blurRadius: 40.r,
            spreadRadius: 0.r,
          )
        ],
      ),
      child: TextFormField(
        decoration: InputDecoration(
            contentPadding: EdgeInsets.all(15.h),
            fillColor: Colors.white,
            filled: true,
            hintText: 'Search Pancakes',
            hintStyle: TextStyle(
              color: Color(0xffdddada),
              fontSize: 14.sp,
            ),
            prefixIcon: Container(
              child: Padding(
                padding: EdgeInsets.all(12.sp),
                child: SvgPicture.asset('assets/icons/Search.svg'),
              ),
            ),
            suffixIcon: Container(
              width: 100.w,
              child: IntrinsicHeight(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    VerticalDivider(
                      color: Colors.black,
                      indent: 10.h,
                      endIndent: 10.h,
                      thickness: 0.5.h,
                    ),
                    Padding(
                      padding: EdgeInsets.all(12.sp),
                      child: SvgPicture.asset('assets/icons/Filter.svg'),
                    ),
                  ],
                ),
              ),
            ),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.r),
                borderSide: BorderSide.none)),
      ),
    );
  }

  AppBar appBar() {
    return AppBar(
      backgroundColor: Colors.white,
      centerTitle: true,
      elevation: 0,
      title: Text(
        'Breakfast',
        style: TextStyle(
            color: Colors.black, fontSize: 18.sp, fontWeight: FontWeight.bold),
      ),
      leading: GestureDetector(
        onTap: () {},
        child: Container(
          width: 30.w,
          height: 30.h,
          margin: EdgeInsets.all(10.r),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Color(0xfff7f8f8),
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: SvgPicture.asset(
            'assets/icons/arrow_left.svg',
            height: 20.h,
            width: 20.w,
          ),
        ),
      ),
      actions: [
        GestureDetector(
          onTap: () {},
          child: Container(
            width: 37.w,
            height: 30.h,
            margin: EdgeInsets.all(10.r),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Color(0xfff7f8f8),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: SvgPicture.asset(
              'assets/icons/dots.svg',
              height: 5.h,
              width: 5.w,
            ),
          ),
        ),
      ],
    );
  }
}
