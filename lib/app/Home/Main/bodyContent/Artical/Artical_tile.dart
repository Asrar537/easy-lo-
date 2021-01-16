import 'package:easy_lo/app/Home/module/artical_module.dart';
import 'package:easy_lo/common/Platform_widget/platform_exception_alert_dialog.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

class ArticalTile extends StatelessWidget {
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

  final ArticalModule artical;

  const ArticalTile({Key key, this.artical}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Container(
        padding: EdgeInsets.all(4),
        margin: EdgeInsets.only(bottom: 14),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          color: Colors.white,
        ),
        child: ListTile(
          title: Text(
            artical?.name ?? 'Title',
            style: TextStyle(
              color: Color.fromRGBO(32, 168, 151, 1),
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 8),
            child: RichText(
              text: new TextSpan(
                style: TextStyle(
                  color: Colors.grey[700],
                ),
                children: [
                  new TextSpan(
                    text: artical?.dec ?? 'dec',
                    style: new TextStyle(color: Colors.black, fontSize: 15),
                  ),
                  if (artical.url != null && artical.url.isNotEmpty) ...[
                    new TextSpan(
                      text: 'Visit ...',
                      style: new TextStyle(color: Colors.blue, fontSize: 18),
                      recognizer: new TapGestureRecognizer()
                        ..onTap = () async {
                          final url = artical?.url ?? '';
                          try {
                            await _launchInBrowser(url);
                          } catch (e) {
                            PlatformExceptionAlertDialog(
                              title: 'Sign In Failed',
                              exception: e,
                            ).show(context);
                          }
                        },
                    ),
                  ]
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
