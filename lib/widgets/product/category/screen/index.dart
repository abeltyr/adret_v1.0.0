import 'package:adret/model/input/index.dart';
import 'package:adret/model/productView/index.dart';
import 'package:adret/services/product/actions/category.dart';
import 'package:adret/utils/text.dart';
import 'package:adret/utils/theme.dart';
import 'package:adret/widgets/header/textHeader/index.dart';
import 'package:adret/widgets/input/input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hive/hive.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CategoryInventory extends StatefulWidget {
  const CategoryInventory({super.key});

  @override
  State<CategoryInventory> createState() => _CategoryInventoryState();
}

class _CategoryInventoryState extends State<CategoryInventory> {
  late TextEditingController _categoryController;
  var companyCategory = Hive.box('companyCategory');

  List<String> categories = [];
  @override
  void initState() {
    super.initState();

    var data = companyCategory.get("current", defaultValue: []);
    if (data.isNotEmpty) categories = data;
    _categoryController = TextEditingController(text: "");
  }

  @override
  void dispose() {
    super.dispose();
    _categoryController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var hiveProduct = Hive.box<ProductViewModel>('productView');
    ProductViewModel hiveData =
        hiveProduct.get("currentProduct", defaultValue: ProductViewModel())!;

    InputModel category = hiveData.category ?? InputModel();

    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
        color: DarkModePlatformTheme.secondBlack,
      ),
      height: MediaQuery.of(context).size.height * 2 / 3,
      width: MediaQuery.of(context).size.width,
      padding: MediaQuery.of(context).viewInsets,
      child: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          TextHeader(
            closeText: AppLocalizations.of(context)!.cancel,
            centerText: AppLocalizations.of(context)!.addCategory,
            actionText: AppLocalizations.of(context)!.add,
            actionFunction: () {
              var textData = _categoryController.text.trim().toLowerCase();
              if (textData.isEmpty || textData.length > 14) {
                category.errorStatus = true;
                category.errorMessage = textData.length > 14
                    ? AppLocalizations.of(context)!.categoryTextToLong
                    : AppLocalizations.of(context)!.categoryTextError;
                setState(() {});
                return null;
              }
              if (textData.isNotEmpty && textData.length <= 14) {
                category.errorStatus = false;
                category.errorMessage = "";
              }
              updateCategory(
                data: textData,
              );
              if (!categories.contains(textData)) {
                var newData = [...categories, textData];
                companyCategory.put("current", newData);
              }
              Navigator.pop(context);
            },
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 0),
            color: DarkModePlatformTheme.secondBlack,
            child: Input(
              onChanged: (value) {
                var textData = value.trim();
                if (category.errorStatus &&
                    value.isNotEmpty &&
                    value.length <= 14) {
                  category.errorStatus = false;
                  category.errorMessage = null;
                  setState(() {});
                }
                if (value.length > 14) {
                  category.errorStatus = true;
                  category.errorMessage =
                      AppLocalizations.of(context)!.categoryTextToLong;
                  _categoryController.text = category.input;
                  _categoryController.selection =
                      TextSelection.fromPosition(TextPosition(
                    offset: _categoryController.text.length,
                  ));
                  textData = value.substring(0, 14);
                  if (category.input != null) {}
                  setState(() {});
                }
                category.input = textData;
              },
              valueSetter: () {
                return category;
              },
              textInputAction: TextInputAction.done,
              icon: "assets/icons/tag.svg",
              controller: _categoryController,
              divider: true,
              label: AppLocalizations.of(context)!.addCategory,
              ratio1: 1.1,
              ratio2: 10.9,
              size: 22,
              borderPadding: 0,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent:
                    (MediaQuery.of(context).size.width - 40) / 1.5,
                mainAxisSpacing: 10.0,
                crossAxisSpacing: 10.0,
                childAspectRatio: 4,
              ),
              itemCount: categories.length,
              itemBuilder: ((context, index) {
                return Padding(
                  padding: EdgeInsets.only(
                    left: index % 2 == 0 ? 20 : 0,
                    right: index % 2 != 0 ? 20 : 0,
                  ),
                  child: GestureDetector(
                    onTap: () {
                      category.input = categories[index];
                      category.errorStatus = false;
                      _categoryController.text = categories[index];
                      setState(() {});
                    },
                    child: Dismissible(
                      onDismissed: (value) {},
                      confirmDismiss: (direction) async {
                        if (direction == DismissDirection.endToStart) {
                          List<String> all =
                              companyCategory.get("current", defaultValue: [])!;
                          if (index < all.length) {
                            all.removeAt(index);
                            companyCategory.put("current", all);
                            setState(() {
                              categories = all;
                            });
                          }
                        }
                        return true;
                      },
                      direction: DismissDirection.endToStart,
                      background: Container(
                        decoration: BoxDecoration(
                          color: DarkModePlatformTheme.negativeLight3,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Container(
                          padding: const EdgeInsets.only(
                            right: 20,
                          ),
                          alignment: Alignment.centerRight,
                          child: SizedBox(
                            width: 30,
                            child: SvgPicture.asset(
                              "assets/icons/delete.svg",
                              width: 27.5,
                              height: 27.5,
                              color: DarkModePlatformTheme.negativeDark1,
                            ),
                          ),
                        ),
                      ),
                      key: UniqueKey(),
                      child: Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          color: DarkModePlatformTheme.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: LayoutBuilder(builder: (context, snapshot) {
                          return Container(
                            alignment: Alignment.center,
                            height: 40,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  "assets/icons/tag.svg",
                                  width: 25,
                                  height: 25,
                                  color: DarkModePlatformTheme.thirdBlack,
                                ),
                                const SizedBox(
                                  width: 2.5,
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  height: 40,
                                  width: categories[index].length *
                                              (categories[index].length > 5
                                                  ? 8
                                                  : 11) >
                                          snapshot.maxWidth - 40
                                      ? snapshot.maxWidth - 40
                                      : categories[index].length *
                                          (categories[index].length > 5
                                              ? 8
                                              : 11),
                                  child: FittedBox(
                                    fit: BoxFit.scaleDown,
                                    child: Text(
                                      capitalize(categories[index]),
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        fontFamily: 'Nunito',
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: DarkModePlatformTheme.thirdBlack,
                                      ),
                                      maxLines: 2,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
