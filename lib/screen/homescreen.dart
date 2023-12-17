import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iqra/globals.dart';
import 'package:iqra/tabs/page_tab.dart';
import 'package:iqra/tabs/para_tab.dart';
import 'package:iqra/tabs/surah_tab.dart';

class Homescreen extends StatelessWidget {
  const Homescreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      bottomNavigationBar: _bottomNavigationBar(),
      body: DefaultTabController(
        length: 3,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: NestedScrollView(
              headerSliverBuilder: (context, innerBoxIsScrolled) => [
                    SliverToBoxAdapter(
                      child: _salam(),
                    ),
                    SliverAppBar(
                      surfaceTintColor: Colors.white,
                      automaticallyImplyLeading: false,
                      elevation: 0,
                      pinned: true,
                      shape: Border(
                          bottom: BorderSide(
                              width: 3, color: Colors.grey.withOpacity(.1))),
                      bottom: PreferredSize(
                        preferredSize: const Size.fromHeight(0),
                        child: _tab(),
                      ),
                    )
                  ],
              body: TabBarView(children: [SurahTab(), ParaTab(), PageTab()])),
        ),
      ),
    );
  }

  TabBar _tab() {
    return TabBar(
        unselectedLabelColor: text,
        labelColor: primary,
        indicatorWeight: 3,
        tabs: [
          _tabItem(label: "Surah"),
          _tabItem(label: "Par"),
          _tabItem(label: "Page")
        ]);
  }

  Tab _tabItem({required String label}) => Tab(
          child: Text(
        label,
        style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600),
      ));

  Column _salam() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Assalamualaikum',
          style: GoogleFonts.poppins(
              fontSize: 18, fontWeight: FontWeight.w500, color: text),
        ),
        const SizedBox(
          height: 4,
        ),
        Text(
          'Gilang Khrismahaq',
          style: GoogleFonts.poppins(
              fontSize: 24, fontWeight: FontWeight.w600, color: textDark),
        ),
        const SizedBox(
          height: 24,
        ),
        _lastRead()
      ],
    );
  }

  Stack _lastRead() {
    return Stack(
      children: [
        Container(
          height: 142,
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
            child: SvgPicture.asset('assets/svgs/alquran.svg')),
        Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  SvgPicture.asset('assets/svgs/buku.svg'),
                  const SizedBox(
                    width: 8,
                  ),
                  Text('Last Read',
                      style: GoogleFonts.poppins(
                          color: Colors.white, fontWeight: FontWeight.w500)),
                ],
              ),
              const SizedBox(
                height: 34,
              ),
              Text('Al-Fatiah',
                  style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600)),
              const SizedBox(
                width: 4,
              ),
              Text('Ayah No. 1',
                  style:
                      GoogleFonts.poppins(color: Colors.white, fontSize: 14)),
            ],
          ),
        )
      ],
    );
  }

  AppBar _appBar() {
    return AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            IconButton(
                onPressed: (() => {}),
                icon: SvgPicture.asset('assets/svgs/menu_icon.svg')),
            const SizedBox(
              width: 24,
            ),
            Text(
              'IQRA',
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

  BottomNavigationBar _bottomNavigationBar() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      showUnselectedLabels: false,
      items: [
        _bottomBarItem(icon: "assets/svgs/quran_icon.svg", label: "Quran"),
        _bottomBarItem(icon: "assets/svgs/sholat_icon.svg", label: "Prayer"),
        _bottomBarItem(icon: "assets/svgs/doa_icon.svg", label: "Dua"),
        _bottomBarItem(icon: "assets/svgs/bookmark_icon.svg", label: "Saved")
      ],
    );
  }

  BottomNavigationBarItem _bottomBarItem(
          {required String icon, required String label}) =>
      BottomNavigationBarItem(
          icon: SvgPicture.asset(
            icon,
            color: text,
          ),
          activeIcon: SvgPicture.asset(
            icon,
            color: primary,
          ),
          label: label);
}
