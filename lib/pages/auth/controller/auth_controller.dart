import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logger/logger.dart';
import 'package:moharrek/app_pages.dart';
import 'package:moharrek/pages/auth/model/user.dart';
import 'package:moharrek/shared_pref.dart';
class AuthController extends GetxController {

  Country country = Country(
      phoneCode: "996",
      countryCode: "SA",
      e164Sc: 0,
      geographic: true,
      level: 1,
      name: "Saudi",
      example: "Saudi",
      displayName: "Saudi",
      displayNameNoCountryCode: "SA",
      e164Key: "");

  GlobalKey<FormState> formState = GlobalKey();
  GlobalKey<FormState> formState2 = GlobalKey();
  TextEditingController username = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Observables
  Rx<User?> user = Rx<User?>(null);
  RxBool isLoading = RxBool(false);
  String? _verificationId;

  // Text editing controllers
  late TextEditingController  phoneNumberController;
  late TextEditingController otpController;

  @override
  void onInit() {
    super.onInit();
    phoneNumberController = TextEditingController();
    otpController = TextEditingController();
    // Check if the user is already signed in
    user.value = _auth.currentUser;
  }


  @override
  void dispose() {
    phoneNumberController.dispose();
    otpController.dispose();
  } // Function to get username by UID from Firestore
  Future<String> getUsernameByUID() async {
    try {
      DocumentSnapshot snapshot = await _firestore.collection('users').doc(Preference.shared.getUserId()).get();
      if (snapshot.exists) {
        Map<String, dynamic> userData = snapshot.data()! as Map<String,dynamic>;
        username.text = userData['userName'] ?? '';
        Get.offAllNamed(AppPages.homePage);

        return userData['userName'] ?? ''; // Return username if exists, otherwise return empty string
      } else {
        username.text = '';
        return ''; // Return empty string if user document does not exist
      }
    } catch (e) {
      username.text = '';
      return ''; // Return empty string in case of any error
    }
  }


  // Function to sign in with phone number
  Future<void> signInWithPhoneNumber(String number) async {
    try{
      if(number.isEmpty){
        Get.snackbar('title', 'empty');
      }else {
        _auth.verifyPhoneNumber(
          phoneNumber: '+966$number',
          verificationCompleted: (phoneAuthCredential) {
            Logger().d('verificationCompleted $phoneAuthCredential');
          },
          verificationFailed: (error) async {
            Get.snackbar('error', '$error');
          },
          codeSent: (verificationId, forceResendingToken) {
            _verificationId = verificationId;
            Get.snackbar('Code Sent', 'Code Sent Successfully.');
          },
          codeAutoRetrievalTimeout: (verificationId) {
            Logger().d('code sent $verificationId');
          },);
      }
    }catch (e){
      Logger().e(e);
    }

  }

  // Function to check OTP
  Future<void> checkOTP(String value) async {

    try {
      isLoading.value = true; // Set loading state to true
      Logger().e('Auth success');

      // Create a PhoneAuthCredential using the OTP and stored verificationId
      PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: _verificationId!, smsCode: value);

      // Sign in the user with the credential
      await _auth.signInWithCredential(credential);

      // Add user data to Firestore
      await addUserToFirestore();
      Preference.shared.setUserId(_auth.currentUser!.uid);
      Get.offNamed(AppPages.userName);
      isLoading.value = false; // Set loading state to false
      Get.snackbar('Success', 'OTP verified successfully');

    } catch (e) {
      Logger().e('Auth error $e');
      isLoading.value = false; // Set loading state to false
      Get.snackbar('Error', e.toString());
    }
  }
  Stream<UserData?> getUserDataStream() {
    return _firestore.collection('users').doc(_auth.currentUser!.uid).snapshots().map((snapshot) {
    // return _firestore.collection('users').doc(_auth.currentUser?.uid).snapshots().map((snapshot) {
      if (snapshot.exists) {
        UserData userData = UserData.fromMap(snapshot.data()!);
        Preference.shared.setUserAdmin(userData.admin);
        return userData;
      } else {
        return null;
      }
    });
  }
  // Function to add user data to Firestore
  Future<void> addUserToFirestore() async {
    try {
      User? currentUser = _auth.currentUser;
      if (currentUser != null) {
        // Create a user object
        UserData user = UserData(
          uid: currentUser.uid,
          userName: '', // You may need to get the username from the user interface
          phoneNumber: currentUser.phoneNumber ?? '', // Ensure phoneNumber is not null
          blocked: false, // Set blocked status as desired
          admin: false, // Set admin status as desired
        );
        bool documentExists = await _firestore.collection('users').doc(currentUser.uid).get().then((doc) => doc.exists);

        if(!documentExists){
          // Add user data to Firestore by converting User object to a Map
          await _firestore.collection('users').doc(currentUser.uid).set(user.toMap());
        }
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
    // Create a user object
    UserData user = UserData(
    uid: _auth.currentUser!.uid,
    userName: '', // You may need to get the username from the user interface
    phoneNumber: phoneNumberController.text, // Ensure phoneNumber is not null
    blocked: false, // Set blocked status as desired
    admin: false, // Set admin status as desired
    );

    bool documentExists = await _firestore.collection('users').doc(user.uid).get().then((doc) => doc.exists);

    if(!documentExists){
      // Add user data to Firestore by converting User object to a Map
      await _firestore.collection('users').doc(user.uid).set(user.toMap());
    }
  }


  // Function to update username
  Future<void> updateUsername() async {
    isLoading.toggle();
    try {

        await _firestore.collection('users').doc(_auth.currentUser!.uid).update({'userName': username.text});
        Get.snackbar('Success', 'Username updated successfully');
      Preference.shared.setUserName(username.text);
      Preference.shared.setUserPhone(_auth.currentUser!.phoneNumber!);


        Get.offAllNamed(AppPages.homePage);
        isLoading.toggle();

      // }
    } catch (e) {
      isLoading.toggle();

      Get.snackbar('Error', e.toString());
    }
  }

  // Function to sign out
  Future<void> signOut() async {
    try {
      await _auth.signOut();
      await Preference.shared.signOut();
      user.value = null;
    } catch (e) {
      print(e.toString());
      Get.snackbar('Error', e.toString());
    }
  }
}
