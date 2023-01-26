import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:moneyger/common/app_theme_data.dart';
import 'package:moneyger/common/color_value.dart';
import 'package:moneyger/common/shared_code.dart';
import 'package:moneyger/constant/list_category.dart';
import 'package:moneyger/service/firebase_service.dart';
import 'package:provider/provider.dart';

class EditBudgetPage extends StatefulWidget {
  final num budget;
  final String docId, category, desc;

  const EditBudgetPage(
      {Key? key,
      required this.budget,
      required this.category,
      required this.desc,
      required this.docId})
      : super(key: key);

  @override
  State<EditBudgetPage> createState() => _EditBudgetPageState();
}

class _EditBudgetPageState extends State<EditBudgetPage> {
  String _selectedCategory = '';
  final _budgetController = TextEditingController();
  final _descController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _formatter = CurrencyTextInputFormatter(
    locale: 'id',
    decimalDigits: 0,
    symbol: 'Rp. ',
  );

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _selectedCategory = widget.category;
    _budgetController.text = _formatter.format(widget.budget.toString());
    _descController.text = widget.desc;
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final provider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor:
            provider.isDarkMode ? ColorValueDark.backgroundColor : Colors.white,
        title: Text(
          'Edit Anggaran',
          style: TextStyle(
            color: provider.isDarkMode ? Colors.white : Colors.black,
          ),
        ),
        iconTheme: IconThemeData(
          color: provider.isDarkMode ? Colors.white : Colors.black,
        ),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 16,
              ),
              Text(
                'Anggaran Kamu',
                style: textTheme.bodyText1!.copyWith(
                  color: provider.isDarkMode ? Colors.white : Colors.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              _textFormTransaction(
                textTheme,
                hint: 'Masukkan anggaran',
                controller: _budgetController,
                validator: (value) => SharedCode().emptyValidator(value),
                isDarkMode: provider.isDarkMode,
              ),
              const SizedBox(
                height: 16,
              ),
              Text(
                'Kategori',
                style: textTheme.bodyText1!.copyWith(
                  color: provider.isDarkMode ? Colors.white : Colors.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              _dropdownCategory(
                textTheme,
                value: _selectedCategory,
                items: ListCategory().dropdownExpenditureItems,
                isDarkMode: provider.isDarkMode,
              ),
              const SizedBox(
                height: 16,
              ),
              Text(
                'Deskripsi',
                style: textTheme.bodyText1!.copyWith(
                  color: provider.isDarkMode ? Colors.white : Colors.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              _textFormTransaction(
                textTheme,
                hint: 'Masukkan deskripsi',
                controller: _descController,
                validator: (value) => SharedCode().emptyValidator(value),
                isDarkMode: provider.isDarkMode,
              ),
              const SizedBox(
                height: 32,
              ),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    await FirebaseService()
                        .editBudget(
                          context,
                          docId: widget.docId,
                          category: _selectedCategory,
                          desc: _descController.text,
                        )
                        .then(
                          (value) => value ? Navigator.pop(context) : null,
                        );
                  }
                },
                child: const Text('Edit'),
              ),
            ],
          ),
        ),
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
}
