import 'package:aromatherapy/components/primary_oil_details_item.dart';
import 'package:aromatherapy/components/primary_oil_titles_item.dart';
import 'package:aromatherapy/components/primary_properties_list_item.dart';
import 'package:aromatherapy/models/oil/oil.dart';
import 'package:flutter/material.dart';

import '../../../models/oil/oil_domain.dart';
import '../../../utils/constants.dart';

class OilDetails extends StatefulWidget {
  const OilDetails({Key? key, required this.oil}) : super(key: key);
  final Oil oil;

  @override
  _OilDetailsState createState() => _OilDetailsState();
}

class _OilDetailsState extends State<OilDetails> {
  String name = '';
  List<String> otherNames = [];
  String sciName = '';
  String? distilledOrgan;
  String? extractionProcess;

  int SelectedIndex = 0;
  int index = 0;
  List<String> aspect = [];
  OilDomain? health;
  OilDomain? beauty;
  OilDomain? wellBeing;
  List<String> colo = [];
  List<String> odor = [];
  List<String> allergie = [];
  String s = '';
  String p = '';
  List tabs = [];
  List<Widget> tabb = [];

  @override
  void initState() {
    getData();
    super.initState();
  }

  getData() {
    setState(() {
      final Oil oil = widget.oil;
      aspect.addAll(oil.aspect);
      colo.addAll(oil.color);
      odor.addAll(oil.smell);
      allergie = oil.allergies;
      name = oil.name;
      otherNames = oil.otherNames!;
      sciName = oil.sciName!;
      s = otherNames.join(', ');
      p = allergie.join(', ');
      health = oil.health;
      beauty = oil.beauty;
      wellBeing = oil.wellBeing;

      if (health != null) {
        tabs.add(health);
        tabb.add(const Tab(
          text: "Health",
        ));
      } else {
        null;
      }

      if (beauty != null) {
        tabs.add(beauty);
        tabb.add(const Tab(
          text: "Beauty",
        ));
      } else {
        null;
      }

      if (wellBeing != null) {
        tabs.add(wellBeing);
        tabb.add(const Tab(
          text: "Well Being",
        ));
      } else {
        null;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: kSecondaryBackgroundColor, //change your color here
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Center(
          child: Text(
            "Essential oils",
            style: TextStyle(
                color: kSecondaryBackgroundColor, fontWeight: FontWeight.bold),
          ),
        ),
        actions: [
          IconButton(
            icon: Image.asset("assets/images/Empty.png"),
            onPressed: null,
          )
        ],
      ),
      body: SingleChildScrollView(
        physics: const ScrollPhysics(),
        child: SafeArea(
          bottom: false,
          top: false,
          child: SingleChildScrollView(
            physics: const ScrollPhysics(),
            child: Container(
              height: MediaQuery.of(context).size.height,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/bg.png'),
                      fit: BoxFit.fill)),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.3,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.vertical(
                            bottom: Radius.elliptical(
                                MediaQuery.of(context).size.width, 130.0)),
                        image: DecorationImage(
                            colorFilter: ColorFilter.mode(
                                kPrimaryColor.withOpacity(.8),
                                BlendMode.srcOver),
                            image: const AssetImage('assets/images/pictop.jpg'),
                            fit: BoxFit.cover)),
                  ), // Picture on top background

                  Positioned(
                      left: 20,
                      right: 20,
                      top: MediaQuery.of(context).size.height * 0.2,
                      bottom: -15,
                      child: Container(
                        decoration: const BoxDecoration(
                            color: kSecondaryBackgroundColor,
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            boxShadow: [
                              BoxShadow(
                                  color: kSecondaryTextColor,
                                  offset: Offset(2, 2),
                                  blurRadius: 16)
                            ]),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 20, horizontal: 40),
                          child: SingleChildScrollView(
                            physics: const AlwaysScrollableScrollPhysics(),
                            child: Column(
                              children: [
                                const SizedBox(height: 8),
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    name,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 25),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    sciName,
                                    style: const TextStyle(
                                        fontSize: 15,
                                        color: kSecondaryTextColor,
                                        fontStyle: FontStyle.italic),
                                  ),
                                ),
                                const SizedBox(height: 5),
                                const Divider(
                                  indent: 60,
                                  thickness: 1,
                                  endIndent: 60,
                                  color: kPrimaryColor,
                                ),
                                const SizedBox(height: 5),
                                !s.isEmpty
                                    ? PrimaryOilTitlesItems(
                                        title: 'Other denomination',
                                        subtitle: s,
                                        color: kPrimaryTextColor)
                                    : const SizedBox(
                                        height: 0,
                                      ),
                                !p.isEmpty
                                    ? PrimaryOilTitlesItems(
                                        title: 'Allergies',
                                        subtitle: p,
                                        color: kPrimaryColor)
                                    : const SizedBox(
                                        height: 0,
                                      ),
                                !aspect.isEmpty
                                    ? PrimaryOilDetailsItems(
                                        type: 'Aspect', list: aspect)
                                    : const SizedBox(
                                        height: 0,
                                      ),
                                colo.isNotEmpty
                                    ? PrimaryOilDetailsItems(
                                        type: 'Color', list: colo)
                                    : const SizedBox(
                                        height: 0,
                                      ),
                                odor.isNotEmpty
                                    ? PrimaryOilDetailsItems(
                                        type: 'Odor', list: odor)
                                    : const SizedBox(
                                        height: 0,
                                      ),
                                DefaultTabController(
                                    initialIndex: SelectedIndex,
                                    length: tabs.length,
                                    child: Container(
                                      height: 40,
                                      child: TabBar(
                                        onTap: (int index) {
                                          SelectedIndex = index;
                                          setState(() {});
                                        },
                                        //indicatorColor: kPrimaryColor,
                                        tabs: tabb,
                                        unselectedLabelColor: graycolor,
                                        labelColor: kPrimaryColor,
                                        indicatorColor: kPrimaryColor,
                                      ),
                                    )),
                                SelectedIndex == tabs.indexOf(health)
                                    ? PrimaryPropertiesListItems(domain: health)
                                    : SelectedIndex == tabs.indexOf(beauty)
                                        ? PrimaryPropertiesListItems(
                                            domain: beauty)
                                        : SelectedIndex ==
                                                tabs.indexOf(wellBeing)
                                            ? PrimaryPropertiesListItems(
                                                domain: wellBeing)
                                            : const SizedBox(
                                                height: 0,
                                              )
                              ],
                            ),
                          ),
                        ),
                      )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
