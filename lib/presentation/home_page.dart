import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:testapp/presentation/widgets/modal_button.dart';
import 'package:testapp/presentation/widgets/switcher.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int selectedIndex = 0;
  int _selectedMood = -1;
  double _stressLevel = 0.5;
  double _selfEsteem = 0.5;
  String _notes = '';

  DateTime focusedDay = DateTime.now();
  PageController _pageController = PageController();
  List<String> selectedButtons = [];
  bool _initialSliderState = true;

  List<String> pickchers = [
    'assets/1.png',
    'assets/2.png',
    'assets/3.png',
    'assets/4.png',
    'assets/5.png',
    'assets/6.png'
  ];

  List<String> names = [
    'Радость',
    'Страх',
    'Бешенство',
    'Грусть',
    'Спокойствие',
    'Сила',
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _resetSelections() {
    setState(() {
      _selectedMood = -1;
      _stressLevel = 0.5;
      _selfEsteem = 0.5;
      _notes = '';
      selectedButtons.clear();
      _initialSliderState = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80.h,
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.calendar_month, color: Color(0xFFBCBCBF)),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Calendar(title: 'Calendar'),
                  ));
            },
          )
        ],
        title: Text(
          focusedDay.toString(),
          style: TextStyle(
              color: const Color(0xFFBCBCBF),
              fontSize: 18.sp,
              fontWeight: FontWeight.w700),
        ),
      ),
      body: Column(
        children: [
          Center(
            child: SizedBox(
              width: 288.w,
              height: 30.h,
              child: SwitchWidget(
                selindex: selectedIndex,
                onTabChanged: (index) {
                  setState(() {
                    selectedIndex = index;
                  });
                  _pageController.animateToPage(index,
                      duration: Duration(milliseconds: 300),
                      curve: Curves.ease);
                },
              ),
            ),
          ),
          SizedBox(height: 18.h),
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  selectedIndex = index;
                });
              },
              children: [
                moodScreen(),
                statisticScreen(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget moodScreen() {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Что чувствуешь?',
            style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16.sp),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 7.h),
            width: MediaQuery.of(context).size.width,
            height: 120.h,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: names.length,
              itemBuilder: (BuildContext context, int index) {
                return MoodButton(
                  images: pickchers[index],
                  mood: names[index],
                  isSelected: _selectedMood == index,
                  onTap: () {
                    setState(() {
                      _selectedMood = index;
                    });
                  },
                );
              },
            ),
          ),
          Wrap(
            spacing: 16.0,
            runSpacing: 8.0,
            children: [
              for (var buttonText in [
                'Возбуждение',
                'Восторг',
                'Игривость',
                'Наслаждение',
                'Очарование',
                'Осознанность',
                'Смелость',
                'Удовольствие',
                'Чувственность',
                'Энергичность',
                'Экстравагантность',
              ])
                InkWell(
                  onTap: () {
                    setState(() {
                      if (selectedButtons.contains(buttonText)) {
                        selectedButtons.remove(buttonText);
                      } else {
                        selectedButtons.add(buttonText);
                      }
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.all(5),
                    margin: EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: selectedButtons.contains(buttonText)
                          ? Colors.orange
                          : Colors.white,
                    ),
                    child: Text(buttonText,
                        style: TextStyle(
                            color: selectedButtons.contains(buttonText)
                                ? Colors.white
                                : Colors.black,
                            fontWeight: FontWeight.w400,
                            fontSize: 11.sp)),
                  ),
                ),
            ],
          ),
          Text(
            'Уровень стресса',
            style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16.sp),
          ),
          SizedBox(height: 8.h),
          Card(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(13.r),
              ),
              width: MediaQuery.of(context).size.width,
              height: 77.h,
              child: Column(
                children: [
                  Expanded(
                    child: Slider(
                      activeColor:
                          _initialSliderState ? Colors.grey : Colors.orange,
                      value: _stressLevel,
                      min: 0,
                      max: 1,
                      divisions: 10,
                      label: _stressLevel.toStringAsFixed(1),
                      onChanged: (value) {
                        setState(() {
                          _stressLevel = value;
                          _initialSliderState = false;
                        });
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.w),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Низкий',
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 11.sp,
                              color: Colors.black),
                        ),
                        Text('Высокий',
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 11.sp,
                                color: Colors.black)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Text(
            'Самооценка',
            style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16.sp),
          ),
          const SizedBox(height: 8),
          Card(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(13.r),
              ),
              width: MediaQuery.of(context).size.width,
              height: 77.h,
              child: Column(
                children: [
                  Expanded(
                    child: Slider(
                      activeColor:
                          _initialSliderState ? Colors.grey : Colors.orange,
                      value: _selfEsteem,
                      min: 0,
                      max: 1,
                      divisions: 10,
                      label: _selfEsteem.toStringAsFixed(1),
                      onChanged: (value) {
                        setState(() {
                          _selfEsteem = value;
                          _initialSliderState = false;
                        });
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.w),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Неуверенность',
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 11.sp,
                              color: Colors.black),
                        ),
                        Text('Уверенность',
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 11.sp,
                                color: Colors.black)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Text(
            'Заметки',
            style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16.sp),
          ),
          Card(
            child: TextField(
              onChanged: (value) {
                setState(() {
                  _notes = value;
                });
              },
              maxLines: 4,
              controller: TextEditingController(text: _notes),
              decoration: const InputDecoration(
                hintText: 'Введите сюда свои заметки',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          const SizedBox(height: 32),
          Container(
            decoration: BoxDecoration(
                color: Colors.orange, borderRadius: BorderRadius.circular(50)),
            width: MediaQuery.of(context).size.width,
            height: 50.h,
            child: MaterialButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text('Вы успешно отправили данные'),
                      actions: [
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text('закрыть'))
                      ],
                    );
                  },
                );
                _resetSelections();
              },
              child: Text('Сохранить',
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 20.sp,
                      color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }

  Widget statisticScreen() {
    return Center(
      child: Text('Статистика', style: TextStyle(fontSize: 24.sp)),
    );
  }
}

