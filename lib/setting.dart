import 'package:flutter/material.dart';

class LanguagePage extends StatelessWidget {
  const LanguagePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Language'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: ListView(
        children: [
          w('Language / ภาษา', context, 'language'),
          w('Notification', context, 'notification'),
          w('Theme', context, 'theme'),
          w('Help & Feedback', context, 'helpFeedback'),
          w('About Us', context, 'aboutUs')
        ],
      ),
    );
  }
}

class NotificationPage extends StatelessWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notification'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: ListView(
        children: [
          Container(
            padding: const EdgeInsets.all(10.0),
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.blue,
                  width: 2.0,
                ),
              ),
            ),
          ),
          w('Warning distant', context, 'warningDistant'),
          w('Sound', context, 'sound'),
          w('Vibration', context, 'vibration'),
        ],
      ),
    );
  }
}

class SoundPage extends StatelessWidget {
  const SoundPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sound'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: ListView(
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 20, top: 20),
            child: Text("Sound"),
          ),
          w('Warn with sound', context, 'warnWithSound'),
          w('Media', context, 'media'),
        ],
      ),
    );
  }
}

class WarningDistantPage extends StatelessWidget {
  const WarningDistantPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Warning distant'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: ListView(
        children: const [
          Text("Measurement"),
          Padding(
            padding: EdgeInsets.only(left: 20, top: 20),
            child: Text("Distant"),
          ),
          Text("Be chill"),
          Text("We're close now"),
          Text("Prepare to leave"),
          Text("Now!"),
        ],
      ),
    );
  }
}

class ThemePage extends StatelessWidget {
  const ThemePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Theme'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: ListView(
        children: [
          w('Language / ภาษา', context, 'language'),
          w('Notification', context, 'notification'),
          w('Theme', context, 'theme'),
          w('Help & Feedback', context, 'helpFeedback'),
          w('About Us', context, 'aboutUs')
        ],
      ),
    );
  }
}

class HelpFeedbackPage extends StatelessWidget {
  const HelpFeedbackPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('How can we help?'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: ListView(
        children: [
          Container(
            padding: const EdgeInsets.all(10.0),
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.blue,
                  width: 2.0,
                ),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 20, top: 20),
            child: Text("HELP"),
          ),
          w('How to use', context, 'howToUse'),
          const Padding(
            padding: EdgeInsets.only(left: 20, top: 20),
            child: Text("Feedback"),
          ),
          w('GPS & Tracking', context, 'GPSTracking'),
          w('Set notification', context, 'setNotification'),
          w('Service', context, 'service'),
          w('Others', context, 'others'),
        ],
      ),
    );
  }
}

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About US'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: ListView(
        children: [
          w('Language / ภาษา', context, 'language'),
          w('Notification', context, 'notification'),
          w('Theme', context, 'theme'),
          w('Help & Feedback', context, 'helpFeedback'),
          w('About Us', context, 'aboutUs')
        ],
      ),
    );
  }
}

class Setting extends StatelessWidget {
  const Setting({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: const Text(
          'Setting',
          style: TextStyle(fontSize: 40),
        ),
      ),
      body: ListView(
        children: [
          Container(
            padding: const EdgeInsets.all(10.0),
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.blue,
                  width: 2.0,
                ),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 20, top: 20),
            child: Text("GENERAL "),
          ),
          w('Language / ภาษา', context, 'language'),
          w('Notification', context, 'notification'),
          w('Theme', context, 'theme'),
          w('Help & Feedback', context, 'helpFeedback'),
          w('About Us', context, 'aboutUs')
        ],
      ),
    );
  }
}

Widget w(String title, BuildContext context, String link) {
  return ListTile(
    tileColor: const Color.fromARGB(255, 228, 238, 246),
    title: Row(children: [
      Text(title),
      const Spacer(),
      const Icon(Icons.arrow_forward_ios_sharp,
          color: Color.fromARGB(255, 0, 153, 255))
    ]),
    onTap: () {
      Navigator.pushNamed(context, '/$link');
    },
  );
}
