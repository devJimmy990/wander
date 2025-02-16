import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wander/controller/cubit/user/user_cubit.dart';
import 'package:wander/data/model/user.dart';

class AvatarBottomSheet extends StatelessWidget {
  const AvatarBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> avatarPaths = [
      // 'assets/images/signup.jpg',
      'assets/images/avatar/avatar1.jpg',
      'assets/images/avatar/avatar2.jpg',
      'assets/images/avatar/avatar3.jpg',
      'assets/images/avatar/avatar4.jpg',
      'assets/images/avatar/avatar5.jpg',
      'assets/images/avatar/avatar6.jpeg',
    ];

    return Container(
      height: 400,
      decoration: BoxDecoration(
        color: Color(0xFFf5ebe0),
        borderRadius: BorderRadius.circular(20),
      ),
      padding: EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Choose an Avatar',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              fontFamily: 'Cinzel',
            ),
          ),
          SizedBox(height: 16),
          GridView.builder(
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemCount: avatarPaths.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  final currentUser = context.read<UserCubit>().user;
                  if (currentUser != null) {
                    final updatedUser = User(
                      id: currentUser.id,
                      name: currentUser.name,
                      phone: currentUser.phone,
                      email: currentUser.email,
                      avatar: avatarPaths[index],
                    );

                    context.read<UserCubit>().onUpdateProfile(updatedUser);
                  }
                  Navigator.pop(context);
                },
                child: Image.asset(
                  avatarPaths[index],
                  fit: BoxFit.cover,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
