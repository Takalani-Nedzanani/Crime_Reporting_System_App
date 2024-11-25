import 'package:crime_reporting_system/pages/login.dart';

import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';

import 'package:google_fonts/google_fonts.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          color: Color(0xFFF0F4F3),
        ),
        child: Stack(
          children: [
            Positioned(
              left: -119,
              top: -123.5,
              child: SizedBox(
                width: 300,
                height: 240,
                child: SvgPicture.asset(
                  'assets/vectors/shape_5_x2.svg',
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(19, 14.5, 17, 79),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.fromLTRB(0, 0, 0, 127),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(0, 0, 12, 55),
                    child: Container(
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage(
                            'assets/images/r_11.jpeg',
                          ),
                        ),
                      ),
                      child: const SizedBox(
                        width: 270,
                        height: 250,
                      ),
                    ),
                  ),
                  Container(
                    child: Text(
                      'Lets save the community!!',
                      style: GoogleFonts.getFont(
                        'Poppins',
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                        color: const Color(0xFF000000),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    margin: const EdgeInsets.fromLTRB(1, 0, 12, 0),
                    decoration: BoxDecoration(
                        border: Border.all(color: const Color(0xFF000000)),
                        color: const Color(0xFF50C2C9),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10))),
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(18, 10, 18, 10),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const Login(),
                            ),
                          );
                        },
                        child: Text(
                          'Get Started',
                          style: GoogleFonts.getFont(
                            'Poppins',
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            color: const Color.fromARGB(255, 0, 0, 0),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
