import 'package:flutter/material.dart';

class ListCategory {
  List<DropdownMenuItem<String>> get dropdownIncomeItems {
    List<DropdownMenuItem<String>> menuItems = [
      const DropdownMenuItem(value: 'Gaji', child: Text('Gaji')),
      const DropdownMenuItem(value: 'Bonus', child: Text('Bonus')),
      const DropdownMenuItem(
          value: 'Hasil Investasi', child: Text('Hasil Investasi')),
      const DropdownMenuItem(value: 'Lainya', child: Text('Lainya')),
    ];
    return menuItems;
  }

  List<DropdownMenuItem<String>> get dropdownExpenditureItems {
    List<DropdownMenuItem<String>> menuItems = [
      const DropdownMenuItem(value: 'Belanja', child: Text('Belanja')),
      const DropdownMenuItem(value: 'Bensin', child: Text('Bensin')),
      const DropdownMenuItem(value: 'Asuransi', child: Text('Asuransi')),
      const DropdownMenuItem(value: 'Edukasi', child: Text('Edukasi')),
      const DropdownMenuItem(value: 'Investasi', child: Text('Investasi')),
      const DropdownMenuItem(value: 'Kesehatan', child: Text('Kesehatan')),
      const DropdownMenuItem(value: 'Lainya', child: Text('Lainya')),
    ];
    return menuItems;
  }
}
