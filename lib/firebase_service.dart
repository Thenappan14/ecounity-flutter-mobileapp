import 'dart:io';
import 'package:path/path.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseService {
  static Future<void> sendNotification(String title, String body) async {
    // Send notification to Firebase
  }

  Future<UserCredential> register(String email, String password,
      String username, String phoneNumber, String address) async {
    UserCredential userCredential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);

    // Add user details to Firestore
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userCredential.user!.uid)
        .set({
      'username': username,
      'phoneNumber': phoneNumber,
      'address': address,
      'email': email,
    });

    return userCredential;
  }

  Future<UserCredential> login(String email, String password) {
    return FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
  }

  //future<void>it indicates that the function performs a async operation and after completing it does not return any result
  //only says whether the function have been completed or failed
  Future<void> forgotPassword(String email) {
    return FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  }

  Stream<User?> getAuthUser() {
    return FirebaseAuth.instance.authStateChanges();
  }

  Future<void> logOut() {
    return FirebaseAuth.instance.signOut();
  }

  Future<void> addProduct(String imageUrl, String name, String detail,
      String caption, String category, String price) async {
    print('Adding product to Firestore...');
    try {
      await FirebaseFirestore.instance.collection('products').add({
        'imageUrl': imageUrl,
        'name': name,
        'detail': detail,
        'caption': caption,
        'category': category,
        'price': price,
        'timestamp': FieldValue.serverTimestamp(), // Add timestamp
      });
      print('Product added to Firestore');
    } catch (e) {
      print('Error adding product to Firestore: $e');
    }
  }

  Future<String> uploadImage(File image) async {
    String fileName = basename(image.path);
    Reference storageReference =
        FirebaseStorage.instance.ref().child('products/$fileName');
    UploadTask uploadTask = storageReference.putFile(image);
    TaskSnapshot snapshot = await uploadTask;
    return await snapshot.ref.getDownloadURL();
  }

  Stream<List<AddProduct>> getProducts() {
    return FirebaseFirestore.instance
        .collection('products')
        .orderBy('timestamp', descending: true) // Order by timestamp, to arrange latest item first
        .snapshots()
        .map((snapshot) => snapshot
            .docs //Map each snapshot to a list of products
            .map(
                (doc) => //Transforms each document snapshot in the snapshot's list of documents into an add product object.
                    AddProduct.fromMap(
                        doc.data() as Map<String, dynamic>, doc.id))
            .toList());
  }

  Future<void> updateProduct(String id, String imageUrl, String name,
      String detail, String caption, String category, String price) {
    return FirebaseFirestore.instance.collection('products').doc(id).update({
      'imageUrl': imageUrl,
      'name': name,
      'detail': detail,
      'caption': caption,
      'category': category,
      'price': price,
      'timestamp': FieldValue.serverTimestamp(), // Update timestamp
    });
  }

  Future<void> deleteProduct(String id) {
    return FirebaseFirestore.instance.collection('products').doc(id).delete();
  }

  Future<void> updatePassword(
      String currentPassword, String newPassword) async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      String email = user.email ?? '';

      try {
        // Re-authenticate user
        AuthCredential credential = EmailAuthProvider.credential(
            email: email, password: currentPassword);
        await user.reauthenticateWithCredential(credential);

        // Update password
        await user.updatePassword(newPassword);
      } on FirebaseAuthException catch (e) {
        print("Error code: ${e.code}");
        print("Error message: ${e.message}");
        throw e;
      }
    } else {
      throw FirebaseAuthException(
        code: 'user-not-found',
        message: 'No user found for the given credentials.',
      );
    }
  }

  Future<void> updateUsername(
      String currentPassword, String newUsername) async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      try {
        // Re-authenticate user
        AuthCredential credential = EmailAuthProvider.credential(
          email: user.email!,
          password: currentPassword,
        );
        await user.reauthenticateWithCredential(credential);

        // Update username
        await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .update({'username': newUsername});
      } on FirebaseAuthException catch (e) {
        switch (e.code) {
          case 'wrong-password':
            throw FirebaseAuthException(
              code: 'wrong-password',
              message: 'The password is incorrect.',
            );
          case 'invalid-credential':
            throw FirebaseAuthException(
              code: 'invalid-credential',
              message: 'The credentials provided are invalid.',
            );
          default:
            throw FirebaseAuthException(
              code: e.code,
              message: 'An unknown error occurred. Code: ${e.code}',
            );
        }
      } catch (e) {
        throw Exception('An unexpected error occurred. Please try again.');
      }
    } else {
      throw FirebaseAuthException(
        code: 'user-not-found',
        message: 'No user found for the given credentials.',
      );
    }
  }

  Future<void> updatePhoneNumber(
      String currentPassword, String newPhoneNumber) async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      try {
        // Re-authenticate user
        AuthCredential credential = EmailAuthProvider.credential(
          email: user.email!,
          password: currentPassword,
        );
        await user.reauthenticateWithCredential(credential);

        // Update phone number in Firestore
        await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .update({'phone_number': newPhoneNumber});
      } on FirebaseAuthException catch (e) {
        switch (e.code) {
          case 'wrong-password':
            throw FirebaseAuthException(
              code: 'wrong-password',
              message: 'The password is incorrect.',
            );
          case 'invalid-credential':
            throw FirebaseAuthException(
              code: 'invalid-credential',
              message: 'The credentials provided are invalid.',
            );
          default:
            throw FirebaseAuthException(
              code: e.code,
              message: 'An unknown error occurred. Code: ${e.code}',
            );
        }
      } catch (e) {
        throw Exception('An unexpected error occurred. Please try again.');
      }
    } else {
      throw FirebaseAuthException(
        code: 'user-not-found',
        message: 'No user found for the given credentials.',
      );
    }
  }

  Future<void> updateAddress(String currentPassword, String newAddress) async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      try {
        // Re-authenticate user
        AuthCredential credential = EmailAuthProvider.credential(
          email: user.email!,
          password: currentPassword,
        );
        await user.reauthenticateWithCredential(credential);

        // Update address in Firestore
        await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .update({'address': newAddress});
      } on FirebaseAuthException catch (e) {
        switch (e.code) {
          case 'wrong-password':
            throw FirebaseAuthException(
              code: 'wrong-password',
              message: 'The password is incorrect.',
            );
          case 'invalid-credential':
            throw FirebaseAuthException(
              code: 'invalid-credential',
              message: 'The credentials provided are invalid.',
            );
          default:
            throw FirebaseAuthException(
              code: e.code,
              message: 'An unknown error occurred. Code: ${e.code}',
            );
        }
      } catch (e) {
        throw Exception('An unexpected error occurred. Please try again.');
      }
    } else {
      throw FirebaseAuthException(
        code: 'user-not-found',
        message: 'No user found for the given credentials.',
      );
    }
  }

  Future<String?> getEmailFromUsername(String username) async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('username', isEqualTo: username)
        .limit(1)
        .get();

    if (snapshot.docs.isNotEmpty) {
      return snapshot.docs.first['email'];
    } else {
      return null;
    }
  }

  Future<Map<String, dynamic>?> getUserDetails(String uid) async {
    DocumentSnapshot doc =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();
    return doc.data() as Map<String, dynamic>?;
  }
}

class AddProduct {
  String id;
  String imageUrl;
  String name;
  String detail;
  String caption;
  String category;
  String price;
  Timestamp timestamp;

  AddProduct({
    required this.id,
    required this.imageUrl,
    required this.name,
    required this.detail,
    required this.caption,
    required this.category,
    required this.price,
    required this.timestamp,
  });

  factory AddProduct.fromMap(Map<String, dynamic> data, String id) {
    return AddProduct(
      id: id,
      imageUrl: data['imageUrl'] ?? '',
      name: data['name'] ?? '',
      detail: data['detail'] ?? '',
      caption: data['caption'] ?? '',
      category: data['category'] ?? '',
      price: data['price'] ?? '',
      timestamp: data['timestamp'] ?? Timestamp.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'imageUrl': imageUrl,
      'name': name,
      'detail': detail,
      'caption': caption,
      'category': category,
      'price': price,
      'timestamp': timestamp,
    };
  }
}
