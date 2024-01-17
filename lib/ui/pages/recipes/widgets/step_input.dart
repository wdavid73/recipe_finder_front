import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:recipe_finder/ui/managers/color_manager.dart';
import 'package:recipe_finder/ui/managers/responsive_manager.dart';
import 'package:recipe_finder/ui/managers/style_text_manager.dart';
import 'package:recipe_finder/utils/extensions.dart';
import 'package:recipe_finder/widgets/button_custom.dart';
import 'package:recipe_finder/widgets/input_custom.dart';

class StepInput extends StatefulWidget {
  final List<Map<String, dynamic>> steps;
  final String messageError;
  const StepInput({
    super.key,
    required this.steps,
    this.messageError = '',
  });

  @override
  State<StepInput> createState() => _StepInputState();
}

class _StepInputState extends State<StepInput> {
  double calculateHeight() {
    if (widget.steps.isEmpty) {
      return 10;
    } else if (widget.steps.length == 1) {
      return 35;
    } else {
      return 50;
    }
  }

  void addStep() {
    setState(() {
      widget.steps.add({
        'name': '',
        'actions': [],
      });
    });
  }

  void addActionToStep(int index) {
    setState(() {
      widget.steps[index]["actions"].add({
        'action': '',
      });
    });
  }

  void _removeStep(int index) {
    setState(() {
      widget.steps.removeAt(index);
    });
  }

  void _removeAction(int indexStep, int indexAction) {
    setState(() {
      widget.steps[indexStep]["actions"].removeAt(indexAction);
    });
  }

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive(context);
    return Container(
      width: responsive.width,
      height: responsive.hp(calculateHeight()),
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
                itemCount: widget.steps.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: Container(
                      width: responsive.wp(90),
                      padding: const EdgeInsets.all(10),
                      margin: EdgeInsets.only(
                          bottom: index < widget.steps.length - 1 ? 10 : 0),
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                            onChange: (value) {
                              widget.steps[index]["name"] = value;
                            },
                            hint: context.translate('step_name'),
                            label: context.translate('step_name'),
                          ),
                          _headerAction(context, responsive, index),
                          Container(
                            width: responsive.width,
                            height: widget.steps[index]['actions'].isEmpty
                                ? responsive.hp(0)
                                : widget.steps[index]['actions'].length == 1
                                    ? responsive.hp(10)
                                    : responsive.hp(15),
                            margin: const EdgeInsets.only(right: 20, top: 10),
                            child: ListView.builder(
                              itemCount: widget.steps[index]["actions"].length,
                              itemBuilder: (context, indexActions) {
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 8.0),
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
                                          onChange: (value) {
                                            widget.steps[index]['actions']
                                                    [indexActions]["action"] =
                                                value;
                                          },
                                          hint:
                                              "${context.translate('action')} ${indexActions + 1}",
                                          label:
                                              "${context.translate('action')} ${indexActions + 1}",
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () =>
                                            _removeAction(index, indexActions),
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
          widget.messageError != ''
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        widget.messageError,
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
          onPressed: () => addActionToStep(index),
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
          onPressed: () => addStep(),
          icon: const Icon(Icons.add),
          text: context.translate('add_step'),
        ),
      ],
    );
  }
}
