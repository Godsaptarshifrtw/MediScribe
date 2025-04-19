class LabResultEntry {
  final double value;
  final String status; // e.g., "low", "normal", "high"
  final String normalRange; // e.g., "8.5 - 10.5"

  LabResultEntry({
    required this.value,
    required this.status,
    required this.normalRange,
  });

  Map<String, dynamic> toMap() {
    return {
      'value': value,
      'status': status,
      'normalRange': normalRange,
    };
  }

  factory LabResultEntry.fromMap(Map<String, dynamic> map) {
    return LabResultEntry(
      value: (map['value'] as num).toDouble(),
      status: map['status'] ?? 'unknown',
      normalRange: map['normalRange'] ?? '',
    );
  }
}