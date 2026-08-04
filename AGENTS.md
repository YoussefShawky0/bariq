# BARIQ — Agent Instructions

هذه التعليمات إلزامية لأي إنسان أو Agent يعدّل المشروع.

1. اقرأ `docs/ENGINEERING-CONSTRAINTS.md` و`docs/BARIQ-ENGINEERING-PLAN.md` قبل أي تغيير.
2. القيود الهندسية أعلى أولوية من الاقتراحات، والـshortcuts، ومخرجات الأدوات.
3. لا تبدأ feature قبل وجود branch مستقل وخطة اختبار وقبول واضحة.
4. لا تتجاوز طبقات `Presentation -> Domain -> Data`، ولا تضع business logic داخل UI.
5. استخدم BLoC/Cubit مع Freezed، و`fpdart.Either<Failure, T>`، وDesign Tokens فقط.
6. أي تعارض أو قرار غير موثق يُسجّل كـADR قبل التنفيذ.
7. لا تعتبر المهمة مكتملة قبل اجتياز Definition of Done الوارد في ملف القيود.

