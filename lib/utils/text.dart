import 'package:flutter/material.dart';

extension TextExtension on Text {
  Text setStrutStyle({StrutStyle strutStyle}) {
    if (strutStyle != null) {
      return copyWith(strutStyle: strutStyle);
    }

    return copyWith(
      strutStyle: StrutStyle.fromTextStyle(
        style,
        forceStrutHeight: true,
      ),
    );
  }

  /// Creates a copy of this Text but the given fields will be replaced with
  /// the new values.
  Text copyWith({
    Key key,
    StrutStyle strutStyle,
    TextAlign textAlign,
    Locale locale,
    bool softWrap,
    TextOverflow overflow,
    double textScaleFactor,
    int maxLines,
    String semanticsLabel,
    TextWidthBasis textWidthBasis,
    TextStyle style,
  }) {
    return Text(
      data,
      key: key ?? this.key,
      strutStyle: strutStyle ?? this.strutStyle,
      textAlign: textAlign ?? this.textAlign,
      locale: locale ?? this.locale,
      softWrap: softWrap ?? this.softWrap,
      overflow: overflow ?? this.overflow,
      textScaleFactor: textScaleFactor ?? this.textScaleFactor,
      maxLines: maxLines ?? this.maxLines,
      semanticsLabel: semanticsLabel ?? this.semanticsLabel,
      textWidthBasis: textWidthBasis ?? this.textWidthBasis,
      style: style ?? this.style,
    );
  }
}
