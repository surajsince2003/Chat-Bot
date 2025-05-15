import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AvatarSelection extends StatefulWidget {
  final List<String> avatars;
  final Function(String) onAvatarSelected;

  const AvatarSelection({super.key,
    required this.avatars,
    required this.onAvatarSelected,
  });

  @override
  _AvatarSelectionState createState() => _AvatarSelectionState();
}

class _AvatarSelectionState extends State<AvatarSelection> {
  late String selectedAvatar;

  @override
  void initState() {
    super.initState();
    selectedAvatar = widget.avatars[Random().nextInt(widget.avatars.length)];
  }

  void changeAvatar() {
    setState(() {
      selectedAvatar = widget.avatars[Random().nextInt(widget.avatars.length)];
    });
  }

  @override
  Widget build(BuildContext context) {
    var mq = MediaQuery.of(context).size;
    return Column(
      children: [
        CircleAvatar(
          radius: 80.0,
          backgroundImage: AssetImage(selectedAvatar),
        ),
        const SizedBox(height: 20),
        Align(
            alignment: Alignment.center,
            child: Text(
              'Select your avatar',
              style:
                  GoogleFonts.karla(fontSize: 18, fontWeight: FontWeight.w600),
            )),
        const SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: widget.avatars.map((avatar) {
            return ElevatedButton(
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(300)),
                  padding: const EdgeInsets.all(5),
                  backgroundColor: Colors.white),
              onPressed: () {
                setState(() {
                  selectedAvatar = avatar;
                  widget.onAvatarSelected(avatar);
                });
              },
              child: CircleAvatar(
                radius: 30.0,
                backgroundImage: AssetImage(avatar),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
