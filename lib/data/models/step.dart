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

  @override
  String toString() {
    return "StepAction: $name";
  }
}
