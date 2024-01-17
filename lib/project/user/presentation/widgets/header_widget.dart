import 'dart:convert';
import 'package:flutter/material.dart';
import '../../../../config/constants/app_constants/constants.dart';
import '../../../../models/user/user_model.dart';
import '../../../global/presentation/widgets/app_divider.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({super.key, required this.user});
  final UserModel user;
  @override
  Widget build(BuildContext context) {
    final date = DateTime.parse(user.birthDate);
    return Card(
      elevation: 0,
      margin: const EdgeInsets.all(8),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(250),
              child: SizedBox(
                height: 150,
                width: 150,
                child: user.image != ''
                    ? Image.memory(
                        base64Decode(user.image),
                        fit: BoxFit.cover,
                      )
                    : Image.asset(personImage, fit: BoxFit.fitHeight),
              ),
            ),
            Text(
              user.name,
              style: const TextStyle(
                color: Color.fromARGB(255, 131, 131, 131),
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            appDivider,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  flex: 1,
                  child: Text(
                    'phone\n${user.phone}',
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 4,
                    style: _infoStyle,
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Text(
                    'study_at\nfci_zu',
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 4,
                    style: _infoStyle,
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Text(
                    'birth_date\n${date.year} / ${date.month} / ${date.day}',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 4,
                    textAlign: TextAlign.center,
                    style: _infoStyle,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  TextStyle get _infoStyle => const TextStyle(
        height: 1.7,
        color: Color.fromARGB(255, 131, 131, 131),
        fontSize: 14,
        fontWeight: FontWeight.bold,
      );
}
