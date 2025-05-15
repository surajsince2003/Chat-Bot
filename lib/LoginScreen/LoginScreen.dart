import 'dart:core';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../AvatarSelection.dart';
import '../DatabaseHelper.dart';
import '../WelcomeScreen/WelcomeScreen.dart';

class UserController extends GetxController {
  var selectedGender = ''.obs;

  void setGender(String gender) {
    selectedGender.value = gender;
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String? selectedAvatar;
  TextEditingController _dobController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final DatabaseHelper _dbHelper = DatabaseHelper();
  final _formKey = GlobalKey<FormState>();

  final UserController userController = Get.put(UserController());

  @override
  void initState() {
    super.initState();
    selectedAvatar = 'assets/images/Ellipse1.png';
  }

  Future<void> _showCupertinoDatePicker(BuildContext context) async {
    DateTime selectedDate = DateTime.now();

    await showCupertinoModalPopup(
      context: context,
      builder: (_) {
        return Container(
          height: 250,
          color: Colors.white,
          child: Column(
            children: [
              SizedBox(
                height: 180,
                child: CupertinoDatePicker(
                  mode: CupertinoDatePickerMode.date,
                  initialDateTime: DateTime.now(),
                  minimumDate: DateTime(1947),
                  maximumDate: DateTime.now(),
                  onDateTimeChanged: (DateTime date) {
                    selectedDate = date;
                  },
                ),
              ),
              CupertinoButton(
                child: const Text('Done'),
                onPressed: () {
                  setState(() {
                    _dobController.text =
                        '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}';
                  });
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _showGenderBottomSheet(BuildContext context) {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
        ),
        child: Wrap(
          children: [
            ListTile(
              title: const Text('Male'),
              onTap: () {
                userController.setGender('Male');
                Get.back();
              },
            ),
            ListTile(
              title: const Text('Female'),
              onTap: () {
                userController.setGender('Female');
                Get.back();
              },
            ),
            ListTile(
              title: const Text("Other's"),
              onTap: () {
                userController.setGender("Other's");
                Get.back();
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var mq = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: const EdgeInsets.only(left: 18, right: 18),
        height: double.infinity,
        color: const Color.fromRGBO(188, 224, 240, 1),
        width: double.infinity,
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 70),
                AvatarSelection(
                  avatars: [
                    'assets/images/Ellipse1.png',
                    'assets/images/Ellipse2.png',
                    'assets/images/Ellipse3.png',
                    'assets/images/Ellipse4.png',
                  ],
                  onAvatarSelected: (avatar) {
                    setState(() {
                      selectedAvatar = avatar;
                    });
                  },
                ),
                const SizedBox(height: 40),
                Container(
                  margin: const EdgeInsets.only(bottom: 20),
                  height: 55,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25.5),
                  ),
                  child: TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.only(left: 20),
                      hintText: 'Name',
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter your name';
                      }
                      return null;
                    },
                  ),
                ),
                GestureDetector(
                  onTap: () => _showGenderBottomSheet(context),
                  child: Obx(() => Container(
                        margin: const EdgeInsets.only(bottom: 20),
                        height: 55,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        alignment: Alignment.centerLeft,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25.5),
                          color: Colors.white,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              userController.selectedGender.value.isEmpty
                                  ? 'Select Gender'
                                  : userController.selectedGender.value,
                              style: TextStyle(
                                color:
                                    userController.selectedGender.value.isEmpty
                                        ? Colors.grey
                                        : Colors.black,
                                fontSize: 16,
                              ),
                            ),
                            const Icon(
                              CupertinoIcons.chevron_down,
                              color: Color(0xff7e7d7d),
                            )
                          ],
                        ),
                      )),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 20),
                  height: 55,
                  padding: const EdgeInsets.only(left: 20),
                  width: double.infinity,
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25.5),
                    color: Colors.white,
                  ),
                  child: SizedBox(
                    width: 200.0,
                    child: TextFormField(
                      controller: _dobController,
                      decoration: const InputDecoration(
                        hintText: 'Date of Birth',
                        border: InputBorder.none,
                      ),
                      readOnly: true,
                      onTap: () => _showCupertinoDatePicker(context),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please select your date of birth';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                SizedBox(
                  width: mq.width,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromRGBO(31, 69, 86, 1),
                    ),
                    onPressed: () async {
                      if (_formKey.currentState!.validate() &&
                          userController.selectedGender.value.isNotEmpty) {
                        Map<String, dynamic> user = {
                          'avatar': selectedAvatar,
                          'name': _nameController.text.trim(),
                          'gender': userController.selectedGender.value,
                          'dob': _dobController.text.trim(),
                        };

                        await _dbHelper.insertUser(user);
                        Get.off(
                          WelcomeScreen(name: _nameController.text.trim()),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Please fill all fields correctly'),
                          ),
                        );
                      }
                    },
                    child: Text(
                      'Continue',
                      style: GoogleFonts.kumbhSans(
                        fontSize: 14,
                        color: Colors.white,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
