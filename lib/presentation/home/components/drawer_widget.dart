import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:instapay_admin/presentation/home/home_state.dart';
import 'package:instapay_admin/presentation/home/home_view_model.dart';
import 'package:instapay_admin/ui/color.dart';
import 'package:provider/provider.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({Key? key}) : super(key: key);

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  final scrollController = ScrollController();
  List<ListItem> _items = [];

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    final viewModel = context.read<HomeViewModel>();

    _items = [
      ListItem(
        title: '거래 내역',
        faIcon: const FaIcon(
          FontAwesomeIcons.chartColumn,
          color: Colors.white54,
          size: 25,
        ),
        childrenItems: [
          ListChildrenItem(
            title: ' - 거래 내역 조회',
            press: () {
              Navigator.pop(context);
              return viewModel
                  .setSelectScreenType(SelectScreenType.tradeHistoryScreen);
            },
            type: SelectScreenType.tradeHistoryScreen,
          )
        ],
      ),
      ListItem(
        title: '정산 내역',
        faIcon: const FaIcon(
          FontAwesomeIcons.calculator,
          color: Colors.white54,
          size: 25,
        ),
        childrenItems: [
          ListChildrenItem(
            title: ' - 정산 내역 조회',
            press: () {
              Navigator.pop(context);
              return viewModel
                  .setSelectScreenType(SelectScreenType.trasHistoryScreen);
            },
            type: SelectScreenType.trasHistoryScreen,
          )
        ],
      ),
      ListItem(
        title: '가맹점 정보',
        faIcon: const FaIcon(
          FontAwesomeIcons.truck,
          color: Colors.white54,
          size: 25,
        ),
        childrenItems: [
          ListChildrenItem(
            title: ' - 기본 정보',
            press: () {
              Navigator.pop(context);
              return viewModel
                  .setSelectScreenType(SelectScreenType.storeInfoScreen);
            },
            type: SelectScreenType.storeInfoScreen,
          ),
          ListChildrenItem(
            title: ' - QR코드 관리',
            press: () {
              Navigator.pop(context);
              return viewModel
                  .setSelectScreenType(SelectScreenType.qrCodeManageScreen);
            },
            type: SelectScreenType.qrCodeManageScreen,
          ),
        ],
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<HomeViewModel>();

    return Drawer(
      child: ListView(
        controller: scrollController,
        children: [
          DrawerHeader(
            padding: const EdgeInsets.all(62),
            child: Image.asset(
              'img/home-logo@2x.png',
            ),
          ),
          ExpansionPanelList(
            elevation: 3,
            children: _getExpansionPanels(_items, viewModel),
            expansionCallback: (panelIndex, isExpanded) {
              setState(() {
                _items[panelIndex].isExpanded = !isExpanded;
              });
            },
          ),
        ],
      ),
    );
  }

  List<ExpansionPanel> _getExpansionPanels(
      List<ListItem> items, HomeViewModel viewModel) {
    return items.map<ExpansionPanel>((ListItem item) {
      return ExpansionPanel(
          headerBuilder: (BuildContext context, bool isExpanded) {
            return DrawerListTile(
              title: item.title,
              faIcon: item.faIcon,
            );
          },
          body: Column(
            children: item.childrenItems.map((child) {
              return ListTile(
                tileColor: viewModel.state.selectScreenType == child.type
                    ? pointColor.withOpacity(0.5)
                    : null,
                horizontalTitleGap: 0.0,
                title: Text(
                  child.title,
                  style: const TextStyle(color: Colors.white54, fontSize: 22),
                ),
                onTap: child.press,
              );
            }).toList(),
          ),
          isExpanded: item.isExpanded,
          backgroundColor: Colors.transparent);
    }).toList();
  }
}

class DrawerListTile extends StatelessWidget {
  const DrawerListTile({
    Key? key,
    // For selecting those three line once press "Command+D"
    required this.title,
    required this.faIcon,
  }) : super(key: key);

  final String title;
  final FaIcon faIcon;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      horizontalTitleGap: 0.0,
      leading: faIcon,
      title: Text(
        title,
        style: const TextStyle(color: Colors.white54, fontSize: 22),
      ),
    );
  }
}

class ListItem {
  final String title;
  final FaIcon faIcon;
  final List<ListChildrenItem> childrenItems;
  bool isExpanded;

  ListItem({
    required this.title,
    required this.faIcon,
    required this.childrenItems,
    this.isExpanded = true,
  });
}

class ListChildrenItem {
  final String title;
  final VoidCallback press;
  final SelectScreenType type;

  ListChildrenItem({
    required this.title,
    required this.press,
    required this.type,
  });
}
