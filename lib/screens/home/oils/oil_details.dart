import 'package:flutter/material.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';

class OilDetails extends StatefulWidget {
  const OilDetails({Key? key}) : super(key: key);

  @override
  _OilDetailsState createState() => _OilDetailsState();
}

class _OilDetailsState extends State<OilDetails> {
  bool isObscure = true;
  int SelectedIndex = 0;
  List aspect = [];
  List colo = [];
  List odor = [];

  @override
  void initState() {
    getData();
    super.initState();
  }

  getData() {
    setState(() {
      aspect.addAll(['Arbre a the']);
      colo.addAll(['Arbre a the', 'Arbre']);
      odor.addAll(['Arbre a the', 'Arbre', 'Arbre a the']);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white, //change your color here
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Center(
            child: Text(
          "Essential oils",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        )),
      ),
      body: SingleChildScrollView(
        physics: const ScrollPhysics(),
        child: SafeArea(
          bottom: false,
          top: false,
          child: SingleChildScrollView(
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
                                const Color(0xff61BB46).withOpacity(.8),
                                BlendMode.srcOver),
                            image: const AssetImage('assets/images/pictop.jpg'),
                            fit: BoxFit.cover)),
                  ), // Picture on top background

                  Positioned(
                      left: 20,
                      right: 20,
                      top: MediaQuery.of(context).size.height * 0.2,
                      child: Container(
                        height: MediaQuery.of(context).size.height,
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey,
                                  offset: Offset(2, 2),
                                  blurRadius: 16)
                            ]),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 20, horizontal: 40),
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                const SizedBox(height: 8),
                                const Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    'Apricot',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 25),
                                  ),
                                ),
                                const Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    'Prunus Armeniaca',
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.grey,
                                        fontStyle: FontStyle.italic),
                                  ),
                                ),
                                const SizedBox(height: 5),
                                const Divider(
                                  indent: 60,
                                  thickness: 1,
                                  endIndent: 60,
                                  color: Color(0xff61BB46),
                                ),
                                const SizedBox(height: 5),
                                const Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    'Other denomination',
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Color(0XFF3C3B3C),
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                const Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    'Arbre a the, Melaleuque',
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Color(0XFF3C3B3C),
                                        fontStyle: FontStyle.italic),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                const Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    'Allergies',
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Color(0xff61BB46),
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                const Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    'Melaleuque',
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Color(0xff61BB46),
                                        fontStyle: FontStyle.italic),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                const Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    'Aspect',
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Color(0XFF3C3B3C),
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                const SizedBox(height: 5),
                                SizedBox(
                                    height: 40,
                                    child: ListView.builder(
                                        itemCount: aspect.length,
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: (context, index) {
                                          return aspectt(
                                              context, aspect[index]);
                                        })),
                                const SizedBox(height: 10),
                                const Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    'Color',
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Color(0XFF3C3B3C),
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                const SizedBox(height: 5),
                                SizedBox(
                                    height: 40,
                                    child: ListView.builder(
                                        itemCount: colo.length,
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: (context, index) {
                                          return aspectt(context, colo[index]);
                                        })),
                                const SizedBox(height: 10),
                                const Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    'Odor',
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Color(0XFF3C3B3C),
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                const SizedBox(height: 5),
                                SizedBox(
                                    height: 40,
                                    child: ListView.builder(
                                        itemCount: odor.length,
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: (context, index) {
                                          return aspectt(context, odor[index]);
                                        })),
                                const SizedBox(height: 20),
                                DefaultTabController(
                                    initialIndex: SelectedIndex,
                                    length: 3,
                                    child: Container(
                                      height: 40,
                                      decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(100)),
                                          border: Border.all(
                                              color:
                                                  Colors.grey.withOpacity(.4),
                                              width: 1)),
                                      child: TabBar(
                                        onTap: (int index) {
                                          setState(() {});
                                        },
                                        //indicatorColor: Color(0xff61BB46),
                                        tabs: const [
                                          Tab(
                                            text: "Health",
                                          ),
                                          Tab(
                                            text: "Beauty",
                                          ),
                                          Tab(
                                            text: "Well Being",
                                          ),
                                        ],
                                        unselectedLabelColor:
                                            const Color(0xff61BB46),
                                        labelColor: Colors.white,
                                        indicator: RectangularIndicator(
                                          color: const Color(0xff61BB46),
                                          bottomLeftRadius: 100,
                                          bottomRightRadius: 100,
                                          topLeftRadius: 100,
                                          topRightRadius: 100,
                                        ),
                                      ),
                                    )),
                                SelectedIndex == 0
                                    ? SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height,
                                        child: ListView.builder(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 10),
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            shrinkWrap: true,
                                            itemCount: odor.length,
                                            scrollDirection: Axis.vertical,
                                            itemBuilder: (context, index) {
                                              return prop(context, odor[index]);
                                            }))
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

Widget aspectt(BuildContext context, String name) {
  return Container(
    margin: const EdgeInsets.all(5),
    padding: const EdgeInsets.all(7),
    decoration: const BoxDecoration(
        color: Color(0xff61BB46),
        borderRadius: BorderRadius.all(Radius.circular(15))),
    child: Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            name,
            style: const TextStyle(
                color: Colors.white, fontStyle: FontStyle.italic),
          ),
        ],
      ),
    ),
  );
}

Widget prop(BuildContext context, String name) {
  return Stack(children: [
    Container(
      width: MediaQuery.of(context).size.height,
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
          color: Color(0XFFE5E5E5),
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: Column(
        children: const [
          SizedBox(height: 20),
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              "Lorem Ipsum is simply dummy text of the printing and typesetting industry." +
                  "Lorem Ipsum has been the industry's standard dummy text ever since the 1500s," +
                  "When an unknown printer took a galley of type Scrambled it to make a type specimen book." +
                  "It has survived not only five centuries" +
                  "When an unknown printer took a galley of type Scrambled it to make a type specimen book.",
              style:
                  TextStyle(color: Colors.black, fontStyle: FontStyle.italic),
            ),
          ),
        ],
      ),
    ),
    Container(
      height: 30,
      width: MediaQuery.of(context).size.height,
      decoration: const BoxDecoration(
          color: Colors.green,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10), topRight: Radius.circular(10))),
      child: Row(
        children: [
          Container(
            margin: const EdgeInsets.only(right: 8, left: 8),
            height: 15,
            width: 15,
            decoration: const BoxDecoration(
                shape: BoxShape.circle, color: Colors.white),
          ),
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Properties',
              style: TextStyle(
                  fontSize: 15,
                  color: Colors.white,
                  fontWeight: FontWeight.normal),
            ),
          ),
        ],
      ),
    ),
  ]);
}
