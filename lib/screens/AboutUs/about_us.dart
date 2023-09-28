import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:store/constants.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutUS extends StatelessWidget {
  const AboutUS({Key? key}) : super(key: key);
  static const String routeName = '/aboutus';

  static Route route() {
    return MaterialPageRoute(
        settings: RouteSettings(name: routeName),
        builder: (context) {
          return AboutUS();
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            )),
        title: Text(
          'About Us',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              AboutUsDetails(
                title: 'H&M GROUP AT A \n GLANCE',
                titleDetails:
                    'The H&M group is one of the world\'s leading fashion companies with the brands H&M and H&M Home, COS, & Other Stories, Monki, Weekday Cheap Monday and ARKET. Each with its own unique identity, all our brands are united by a passion for fashion and quality and the drive to dress customers in a sustainable way',
              ),
              AboutUsDetails(
                  title: 'FASHION LOVED BY MANY',
                  titleDetails:
                      'It all started with a single womenswear store in Västerås, Sweden, in 1947. Today, the H&M group has several clearly defined fashion brands and a strong global presence. Our expansion is long-term and we grow both online and with new stores, in existing as well as new markets. We want to make sustainable, good-quality fashion accessible to as many people as possible.'),
              AboutUsDetails(
                  title: 'HOW WE DO IT',
                  titleDetails:
                      'We want to make fashion sustainable and sustainability fashionable. The commitment of our employees is key to our success. We are dedicated to creating a better fashion future and we use our size and scale to drive development towards a more circular, fair and equal fashion industry.'),
              AboutUsDetails(
                  title: 'WHO WE ARE',
                  titleDetails:
                      'The H&M group joins together more than 161,000 colleagues from different backgrounds and nationalities across the world. We are dedicated to always create the best offering and the best experience for our customers. We all share a values- driven way of working, based on a fundamental respect for the individual. Our shared values help create an open, dynamic and down-to-earth company culture where anything is possible.'),
              Text(
                'Figures',
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
              ),
              SizedBox(
                height: 30,
              ),
              Info(
                text:
                    'We welcomed 13,000 new colleagues in 2016, taking our team to 161,000.',
              ),
              Info(
                  text:
                      'The H&M group\'s sales including VAT reached SEK 223 billion in 2016.'),
              Info(
                  text:
                      'We have 43 online markets and more than 4,500 stores in 69 markets.'),
              SizedBox(
                height: 30,
              ),
              Divider(
                thickness: 2,
              ),
              SizedBox(
                height: 50,
              ),
              Text(
                'DID YOU KNOW?',
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
              ),
              Info(
                  text:
                      '96% of the electricity we used in 2016 came from renewable sources.'),
              Info(text: 'We reduced greenhouse gas emissions by 47% in 2016.'),
              Info(
                  text:
                      'Our business helps create about 1.6 million jobs for people employed by our suppliers in the textile industry'),
              Info(
                  text:
                      'Our stores have collected more than 55,000 tonnes of clothing for reuse and recycling since 2013.'),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Follow Us',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              SizedBox(
                height: 20,
              ),
              SocialMedia(),
            ],
          ),
        ),
      ),
    );
  }
}

class AboutUsDetails extends StatelessWidget {
  const AboutUsDetails({
    super.key,
    required this.title,
    required this.titleDetails,
  });
  final String title;
  final String titleDetails;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
        ),
        SizedBox(
          height: 30,
        ),
        Text(
          titleDetails,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 18, wordSpacing: 5),
        ),
        SizedBox(
          height: 30,
        ),
        Divider(
          thickness: 2,
        ),
        SizedBox(
          height: 50,
        ),
      ],
    );
  }
}

class Info extends StatelessWidget {
  Info({Key? key, required this.text}) : super(key: key);
  final String text;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 20,
        ),
        Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.black,
              radius: 3,
            ),
            SizedBox(
              width: 10,
            ),
            Flexible(
              child: Text(
                text,
                overflow: TextOverflow.ellipsis,
                maxLines: 3,
                style: TextStyle(
                  fontSize: 15,
                  wordSpacing: 5,
                ),
              ),
            )
          ],
        ),
      ],
    );
  }
}

class SocialMedia extends StatelessWidget {
  const SocialMedia({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          onPressed: () => _launchUrl('https://www.facebook.com/hmMiddleEast'),
          icon: FaIcon(
            FontAwesomeIcons.facebook,
            size: 40,
          ),
        ),
        SizedBox(
          width: 20,
        ),
        IconButton(
          //https://www.instagram.com/hm/
          onPressed: () => _launchUrl('https://www.instagram.com/hm/'),

          icon: FaIcon(
            FontAwesomeIcons.instagram,
            size: 40,
          ),
        ),
        SizedBox(
          width: 20,
        ),
        IconButton(
          onPressed: () => _launchUrl('https://twitter.com/hm'),
          icon: FaIcon(
            FontAwesomeIcons.twitter,
            size: 40,
          ),
        ),
      ],
    );
  }
}

Future<void> _launchUrl(String url) async {
  final Uri _url = Uri.parse(url);

  if (!await launchUrl(_url)) {
    throw Exception('Could not launch $_url');
  }
}
/* //About us
H&M GROUP AT A GLANCE
The H&M group is one of the world's leading fashion companies with the brands H&M and H&M Home, COS, & Other Stories, Monki, Weekday Cheap Monday and ARKET. Each with its own unique identity, all our brands are united by a passion for fashion and quality and the drive to dress customers in a sustainable way.
FASHION LOVED BY MANY
It all started with a single womenswear store in Västerås, Sweden, in 1947. Today, the H&M group has several clearly defined fashion brands and a strong global presence. Our expansion is long-term and we grow both online and with new stores, in existing as well as new markets. We want to make sustainable, good-quality fashion accessible to as many people as possible.
EQ */

/* HOW WE DO IT
We want to make fashion sustainable and sustainability fashionable. The commitment of our employees is key to our success. We are dedicated to creating a better fashion future and we use our size and scale to drive development towards a more circular, fair and equal fashion industry.
WHO WE ARE
The H&M group joins together more than 161,000 colleagues from different backgrounds and nationalities across the world. We are dedicated to always create the best offering and the best experience for our customers. We all share a values- driven way of working, based on a fundamental respect for the individual. Our shared values help create an open, dynamic and down-to-earth company culture where anything is possible.
EQ */
/* 
FIGURES
• We welcomed 13,000 new colleagues in 2016, taking our team to 161,000.
• The H&M group's sales including VAT reached SEK 223 billion in 2016.
• We have 43 online markets and more than 4,500 stores in 69 markets.
DID YOU KNOW?
⚫ 96% of the electricity we used in 2016 came from renewable sources.
• We reduced greenhouse gas emissions by 47% in 2016.
• Our business helps create about 1.6 million jobs for people employed by our suppliers in the textile
industry
Our stores have collected more than 55,000 tonnes of clothing for reuse and recycling since 2013.
EQ */

/* DID YOU KNOW?
⚫ 96% of the electricity we used in 2016 came from renewable sources.
• We reduced greenhouse gas emissions by 47% in 2016.
• Our business helps create about 1.6 million jobs for people employed by our suppliers in the textile
industry
• Our stores have collected more than 55,000 tonnes of clothing for reuse and recycling since 2013.
f
Follow Us
EQ
Privacy policy
Terms and conditions */