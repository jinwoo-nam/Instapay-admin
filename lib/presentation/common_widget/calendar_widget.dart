import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarWidget extends StatefulWidget {
  final void Function(DateTime date)? onCalendarTap;

  const CalendarWidget({
    Key? key,
    this.onCalendarTap,
  }) : super(key: key);

  @override
  State<CalendarWidget> createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {
  late final PageController _pageController;

  final ValueNotifier<DateTime> _focusedDay = ValueNotifier(DateTime.now());
  DateTime? _selectedDay;

  @override
  void initState() {
    super.initState();

    _selectedDay = _focusedDay.value;
  }

  @override
  void dispose() {
    _focusedDay.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ValueListenableBuilder<DateTime>(
          valueListenable: _focusedDay,
          builder: (context, value, _) {
            return _CalendarHeader(
              focusedDay: value,
              clearButtonVisible: false,
              onTodayButtonTap: () {
                setState(() {
                  _focusedDay.value = DateTime.now();
                  _selectedDay = DateTime.now();
                });
              },
              onClearButtonTap: () {
                setState(() {});
              },
              onLeftArrowTap: () {
                _pageController.previousPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeOut,
                );
              },
              onRightArrowTap: () {
                _pageController.nextPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeOut,
                );
              },
              onYearSelect: (year) {
                int res = int.parse(year.substring(0, year.length - 1));
                int gap = res - _focusedDay.value.year;
                _focusedDay.value = DateTime(res, DateTime.now().month);
                _pageController
                    .jumpToPage(_pageController.page!.round() + (12 * gap));
              },
            );
          },
        ),
        TableCalendar(
          firstDay: kFirstDay,
          lastDay: kLastDay,
          focusedDay: _focusedDay.value,
          headerVisible: false,
          selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
          onDaySelected: (DateTime selectedDay, DateTime focusedDay) {
            setState(() {
              widget.onCalendarTap?.call(selectedDay);

              if (!isSameDay(_selectedDay, selectedDay)) {
                _selectedDay = selectedDay;
              }

              _focusedDay.value = focusedDay;
            });
          },
          onCalendarCreated: (controller) => _pageController = controller,
          onPageChanged: (focusedDay) => _focusedDay.value = focusedDay,
        ),
      ],
    );
  }
}

class _CalendarHeader extends StatefulWidget {
  final DateTime focusedDay;
  final VoidCallback onLeftArrowTap;
  final VoidCallback onRightArrowTap;
  final VoidCallback onTodayButtonTap;
  final VoidCallback onClearButtonTap;
  final bool clearButtonVisible;
  final void Function(String) onYearSelect;

  const _CalendarHeader({
    Key? key,
    required this.focusedDay,
    required this.onLeftArrowTap,
    required this.onRightArrowTap,
    required this.onTodayButtonTap,
    required this.onClearButtonTap,
    required this.clearButtonVisible,
    required this.onYearSelect,
  }) : super(key: key);

  @override
  State<_CalendarHeader> createState() => _CalendarHeaderState();
}

class _CalendarHeaderState extends State<_CalendarHeader> {
  List<String> yearItems = [];
  List<String> monthtems = [];
  String selectedValue = '${DateTime.now().year}년';

  @override
  void initState() {
    for (int i = 0; i < 10; i++) {
      yearItems.add('${DateTime.now().year - i}년');
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final headerText = DateFormat.yMMM().format(widget.focusedDay);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          const SizedBox(width: 16.0),
          IconButton(
            icon: const Icon(Icons.chevron_left),
            onPressed: widget.onLeftArrowTap,
          ),
          SizedBox(
            width: 130.0,
            child: Text(
              headerText,
              style: const TextStyle(fontSize: 26.0),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.chevron_right),
            onPressed: widget.onRightArrowTap,
          ),
          GestureDetector(
            onTap: widget.onTodayButtonTap,
            child: Container(
              padding: const EdgeInsets.all(7),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white54),
                borderRadius: BorderRadius.circular(15),
              ),
              child: const Text('Today'),
            ),
          ),
          const Spacer(),
          DropdownButton2(
            isExpanded: true,
            items: yearItems
                .map((item) => DropdownMenuItem<String>(
                      value: item,
                      child: Text(
                        item,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ))
                .toList(),
            value: selectedValue,
            onChanged: (value) {
              setState(() {
                selectedValue = value as String;
                widget.onYearSelect.call(selectedValue);
              });
            },
            icon: const Icon(
              Icons.arrow_forward_ios_outlined,
            ),
            iconSize: 14,
            iconDisabledColor: Colors.grey,
            buttonHeight: 40,
            buttonWidth: 100,
            buttonPadding: const EdgeInsets.only(left: 14, right: 14),
            buttonDecoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
            ),
            itemHeight: 40,
            itemPadding: const EdgeInsets.only(left: 14, right: 14),
            dropdownMaxHeight: 200,
            dropdownWidth: 200,
            dropdownPadding: null,
            dropdownDecoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
            ),
            dropdownElevation: 8,
            scrollbarRadius: const Radius.circular(40),
            scrollbarThickness: 6,
            scrollbarAlwaysShow: true,
            offset: const Offset(-20, 0),
          ),
        ],
      ),
    );
  }
}

final kToday = DateTime.now();
final kFirstDay = DateTime(kToday.year - 20, 1, 1);
final kLastDay = DateTime(kToday.year + 3, 1, 1);
