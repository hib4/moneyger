import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:moneyger/common/color_value.dart';
import 'package:moneyger/common/shared_code.dart';
import 'package:moneyger/service/firebase_service.dart';
import 'package:moneyger/ui/widget/loading/loading_animation.dart';
import 'package:moneyger/ui/widget/snackbar/snackbar_item.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _document =
      FirebaseFirestore.instance.collection('users').doc(SharedCode().uid);
  final _fullNameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  PlatformFile? _pickedImage;

  Future _selectImage() async {
    final result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg', 'png'],
    );

    if (result != null) {
      setState(() {
        _pickedImage = result.files.first;
      });
    } else {
      showSnackBar(context, title: 'Tidak ada gambar yang dipilih');
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Edit Profil',
          style: TextStyle(color: Colors.black),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        child: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
          future: _document.get(),
          builder: (_, snapshot) {
            if (snapshot.hasData) {
              var data = snapshot.data!;
              _fullNameController.text = data['full_name'];

              return Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: GestureDetector(
                          onTap: _selectImage,
                          child: Stack(
                            children: [
                              CircleAvatar(
                                backgroundColor: ColorValue.secondaryColor,
                                radius: 50,
                                backgroundImage: _pickedImage != null
                                    ? FileImage(
                                        File(
                                          _pickedImage!.path!,
                                        ),
                                      )
                                    : data['photo_profile'] != ''
                                        ? NetworkImage(data['photo_profile'])
                                            as ImageProvider
                                        : null,
                                child: data['photo_profile'] != '' ||
                                        _pickedImage != null
                                    ? null
                                    : Text(
                                        SharedCode()
                                            .getInitials(data['full_name']),
                                        style: textTheme.headline2!.copyWith(
                                          color: Colors.white,
                                          fontSize: 22,
                                        ),
                                      ),
                              ),
                              const Positioned(
                                bottom: 5,
                                right: 3,
                                child: CircleAvatar(
                                  radius: 12,
                                  child: Icon(Icons.edit_rounded, size: 12),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 32,
                      ),
                      Text(
                        'Nama Lengkap',
                        style: textTheme.bodyText1!.copyWith(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      _textFormTransaction(
                        textTheme,
                        hint: 'Masukkan nama lengkap',
                        controller: _fullNameController,
                        validator: (value) => SharedCode().nameValidator(value),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Text(
                        'Email',
                        style: textTheme.bodyText1!.copyWith(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Container(
                        width: double.infinity,
                        height: 50,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          data['email'],
                          style: textTheme.bodyText1,
                        ),
                      ),
                      const SizedBox(
                        height: 32,
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            _pickedImage != null
                                ? await FirebaseService()
                                    .editProfileWithImage(
                                      context,
                                      name: _fullNameController.text,
                                      fileName: _pickedImage!.name,
                                      filePath: _pickedImage!.path!,
                                    )
                                    .then(
                                      (value) =>
                                          value ? Navigator.pop(context) : null,
                                    )
                                : await FirebaseService()
                                    .editProfile(
                                      context,
                                      name: _fullNameController.text,
                                    )
                                    .then(
                                      (value) =>
                                          value ? Navigator.pop(context) : null,
                                    );
                          }
                        },
                        child: const Text('Edit'),
                      ),
                    ],
                  ),
                ),
              );
            } else {
              return const Center(
                child: LoadingAnimation(),
              );
            }
          },
        ),
      ),
    );
  }

  Widget _textFormTransaction(
    TextTheme textTheme, {
    required String hint,
    required TextEditingController controller,
    TextInputType textInputType = TextInputType.text,
    String? Function(String?)? validator,
    bool withIcon = false,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: textInputType,
      validator: validator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      style: textTheme.bodyText1!.copyWith(color: Colors.black),
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
