import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:intl/intl.dart';
import 'package:moneyger/common/shared_code.dart';
import 'package:moneyger/common/shared_code.dart';
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
              'total_balance': 0,
              'income': 0,
              'expenditure': 0,
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

  Future<bool> resetPassword(BuildContext context,
      {required String email}) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email).then(
            (value) => showSnackBar(
              context,
              title: 'Email telah dikirim (cek dibagian spam)',
              duration: const Duration(seconds: 3),
            ),
          );
      return true;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'user-not-found':
          showSnackBar(context, title: 'Email tidak ditemukan');
          break;
        case 'invalid-email':
          showSnackBar(context, title: 'Invalid Email');
          break;
        case 'missing-email':
          showSnackBar(context, title: 'Email tidak ditemukan');
          break;
      }
      return false;
    }
  }

  Future<bool> signInGoogle(BuildContext context) async {
    final GoogleSignIn googleSignIn = GoogleSignIn();

    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();

    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      try {
        await FirebaseAuth.instance
            .signInWithCredential(credential)
            .then((value) {
          FirebaseFirestore.instance.runTransaction((transaction) async {
            DocumentReference documentReference = FirebaseFirestore.instance
                .collection('users')
                .doc(FirebaseAuth.instance.currentUser!.uid);
            DocumentSnapshot snapshot =
                await transaction.get(documentReference);

            if (!snapshot.exists) {
              documentReference.set({
                'email': googleSignInAccount.email,
                'full_name': googleSignInAccount.displayName,
                'total_balance': 0,
                'income': 0,
                'expenditure': 0,
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
        return false;
      } on SocketException {
        showSnackBar(context, title: 'Tidak ada koneksi internet');
        return false;
      } on PlatformException {
        return false;
      }
    } else {
      return false;
    }
  }

  Future<bool> addTransaction(
    BuildContext context, {
    required String type,
    required num total,
    required String category,
    required String date,
    required String desc,
  }) async {
    try {
      String uid = SharedCode().uid;

      DocumentReference userDocument =
          FirebaseFirestore.instance.collection('users').doc(uid);

      DocumentReference transactionDocument = FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .collection('transaction')
          .doc();

      FirebaseFirestore.instance.runTransaction(
        (transaction) async {
          DocumentSnapshot userSnapshot = await transaction.get(userDocument);
          DocumentSnapshot transactionSnapshot =
              await transaction.get(transactionDocument);

          num oldBalance = userSnapshot['total_balance'];
          num newBalance =
              type == 'income' ? oldBalance + total : oldBalance - total;
          num oldValueType = userSnapshot[type];
          num newValueType = oldValueType + total;

          if (!transactionSnapshot.exists) {
            transactionDocument.set({
              'type': type,
              'total': total,
              'category': category,
              'date': date,
              'desc': desc,
              'created_at': DateTime.now(),
              'updated_at': DateTime.now(),
            }).then(
              (value) => addTypeTransaction(context, type: type, total: total),
            );
          }

          transaction.update(userDocument, {
            'total_balance': newBalance,
            type: newValueType,
          });
          return true;
        },
      );
      return true;
    } on PlatformException {
      return false;
    } on SocketException {
      showSnackBar(context, title: 'Tidak ada koneksi internet');
      return false;
    } on FirebaseException {
      return false;
    }
  }

  Future addTypeTransaction(
    BuildContext context, {
    required String type,
    required num total,
  }) async {
    try {
      String uid = SharedCode().uid;
      String day = SharedCode().day;
      String formattedDate = SharedCode().formattedDate;

      DocumentReference detailTransactionDocument = FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .collection(type)
          .doc(formattedDate);

      FirebaseFirestore.instance.runTransaction(
        (transaction) async {
          DocumentSnapshot detailTransactionSnapshot =
              await transaction.get(detailTransactionDocument);

          if (!detailTransactionSnapshot.exists) {
            detailTransactionDocument.set({
              'total': total,
              'day': {
                day: total,
              },
              'last_day': day,
            });
          } else {
            print(1);
            num oldValueTotal = detailTransactionSnapshot['total'];
            num newValueTotal = oldValueTotal + total;
            num oldValueDay = detailTransactionSnapshot['day'][day];
            num newValueDay = oldValueDay + total;

            if (detailTransactionSnapshot['last_day'] == day) {
              print(2);
              transaction.update(
                detailTransactionDocument,
                {
                  'total': newValueTotal,
                  'day.$day': newValueDay,
                },
              );
            } else {
              print(3);
              detailTransactionDocument.set(
                {
                  'total': newValueTotal,
                  'day': {
                    day: total,
                  },
                  'last_day': day,
                },
                SetOptions(merge: true),
              );
            }
          }
        },
      );
    } catch (e) {
      print(e.toString());
    }
  }
}
