import 'package:card_swiper/card_swiper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:itm/ColorPalettes/color.dart';

class MagalangGallery extends StatelessWidget {
  final DocumentSnapshot magalangimage;
  const MagalangGallery({Key? key, required this.magalangimage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool myMarkerThumb = true;
    List swimmingpool = [
      magalangimage['image1'],
      magalangimage['image2'],
    ];

    List lobby = [
      magalangimage['image3'],
      magalangimage['image4'],
    ];

    List room = [
      magalangimage['image5'],
      magalangimage['image6'],
    ];

    List dining = [
      magalangimage['image7'],
      magalangimage['image8'],
    ];

    void show1() {
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (_) => Swiper(
                itemWidth: 400,
                itemHeight: 225,
                loop: true,
                duration: 1200,
                control: new SwiperControl(),
                itemBuilder: (context, index) {
                  return Container(
                    width: 300,
                    height: 300,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(swimmingpool[index]),
                            fit: BoxFit.fill),
                        borderRadius: BorderRadius.circular(20)),
                  );
                },
                scrollDirection: Axis.horizontal,
                itemCount: swimmingpool.length,
                layout: SwiperLayout.STACK,
              ));
    }

    void show2() {
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (_) => Swiper(
                itemWidth: 400,
                itemHeight: 225,
                loop: true,
                duration: 1200,
                control: new SwiperControl(),
                itemBuilder: (context, index) {
                  return Container(
                    width: 300,
                    height: 300,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(lobby[index]),
                            fit: BoxFit.fill),
                        borderRadius: BorderRadius.circular(20)),
                  );
                },
                scrollDirection: Axis.horizontal,
                itemCount: lobby.length,
                layout: SwiperLayout.STACK,
              ));
    }

    void show3() {
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (_) => Swiper(
                itemWidth: 400,
                itemHeight: 225,
                loop: true,
                duration: 1200,
                control: new SwiperControl(),
                itemBuilder: (context, index) {
                  return Container(
                    width: 300,
                    height: 300,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(room[index]), fit: BoxFit.fill),
                        borderRadius: BorderRadius.circular(20)),
                  );
                },
                scrollDirection: Axis.horizontal,
                itemCount: room.length,
                layout: SwiperLayout.STACK,
              ));
    }

    void show4() {
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (_) => Swiper(
                itemWidth: 400,
                itemHeight: 225,
                loop: true,
                duration: 1200,
                control: new SwiperControl(),
                itemBuilder: (context, index) {
                  return Container(
                    width: 300,
                    height: 300,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(dining[index]),
                            fit: BoxFit.fill),
                        borderRadius: BorderRadius.circular(20)),
                  );
                },
                scrollDirection: Axis.horizontal,
                itemCount: dining.length,
                layout: SwiperLayout.STACK,
              ));
    }

    return Scaffold(
      backgroundColor: ColorPalette.backgroundcolor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: ColorPalette.container.withOpacity(0.7),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Column(
                  children: [
                    SizedBox(height: 10),
                    Text(
                      'Swimming Pool',
                      style: GoogleFonts.openSans(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: ColorPalette.titleColor),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            show1();
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width / 1.5,
                            height: 200,
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.3),
                                borderRadius: BorderRadius.circular(15),
                                image: DecorationImage(
                                    image: myMarkerThumb != 'noImage'
                                        ? NetworkImage(magalangimage['image1'])
                                        : AssetImage('assets/no_image.jpg')
                                            as ImageProvider,
                                    fit: BoxFit.fill)),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Lobby',
                      style: GoogleFonts.openSans(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: ColorPalette.titleColor),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            show2();
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width / 1.5,
                            height: 200,
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.3),
                                borderRadius: BorderRadius.circular(15),
                                image: DecorationImage(
                                    image: myMarkerThumb != 'noImage'
                                        ? NetworkImage(magalangimage['image3'])
                                        : AssetImage('assets/no_image.jpg')
                                            as ImageProvider,
                                    fit: BoxFit.fill)),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Room',
                      style: GoogleFonts.openSans(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: ColorPalette.titleColor),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            show3();
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width / 1.5,
                            height: 200,
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.3),
                                borderRadius: BorderRadius.circular(15),
                                image: DecorationImage(
                                    image: myMarkerThumb != 'noImage'
                                        ? NetworkImage(magalangimage['image5'])
                                        : AssetImage('assets/no_image.jpg')
                                            as ImageProvider,
                                    fit: BoxFit.fill)),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Dining',
                      style: GoogleFonts.openSans(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: ColorPalette.titleColor),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            show4();
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width / 1.5,
                            height: 200,
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.3),
                                borderRadius: BorderRadius.circular(15),
                                image: DecorationImage(
                                    // ignore: unrelated_type_equality_checks
                                    image: myMarkerThumb != 'noImage'
                                        ? NetworkImage(magalangimage['image7'])
                                        : const AssetImage(
                                                'assets/no_image.jpg')
                                            as ImageProvider,
                                    fit: BoxFit.fill)),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(
                      '',
                      style: GoogleFonts.openSans(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: ColorPalette.titleColor),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AlerPop extends StatefulWidget {
  const AlerPop({Key? key}) : super(key: key);

  @override
  State<AlerPop> createState() => _AlerPopState();
}

class _AlerPopState extends State<AlerPop> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
