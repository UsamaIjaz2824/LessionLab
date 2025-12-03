import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lessionlab/main.dart';
import 'package:lessionlab/view/home/home_controller.dart';

class HomeUpperPortion extends StatelessWidget {
  HomeUpperPortion({
    super.key,
  });
  final controller = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               Text('Hi, ${localUser!.name}', style: const TextStyle(fontSize: 24,fontWeight: FontWeight.bold)),
              const Text( 'Let\'s get started',
                  style:
                      TextStyle(fontSize: 14)),
            ],
          ),
          CachedNetworkImage(imageUrl: localUser!.profilePicture.toString(),
          errorWidget: (context, url, error) {
            return const CircleAvatar(
              radius: 40,
              child: Center(
                child: Icon(Icons.person,color: Colors.white,size: 50,),
              ),
            );
          },
            placeholder: (context, url) {
              return const CircleAvatar(
                radius: 40,
                child: Center(child: CircularProgressIndicator(color: Colors.white,),),
              );
            },
          imageBuilder: (context, imageProvider) {
            return CircleAvatar(
              radius: 40,
              backgroundImage: imageProvider,
            );
          },
          )
        ],
      ),
    );
  }
}
