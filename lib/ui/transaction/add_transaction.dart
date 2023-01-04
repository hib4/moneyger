import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:moneyger/common/color_value.dart';
import 'package:moneyger/common/shared_code.dart';
import 'package:moneyger/constant/list_category.dart';
import 'package:moneyger/service/firebase_service.dart';
import 'package:moneyger/ui/widget/snackbar/snackbar_item.dart';

class AddTransactionPage extends StatefulWidget {
  const AddTransactionPage({Key? key}) : super(key: key);

  @override
  State<AddTransactionPage> createState() => _AddTransactionPageState();
}

class _AddTransactionPageState extends State<AddTransactionPage> {
  bool _isSelectedIncome = true;
  String _selectedCategory = 'Gaji';
  final _formKey = GlobalKey<FormState>();
  final _formatter = CurrencyTextInputFormatter(
    locale: 'id',
    decimalDigits: 0,
    symbol: 'Rp ',
  );
  Map<String, dynamic> _userData = {};

  final _totalController = TextEditingController();
  final _dateController = TextEditingController();
  final _descController = TextEditingController();

  Future _selectDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      setState(
        () => _dateController.text =
            DateFormat('d MMM yyyy', 'id').format(picked),
      );
    }
  }

  Future _getUserData() async {
    var document =
        FirebaseFirestore.instance.collection('users').doc(SharedCode().uid);

    var value = await document.get();
    _userData = value.data() ?? {};
  }

  Future<bool> _addTransaction(bool isSelectedIncome) async {
    bool isSuccess = await FirebaseService().addTransaction(
      context,
      type: isSelectedIncome ? 'income' : 'expenditure',
      total: _formatter.getUnformattedValue(),
      category: _selectedCategory,
      date: _dateController.text,
      desc: _descController.text,
    );

    return isSuccess;
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Tambah Transaksi',
          style: TextStyle(color: Colors.black),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 16),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buttonIncome(textTheme),
                      _buttonExpenditure(textTheme),
                    ],
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  Text(
                    'Nominal',
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
                    validator: (value) => SharedCode().emptyValidator(value),
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
                    items: _isSelectedIncome
                        ? ListCategory().dropdownIncomeItems
                        : ListCategory().dropdownExpenditureItems,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(
                    'Tanggal',
                    style: textTheme.bodyText1!.copyWith(
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  InkWell(
                    borderRadius: BorderRadius.circular(8),
                    onTap: () async {
                      await _selectDate();
                    },
                    child: IgnorePointer(
                      child: _textFormTransaction(
                        textTheme,
                        hint: 'Masukkan tanggal',
                        controller: _dateController,
                        withIcon: true,
                        validator: (value) =>
                            SharedCode().emptyValidator(value),
                      ),
                    ),
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
                    validator: (value) => SharedCode().emptyValidator(value),
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
                        _isSelectedIncome
                            ? await _addTransaction(_isSelectedIncome).then(
                                (value) =>
                                    value ? Navigator.pop(context) : null,
                              )
                            : _getUserData().then((value) async {
                                _userData['total_balance'] <
                                        _formatter.getUnformattedValue()
                                    ? showSnackBar(context,
                                        title: 'Saldo tidak mencukupi')
                                    : await _addTransaction(_isSelectedIncome)
                                        .then(
                                        (value) => value
                                            ? Navigator.pop(context)
                                            : null,
                                      );
                              });
                      }
                    },
                    child: const Text('Tambah'),
                  ),
                ],
              ),
            ),
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

  Widget _buttonExpenditure(TextTheme textTheme) {
    return GestureDetector(
      onTap: () {
        if (_isSelectedIncome == true) {
          setState(() {
            _isSelectedIncome = !_isSelectedIncome;
            _selectedCategory = 'Belanja';
          });
        }
      },
      child: Container(
        width: 148,
        height: 48,
        decoration: BoxDecoration(
          border: Border.all(
            color: ColorValue.greyBorderColor,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(10),
          color: _isSelectedIncome
              ? Colors.white
              : ColorValue.secondaryColor.withOpacity(0.1),
        ),
        child: Center(
          child: Text(
            'Pengeluaran',
            style: textTheme.bodyText1!.copyWith(
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buttonIncome(TextTheme textTheme) {
    return GestureDetector(
      onTap: () {
        if (_isSelectedIncome == false) {
          setState(() {
            _isSelectedIncome = !_isSelectedIncome;
            _selectedCategory = 'Gaji';
          });
        }
      },
      child: Container(
        width: 148,
        height: 48,
        decoration: BoxDecoration(
          border: Border.all(
            color: ColorValue.greyBorderColor,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(10),
          color: _isSelectedIncome
              ? ColorValue.secondaryColor.withOpacity(0.1)
              : Colors.white,
        ),
        child: Center(
          child: Text(
            'Pendapatan',
            style: textTheme.bodyText1!.copyWith(
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
