import 'package:flutter/material.dart';

/// representing the alignment options for an item.
enum AlignmentCRL { center, right, left }

/// Extension on [AlignmentCRL] to provide additional functionality for working with item alignments.
extension AlignmentImageEx on AlignmentCRL {
  /// Returns the name of the alignment as a string.
  String get name {
    switch (this) {
      case AlignmentCRL.center:
        return 'center';
      case AlignmentCRL.left:
        return 'left';
      case AlignmentCRL.right:
        return 'right';
    }
  }

  /// Gets the [AlignmentCRL] corresponding to the given [alignment] string.
  /// Returns the appropriate alignment value or [AlignmentCRL.center] if no match is found.
  static AlignmentCRL getAlignment(String alignment) {
    return AlignmentCRL.values.firstWhere(
      (element) => element.name.contains(alignment),
    );
  }

  /// Returns the [AlignmentGeometry] corresponding to the alignment option.
  AlignmentGeometry get alignmentGeometry {
    switch (this) {
      case AlignmentCRL.center:
        return Alignment.center;
      case AlignmentCRL.left:
        return Alignment.centerLeft;
      case AlignmentCRL.right:
        return Alignment.centerRight;
    }
  }
}
