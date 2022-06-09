import 'package:flutter/material.dart';
import 'package:instapay_admin/domain/model/qr_code_info.dart';
import 'package:instapay_admin/presentation/home/widgets/franchisee/qr_manage/components/qr_info_detail_widget.dart';
import 'package:instapay_admin/ui/color.dart';

class QrInfoListWidget extends StatefulWidget {
  final QrCodeInfo data;

  const QrInfoListWidget({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  State<QrInfoListWidget> createState() => _QrInfoListWidgetState();
}

class _QrInfoListWidgetState extends State<QrInfoListWidget> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Checkbox(
              value: isSelected,
              onChanged: (checked) {
                setState(() {
                  if (checked != null) {
                    isSelected = checked;
                  }
                });
              }),
          Expanded(
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => QrInfoDetailWidget(
                      data: widget.data,
                    ),
                  ),
                );
              },
              child: Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: secondaryColor,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const Expanded(
                          child: Text('결제건명'),
                        ),
                        Expanded(
                          flex: 3,
                          child: Text(widget.data.title),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Expanded(
                          child: Text('결제금액'),
                        ),
                        Expanded(
                          flex: 3,
                          child: Text('${widget.data.price}'),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Expanded(
                          child: Text('유효기간'),
                        ),
                        Expanded(
                          flex: 3,
                          child: Text(widget.data.expireDate),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Expanded(
                          child: Text('생성일시'),
                        ),
                        Expanded(
                          flex: 3,
                          child: Text(widget.data.createDate),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Expanded(
                          child: Text('상태'),
                        ),
                        Expanded(
                          flex: 3,
                          child: Text(widget.data.state),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
