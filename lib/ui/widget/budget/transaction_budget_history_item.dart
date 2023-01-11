import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:moneyger/common/color_value.dart';
import 'package:moneyger/common/navigate.dart';
import 'package:moneyger/common/shared_code.dart';
import 'package:moneyger/ui/budget/edit_budget_transaction.dart';
import 'package:moneyger/ui/widget/loading/shimmer_widget.dart';
import 'package:moneyger/ui/transaction/edit_transaction.dart';
import 'package:moneyger/ui/widget/pop_menu/custom_pop_menu_budget.dart';
import 'package:moneyger/ui/widget/pop_menu/custom_pop_menu_transaction.dart';

class TransactionBudgetHistoryItem extends StatefulWidget {
  final String docId, category;

  const TransactionBudgetHistoryItem({Key? key, required this.docId, required this.category})
      : super(key: key);

  @override
  State<TransactionBudgetHistoryItem> createState() =>
      _TransactionBudgetHistoryItemState();
}

class _TransactionBudgetHistoryItemState
    extends State<TransactionBudgetHistoryItem> {
  var _tapPosition;

  final _collection = FirebaseFirestore.instance
      .collection('users')
      .doc(SharedCode().uid)
      .collection('budget');

  void _showCustomPopMenu(List data) {
    final RenderObject? overlay =
        Overlay.of(context)?.context.findRenderObject();

    showMenu(
      context: context,
      position: RelativeRect.fromRect(
        _tapPosition & const Size(40, 40),
        Offset.zero & overlay!.paintBounds.size,
      ),
      items: <PopupMenuEntry<int>>[
        CustomPopMenuBudget(
          data: data,
        ),
      ],
    );
  }

  void _storePosition(TapDownDetails details) {
    _tapPosition = details.globalPosition;
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return StreamBuilder<QuerySnapshot>(
      stream: _collection
          .doc(widget.docId)
          .collection('transaction')
          .orderBy('created_at', descending: true)
          .snapshots(),
      builder: (_, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text('Data masih kosong'),
            );
          }
          return ListView.builder(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (_, index) {
              final data = snapshot.data!.docs[index];

              return GestureDetector(
                onLongPress: () {
                  _showCustomPopMenu(
                    [
                      widget.docId,
                      data.id,
                      data['total'],
                      data['day'],
                      data['week'],
                      data['desc'],
                    ],
                  );
                },
                onTapDown: _storePosition,
                onTap: () {
                  Navigate.navigatorPush(
                      context,
                      EditBudgetTransactionPage(
                        data: [
                          data['total'],
                          data['date'],
                          data['desc'],
                          data['day'],
                          data['week'],
                          widget.docId,
                          data.id,
                          widget.category,
                        ],
                      ));
                },
                child: Container(
                  padding: const EdgeInsets.all(15),
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.only(bottom: 8),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF9F9F9),
                    borderRadius: BorderRadius.circular(7.5),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        width: 35,
                        height: 35,
                        margin: const EdgeInsets.only(right: 16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: ColorValue.redColor,
                        ),
                        child: SvgPicture.asset(
                          'assets/svg/down.svg',
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.category,
                            style: textTheme.bodyText1!.copyWith(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            data['desc'],
                            style: textTheme.bodyText2,
                          )
                        ],
                      ),
                      const Spacer(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            '- ${SharedCode().convertToIdr(data['total'], 0)}',
                            style: textTheme.bodyText2!.copyWith(
                              color: ColorValue.redColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(
                            height: 3,
                          ),
                          Text(
                            data['date'],
                            style: textTheme.bodyText2,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              );
            },
          );
        } else {
          return ListView.builder(
            padding: EdgeInsets.zero,
            itemCount: 3,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return Container(
                margin: const EdgeInsets.only(bottom: 8),
                child: ShimmerWidget(
                  height: 65,
                  width: MediaQuery.of(context).size.width,
                  radius: 7.5,
                ),
              );
            },
          );
        }
      },
    );
  }
}
