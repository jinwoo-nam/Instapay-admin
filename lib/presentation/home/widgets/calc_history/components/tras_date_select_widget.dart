import 'package:flutter/material.dart';
import 'package:instapay_admin/presentation/home/home_state.dart';
import 'package:instapay_admin/ui/color.dart';
import 'package:intl/intl.dart';

class TrasDateSelectWidget extends StatelessWidget {
  const TrasDateSelectWidget({
    Key? key,
    required this.dateContainerWidth,
    required this.state,
  }) : super(key: key);

  final double dateContainerWidth;
  final HomeState state;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // viewModel.setCalendarSelectState(
        //     !state.isCalendarSelected, PeriodType.start);
      },
      child: Container(
        padding: const EdgeInsets.all(13),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          color: secondaryColor,
        ),
        width: dateContainerWidth,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              state.calcDay == null
                  ? '정산일'
                  : DateFormat('yyyy-MM-dd').format(state.calcDay!),
              style: const TextStyle(
                color: Colors.white54,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
