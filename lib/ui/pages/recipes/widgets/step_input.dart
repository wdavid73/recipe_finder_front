import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:recipe_finder/data/models/step_recipe.dart';
import 'package:recipe_finder/ui/bloc/bloc_imports.dart';
import 'package:recipe_finder/ui/bloc/create_recipe/create_recipe_bloc.dart';
import 'package:recipe_finder/ui/managers/color_manager.dart';
import 'package:recipe_finder/ui/managers/responsive_manager.dart';
import 'package:recipe_finder/ui/managers/style_text_manager.dart';
import 'package:recipe_finder/utils/extensions.dart';
import 'package:recipe_finder/widgets/button_custom.dart';
import 'package:recipe_finder/widgets/input_custom.dart';

class StepInput extends StatefulWidget {
  const StepInput({
    super.key,
  });

  @override
  State<StepInput> createState() => _StepInputState();
}

class _StepInputState extends State<StepInput> {
  Timer? _debounce;
  final Duration _debounceDuration = const Duration(seconds: 1);
  /* double calculateHeight() {
    if (widget.steps.isEmpty) {
      return 10;
    } else if (widget.steps.length == 1) {
      return 35;
    } else {
      return 50;
    }
  } */

  void _addStep() {
    final bloc = BlocProvider.of<CreateRecipeBloc>(context);
    bloc.add(const SetStepEvent(
      step: StepRecipe(),
    ));
  }

  void _updateStepName(String name, int index) {
    if (_debounce?.isActive ?? false) {
      _debounce?.cancel();
    }

    _debounce = Timer(_debounceDuration, () {
      final bloc = BlocProvider.of<CreateRecipeBloc>(context);
      bloc.add(UpdateStepNameEvent(name: name, indexStep: index));
    });
  }

  void _removeStep(int index) {
    final bloc = BlocProvider.of<CreateRecipeBloc>(context);
    bloc.add(RemoveStepEvent(index: index));
  }

  void _addActionToStep(int index) {
    final bloc = BlocProvider.of<CreateRecipeBloc>(context);
    bloc.add(AddActionToStepEvent(indexStep: index));
  }

  void _updateActionName(String name, int indexStep, int indexAction) {
    if (_debounce?.isActive ?? false) {
      _debounce?.cancel();
    }
    _debounce = Timer(_debounceDuration, () {
      final bloc = BlocProvider.of<CreateRecipeBloc>(context);
      bloc.add(
        UpdateActionNameInStepEvent(
          name: name,
          indexStep: indexStep,
          indexAction: indexAction,
        ),
      );
    });
  }

  void _removeAction(int indexStep, int indexAction) {
    final bloc = BlocProvider.of<CreateRecipeBloc>(context);
    bloc.add(RemoveActionEvent(indexStep: indexStep, indexAction: indexAction));
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive(context);
    return BlocBuilder<CreateRecipeBloc, CreateRecipeState>(
      builder: (context, state) {
        return Container(
          width: responsive.width,
          height: responsive.hp(40),
          padding: const EdgeInsets.symmetric(
            horizontal: 10.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              _header(context, responsive),
              Expanded(
                child: Container(
                  width: responsive.width,
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  child: ListView.builder(
                    itemCount: state.steps.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: Container(
                          width: responsive.wp(90),
                          padding: const EdgeInsets.all(10),
                          margin: EdgeInsets.only(
                              bottom: index < state.steps.length - 1 ? 10 : 0),
                          child: Column(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Text(
                                    "${context.translate('step')} #${index + 1}",
                                    style: getSemiBoldStyle(
                                      fontSize: responsive.dp(1.6),
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () => _removeStep(index),
                                    icon: const Icon(Icons.close),
                                    padding: EdgeInsets.zero,
                                    alignment: Alignment.centerRight,
                                  ),
                                ],
                              ),
                              InputCustom(
                                onChange: (value) =>
                                    _updateStepName(value, index),
                                hint: context.translate('step_name'),
                                label: context.translate('step_name'),
                              ),
                              _headerAction(context, responsive, index),
                              Container(
                                width: responsive.width,
                                height: state.steps[index].actions.isEmpty
                                    ? responsive.hp(0)
                                    : state.steps[index].actions.length == 1
                                        ? responsive.hp(10)
                                        : responsive.hp(15),
                                margin:
                                    const EdgeInsets.only(right: 20, top: 10),
                                child: ListView.builder(
                                  itemCount: state.steps[index].actions.length,
                                  itemBuilder: (context, indexActions) {
                                    return Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 8.0),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Expanded(
                                            child: InputCustom(
                                              bottomPadding: 0,
                                              onChange: (value) =>
                                                  _updateActionName(value,
                                                      index, indexActions),
                                              hint:
                                                  "${context.translate('action')} ${indexActions + 1}",
                                              label:
                                                  "${context.translate('action')} ${indexActions + 1}",
                                            ),
                                          ),
                                          IconButton(
                                            onPressed: () => _removeAction(
                                                index, indexActions),
                                            icon: const Icon(
                                              Icons.close,
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              state.stepError != ''
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            state.stepError,
                            textAlign: TextAlign.left,
                            style: getRegularStyle(
                              color: ColorManager.error,
                            ),
                          ),
                        ),
                        const Gap(10),
                      ],
                    )
                  : const SizedBox.shrink(),
            ],
          ),
        );
      },
    );
  }

  Widget _headerAction(BuildContext context, Responsive responsive, int index) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.max,
      children: [
        Text(
          context.translate('step_action'),
          style: getSemiBoldStyle(
            fontSize: responsive.dp(1.6),
          ),
        ),
        ButtonCustom(
          onPressed: () => _addActionToStep(index),
          text: context.translate('add_step'),
          fontSize: responsive.dp(1.5),
          height: 30,
          icon: Icon(
            Icons.add,
            size: responsive.dp(2),
          ),
        ),
      ],
    );
  }

  Widget _header(BuildContext context, Responsive responsive) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.max,
      children: [
        Text(
          context.translate('steps'),
          style: getMediumStyle(
            fontSize: responsive.dp(1.6),
          ),
        ),
        ButtonCustom(
          onPressed: () => _addStep(),
          icon: const Icon(Icons.add),
          text: context.translate('add_step'),
        ),
      ],
    );
  }
}
