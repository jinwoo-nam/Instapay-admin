import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({Key? key}) : super(key: key);

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  final List<ListItem> _items = [
    ListItem(
      title: '거래 내역',
      faIcon: const FaIcon(
        FontAwesomeIcons.chartColumn,
        color: Colors.white54,
        size: 25,
      ),
      childrenItems: [ListChildrenItem(title: ' - 거래 내역 조회', press: () {})],
    ),
    ListItem(
      title: '정산 내역',
      faIcon: const FaIcon(
        FontAwesomeIcons.calculator,
        color: Colors.white54,
        size: 25,
      ),
      childrenItems: [ListChildrenItem(title: ' - 정산 내역 조회', press: () {})],
    ),
    ListItem(
      title: '가맹점 정보',
      faIcon: const FaIcon(
        FontAwesomeIcons.truck,
        color: Colors.white54,
        size: 25,
      ),
      childrenItems: [
        ListChildrenItem(title: ' - 기본 정보', press: () {}),
        ListChildrenItem(title: ' - QR코드 관리', press: () {}),
      ],
    ),
  ];

  List<ExpansionPanel> _getExpansionPanels(List<ListItem> items) {
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

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            padding: const EdgeInsets.all(62),
            child: Image.asset(
              'img/home-logo@2x.png',
            ),
          ),
          ExpansionPanelList(
            elevation: 3,
            children: _getExpansionPanels(_items),
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
    this.isExpanded = false,
  });
}

class ListChildrenItem {
  final String title;
  final VoidCallback press;

  ListChildrenItem({
    required this.title,
    required this.press,
  });
}
