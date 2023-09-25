import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class ErrorSnackbar extends StatelessWidget {
  String text;
  ErrorSnackbar({required this.text});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 1.sw,
        child: Text(
          text,
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
          maxLines: 10,
          style: GoogleFonts.lato(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        )
    );
  }

}
