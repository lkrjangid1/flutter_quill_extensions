/// A utility class providing methods for validating data, such as image URLs and color codes.
class ValidatorUtils {
  ValidatorUtils._();

  /// Checks if the given [imageUrl] is in base64 format and not a URL starting with 'http'.
  /// Returns true if the [imageUrl] is in base64 format and false otherwise.
  static bool isImageBase64(String imageUrl) {
    return !imageUrl.startsWith('http') && isBase64(imageUrl);
  }

  /// Checks if the given [str] is a valid base64 string.
  /// Returns true if the [str] is a valid base64 string and false otherwise.
  static bool isBase64(String str) => _base64.hasMatch(str);

  static final RegExp _base64 = RegExp(
    r'^(?:[A-Za-z0-9+\/]{4})*(?:[A-Za-z0-9+\/]{2}==|[A-Za-z0-9+\/]{3}=|[A-Za-z0-9+\/]{4})$',
  );

  /// Checks if the given [str] is a valid hex color code (e.g., 'FF0000' or 'F00').
  /// Returns true if the [str] is a valid hex color code and false otherwise.
  static bool isHex(String str) => _colorHex.hasMatch(str);

  static final RegExp _colorHex = RegExp(r'([0-9A-Fa-f]{3}|[0-9A-Fa-f]{6})$');
}
