class StepData {
  final int? id;
  final String? name;
  final int? state;
  final int? recipeId;
  final List<StepAction> actions;

  const StepData({
    this.name,
    this.id,
    this.state,
    this.recipeId,
    this.actions = const [],
  });

  factory StepData.fromJson(Map<String, dynamic> json) {
    return StepData(
      id: json['id'] as int?,
      name: json['name'] as String?,
      state: json['state'] as int?,
      recipeId: json['recipe_id'] as int?,
      actions: parseStepActions(json['actions']),
    );
  }

  @override
  String toString() {
    return "Step: $name";
  }
}

class StepAction {
  final int? id;
  final String? name;
  final int? state;

  const StepAction({
    this.name,
    this.id,
    this.state,
  });

  factory StepAction.fromJson(Map<String, dynamic> json) {
    return StepAction(
      id: json['id'] as int?,
      name: json['action'] as String?,
      state: json['state'] as int?,
    );
  }

  @override
  String toString() {
    return "StepAction: $name";
  }
}

List<StepData> parseStep(List<dynamic> data) =>
    data.map<StepData>((json) => StepData.fromJson(json)).toList();

List<StepAction> parseStepActions(List<dynamic> data) =>
    data.map<StepAction>((json) => StepAction.fromJson(json)).toList();
