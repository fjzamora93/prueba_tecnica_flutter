import 'package:flutter/material.dart';
import 'package:pruebakidsandclouds/core/theme/app_colors.dart';
import 'package:pruebakidsandclouds/kidsandclouds/data/models/user.dart';



class ProfileCard extends StatelessWidget {
  final User user;
  final VoidCallback onTap;

  const ProfileCard({
    required this.user,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.white,
      margin: const EdgeInsets.only(bottom: 16),
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero, side: BorderSide.none),
      elevation: 0,
      child: ListTile(
        leading: CircleAvatar(
          radius: 28,
          backgroundImage: (user.image != null && user.image!.isNotEmpty)
            ? NetworkImage(user.image!)
            : const AssetImage('assets/img/default_avatar.png') as ImageProvider,
        ),
        title: Text(user.firstName!, style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold)),
        subtitle: Text(user.email!, style: Theme.of(context).textTheme.bodyMedium),
        trailing: const Icon(Icons.arrow_forward_rounded, color: AppColors.borderFocused,),
        onTap: onTap,
      ),
    );
  }
}