import 'package:flutter/material.dart';

import '../../../utils/colors.dart';

class UserRoleView extends StatelessWidget {
  const UserRoleView({super.key, required this.onTap, required this.selectedId, required this.userRoleText});

  final VoidCallback onTap;
  final bool selectedId;
  final String userRoleText;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [BoxShadow(
              spreadRadius: 1,
              blurRadius: 6,
              color: AppColors.black.withOpacity(0.1)
          )],
          borderRadius: BorderRadius.circular(10),
          color: selectedId
              ? Colors.green
              : Colors.white,
        ),
        height: 50,
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        child: Center(
          child: Text(
            userRoleText,
            style: TextStyle(
              color: selectedId
                  ? Colors.white
                  : Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}