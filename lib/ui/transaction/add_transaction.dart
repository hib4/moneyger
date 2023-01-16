import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:moneyger/common/app_theme_data.dart';
import 'package:moneyger/common/color_value.dart';
import 'package:moneyger/common/navigate.dart';
import 'package:moneyger/common/shared_code.dart';
import 'package:moneyger/constant/list_category.dart';
import 'package:moneyger/service/firebase_service.dart';
import 'package:moneyger/ui/bottom_navigation/bottom_navigation.dart';
import 'package:moneyger/ui/subscribe/subscribe.dart';
import 'package:moneyger/ui/widget/banner_subscription.dart';
import 'package:moneyger/ui/widget/snackbar/snackbar_item.dart';
import 'package:provider/provider.dart';

class AddTransactionPage extends StatefulWidget {
  final bool isFromHome;

  const AddTransactionPage({Key? key, this.isFromHome = false})
      : super(key: key);

  @override
  State<AddTransactionPage> createState() => _AddTransactionPageState();
}

class _AddTransactionPageState extends State<AddTransactionPage> {
  bool _isSelectedIncome = true;
  String _selectedCategory = 'Gaji';
  final ValueNotifier<bool> _status = ValueNotifier<bool>(true);
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

  Future _checkTokenStatus() async {
    String check = await SharedCode().getToken('subs') ?? '';
    if (check == '') {
      _status.value = true;
    } else {
      _status.value = false;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _checkTokenStatus();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final provider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Tambah Transaksi',
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
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              ValueListenableBuilder<bool>(
                valueListenable: _status,
                builder: (_, value, __) => Visibility(
                  visible: value,
                  child: const BannerSubscription(),
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(30, 8, 30, 16),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 16,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buttonIncome(textTheme, provider.isDarkMode),
                          _buttonExpenditure(textTheme, provider.isDarkMode),
                        ],
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      Text(
                        'Nominal',
                        style: textTheme.bodyText1!.copyWith(
                          color:
                              provider.isDarkMode ? Colors.white : Colors.black,
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
                        isDarkMode: provider.isDarkMode,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Text(
                        'Kategori',
                        style: textTheme.bodyText1!.copyWith(
                          color:
                              provider.isDarkMode ? Colors.white : Colors.black,
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
                        isDarkMode: provider.isDarkMode,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Text(
                        'Tanggal',
                        style: textTheme.bodyText1!.copyWith(
                          color:
                              provider.isDarkMode ? Colors.white : Colors.black,
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
                            isDarkMode: provider.isDarkMode,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Text(
                        'Deskripsi',
                        style: textTheme.bodyText1!.copyWith(
                          color:
                              provider.isDarkMode ? Colors.white : Colors.black,
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
                        isDarkMode: provider.isDarkMode,
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
                                    (value) => value
                                        ? widget.isFromHome
                                            ? Navigate.navigatorReplacement(
                                                context,
                                                const BottomNavigation(
                                                  currentIndex: 1,
                                                ))
                                            : Navigator.pop(context)
                                        : null,
                                  )
                                : _getUserData().then((value) async {
                                    _userData['total_balance'] <
                                            _formatter.getUnformattedValue()
                                        ? showSnackBar(context,
                                            title: 'Saldo tidak mencukupi')
                                        : await _addTransaction(
                                                _isSelectedIncome)
                                            .then(
                                            (value) => value
                                                ? widget.isFromHome
                                                    ? Navigate
                                                        .navigatorReplacement(
                                                            context,
                                                            const BottomNavigation(
                                                              currentIndex: 1,
                                                            ))
                                                    : Navigator.pop(context)
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
    required bool isDarkMode,
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
          color: isDarkMode ? Colors.white : Colors.black,
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
    required bool isDarkMode,
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
      style: textTheme.bodyText1!.copyWith(
        color: isDarkMode ? Colors.white : Colors.black,
      ),
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
          borderSide: BorderSide(
            width: 2,
            color: isDarkMode
                ? ColorValueDark.secondaryColor
                : ColorValue.secondaryColor,
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
            ? Icon(
                Icons.date_range_outlined,
                color: isDarkMode
                    ? ColorValueDark.secondaryColor
                    : ColorValue.secondaryColor,
              )
            : null,
        contentPadding:
            const EdgeInsets.symmetric(vertical: 17, horizontal: 16),
      ),
    );
  }

  Widget _buttonExpenditure(TextTheme textTheme, bool isDarkMode) {
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
              ? isDarkMode
                  ? ColorValueDark.backgroundColor
                  : Colors.white
              : isDarkMode
                  ? Colors.white
                  : ColorValue.secondaryColor.withOpacity(0.1),
        ),
        child: Center(
          child: Text(
            'Pengeluaran',
            style: textTheme.bodyText1!.copyWith(
              color: isDarkMode
                  ? _isSelectedIncome
                      ? Colors.white
                      : Colors.black
                  : Colors.black,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buttonIncome(TextTheme textTheme, bool isDarkMode) {
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
              ? isDarkMode
                  ? Colors.white
                  : ColorValue.secondaryColor.withOpacity(0.1)
              : isDarkMode
                  ? ColorValueDark.backgroundColor
                  : Colors.white,
        ),
        child: Center(
          child: Text(
            'Pendapatan',
            style: textTheme.bodyText1!.copyWith(
              color: isDarkMode
                  ? _isSelectedIncome
                      ? Colors.black
                      : Colors.white
                  : Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
