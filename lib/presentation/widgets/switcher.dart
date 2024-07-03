import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SwitchWidget extends StatefulWidget {
  final int selindex;
  final Function(int) onTabChanged;

  const SwitchWidget({
    super.key,
    required this.selindex,
    required this.onTabChanged,
  });

  @override
  State<SwitchWidget> createState() => _SwitchWidgetState();
}

class _SwitchWidgetState extends State<SwitchWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
            onTap: () {
              widget.onTabChanged(0);
            },
            child: Container(
              decoration: BoxDecoration(
                  color: 0 == widget.selindex
                      ? const Color(0xFFFF8702)
                      : const Color(0xFFF2F2F2),
                  borderRadius: BorderRadius.circular(10)),
              width: 172.w,
              height: 33.h,
              child: Center(
                child: Row(
                  children: [
                    Expanded(
                        child: Image.asset('assets/book.png', height: 12.h)),
                    Text(
                      'Дневник настроения',
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: 0 == widget.selindex
                              ? Colors.white
                              : const Color(0xFFBCBCBF),
                          fontSize: 12.sp),
                    ),
                    const Spacer()
                  ],
                ),
              ),
            )),
        InkWell(
            onTap: () {
              widget.onTabChanged(1);
            },
            child: Container(
                decoration: BoxDecoration(
                    color: 1 == widget.selindex
                        ? const Color(0xFFFF8702)
                        : const Color(0xFFF2F2F2),
                    borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(10),
                        bottomRight: Radius.circular(10))),
                width: 116.w,
                height: 33.h,
                child: Center(
                  child: Row(
                    children: [
                      Expanded(
                          child:
                              Image.asset('assets/static.png', height: 12.h)),
                      const Text(
                        'Статистика',
                        style: TextStyle(
                          color: Color(0XFFBCBCBF),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const Spacer()
                    ],
                  ),
                )))
      ],
    );
  }
}
