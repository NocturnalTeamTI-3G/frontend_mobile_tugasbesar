import 'package:flutter/material.dart';
import 'package:frontend_mobile_tugasbesar/app/modules/history/providers/history_provider.dart';
import 'package:frontend_mobile_tugasbesar/app/modules/history/widgets/custom_appbar_with_tabbar.dart';
import 'package:frontend_mobile_tugasbesar/app/modules/history/widgets/history_list.dart';
import 'package:provider/provider.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late HistoryProvider historyProvider;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      historyProvider = Provider.of<HistoryProvider>(context, listen: false);
      historyProvider.getHistory();
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(120),
        child: CustomAppbarWithTabbar(tabController: _tabController),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          Consumer<HistoryProvider>(
            builder: (context, historyProvider, child) {
              return historyProvider.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : HistoryList(list: historyProvider.historyList);
            },
          ),
          Consumer<HistoryProvider>(
            builder: (context, historyProvider, child) {
              return historyProvider.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : HistoryList(list: historyProvider.healthyHistoryList);
            },
          ),
          Consumer<HistoryProvider>(
            builder: (context, historyProvider, child) {
              return historyProvider.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : HistoryList(list: historyProvider.acneHistoryList);
            },
          ),
        ],
      ),
    );
  }
}
