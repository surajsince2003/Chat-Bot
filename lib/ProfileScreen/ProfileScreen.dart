import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

import '../AvatarSelection.dart';
import '../DatabaseHelper.dart';
import '../LoginScreen/LoginScreen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String? selectedAvatar;
  TextEditingController _nameController = TextEditingController();
  TextEditingController _genderController = TextEditingController();
  TextEditingController _dobController = TextEditingController();
  final DatabaseHelper _dbHelper = DatabaseHelper();
  DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  void _logout(BuildContext context) async {
    await _dbHelper.deleteAllUsers();
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => const LoginScreen()),
      (Route<dynamic> route) => false,
    );
  }

  Future<void> fetchUserData() async {
    final user = await _dbHelper.getUsers();
    if (user.isNotEmpty) {
      setState(() {
        _nameController.text = user[0]['name'];
        _genderController.text = user[0]['gender'];
        _dobController.text = user[0]['dob'];
        selectedAvatar = user[0]['avatar'];
        selectedDate = _parseDate(user[0]['dob']);
      });
    }
  }

  DateTime _parseDate(String dob) {
    try {
      final parts = dob.split('/');
      return DateTime(
        int.parse(parts[2]),
        int.parse(parts[1]),
        int.parse(parts[0]),
      );
    } catch (_) {
      return DateTime.now();
    }
  }

  void _editDetails(TextEditingController controller) {
    if (controller == _genderController) {
      String selected = _genderController.text;
      int selectedIndex = ['Male', 'Female', "Other's"].indexOf(selected);
      showCupertinoModalPopup(
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: 250,
            color: Colors.white,
            child: Column(
              children: [
                SizedBox(
                  height: 180,
                  child: CupertinoPicker(
                    itemExtent: 32,
                    scrollController: FixedExtentScrollController(
                        initialItem: selectedIndex >= 0 ? selectedIndex : 0),
                    onSelectedItemChanged: (int index) {
                      selected = ['Male', 'Female', "Other's"][index];
                    },
                    children: ['Male', 'Female', "Other's"]
                        .map((e) => Center(child: Text(e)))
                        .toList(),
                  ),
                ),
                CupertinoButton(
                  child: const Text('Save'),
                  onPressed: () {
                    setState(() {
                      _genderController.text = selected;
                    });
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          );
        },
      );
    } else if (controller == _dobController) {
      DateTime tempDate = selectedDate;
      showCupertinoModalPopup(
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: 300,
            color: Colors.white,
            child: Column(
              children: [
                SizedBox(
                  height: 220,
                  child: CupertinoDatePicker(
                    mode: CupertinoDatePickerMode.date,
                    initialDateTime: selectedDate,
                    maximumDate: DateTime.now(),
                    minimumYear: 1900,
                    maximumYear: DateTime.now().year,
                    onDateTimeChanged: (DateTime newDate) {
                      tempDate = newDate;
                    },
                  ),
                ),
                CupertinoButton(
                  child: const Text('Save'),
                  onPressed: () {
                    setState(() {
                      selectedDate = tempDate;
                      _dobController.text =
                          '${tempDate.day}/${tempDate.month}/${tempDate.year}';
                    });
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          );
        },
      );
    } else {
      // Name editing with CupertinoAlertDialog
      TextEditingController tempController =
          TextEditingController(text: controller.text);
      showCupertinoDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            title: const Text('Edit Name'),
            content: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: CupertinoTextField(
                controller: tempController,
                placeholder: "Enter name",
              ),
            ),
            actions: [
              CupertinoDialogAction(
                child: const Text('Cancel'),
                onPressed: () => Navigator.of(context).pop(),
              ),
              CupertinoDialogAction(
                child: const Text('Save'),
                onPressed: () {
                  setState(() {
                    controller.text = tempController.text;
                  });
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  void _changeAvatar() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.0)),
      ),
      backgroundColor: Colors.white,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Change Avatar',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              AvatarSelection(
                avatars: [
                  'assets/images/Ellipse1.png',
                  'assets/images/Ellipse2.png',
                  'assets/images/Ellipse3.png',
                  'assets/images/Ellipse4.png',
                ],
                onAvatarSelected: (avatar) async {
                  setState(() {
                    selectedAvatar = avatar;
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

  @override
  Widget build(BuildContext context) {
    var mq = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(188, 224, 240, 1),
        elevation: 4.0,
        centerTitle: true,
        title: Text(
          "Profile Screen",
          style: GoogleFonts.figtree(fontWeight: FontWeight.w700),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Color(0xff000000)),
            onPressed: () => _logout(context),
            tooltip: "Logout",
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        height: double.infinity,
        color: const Color.fromRGBO(188, 224, 240, 1),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 70),
              selectedAvatar != null
                  ? CircleAvatar(
                      backgroundColor: Colors.grey.shade400,
                      radius: 90.0,
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            fit: BoxFit.scaleDown,
                            image: AssetImage(selectedAvatar!),
                          ),
                        ),
                      ),
                    )
                  : const SizedBox(),
              const SizedBox(height: 20),
              SizedBox(
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromRGBO(31, 69, 86, 1),
                  ),
                  onPressed: _changeAvatar,
                  child: Text(
                    'Change Avatar',
                    style: GoogleFonts.kumbhSans(color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 40),
              buildEditableField(_nameController, 'Name', Icons.edit),
              buildEditableField(_genderController, 'Gender', Icons.edit),
              buildEditableField(_dobController, 'Date of Birth', Icons.edit),
              Container(
                margin: EdgeInsets.only(bottom: 20),
                width: mq.width,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromRGBO(31, 69, 86, 1),
                  ),
                  onPressed: () async {
                    await saveChanges();
                  },
                  child: Text(
                    'Save Changes',
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
    );
  }

  Widget buildEditableField(
      TextEditingController controller, String label, IconData icon) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      height: 55,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25.5),
      ),
      child: ListTile(
        title: Text(
          controller.text,
          style: GoogleFonts.kumbhSans(color: Colors.black),
        ),
        trailing: IconButton(
          icon: Icon(icon),
          onPressed: () {
            _editDetails(controller);
          },
        ),
      ),
    );
  }

  Future<void> saveChanges() async {
    Map<String, dynamic> userData = {
      'name': _nameController.text,
      'gender': _genderController.text,
      'dob': _dobController.text,
      'avatar': selectedAvatar,
    };
    await _dbHelper.updateUser(userData);
    Fluttertoast.showToast(
      msg: "Profile updated successfully!",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
    );
  }
}
