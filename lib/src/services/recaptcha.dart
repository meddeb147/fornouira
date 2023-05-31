import 'package:g_recaptcha_v3/g_recaptcha_v3.dart';

class RecaptchaService {
  /// Adem's key
  static const siteKey1 = '6LcTp1ImAAAAAKnQn4NOiSetG6mb2GRx1x0qJrMY';
  static const siteKey2 = '6Lfl7coUAAAAAKUjryaKQDhrrklXE9yrvWNXqKTj';

  Future<bool> init() async {
    return GRecaptchaV3.ready(siteKey2, showBadge: true);
  }

  Future<String?> getToken() async {
    return GRecaptchaV3.execute('submit');
  }
}
