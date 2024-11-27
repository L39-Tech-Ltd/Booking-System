import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';

class Footer extends StatelessWidget{
  const Footer({super.key});

  static const TextStyle titleStyle = TextStyle(fontSize: 22, color: Colors.white);
  static const TextStyle subtitleStyle = TextStyle(fontSize: 12, color: Colors.white);
  static const Color iconColor = Color.fromARGB(255, 195, 197, 199);

  @override
  Widget build(BuildContext context){
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
      color: const Color.fromARGB(255, 52, 52, 56),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              //Logo / name, socail links
              Expanded(
                flex: 4,
                child: _buildLogoAndSocials(),
                ),
            
              //Section 2
              Expanded(
                flex: 1,
                child: _buildDummySection(),
              ),

              //Section 3
              Expanded(
                flex: 1,
                child: _buildDummySection(),
              )

            ],
          ),
          _buildLegalNote(),
        ],
      ),
    );
  }

  Widget _buildLogoAndSocials(){
    return Container(
      child:Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('L39',style: titleStyle),
          Text('Build Cool Shit',style: subtitleStyle),
          SizedBox(height: 30),
          Row(
            children: _buildSocialIcons(),
          )
        ],
      )
    );
  }

  List<Widget> _buildSocialIcons() {
    final icons = [
      FontAwesomeIcons.facebook,
      FontAwesomeIcons.instagram,
      FontAwesomeIcons.twitter,
      FontAwesomeIcons.youtube,
      FontAwesomeIcons.envelope,
      FontAwesomeIcons.linkedin,
    ];

    return icons.map((icon) {
      return Padding(
        padding: const EdgeInsets.only(right: 10.0), // Add spacing between icons
        child: Icon(icon, color: iconColor, size: 22.0),
      );
    }).toList();
  }

  Widget _buildDummySection(){
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Dummy Text',style: TextStyle(fontSize: 12, color: Colors.white)),
          SizedBox(height: 5),
          Text('Dummy Text',style: TextStyle(fontSize: 12, color: Colors.white)),
          SizedBox(height: 5),
          Text('Dummy Text',style: TextStyle(fontSize: 12, color: Colors.white)),
          SizedBox(height: 5),
        ],
      )
    );
  }

  Widget _buildLegalNote(){
    return Column(
      children: [
        const Divider(color: Colors.white38),
        const SizedBox(height: 10),
        const Text('L39', style: TextStyle(color: Colors.white)),
        const SizedBox(height: 5),
        const Text('© 2024 L39', style: TextStyle(color: Colors.white)),
      ],
    );
  }
}