// class Calendar extends StatefulWidget {
//   const Calendar({super.key, required this.focday, required this.format});
//  final DateTime focday;
//  final CalendarFormat format;
//   @override
//   State<Calendar> createState() => _CalendarState();
// }

// class _CalendarState extends State<Calendar> {
  

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(body:   SizedBox(
//                         width: double.maxFinite,
//                         child: Column(
//                           children: [
//                             //defining min an max years
//                             TableCalendar(
//                               focusedDay: widget.focday, // Используем focusedDay
//                               firstDay: DateTime(1990),
//                               lastDay: DateTime(2050),

//                               //changing calendar format
//                               calendarFormat: widget.format,
//                               onFormatChanged: (CalendarFormat format) {
//                                 setState(() {
//                                   format = format;
//                                 });
//                               },
//                               startingDayOfWeek: StartingDayOfWeek.monday,
//                               daysOfWeekVisible: true,

//                               //Day Changed on select
//                               onDaySelected: (DateTime selectDay,
//                                   DateTime focusDay) async {
//                                 setState(() {
//                                   selectedDay = selectDay;
//                                   focusedDay = focusDay;
//                                   Navigator.pop(context);
//                                 });
//                               },
//                               selectedDayPredicate: (DateTime date) {
//                                 return isSameDay(selectedDay, date);
//                               },

//                               //To style the Calendar
//                               calendarStyle: CalendarStyle(
//                                 isTodayHighlighted: true,
//                                 selectedDecoration: BoxDecoration(
//                                   color: Colors.blue,
//                                   shape: BoxShape.rectangle,
//                                   borderRadius: BorderRadius.circular(5.0),
//                                 ),
//                                 selectedTextStyle:
//                                     const TextStyle(color: Colors.white),
//                                 todayDecoration: BoxDecoration(
//                                   color: Colors.purpleAccent,
//                                   shape: BoxShape.rectangle,
//                                   borderRadius: BorderRadius.circular(5.0),
//                                 ),
//                                 defaultDecoration: BoxDecoration(
//                                   shape: BoxShape.rectangle,
//                                   borderRadius: BorderRadius.circular(5.0),
//                                 ),
//                                 weekendDecoration: BoxDecoration(
//                                   shape: BoxShape.rectangle,
//                                   borderRadius: BorderRadius.circular(5.0),
//                                 ),
//                               ),
//                               headerStyle: HeaderStyle(
//                                 formatButtonVisible: true,
//                                 titleCentered: true,
//                                 formatButtonShowsNext: false,
//                                 formatButtonDecoration: BoxDecoration(
//                                   color: Colors.blue,
//                                   borderRadius: BorderRadius.circular(5.0),
//                                 ),
//                                 formatButtonTextStyle: const TextStyle(
//                                   color: Colors.white,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       actions: [
//                         TextButton(
//                             onPressed: () {
//                               Navigator.pop(context);
//                             },
//                             child: const Text('No')),
//                         TextButton(
//                             onPressed: () {
//                               Navigator.pop(context);
//                             },
//                             child: const Text('yes'))
//                       ],
//                       title: const Text(
//                         'Только 1 нажатие ',
//                       ),
//                     );
//   }
// }

// // class MoodTracker extends StatefulWidget {
// //   const MoodTracker({Key? key}) : super(key: key);

// //   @override
// //   State<MoodTracker> createState() => _MoodTrackerState();
// // }

// // class _MoodTrackerState extends State<MoodTracker> {
// //   int _selectedMood = -1;
//   // double _stressLevel = 0.5;
//   // double _selfEsteem = 0.5;
// //   String _notes = '';

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: const Text('Mood Tracker'),
// //       ),
// //       body: Padding(
// //         padding: const EdgeInsets.all(16.0),
// //         child: Column(
// //           crossAxisAlignment: CrossAxisAlignment.start,
// //           children: [
// //             const Text(
// //               'How are you feeling?',
// //               style: TextStyle(
// //                 fontSize: 20,
// //                 fontWeight: FontWeight.bold,
// //               ),
// //             ),
// //             const SizedBox(height: 16),
// //             Row(
// //               mainAxisAlignment: MainAxisAlignment.spaceAround,
// //               children: [
// //                 MoodButton(
// //                   mood: 'Joy',
// //                   icon: Icons.emoji_emotions_outlined,
// //                   isSelected: _selectedMood == 0,
// //                   onTap: () {
// //                     setState(() {
// //                       _selectedMood = 0;
// //                     });
// //                   },
// //                 ),
// //                 MoodButton(
// //                   mood: 'Fear',
// //                   icon: Icons.sentiment_very_dissatisfied,
// //                   isSelected: _selectedMood == 1,
// //                   onTap: () {
// //                     setState(() {
// //                       _selectedMood = 1;
// //                     });
// //                   },
// //                 ),
// //                 MoodButton(
// //                   mood: 'Anger',
// //                   icon: Icons.analytics,
// //                   isSelected: _selectedMood == 2,
// //                   onTap: () {
// //                     setState(() {
// //                       _selectedMood = 2;
// //                     });
// //                   },
// //                 ),
// //                 MoodButton(
// //                   mood: 'Sadness',
// //                   icon: Icons.sentiment_dissatisfied,
// //                   isSelected: _selectedMood == 3,
// //                   onTap: () {
// //                     setState(() {
// //                       _selectedMood = 3;
// //                     });
// //                   },
// //                 ),
// //               ],
            
//     //         const SizedBox(height: 32),
//     //         const Text(
//     //           'Stress Level',
//     //           style: TextStyle(
//     //             fontSize: 18,
//     //             fontWeight: FontWeight.bold,
//     //           ),
//     //         ),
//     //         const SizedBox(height: 8),
//     //         Slider(
//     //           value: _stressLevel,
//     //           onChanged: (value) {
//     //             setState(() {
//     //               _stressLevel = value;
//     //             });
//     //           },
//     //           min: 0,
//     //           max: 1,
//     //           divisions: 10,
//     //           label: _stressLevel.toStringAsFixed(1),
//     //         ),
//     //         const SizedBox(height: 32),
//     //         const Text(
//     //           'Self Esteem',
//     //           style: TextStyle(
//     //             fontSize: 18,
//     //             fontWeight: FontWeight.bold,
//     //           ),
//     //         ),
//     //         const SizedBox(height: 8),
//     //         Slider(
//     //           value: _selfEsteem,
//     //           onChanged: (value) {
//     //             setState(() {
//     //               _selfEsteem = value;
//     //             });
//     //           },
//     //           min: 0,
//     //           max: 1,
//     //           divisions: 10,
//     //           label: _selfEsteem.toStringAsFixed(1),
//     //         ),
//     //         const SizedBox(height: 32),
//     //         const Text(
//     //           'Notes',
//     //           style: TextStyle(
//     //             fontSize: 18,
//     //             fontWeight: FontWeight.bold,
//     //           ),
//     //         ),
//     //         const SizedBox(height: 8),
//     //         TextField(
//     //           onChanged: (value) {
//     //             setState(() {
//     //               _notes = value;
//     //             });
//     //           },
//     //           maxLines: 5,
//     //           decoration: const InputDecoration(
//     //             hintText: 'Enter your notes here',
//     //             border: OutlineInputBorder(),
//     //           ),
//     //         ),
//     //         const SizedBox(height: 32),
//     //         ElevatedButton(
//     //           onPressed: () {
//     //             // TODO: Save mood data
//     //             print('Mood saved!');
//     //           },
//     //           child: const Text('Save'),
//     //         ),
//     //       ],
//     //     ),
//     //   ),
//     // );
// //   }
// // }
