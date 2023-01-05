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
            } else {
              documentReference.update({
                'updated_at': DateTime.now(),
              });
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
      String day = SharedCode().day;
      String formattedDate = SharedCode().formattedDate;

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
              'day': day,
              'week': formattedDate,
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

            if (detailTransactionSnapshot['last_day'] == day) {
              num oldValueDay = detailTransactionSnapshot['day'][day];
              num newValueDay = oldValueDay + total;

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

  Future<bool> editTransaction(
    BuildContext context, {
    required String docId,
    required String type,
    required num total,
    required num oldTotal,
    required String category,
    required String date,
    required String desc,
    required String day,
    required String week,
  }) async {
    try {
      String uid = SharedCode().uid;

      DocumentReference userDocument =
          FirebaseFirestore.instance.collection('users').doc(uid);

      DocumentReference transactionDocument = FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .collection('transaction')
          .doc(docId);

      DocumentReference detailTransactionDocument = FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .collection(type)
          .doc(week);

      FirebaseFirestore.instance.runTransaction(
        (transaction) async {
          DocumentSnapshot userSnapshot = await transaction.get(userDocument);
          DocumentSnapshot detailTransactionSnapshot =
              await transaction.get(detailTransactionDocument);

          num oldTotalBalance = userSnapshot['total_balance'];
          num oldValueUser = userSnapshot[type];
          num oldValueDetail = detailTransactionSnapshot['day'][day];
          num oldValueDetailTotal = detailTransactionSnapshot['total'];

          num newTotalBalance = type == 'income'
              ? (oldTotalBalance - oldTotal) + total
              : oldTotalBalance + (oldTotal - total);
          print('newTotalBalance = $newTotalBalance');

          num newValueUser = (oldValueUser - oldTotal) + total;
          print('newValueUser = $newValueUser');

          num newValueDetail = (oldValueDetail - oldTotal) + total;
          print('newValueDetail = $newValueDetail');

          num newValueDetailTotal = (oldValueDetailTotal - oldTotal) + total;
          print('newValueDetailTotal = $newValueDetailTotal');

          transaction.update(transactionDocument, {
            'type': type,
            'total': total,
            'category': category,
            'date': date,
            'desc': desc,
            'day': day,
            'updated_at': DateTime.now(),
          });

          transaction.update(detailTransactionDocument, {
            'total': newValueDetailTotal,
            'day.$day': newValueDetail,
          });

          transaction.update(userDocument, {
            type: newValueUser,
            'total_balance': newTotalBalance,
          });
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

  Future<bool> deleteTransaction(
    BuildContext context, {
    required String docId,
    required String type,
    required num total,
    required String day,
    required String week,
  }) async {
    try {
      String uid = SharedCode().uid;

      DocumentReference userDocument =
          FirebaseFirestore.instance.collection('users').doc(uid);

      DocumentReference transactionDocument = FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .collection('transaction')
          .doc(docId);

      DocumentReference detailTransactionDocument = FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .collection(type)
          .doc(week);

      FirebaseFirestore.instance.runTransaction(
        (transaction) async {
          DocumentSnapshot userSnapshot = await transaction.get(userDocument);
          DocumentSnapshot detailTransactionSnapshot =
              await transaction.get(detailTransactionDocument);

          num oldTotalBalance = userSnapshot['total_balance'];
          num oldValueUser = userSnapshot[type];
          num oldValueDetail = detailTransactionSnapshot['day'][day];
          num oldValueDetailTotal = detailTransactionSnapshot['total'];

          num newTotalBalance = type == 'income'
              ? oldTotalBalance - total
              : oldTotalBalance + total;
          num newValueUser = oldValueUser - total;
          num newValueDetail = oldValueDetail - total;
          num newValueDetailTotal = oldValueDetailTotal - total;

          await transactionDocument.delete().then((value) {
            transaction.update(detailTransactionDocument, {
              'total': newValueDetailTotal,
              'day.$day': newValueDetail,
            });

            transaction.update(userDocument, {
              type: newValueUser,
              'total_balance': newTotalBalance,
            });
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

  Future<bool> editProfile(BuildContext context, {required String name}) async {
    try {
      String uid = SharedCode().uid;

      DocumentReference userDocument =
          FirebaseFirestore.instance.collection('users').doc(uid);

      FirebaseFirestore.instance.runTransaction(
        (transaction) async {
          transaction.update(userDocument, {
            'full_name': name,
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

  Future<bool> addBudget(
    BuildContext context, {
    required String category,
    required String desc,
    required num budget,
    required num remain,
  }) async {
    try {
      String uid = SharedCode().uid;

      DocumentReference budgetDocument = FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .collection('budget')
          .doc();

      FirebaseFirestore.instance.runTransaction(
        (transaction) async {
          DocumentSnapshot budgetSnapshot =
              await transaction.get(budgetDocument);

          if (!budgetSnapshot.exists) {
            budgetDocument.set({
              'category': category,
              'desc': desc,
              'budget': budget,
              'remain': remain,
              'percent': 0,
              'created_at': DateTime.now(),
              'updated_at': DateTime.now(),
            });
          }
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
}
