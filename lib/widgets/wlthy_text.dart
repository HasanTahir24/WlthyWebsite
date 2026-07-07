import 'package:flutter/widgets.dart';

/// Renders [text] with every occurrence of the word "wlthy" (any case) a couple
/// of weights heavier than the surrounding copy — the brand treatment used
/// throughout the Figma design.
class WlthyText extends StatelessWidget {
  const WlthyText(
    this.text, {
    super.key,
    this.style,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.boldWeight,
  });

  final String text;
  final TextStyle? style;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;

  /// Weight applied to "wlthy". Defaults to two steps heavier than the base.
  final FontWeight? boldWeight;

  @override
  Widget build(BuildContext context) {
    final base = style ?? DefaultTextStyle.of(context).style;
    return Text.rich(
      TextSpan(children: wlthySpans(text, base, boldWeight: boldWeight)),
      style: base,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
    );
  }
}

/// Splits [text] into spans, weighting each "wlthy" match heavier.
List<InlineSpan> wlthySpans(String text, TextStyle base,
    {FontWeight? boldWeight}) {
  final bold = boldWeight ?? _heavier(base.fontWeight ?? FontWeight.w400);
  final spans = <InlineSpan>[];
  final re = RegExp('wlthy', caseSensitive: false);
  var last = 0;
  for (final m in re.allMatches(text)) {
    if (m.start > last) {
      spans.add(TextSpan(text: text.substring(last, m.start)));
    }
    spans.add(TextSpan(
      text: text.substring(m.start, m.end),
      style: TextStyle(fontWeight: bold),
    ));
    last = m.end;
  }
  if (last < text.length) spans.add(TextSpan(text: text.substring(last)));
  if (spans.isEmpty) spans.add(TextSpan(text: text));
  return spans;
}

/// Two steps heavier on the [FontWeight] scale (e.g. w500 → w700), capped.
FontWeight _heavier(FontWeight w) {
  final i = FontWeight.values.indexOf(w);
  return FontWeight.values[(i + 2).clamp(0, FontWeight.values.length - 1)];
}
