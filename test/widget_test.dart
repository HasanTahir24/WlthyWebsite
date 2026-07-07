import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:wlthy_website/main.dart';

void main() {
  testWidgets('landing page renders key copy', (WidgetTester tester) async {
    // Give the test surface a desktop-sized viewport.
    tester.view.physicalSize = const Size(1440, 2400);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const WlthyApp());
    await tester.pump();

    // The hero headline is present.
    expect(
      find.textContaining('You need more than a finance app.'),
      findsOneWidget,
    );
    // A known section title renders further down the page.
    expect(find.text('Six things wlthy tracks for you'), findsWidgets);
  });
}
