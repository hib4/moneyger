import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:moneyger/common/color_value.dart';
import 'package:moneyger/common/navigate.dart';
import 'package:moneyger/common/shared_code.dart';
import 'package:moneyger/constant/list_category.dart';
import 'package:moneyger/service/firebase_service.dart';
import 'package:moneyger/ui/bottom_navigation/bottom_navigation.dart';
import 'package:moneyger/ui/widget/banner_subscription.dart';
import 'package:moneyger/ui/widget/snackbar/snackbar_item.dart';

class AddBudgetPage extends StatefulWidget {
  final bool isFromHome;

  const AddBudgetPage({Key? key, this.isFromHome = false}) : super(key: key);

  @override
  State<AddBudgetPage> createState() => _AddBudgetPageState();
}

class _AddBudgetPageState extends State<AddBudgetPage> {
  String _selectedCategory = 'Belanja';
  final _formKey = GlobalKey<FormState>();
  final _formatter = CurrencyTextInputFormatter(
    locale: 'id',
    decimalDigits: 0,
    symbol: 'Rp. ',
  );

  final _totalController = TextEditingController();
  final _descController = TextEditingController();

  Future<bool> _addBudget() async {
    bool isSuccess = await FirebaseService().addBudget(
      context,
      category: _selectedCategory,
      desc: _descController.text,
      budget: _formatter.getUnformattedValue(),
      remain: _formatter.getUnformattedValue(),
    );

    return isSuccess;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Tambah Anggaran',
          style: TextStyle(color: Colors.black),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const BannerSubscription(),
              const SizedBox(
                height: 24,
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 8),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Berapa Anggaran Kamu',
                        style: textTheme.bodyText1!.copyWith(
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      _textFormTransaction(
                        textTheme,
                        hint: 'Rp',
                        controller: _totalController,
                        textInputType: TextInputType.number,
                        withInputFormatter: true,
                        validator: (value) =>
                            SharedCode().transactionValidator(value),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Text(
                        'Kategori',
                        style: textTheme.bodyText1!.copyWith(
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      _dropdownCategory(
                        textTheme,
                        value: _selectedCategory,
                        items: ListCategory().dropdownExpenditureItems,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Text(
                        'Deskripsi',
                        style: textTheme.bodyText1!.copyWith(
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      _textFormTransaction(
                        textTheme,
                        hint: 'Deskripsi singkat',
                        controller: _descController,
                        maxLength: 20,
                        validator: (value) =>
                            SharedCode().emptyValidator(value),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            await _addBudget().then(
                              (value) => value
                                  ? widget.isFromHome
                                      ? Navigate.navigatorReplacement(
                                          context,
                                          const BottomNavigation(
                                            currentIndex: 2,
                                          ))
                                      : Navigator.pop(context)
                                  : null,
                            );
                          }
                        },
                        child: const Text('Simpan'),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _dropdownCategory(
    TextTheme textTheme, {
    required String value,
    required List<DropdownMenuItem<String>>? items,
  }) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        value: value,
        items: items,
        onChanged: (String? value) {
          setState(() {
            _selectedCategory = value!;
          });
        },
        hint: Text(
          'Pilih Kategori',
          style: textTheme.bodyText1!,
        ),
        style: textTheme.bodyText1!.copyWith(
          color: Colors.black,
        ),
        isExpanded: true,
        itemHeight: 50,
        itemPadding: const EdgeInsets.symmetric(horizontal: 16),
        buttonPadding: const EdgeInsets.only(right: 16),
        dropdownPadding: const EdgeInsets.symmetric(vertical: 5),
        buttonDecoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: ColorValue.greyBorderColor,
            ),
            borderRadius: BorderRadius.circular(8)),
        iconDisabledColor: Colors.grey,
        iconEnabledColor: Colors.grey,
      ),
    );
  }

  Widget _textFormTransaction(
    TextTheme textTheme, {
    required String hint,
    required TextEditingController controller,
    TextInputType textInputType = TextInputType.text,
    String? Function(String?)? validator,
    int? maxLength,
    bool withInputFormatter = false,
    bool withIcon = false,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: textInputType,
      validator: validator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      style: textTheme.bodyText1!.copyWith(color: Colors.black),
      maxLength: maxLength ?? null,
      inputFormatters: withInputFormatter ? [_formatter] : [],
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderSide: const BorderSide(
            width: 1,
            color: ColorValue.borderColor,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            width: 1,
            color: ColorValue.borderColor,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            width: 2,
            color: ColorValue.secondaryColor,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            width: 2,
            color: Colors.redAccent,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            width: 2,
            color: Colors.redAccent,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        hintText: hint,
        hintStyle: textTheme.bodyText1,
        prefixIcon: withIcon
            ? const Icon(
                Icons.date_range_outlined,
                color: ColorValue.secondaryColor,
              )
            : null,
        contentPadding:
            const EdgeInsets.symmetric(vertical: 17, horizontal: 16),
      ),
    );
  }
}
