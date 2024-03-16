import 'package:async_and_await/view/widgets/primary_button.dart';
import 'package:async_and_await/view/widgets/secondary_button.dart';
import 'package:flutter/material.dart';
import 'package:async_and_await/constants.dart';
import 'package:share_plus/share_plus.dart';
import 'package:async_and_await/view/pages/qr_code.dart';

class InviteFriends extends StatefulWidget {
  const InviteFriends({super.key});

  @override
  State<InviteFriends> createState() => _InviteFriendsState();
}

class _InviteFriendsState extends State<InviteFriends> {
  void shareApp() async {
    final result = await Share.shareWithResult(
        'Be a proud member of async_and_await Family! https://tinyurl.com/5n6dapka',
        subject: 'Download JobConnect Now!');
    if (result.status == ShareResultStatus.success) {}
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(

        body: Container(
          width: screenWidth,
          height: screenHeight,
          decoration: const BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage('assets/images/noise.webp'),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                   Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
                    child: Text(
                      'Discover a world of opportunities for Sri Lankan freelancers with our app! Download now and embark on a journey of creativity, flexibility, and endless possibilities!',
                      textAlign: TextAlign.center,
                      style: kHeading2TextStyle.copyWith(fontSize: 18),
                    ),
                  ),
                  const SizedBox(
                    height: 50.0,
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.symmetric(vertical: 8.0),
                  //   child: Image.asset('images/playstore.png'),
                  // ),
                  SizedBox(
                    width: screenWidth,
                    child: PrimaryButton(
                      title: 'Scan QR Code',
                      process: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const ScanQR(),
                          ),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 30.0),
                    child: SizedBox(
                      width: screenWidth,
                      child: SecondaryButton(
                        title: 'Share',
                        process: shareApp,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
