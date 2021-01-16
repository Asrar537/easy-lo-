import 'package:easy_lo/app/Home/module/program_pdf_module.dart';
import 'package:easy_lo/app/Sign_in/Function/social_sign_in_btn.dart';
import 'package:easy_lo/common/Platform_widget/platform_exception_alert_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class About extends StatefulWidget {
  static void show(BuildContext context,
      {ProgramPDFModule pdf, Future future}) {
    Navigator.of(context, rootNavigator: false).push(
      CupertinoPageRoute(
        builder: (context) => About(),
        fullscreenDialog: false,
      ),
    );
  }

  @override
  _AboutState createState() => _AboutState();
}

class _AboutState extends State<About> {
  Future<void> _launchInBrowser(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: false,
        forceWebView: false,
        headers: <String, String>{'my_header_key': 'my_header_value'},
      );
    } else {
      throw PlatformException(
        code: 'Invalid Location',
        message: 'Error in url location',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        iconTheme: IconThemeData(
          color: Color.fromRGBO(32, 168, 151, 1), //change your color here
        ),
        title: Text(
          'About Us',
          style: TextStyle(
            color: Color.fromRGBO(32, 168, 151, 1), //change your color here
          ),
        ),
        centerTitle: true,
      ),
      body: _buildContent(),
    );
  }

  Widget _buildContent() {
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 30,
            ),
            Center(
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Easy',
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Lo ',
                      style: TextStyle(
                        color: Color.fromRGBO(38, 161, 148, 1),
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text(
                      '    Easy Lo Empowers our learner around world and better understanding of medicine and health topics.',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                    Text(
                      '    Learn more, forget less with fun and easy to digest videos and tools that help you study more strategically at your own pace.Discover the magic of learning with easy lo',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                    Text(
                      '    Discover the magic of learning with easy lo',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Center(
              child: Text(
                'Contact Us',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Row(
              children: [
                Expanded(
                  child: SocialSignInBtn(
                    height: 40,
                    fontSize: 13,
                    borderRadius: 10,
                    icon:
                        FaIcon(FontAwesomeIcons.facebookF, color: Colors.white),
                    text: 'Facebook',
                    textColor: Colors.white,
                    color: Color(0xFF334D92),
                    onpress: () async {
                      try {
                        await _launchInBrowser(
                            'https://www.facebook.com/Easy-Learning-101042025276813');
                      } catch (e) {
                        PlatformExceptionAlertDialog(
                          title: 'Something Went Wrong',
                          exception: e,
                        ).show(context);
                      }
                    },
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 16.0,
            ),
            Row(
              children: [
                Expanded(
                  child: SocialSignInBtn(
                    height: 40,
                    fontSize: 13,
                    borderRadius: 10,
                    icon: FaIcon(
                      FontAwesomeIcons.google,
                      color: Colors.white,
                    ),
                    text: 'Google',
                    textColor: Colors.white,
                    color: Color.fromRGBO(234, 67, 53, 1),
                    onpress: () async {
                      try {
                        await _launchInBrowser(
                            'mailto:Easylomedlife@gmail.com?subject=Discussion&body=');
                      } catch (e) {
                        PlatformExceptionAlertDialog(
                          title: 'Something went wrong',
                          exception: e,
                        ).show(context);
                      }
                    },
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Center(
              child: Text(
                'Developed By',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () async {
                      try {
                        await _launchInBrowser(
                            'https://www.facebook.com/abdul.naeem.169067/');
                      } catch (e) {
                        PlatformExceptionAlertDialog(
                          title: 'Something went wrong',
                          exception: e,
                        ).show(context);
                      }
                    },
                    child: Row(
                      children: [
                        FaIcon(
                          FontAwesomeIcons.facebookF,
                          color: Color(0xFF334D92),
                          size: 16,
                        ),
                        SizedBox(
                          width: 7,
                        ),
                        Text(': Usama'),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      try {
                        await _launchInBrowser(
                            'mailto:usamanaeem911@gmail.com?subject=Discussion&body=');
                      } catch (e) {
                        PlatformExceptionAlertDialog(
                          title: 'Something went wrong',
                          exception: e,
                        ).show(context);
                      }
                    },
                    child: Row(
                      children: [
                        SizedBox(
                          width: 7,
                        ),
                        FaIcon(
                          FontAwesomeIcons.google,
                          color: Color.fromRGBO(234, 67, 53, 1),
                          size: 16,
                        ),
                        SizedBox(
                          width: 7,
                        ),
                        Text(': usamaneem911@gmail.com'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 8.0,
            ),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () async {
                      try {
                        await _launchInBrowser(
                            'https://www.facebook.com/rana.asrar.5680');
                      } catch (e) {
                        PlatformExceptionAlertDialog(
                          title: 'Something went wrong',
                          exception: e,
                        ).show(context);
                      }
                    },
                    child: Row(
                      children: [
                        FaIcon(
                          FontAwesomeIcons.facebookF,
                          color: Color(0xFF334D92),
                          size: 16,
                        ),
                        SizedBox(
                          width: 7,
                        ),
                        Text(': Asrar Hussain'),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      try {
                        await _launchInBrowser(
                            'mailto:hisrar537@gmail.com?subject=Discussion&body=');
                      } catch (e) {
                        PlatformExceptionAlertDialog(
                          title: 'Something went wrong',
                          exception: e,
                        ).show(context);
                      }
                    },
                    child: Row(
                      children: [
                        SizedBox(
                          width: 7,
                        ),
                        FaIcon(
                          FontAwesomeIcons.google,
                          color: Color.fromRGBO(234, 67, 53, 1),
                          size: 16,
                        ),
                        SizedBox(
                          width: 7,
                        ),
                        Text(' : hisrar537@gmail.com'),
                      ],
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
