part of app_module;

class AppLinks {
  static const appSupportUrlEn =
      'https://sugarofficialhelp.zendesk.com/hc/zh-cn';
  static const appSupportUrlZh =
      'https://sugarofficialhelp.zendesk.com/hc/en-001';

  static String appSupportUrl(String lang) =>
      lang == 'zh' ? appSupportUrlZh : appSupportUrlEn;

  static const appContactUrlZh =
      'https://sugarofficialhelp.zendesk.com/hc/zh-cn/requests/new';
  static const appContactUrlEn =
      'https://sugarofficialhelp.zendesk.com/hc/en-001/requests/new';

  static String appContactUrl(String lang) =>
      lang == 'zh' ? appContactUrlZh : appContactUrlEn;

  static const appWebsiteUrl = 'https://sugar.one/';

  static const appTwitter = 'https://www.twitter.com/sugarofficial0';
  static const appFacebook = 'https://www.facebook.com/sugaroffcial';
  static const appInstagram = 'https://www.instagram.com/sugaranswer';
  static const appReddit = 'https://www.reddit.com/user/sugar-official';
  static const appTelegram = 'https://t.me/sugarofficialgroup';
}
