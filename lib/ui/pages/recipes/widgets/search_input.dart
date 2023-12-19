import 'package:flutter/material.dart';
import 'package:recipe_finder/ui/managers/color_manager.dart';
import 'package:recipe_finder/ui/managers/responsive_manager.dart';
import 'package:recipe_finder/ui/managers/style_text_manager.dart';

class SearchInputCustom extends StatefulWidget {
  final List<dynamic> items;
  final double? width;
  final SearchController searchController;
  final String barHintText;
  final String viewHintText;
  const SearchInputCustom({
    super.key,
    required this.searchController,
    this.items = const [],
    this.width,
    required this.barHintText,
    required this.viewHintText,
  });

  @override
  State<SearchInputCustom> createState() => _SearchInputCustomState();
}

class _SearchInputCustomState extends State<SearchInputCustom> {
  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive(context);
    return SizedBox(
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
          final keyword = controller.value.text;

          return List.generate(
            widget.items.length,
            (index) => widget.items[index]['name'],
          )
              .where((element) => element.toLowerCase().startsWith(
                    keyword.toLowerCase(),
                  ))
              .map(
                (item) => GestureDetector(
                  onTap: () {
                    setState(() => controller.closeView(item));
                  },
                  child: ListTile(
                    title: Text(
                      item,
                      style: getRegularStyle(),
                    ),
                    onTap: () {
                      setState(() {
                        controller.closeView(item);
                        FocusScope.of(context).unfocus();
                      });
                    },
                  ),
                ),
              );
        },
      ),
    );
  }
}
