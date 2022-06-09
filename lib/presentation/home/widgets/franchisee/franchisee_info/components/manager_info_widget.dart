import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:instapay_admin/domain/model/franchisee/franchisee_manager_info.dart';

class ManagerInfoWidget extends StatelessWidget {
  final FranchiseeManagerInfo info;
  final int index;
  final Function(int)? onDelete;

  const ManagerInfoWidget({
    Key? key,
    required this.info,
    required this.index,
    this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Center(
            child: Text(
              info.name,
              style: const TextStyle(
                fontSize: 14,
              ),
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Center(
            child: Text(
              info.department,
              style: const TextStyle(
                fontSize: 14,
              ),
            ),
          ),
        ),
        Expanded(
          flex: 4,
          child: Center(
            child: Text(
              info.email,
              style: const TextStyle(
                fontSize: 14,
              ),
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Center(
            child: Text(
              info.phone,
              style: const TextStyle(
                fontSize: 14,
              ),
            ),
          ),
        ),
        Expanded(
          child: Center(
              child: IconButton(
                onPressed: () {
                  if (onDelete != null) {
                    onDelete!(index);
                  }
                },
                icon: const FaIcon(
                  FontAwesomeIcons.circleXmark,
                  color: Colors.white54,
                  size: 20,
                ),
              )),
        ),
      ],
    );
  }
}
