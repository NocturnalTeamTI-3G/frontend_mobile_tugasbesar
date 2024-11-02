import 'package:flutter/material.dart';
import 'package:frontend_mobile_tugasbesar/models/history/history_model.dart';
import 'package:frontend_mobile_tugasbesar/views/history/widgets/custom_appbar_with_tabbar.dart';
import 'package:frontend_mobile_tugasbesar/views/history/widgets/history_list.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<HistoryType> historyList = HistoryData().getAllHistory();
    List<HistoryType> successHistoryList = HistoryData().getSuccessHistory();
    List<HistoryType> failHistoryList = HistoryData().getFailHistory();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(140),
        child: CustomAppbarWithTabbar(tabController: _tabController),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          HistoryList(list: historyList),
          HistoryList(list: successHistoryList),
          HistoryList(list: failHistoryList),
        ],
      ),
    );
  }
}
