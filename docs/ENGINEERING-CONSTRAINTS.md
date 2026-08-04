# BARIQ — Engineering Constraints (Hard Rules)

> هذا الملف ليس اقتراحات. هذه قواعد إلزامية لا يجوز تجاوزها دون ADR مكتوب وموافقة صريحة من مالك المشروع.

## 1. Architecture

- تطبيقات Flutter تتبع **Clean Architecture + Feature-First**.
- اتجاه الاعتماد ثابت:
  `Presentation (UI + BLoC) -> Domain (Entities + Use Cases + Repository Contracts) -> Data (Models + Data Sources + Repository Implementations)`.
- الـWidget يتعامل مع BLoC/Cubit فقط.
- الـBLoC/Cubit يستدعي Use Cases فقط.
- الـUse Case يعتمد على Repository interface من Domain.
- Data يطبق العقود ولا يُستدعى مباشرة من Presentation.
- ممنوع تخطي طبقة حتى لو كان الـfeature صغيرًا.

## 2. State Management

- **BLoC + Freezed إلزاميان**.
- Events وStates تكتب كـFreezed unions/sealed classes.
- ممنوع تجميع flags متعارضة مثل `isLoading` و`hasError`.
- الحالة تمثل مرحلة واحدة واضحة ويجري التعامل معها بـ`when` أو`map`.
- استخدم Cubit للحالات البسيطة المحدودة، وBloc للـflows متعددة الأحداث والحالات.
- لا نستخدم Equatable في الـfeatures الجديدة.

## 3. Feature-First Structure

```text
lib/
├── app/
├── core/
│   ├── constants/
│   ├── errors/
│   ├── network/
│   ├── theme/
│   ├── widgets/
│   ├── extensions/
│   └── utils/
└── features/
    └── feature_name/
        ├── data/
        │   ├── models/
        │   ├── datasources/
        │   └── repositories/
        ├── domain/
        │   ├── entities/
        │   ├── repositories/
        │   └── usecases/
        └── presentation/
            ├── bloc/
            ├── pages/
            └── widgets/
```

- أي Widget يُستخدم في أكثر من feature ينتقل فورًا إلى `core/widgets`.
- ممنوع copy/paste لنفس المكوّن بين features.

## 4. Widget Rules

- الحد الأقصى لملف Widget هو 150 سطرًا.
- الحد الأقصى للتداخل داخل `build` هو 3 مستويات.
- الـPage تُقسّم إلى Widgets صغيرة ذات مسؤولية واحدة.
- الـdeep child لا يستعمل `context.read` مباشرة؛ تُمرر callbacks/values أو يستخدم `context.select` عند الحاجة المحددة.
- الـbusiness logic ممنوع داخل Widget.
- constructors تكون `const` متى أمكن.

## 5. Design System

كل القيم البصرية تأتي من:

```text
core/theme/
├── app_colors.dart
├── app_text_styles.dart
├── app_spacing.dart
├── app_radius.dart
└── app_theme.dart
```

- ممنوع `Color(...)` داخل Widgets.
- ممنوع `EdgeInsets` أو `fontSize` أو radius كأرقام خام داخل Widgets.
- Branding assets داخل `assets/branding`.
- كل asset path يُعرّف في constants؛ ممنوع string paths داخل UI.

## 6. Responsive Design

- `flutter_screenutil` هو المصدر الوحيد للـresponsive sizing.
- ممنوع خلطه مع `MediaQuery` لحساب layout sizing.
- مقاس Figma المعتمد لتطبيقات الهاتف هو `390×844`.
- الإعداد المعتمد: `ScreenUtilInit(designSize: const Size(390, 844))`.
- أرقام layout تستخدم `.w`, `.h`, `.sp`, `.r`.
- Design tokens نفسها تكون responsive.
- يجوز إبقاء elevation وstroke ثابتين بقرار مقصود.
- كل flow مهم يُختبر على small phone وstandard phone وtablet.

## 7. Git Workflow

- `main`: production فقط.
- `develop`: integration فقط.
- الفروع: `feature/*`, `fix/*`, `chore/*`, `refactor/*`.
- ممنوع commit مباشر إلى `main` أو`develop`.
- feature واحدة لكل branch وPR إلى `develop`.
- Conventional Commits إلزامية.
- كل PR يمر على checklist الاختبارات، المعمارية، UI states، security، وDoD.

## 8. Dart and Error Handling

- Strict null safety.
- ممنوع `!` إلا إذا كان الإثبات واضحًا ومشروحًا بالتعليق.
- ممنوع `print`; استخدم logger.
- أخطاء الشبكة/التخزين تتحول إلى `Failure` موحد.
- Repository contracts ترجع `fpdart.Either<Failure, T>` فقط؛ لا نخلط `dartz`.
- Magic values تتحول إلى constants أوconfig.
- Dartdoc إلزامي لكل class/method عام في Domain.

## 9. Testing

- Unit tests لكل Use Case.
- Unit tests لكل Bloc/Cubit تشمل success وfailure والحالات الانتقالية.
- Widget tests للـcritical flows.
- Repository mapping tests بين DTO/Model وEntity وFailure.
- لا يُقبل feature PR دون اختبار مناسب.

## 10. Security

- لا API keys أوsecrets داخل source code.
- client configuration عبر `flutter_dotenv` وملف `.env` غير متتبع.
- server secrets في secret manager/environment.
- لا نخزن card/payment tokens.
- كل endpoint حساس يتحقق من الصلاحيات والبيانات server-side.
- Redirect الدفع ليس إثبات نجاح؛ webhook موثق هو المصدر الموثوق.

## 11. Definition of Done

- [ ] الـacceptance criteria منجزة.
- [ ] طبقات Clean Architecture محفوظة.
- [ ] States/Events بـFreezed ولا توجد flags متعارضة.
- [ ] لا raw design values أوasset paths في Widgets.
- [ ] loading/empty/error/offline/success states مغطاة.
- [ ] unit/widget/repository tests المناسبة ناجحة.
- [ ] `flutter analyze` بلا أخطاء.
- [ ] التنسيق وتوليد codegen ناجحان.
- [ ] لا secrets أوlogs حساسة.
- [ ] accessibility والـRTL والـresponsive راجعوا.
- [ ] التوثيق وADR/API contract محدثان.
- [ ] PR إلى `develop` بمراجعة مكتملة.

