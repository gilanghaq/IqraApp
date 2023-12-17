import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iqra/globals.dart';
import 'package:iqra/models/surah.dart';
import 'package:iqra/models/ayat.dart';

class DetailScreen extends StatelessWidget {
  final int noSurah;
  const DetailScreen({super.key, required this.noSurah});

  Future<Surah> _getDetailsSurah() async {
    var data = await Dio().get("https://equran.id/api/surat/$noSurah");
    return Surah.fromJson(json.decode(data.toString()));
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Surah>(
        future: _getDetailsSurah(),
        initialData: null,
        builder: ((context, snapshot) {
          if (!snapshot.hasData) {
            return Scaffold();
          }
          Surah surah = snapshot.data!;
          return Scaffold(
              appBar: _appBar(context: context, surah: surah),
              body: NestedScrollView(
                  headerSliverBuilder: (context, innerBoxIsScrolled) => [
                        SliverToBoxAdapter(
                          child: _details(surah: surah),
                        )
                      ],
                  body: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: ListView.separated(
                        itemBuilder: (context, index) => _ayatItem(
                            ayat: surah.ayat!
                                .elementAt(index + (noSurah == 1 ? 1 : 0))),
                        separatorBuilder: (context, index) => Container(),
                        itemCount: surah.jumlahAyat + (noSurah == 1 ? -1 : 0)),
                  )));
        }));
  }

  Widget _ayatItem({required Ayat ayat}) => Padding(
        padding: const EdgeInsets.only(top: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              decoration: BoxDecoration(
                  color: const Color(0xFFF3F3F4),
                  borderRadius: BorderRadius.circular(10)),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              child: Row(children: [
                Container(
                  width: 27,
                  height: 27,
                  decoration: BoxDecoration(
                      color: primary,
                      borderRadius: BorderRadius.circular(27 / 2)),
                  child: Center(
                    child: Text(
                      '${ayat.nomor}',
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w500, color: Colors.white),
                    ),
                  ),
                ),
                const Spacer(),
                const Icon(
                  Icons.share_outlined,
                  color: Color(0xFF672CBC),
                ),
                const SizedBox(
                  width: 16,
                ),
                const Icon(
                  Icons.play_arrow_outlined,
                  color: Color(0xFF672CBC),
                ),
                const SizedBox(
                  width: 16,
                ),
                const Icon(
                  Icons.bookmark_border_outlined,
                  color: Color(0xFF672CBC),
                ),
              ]),
            ),
            const SizedBox(
              height: 24,
            ),
            Text(
              ayat.ar,
              style: GoogleFonts.amiri(
                  color: textDark, fontWeight: FontWeight.bold, fontSize: 18),
              textAlign: TextAlign.right,
            ),
            const SizedBox(
              height: 16,
            ),
            Text(
              ayat.idn,
              style: GoogleFonts.poppins(color: textDark, fontSize: 16),
            )
          ],
        ),
      );

  Widget _details({required Surah surah}) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Stack(children: [
          Container(
            height: 257,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  stops: [0, .6],
                  colors: [Color(0xFFDF98FA), Color(0xFF9055FF)]),
            ),
          ),
          Positioned(
              bottom: 0,
              right: 0,
              child: Opacity(
                  opacity: .2,
                  child: SvgPicture.asset(
                    'assets/svgs/alquran.svg',
                    width: 324 - 55,
                  ))),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(28),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(surah.namaLatin,
                    style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 26,
                        fontWeight: FontWeight.w500)),
                const SizedBox(
                  width: 4,
                ),
                Text(surah.arti,
                    style:
                        GoogleFonts.poppins(color: Colors.white, fontSize: 14)),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 32),
                  child: Divider(
                    color: Colors.white.withOpacity(.35),
                    thickness: 2,
                    height: 32,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      surah.tempatTurun.name,
                      style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      width: 6,
                    ),
                    Container(
                      width: 4,
                      height: 4,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(2),
                          color: Colors.white),
                    ),
                    SizedBox(
                      width: 6,
                    ),
                    Text(
                      "${surah.jumlahAyat} AYAH",
                      style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                SizedBox(
                  height: 32,
                ),
                SvgPicture.asset('assets/svgs/bismillah.svg')
              ],
            ),
          )
        ]),
      );
}

AppBar _appBar({required BuildContext context, required Surah surah}) {
  return AppBar(
      elevation: 0,
      backgroundColor: Colors.white,
      automaticallyImplyLeading: false,
      title: Row(
        children: [
          IconButton(
              onPressed: (() => Navigator.of(context).pop()),
              icon: SvgPicture.asset('assets/svgs/back_icon.svg')),
          const SizedBox(
            width: 24,
          ),
          Text(
            surah.namaLatin,
            style: GoogleFonts.poppins(
                fontSize: 20, fontWeight: FontWeight.bold, color: primary),
          ),
          const Spacer(),
          IconButton(
              onPressed: (() => {}),
              icon: SvgPicture.asset('assets/svgs/search_icon.svg')),
        ],
      ));
}
