class DiscountModel {
  final String id;
  final String title;
  final String code;
  final double percentage;
  final int minAmount;
  final DateTime validUntil;
  final bool isActive;
  final bool firstTimeOnly;
  final List<String> rules;

  DiscountModel({
    required this.id,
    required this.title,
    required this.code,
    required this.percentage,
    required this.minAmount,
    required this.validUntil,
    required this.rules,
    required this.isActive,
    required this.firstTimeOnly,
  });

  factory DiscountModel.fromJson(Map<String, dynamic> json) {
    List<String> rulesList = [];

    if (json['rules'] != null) {
      if (json['rules'] is List) {
        rulesList = List<String>.from(json['rules']);
      } else if (json['rules'] is String) {
        final rulesStr = json['rules'] as String;
        if (rulesStr.startsWith('{') && rulesStr.endsWith('}')) {
          final content = rulesStr.substring(1, rulesStr.length - 1);
          if (content.isNotEmpty) {
            rulesList = content
                .split(',')
                .map((e) => e.trim().replaceAll('"', ''))
                .toList();
          }
        } else {
          rulesList = [rulesStr];
        }
      }
    }

    String parsedId = json['id'].toString();

    return DiscountModel(
      id: parsedId,
      title: json['title'],
      code: json['code'],
      percentage: (json['percentage'] as num).toDouble(),
      minAmount: (json['minAmount'] as num).toInt(),
      validUntil: DateTime.parse(json['valid_until']),
      rules: rulesList,
      isActive: json['isActive'],
      firstTimeOnly: json['firstTimeOnly'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'code': code,
      'percentage': percentage,
      'minAmount': minAmount,
      'valid_until': validUntil.toIso8601String(),
      'rules': rules,
      'isActive': isActive,
      'firstTimeOnly': firstTimeOnly,
    };
  }
}
