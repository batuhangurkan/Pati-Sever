import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class LocaleConstants {
  static const trLocale = Locale("tr", "TR");
  static const enLocale = Locale("en", "US");
  static const localePath = 'assets/translations';

  //////////////////////////////////////////

  var loginText = "İnternet Bağlantınız Kontrol Ediliyor... ✓";
  var loadingText = "Merhaba";
  var loginDescText =
      "Bu sayfa yönetici giriş sayfasıdır. Yönetici olanlar giriş yapabilir.Yönetici değilseniz misafir olarak devam edebilirsiniz.";
  var emailText = "E-mail";
  var passWordText = "Şifre";
  var loginSuccesText = "Başarılı bir şekilde giriş yaptınız...";
  var loginEmptyUserNamePassword = "Kullanıcı adı ve şifre boş geçilemez!";
  var loginEmptyUserName = "Kullanıcı adı boş geçilemez!";
  var passwordEmpty = "Şifre boş geçilemez!";
  var noSuchUserSystem = "Sistemde böyle bir kullanıcı yok";
  var loginSuccesGuestText = "Misafir olarak giriş yaptınız";
  var loginGuestButtonText = "Misafir Girişi";
  var loginButtonText = "Giriş yap";
  var dontHaveAccountText = "Hesabınız yok mu?";
  var registerNowText = "Kayıt olun!";
  var appBarText = "Arama - Kurtarma";
  var bottomNavigationBarTextHome = "Anasayfa";
  var lastEarthQuakeNavigationBarText = "Son Depremler";
  var languageCheckText = "Dil Ayarlarınız Kontrol Ediliyor... ✓";
  var settingsText = "Ayarlar";
  var logOutText = "Çıkış yaptınız!";
  var contactusText = "Bizimle İletişime Geçin";
  var themeChangeText = "Tema Seçenekleri";
  var logOutButtonText = "Çıkış Yapın";
  var passWordTextVerification = "Şifre Onay";
  var registerPageText = "Kayıt Sayfası,";
  var registerPageDescText =
      "Bu sayfa yönetici kayıt sayfasıdır. Üyelikler onaya tabii tutulacaktır.";
  var registerButtonText = "Kayıt ol";
  var kvkkText = "Bu uygulama kişisel verilerinizi kaydeder. Detaylar için ";
  var readKvvkText = " KVKK Metnini Okuyun";
  var loginNetConnectionSuccesText = "İnternet bağlantısı başarılı!";
}
