import 'package:flutter/widgets.dart';

abstract final class AppStrings {
  static const String appName = 'BARIQ';
  static const String tagline = 'Car Care, Wherever You Are';
  static const String brandSemanticLabel = 'BARIQ logo';
  static const String foundationReady = 'الأساس جاهز';
  static const String onboardingNext = 'الخطوة التالية: تجربة التعريف بالتطبيق';
  static const String signInNext = 'الخطوة التالية: تسجيل الدخول';
  static const String homeNext = 'تم العثور على جلسة محفوظة';
  static const String profileCompletionNext = 'استكمال بيانات الحساب';
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
  static const String profileStep = 'خطوة أخيرة';
  static const String profileTitle = 'خلّينا نعرفك';
  static const String profileSubtitle =
      'اسمك هو المطلوب دلوقتي. كمّل باقي البيانات لو حابب عشان أول حجز يبقى أسرع.';
  static const String profilePhoto = 'صورة الحساب';
  static const String addProfilePhoto = 'إضافة صورة اختيارية';
  static const String changeProfilePhoto = 'تغيير الصورة';
  static const String fullName = 'الاسم بالكامل *';
  static const String phoneNumber = 'رقم الهاتف';
  static const String egyptCountryCodePrefix = '+20 ';
  static const String phoneHint = '01012345678';
  static const String phoneUnverifiedHint =
      'اكتب رقمك المصري فقط؛ الصفر الأول مقبول ولن يُخزَّن.';
  static const String city = 'المحافظة';
  static const String governorateHint = 'اختر المحافظة (اختياري)';
  static const String area = 'المنطقة';
  static const String bookingDetailsSection = 'وفّر وقتك عند أول حجز';
  static const String bookingDetailsHint =
      'الهاتف والمحافظة والمنطقة هنطلبهم قبل تأكيد أول حجز.';
  static const String termsAgreement =
      'قرأت ووافقت على الشروط وملخص استخدام البيانات.';
  static const String viewTerms = 'عرض التفاصيل';
  static const String termsTitle = 'الشروط واستخدام البيانات';
  static const String termsIntro =
      'بنستخدم بيانات الحساب لتنفيذ الخدمة، التواصل بخصوص الحجز، وحماية حسابك.';
  static const String termsPrivacy =
      'صورتك اختيارية ومحفوظة بشكل خاص. لا نطلب بطاقة شخصية أو رخصة من العميل.';
  static const String termsControl =
      'تقدر تعدّل بياناتك لاحقًا من الحساب، وطلبات الحذف هتتضاف ضمن إعدادات الخصوصية.';
  static const String close = 'إغلاق';
  static const String saveAndContinue = 'حفظ ومتابعة';
  static const String profileSecureHint =
      'بياناتك محمية بصلاحيات ملكية، ومحدش يقدر يقرأ بروفايل غيره.';
  static const String profileLoadFailed = 'تعذر تحميل بيانات الحساب.';
  static const String retryProfile = 'حاول مرة أخرى';
  static const String avatarFormatError = 'اختَر صورة JPG أو PNG أو WebP.';
  static const String avatarReadError = 'تعذر قراءة الصورة. جرّب صورة أخرى.';
  static const String avatarSemanticLabel = 'صورة حساب العميل';
  static const String cropAvatarTitle = 'ضبط صورة الحساب';
  static const String cropAvatarDone = 'استخدام';
  static const String cropAvatarCancel = 'إلغاء';
  static const String vehiclesTitle = 'سياراتي';
  static const String vehiclesSubtitle =
      'أضف بيانات عربيتك عشان نحدد الخدمة والسعر المناسبين.';
  static const String addVehicle = 'إضافة عربية';
  static const String editVehicle = 'تعديل العربية';
  static const String emptyVehiclesTitle = 'لسه مفيش عربيات مضافة';
  static const String emptyVehiclesBody =
      'ضيف أول عربية، وهتكون هي الاختيار الافتراضي في الحجز.';
  static const String defaultVehicle = 'الافتراضية';
  static const String vehicleMake = 'الماركة *';
  static const String vehicleModel = 'الموديل *';
  static const String vehicleYear = 'سنة الصنع *';
  static const String vehicleColor = 'اللون *';
  static const String vehiclePlate = 'رقم اللوحة *';
  static const String vehiclePlateHint = 'مثال: أ ب ج ١٢٣';
  static const String vehicleClassLabel = 'فئة العربية *';
  static const String makeDefaultVehicle = 'استخدمها كعربيتي الافتراضية';
  static const String makeDefaultVehicleHint =
      'هنختارها تلقائيًا عند بدء أي حجز جديد.';
  static const String defaultVehicleLockedHint =
      'لتغيير الافتراضية، اختَر عربية تانية واجعلها الافتراضية.';
  static const String saveVehicle = 'حفظ العربية';
  static const String deleteVehicle = 'حذف';
  static const String deleteVehicleTitle = 'حذف العربية؟';
  static const String cancel = 'إلغاء';
  static const String vehicleSaved = 'تم حفظ العربية بنجاح.';
  static const String vehicleDeleted = 'تم حذف العربية.';
  static const String vehiclesLoadFailed = 'تعذر تحميل العربيات.';
  static const String vehicleOwnershipHint =
      'بيانات العربيات خاصة بحسابك، ولا نطلب صورة رخصة من العميل.';

  static String onboardingProgressLabel(int page, int total) =>
      'الشاشة $page من $total';

  static String emailSentTo(String email) => 'تم الإرسال إلى $email';

  static String deleteVehicleBody(String name) =>
      'هتحذف $name من حسابك. تقدر تضيفها من جديد لاحقًا.';

  static String vehicleMeta(int year, String vehicleClass) =>
      '$year • $vehicleClass';

  static const Locale arabicLocale = Locale('ar');
  static const List<Locale> supportedLocales = [arabicLocale];
}
