import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:recipe_finder/ui/managers/color_manager.dart';
import 'package:recipe_finder/ui/managers/responsive_manager.dart';

class SearchInputCustom extends StatefulWidget {
  final List<dynamic> items;
  final double? width;
  final SearchController searchController;
  final String barHintText;
  final String viewHintText;
  final bool loading;
  final dynamic Function(dynamic value) itemBuilder;
  const SearchInputCustom({
    super.key,
    required this.searchController,
    this.items = const [],
    this.loading = false,
    this.width,
    required this.barHintText,
    required this.viewHintText,
    required this.itemBuilder,
  });

  @override
  State<SearchInputCustom> createState() => _SearchInputCustomState();
}

class _SearchInputCustomState extends State<SearchInputCustom> {
  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive(context);
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: Column(
        children: [
          Opacity(
            opacity: widget.loading ? 0.5 : 1,
            child: AbsorbPointer(
              absorbing: widget.loading,
              child: SizedBox(
                width: widget.width ?? responsive.wp(90),
                height: 50,
                child: SearchAnchor.bar(
                  searchController: widget.searchController,
                  barLeading: Icon(
                    Icons.search,
                    color: ColorManager.textSecondary,
                  ),
                  barHintText: widget.barHintText,
                  constraints: BoxConstraints(
                    maxWidth: responsive.width,
                  ),
                  viewTrailing: [
                    IconButton(
                      icon: Icon(
                        Icons.close,
                        color: ColorManager.textSecondary,
                      ),
                      onPressed: () => widget.searchController.clear(),
                    ),
                  ],
                  viewLeading: IconButton(
                    onPressed: () {
                      FocusNode tempFocusNode = FocusNode();
                      FocusScope.of(context).requestFocus(tempFocusNode);
                      Future.delayed(const Duration(milliseconds: 50), () {
                        widget.searchController
                            .closeView(widget.searchController.value.text);
                        FocusScope.of(context).requestFocus(tempFocusNode);
                      });
                    },
                    icon: Icon(Icons.adaptive.arrow_back),
                  ),
                  viewHintText: widget.viewHintText,
                  viewConstraints: const BoxConstraints(
                    maxWidth: 300,
                    maxHeight: 300,
                  ),
                  suggestionsBuilder:
                      (BuildContext context, SearchController controller) {
                    return List.generate(
                      widget.items.length,
                      (index) => widget.items[index],
                    ).map(
                      (dynamic item) => widget.itemBuilder(item),
                    );
                  },
                ),
              ),
            ),
          ),
          const Gap(10),
          widget.loading
              ? SizedBox(
                  width: widget.width ?? responsive.wp(90),
                  child: LinearProgressIndicator(
                    borderRadius: BorderRadius.circular(12),
                  ),
                )
              : const SizedBox.shrink(),
        ],
      ),
    );
  }
}

/* .where((element) => element
                          .toLowerCase()
                          .startsWith(keyword.toLowerCase())) */