class StepRecipe {
  final String name;
  final List<ActionStepRecipe> actions;

  const StepRecipe({
    this.name = '',
    this.actions = const [],
  });

  StepRecipe copyWith({String? name, List<ActionStepRecipe>? actions}) {
    return StepRecipe(
      name: name ?? this.name,
      actions: actions ?? this.actions,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'actions': actions.map((e) => e.toJson()).toList(),
    };
  }

  @override
  String toString() {
    return "Step: $name, $actions";
  }
}

class ActionStepRecipe {
  final String name;

  const ActionStepRecipe({
    this.name = '',
  });

  ActionStepRecipe copyWith({String? name}) {
    return ActionStepRecipe(
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'action': name,
    };
  }

  @override
  String toString() {
    return "Action: $name";
  }
}
