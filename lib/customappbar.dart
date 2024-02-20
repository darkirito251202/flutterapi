import 'package:flutter/material.dart';
import 'package:flutter_application_1/login.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/myhomepage.dart';
import 'package:http/http.dart' as http;

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? email;

  CustomAppBar({Key? key, required this.email}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(email ?? ''),
      actions: [
        IconButton(
          icon: Icon(Icons.logout),
          onPressed: () {
            // Gérer la déconnexion ici
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
