# Talabat App — SwiftUI student prototype

A five-screen iOS food-ordering starter project with an orange visual theme, sample Dubai restaurant locations, and a working local basket. Built with SwiftUI and MapKit; no packages or API keys required.

> Educational prototype only. Not affiliated with Talabat. Businesses, menu prices, ratings, delivery times, pins and orders are sample data. No real account, payment or delivery is created.

## Open and run

1. Clone this repository into a **new folder** (do not overwrite your older Xcode project):
   ```sh
   git clone https://github.com/Mnt9r/TalabatApp.git
   cd TalabatApp
   open TalabatApp.xcodeproj
   ```
   Alternatively, choose **Code → Download ZIP** on GitHub, extract it, then open `TalabatApp.xcodeproj`.
2. Use **Xcode 15 or later**, with an **iOS 17+** simulator runtime installed.
3. Select the **TalabatApp** scheme and an iPhone simulator. Press **⌘R**.
4. Choose **Explore as a guest**, or enter a made-up email such as `demo@example.com` and any password of six or more characters.

Simulator builds do not require a development team. For a physical iPhone, select your Apple development team under **Signing & Capabilities** and use your own unique bundle identifier if needed.

## Five screens

| Screen | Included behaviour |
| --- | --- |
| Login | Demo form validation, secure password field, guest mode, sign-out |
| Discover | Four restaurant cards, search, cuisine filters, empty search state |
| Restaurant | Menu, prices in AED, add to basket, quantity feedback, location link |
| Locations | Interactive Apple map, selectable pins, restaurant list, focus/reset map, menu navigation |
| Cart | Increase/decrease quantities, remove items, shared basket, subtotal + fee, simulated order confirmation |

The map uses illustrative Dubai coordinates and requires internet for map tiles. The rest of the prototype uses bundled sample data. No location permission is requested.

## Demo limitations

- Sign-in validates form shape locally; it does **not** authenticate a real account. Do not enter a real password. Credentials are never stored or transmitted.
- The session and cart live in memory; closing the app or signing out clears them.
- The basket can contain items from different demo restaurants. The flat AED 7 fee applies once to the whole basket.
- Placing a demo order clears the basket and shows a simulated reference. It does not charge, deliver, or save order history.
- No backend, real payment integration, live restaurant information, or production app icon is included yet.

## Source structure

```text
TalabatApp.xcodeproj             Xcode project and shared scheme
TalabatApp/
  TalabatAppApp.swift            App entry and shared state
  ContentView.swift             Sign-in gate and tab navigation
  Models/Models.swift           Restaurant, menu, basket and sample data
  Models/AppStore.swift         Demo session, quantities, totals and checkout
  Views/                        Five screen views and reusable styling
  Assets.xcassets/               Accent colour
TalabatAppTests/                 XCTest coverage of demo state and sample data
```

## Verify

In Xcode press **⌘U**. Tests cover invalid/valid demo sign-in, sign-out clearing state, repeated add/remove operations, totals and fees, empty checkout, successful demo checkout, and sample identifier/coordinate validity.

A GitHub Actions workflow also builds and tests on a macOS iPhone simulator when Actions is enabled for this repository.

Manual walkthrough:

1. Reject an invalid login; enter guest mode.
2. Search for `pizza`; select a cuisine; verify an unmatched search has an empty state.
3. Open a menu and add one item twice; check the cart badge and subtotal.
4. Open the restaurant's location; select other pins and use **Show all**.
5. Decrease a basket quantity to zero; verify the delivery fee disappears when empty.
6. Place and confirm a demo order; verify the confirmation and empty basket.
7. Check small/large iPhone sizes, landscape, dark mode, Dynamic Type and VoiceOver.

## شرح سريع بالعربي

المشروع بداية تطبيق طلبات من خمس صفحات: تسجيل الدخول، المطاعم، تفاصيل المطعم والمنيو، خريطة المواقع، والسلة.

نزّل المشروع من **Code → Download ZIP**، فك الضغط، وافتح `TalabatApp.xcodeproj`. اختَر محاكي iPhone واضغط **⌘R**. تقدر تدخل كضيف من **Explore as a guest**. إذا بتستخدم النموذج، اكتب إيميل وكلمة مرور تجريبيين.

تسجيل الدخول والطلبات تجريبية محلية. المطاعم ومواقعها بيانات للعرض، وما فيه دفع أو توصيل حقيقي. الخطوة التالية للمشروع هي ربط تسجيل الحسابات وقاعدة البيانات وإضافة معلومات مطاعم فعلية.
