import 'package:accesorios_para_mascotas/values/responsive_app.dart';
import 'package:accesorios_para_mascotas/values/string_app.dart';
import 'package:accesorios_para_mascotas/widgets/web_components/footer/bottom_colum.dart';
import 'package:flutter/material.dart';

import 'info_text.dart';

class Footer extends StatefulWidget {

  const Footer({super.key});

  @override
  State<Footer> createState() => _FooterState();
}

class _FooterState extends State<Footer> {
  late ResponsiveApp responsiveApp;

  @override
  Widget build(BuildContext context) {
    responsiveApp = ResponsiveApp(context);
    return Container(
      padding: responsiveApp.edgeInsetsApp?.allMediumEdgeInsets,
      color: Theme.of(context).primaryColor,
      child: Column(
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              BottomColumn(
                heading: aboutStr,
                s1: contactanos,
                s2: home,
                s3: conocenos,
              ),
              BottomColumn(
                heading: helpStr,
                s1: paymentStr,
                s2: cancellationStr,
                s3: fAQStr,
              ),
              BottomColumn(
                heading: socialStr,
                s1: twitterStr,
                s2: facebookStr,
                s3: instagramStr,
              ),
              Container(
                color: Theme.of(context).colorScheme.secondary,
                width: responsiveApp.dividerVtlWidth,
                height: responsiveApp.dividerVtlHeight,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                      padding:
                          responsiveApp.edgeInsetsApp?.vrtSmallEdgeInsets ??
                              const EdgeInsets.all(0),
                      child: InfoText(
                        type: emailStr,
                        text: emailDefaultStr,
                      )),
                  InfoText(
                    type: addressStr,
                    text: addressDefaultStr,
                  )
                ],
              ),
            ],
          ),
          Padding(
              padding: responsiveApp.edgeInsetsApp?.vrtSmallEdgeInsets ??
                  const EdgeInsets.all(0),
              child: Divider(
                color: Theme.of(context).colorScheme.secondary,
                height: responsiveApp.dividerHznHeight,
              )),
          Text(
            copyrightStr,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ],
      ),
    );
  }
}
