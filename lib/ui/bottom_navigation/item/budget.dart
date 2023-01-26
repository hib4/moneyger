import 'package:flutter/material.dart';
import 'package:moneyger/common/app_theme_data.dart';
import 'package:moneyger/common/color_value.dart';
import 'package:moneyger/common/navigate.dart';
import 'package:moneyger/ui/budget/add_budget.dart';
import 'package:moneyger/ui/widget/budget/budget_history_item.dart';
import 'package:provider/provider.dart';

class BudgetPage extends StatefulWidget {
  const BudgetPage({Key? key}) : super(key: key);

  @override
  State<BudgetPage> createState() => _BudgetPageState();
}

class _BudgetPageState extends State<BudgetPage> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Anggaran Kamu",
          style: TextStyle(
            color: provider.isDarkMode
                ? Colors.white
                : ColorValueDark.backgroundColor,
          ),
        ),
        backgroundColor:
            provider.isDarkMode ? ColorValueDark.backgroundColor : Colors.white,
        iconTheme: IconThemeData(
          color: provider.isDarkMode ? Colors.white : Colors.black,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigate.navigatorPush(context, const AddBudgetPage());
        },
        backgroundColor: provider.isDarkMode
            ? ColorValueDark.secondaryColor
            : ColorValue.secondaryColor,
        child: const Icon(Icons.add_rounded),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: const [
              BudgetHistoryItem(),
            ],
          ),
        ),
      ),
    );
  }
}
