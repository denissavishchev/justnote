import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

const kGrey = Color(0xffc5ced9);
const kBlack = Color(0xff16354d);

final kBlackStyle = TextStyle(
    color: kBlack.withOpacity(0.8),
    fontWeight: FontWeight.bold,
    fontSize: 18.sp,
    );

final kBlackStyleSmall = TextStyle(
    color: kBlack,
    fontSize: 11.sp,
    );

final insetDecoration = BoxDecoration(
    borderRadius: const BorderRadius.all(Radius.circular(20)),
    border: Border.all(width: 2, color: Colors.white),
    boxShadow: [
        BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            blurRadius: 3,
            spreadRadius: 0.3,
            offset: const Offset(2, 2)),
        BoxShadow(
            color: Colors.grey.withOpacity(0.5),
        ),
        BoxShadow(
            color: Colors.white.withOpacity(0.5),
        ),
        const BoxShadow(
            color: Colors.white,
            blurRadius: 2,
            spreadRadius: -2,
            offset: Offset(2, 2)),
    ],
    gradient: LinearGradient(
        colors: [
            Colors.transparent,
            Colors.grey.withOpacity(0.23),
        ],
        begin: Alignment.bottomRight,
        end: Alignment.topLeft,
        stops: const [0.2, 1.0],
    ),
    );