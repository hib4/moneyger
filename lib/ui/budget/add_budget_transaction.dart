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

class AddBudgetTransactionPage extends StatefulWidget {
  final String docId;

  const AddBudgetTransactionPage({Key? key, required this.docId})
      : super(key: key);

  @override
  State<AddBudgetTransactionPage> createState() =>
      _AddBudgetTransactionPageState();
}

class _AddBudgetTransactionPageState extends State<AddBudgetTransactionPage> {
  String _selectedCategory = 'Belanja';
  final _formKey = GlobalKey<FormState>();
  final _formatter = CurrencyTextInputFormatter(
    locale: 'id',
    decimalDigits: 0,
    symbol: 'Rp. ',
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
            () =>
        _dateController.text =
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

  Future<bool> _addBudgetTransaction() async {
    bool isSuccess = await FirebaseService().addBudgetTransaction(
        context,
        total: _formatter.getUnformattedValue(),
        category: _selectedCategory,
        desc: _descController.text,
        date: _dateController.text,
        docId: widget.docId,
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
    final textTheme = Theme
        .of(context)
        .textTheme;

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
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 8),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                        _getUserData().then((value) async {
                          _userData['total_balance'] <
                              _formatter.getUnformattedValue()
                              ? showSnackBar(context,
                              title: 'Saldo tidak mencukupi')
                              : await _addBudgetTransaction().then(
                                (value) =>
                            value ? Navigator.pop(context) : null,
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

  Widget _dropdownCategory(TextTheme textTheme, {
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

  Widget _textFormTransaction(TextTheme textTheme, {
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
