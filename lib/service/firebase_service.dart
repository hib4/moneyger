import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:moneyger/ui/widget/snackbar/snackbar_item.dart';

class FirebaseService {
  Future<bool> signUpEmail(
    BuildContext context, {
    required String email,
    required String password,
    required String fullName,
  }) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) {
        FirebaseFirestore.instance.runTransaction((transaction) async {
          DocumentReference documentReference = FirebaseFirestore.instance
              .collection('users')
              .doc(FirebaseAuth.instance.currentUser!.uid);
          DocumentSnapshot snapshot = await transaction.get(documentReference);

          if (!snapshot.exists) {
            documentReference.set({
              'email': email,
              'full_name': fullName,
              'created_at': DateTime.now(),
              'updated_at': DateTime.now(),
            });
            return true;
          } else {
            documentReference.update({
              'updated_at': DateTime.now(),
            });
            return true;
          }
        });
      });
      return true;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'email-already-in-use':
          showSnackBar(context, title: 'Email sudah digunakan');
          break;
      }
      return false;
    } on SocketException {
      showSnackBar(context, title: 'Tidak ada koneksi internet');
      return false;
    }
  }

  Future<bool> signInEmail(
    BuildContext context, {
    required String email,
    required String password,
  }) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return true;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'user-not-found':
          showSnackBar(context, title: 'Pengguna tidak ditemukan');
          break;
        case 'wrong-password':
          showSnackBar(context, title: 'Kata sandi salah');
          break;
      }
      return false;
    } on SocketException {
      showSnackBar(context, title: 'Tidak ada koneksi internet');
      return false;
    }
  }
}
