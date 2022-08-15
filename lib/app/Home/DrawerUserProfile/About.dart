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
  Widget bullet(String massage) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0, top: 2),
            child: Icon(
              Icons.fiber_manual_record_outlined,
              size: 14,
            ),
          ),
          Expanded(
            child: Text(
              massage,
              style: TextStyle(
                fontSize: 18,
              ),
              textAlign: TextAlign.justify,
            ),
          ),
        ],
      ),
    );
  }

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
        width: MediaQuery.of(context).size.width,
        //decoration: BoxDecoration(color: Colors.red),
        margin: EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                //crossAxisAlignment: CrossAxisAlignment.stretch,
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
                          bullet(
                              "Easy Lo Empowers our learner around world better understanding of medicine and health topics."),
                          bullet(
                              "Learn more, forget less with fun and easy digest videos and tools that help you study more strategically at your own pace."),
                          bullet("Discover the magic of learning with Easy Lo"),
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
                          icon: FaIcon(FontAwesomeIcons.facebookF,
                              color: Colors.white),
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
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              Center(
                                child: InkWell(
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
                                    mainAxisAlignment: MainAxisAlignment.center,
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
                                      Flexible(
                                          child: Text(
                                        'Usama : usamaneem911@gmail.com',
                                      )),
                                    ],
                                  ),
                                ),
                              ),
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
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Column(
                            children: [
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
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
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
                                    Flexible(
                                        child: Text(
                                            'Asrar Hussain : hisrar537@gmail.com')),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
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
