import 'package:flutter/widgets.dart';

abstract final class AppStrings {
  static const String appName = 'BARIQ';
  static const String tagline = 'Car Care, Wherever You Are';
  static const String brandSemanticLabel = 'BARIQ logo';
  static const String foundationReady = 'الأساس جاهز';
  static const String onboardingNext = 'الخطوة التالية: تجربة التعريف بالتطبيق';
  static const String signInNext = 'الخطوة التالية: تسجيل الدخول';
  static const String homeNext = 'تم العثور على جلسة محفوظة';
  static const String initializationFailed = 'تعذر تجهيز التطبيق';
  static const String retry = 'إعادة المحاولة';
  static const String genericError = 'حدث خطأ غير متوقع. حاول مرة أخرى.';
  static const String onboardingConvenienceSemanticLabel =
      'فني يغسل سيارة العميل أمام منزله';
  static const String onboardingExpertiseSemanticLabel =
      'فني محترف يلمع طلاء السيارة بعناية';
  static const String onboardingTrackingSemanticLabel =
      'متابعة موقع خدمة السيارة من الهاتف';
  static const String onboardingConvenienceEyebrow = 'الخدمة عندك';
  static const String onboardingConvenienceTitle = 'غسيل وتلميع لحد عندك';
  static const String onboardingConvenienceBody =
      'حدد مكانك وميعادك، وفريق مجهّز يوصلك في البيت أو الشغل—من غير مشوار ولا انتظار.';
  static const String onboardingExpertiseEyebrow = 'عناية باحتراف';
  static const String onboardingExpertiseTitle = 'كل تفصيلة في إيد أمينة';
  static const String onboardingExpertiseBody =
      'فنيون محترفون ومعدات مخصصة لخدمة دقيقة تحافظ على عربيتك ولمعتها.';
  static const String onboardingTrackingEyebrow = 'متابعة واضحة';
  static const String onboardingTrackingTitle = 'من الحجز لحد التسليم';
  static const String onboardingTrackingBody =
      'تأكيد فوري، تحديثات مباشرة، ودفع مرن—وأنت متابع كل خطوة براحة.';
  static const String next = 'التالي';
  static const String skip = 'تخطي';
  static const String startNow = 'ابدأ الآن';
  static const String onboardingSaveFailed = 'تعذر حفظ اختيارك. حاول مرة أخرى.';
  static const String signInTitle = 'أهلًا بيك في BARIQ';
  static const String signInSubtitle =
      'سجّل دخولك أو أنشئ حساب جديد وخلّي عناية عربيتك أسهل.';
  static const String signUpTitle = 'ابدأ مع BARIQ';
  static const String signUpSubtitle =
      'أنشئ حسابك في أقل من دقيقة، والتفاصيل نكملها وقت الحجز.';
  static const String email = 'البريد الإلكتروني';
  static const String password = 'كلمة المرور';
  static const String confirmPassword = 'تأكيد كلمة المرور';
  static const String forgotPassword = 'نسيت كلمة المرور؟';
  static const String signIn = 'تسجيل الدخول';
  static const String createAccount = 'إنشاء حساب';
  static const String continueWithGoogle = 'المتابعة باستخدام Google';
  static const String orContinueWith = 'أو';
  static const String noAccount = 'ليس لديك حساب؟';
  static const String haveAccount = 'لديك حساب بالفعل؟';
  static const String googleOpened =
      'أكمل تسجيل الدخول في المتصفح، وستعود للتطبيق تلقائيًا.';
  static const String verifyEmailTitle = 'راجع بريدك الإلكتروني';
  static const String verifyEmailBody =
      'أرسلنا رابط تفعيل الحساب. افتحه ثم ارجع وسجّل دخولك.';
  static const String passwordResetTitle = 'راجع بريدك الإلكتروني';
  static const String passwordResetBody =
      'إذا كان البريد مسجلًا، ستصلك رسالة آمنة لتغيير كلمة المرور.';
  static const String passwordRecoveryTitle = 'عيّن كلمة مرور جديدة';
  static const String passwordRecoveryBody =
      'اختَر كلمة قوية لا تقل عن 8 أحرف، ولا تستخدمها في حساب آخر.';
  static const String saveNewPassword = 'حفظ كلمة المرور';
  static const String backToSignIn = 'العودة لتسجيل الدخول';
  static const String secureAuthHint =
      'لن نشارك بياناتك، ولن نطلب بطاقة أو رخصة من العميل.';

  static String onboardingProgressLabel(int page, int total) =>
      'الشاشة $page من $total';

  static String emailSentTo(String email) => 'تم الإرسال إلى $email';

  static const Locale arabicLocale = Locale('ar');
  static const List<Locale> supportedLocales = [arabicLocale];
}
