class PostalCode {
  String? format;
  String? regex;

  PostalCode({
    this.format,
    this.regex,
  });

  factory PostalCode.fromJson(Map<String, dynamic>? json) => PostalCode(
    format: json?["format"],
    regex: json?["regex"],
  );

  Map<String, dynamic> toJson() => {
    "format": format,
    "regex": regex,
  };
}