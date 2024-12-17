
import 'package:flutter/material.dart';
import 'package:growmind_tutuor/core/utils/constants.dart';



class Googlebutton extends StatelessWidget {
  const Googlebutton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            foregroundColor: Colors.black,
            backgroundColor: Colors.white,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            elevation: 2,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            minimumSize: const Size(double.infinity, 54)),
        onPressed: () {},
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network("https://firebasestorage.googleapis.com/v0/b/flutterbricks-public.appspot.com/o/crypto%2Fsearch%20(2).png?alt=media&token=24a918f7-3564-4290-b7e4-08ff54b3c94c",width: 20,),
            kwidth,
          const  Text('Sign in with google',style: TextStyle(
            color: Colors.black,
            fontSize: 16,
           fontWeight: FontWeight.w500
          ),)
          ],
        ));
  }
}
