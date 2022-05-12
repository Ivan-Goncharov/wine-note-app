import 'package:flutter/material.dart';
import 'package:flutter_my_wine_app/widgets/system_widget/toast_message.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../models/wine_item.dart';

//виджет для создания нижней панели для фильтрации вин по регионам
class RegionBottomSheet extends StatefulWidget {
  //принимает список регионов и функцию для сохранения ввода
  final List<String> regions;
  final Function saveRegion;
  final String selectRegion;
  const RegionBottomSheet({
    Key? key,
    required this.regions,
    required this.saveRegion,
    required this.selectRegion,
  }) : super(key: key);

  @override
  State<RegionBottomSheet> createState() => _RegionBottomSheetState();
}

class _RegionBottomSheetState extends State<RegionBottomSheet> {
  String regionSelect = '';
  late FToast _fToast;
  @override
  void initState() {
    regionSelect = widget.selectRegion;
    _fToast = FToast();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final colorScheme = Theme.of(context).colorScheme;

    _fToast.init(context);
    return Container(
      height: size.height * 0.4,
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: colorScheme.surfaceVariant,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(child: Container()),
              //заголовок
              Expanded(
                child: Text(
                  'Регионы',
                  style: TextStyle(
                    color: colorScheme.onSurfaceVariant,
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                  ),
                ),
              ),

              //кнопка для сброса выбора фильтра
              TextButton(
                onPressed: () {
                  setState(() {
                    regionSelect = '';
                    widget.saveRegion(
                      WineNoteFields.region,
                      regionSelect,
                    );
                  });
                },
                child: Text(
                  'Очистить',
                  textAlign: TextAlign.end,
                  style: TextStyle(color: colorScheme.tertiary, fontSize: 16),
                ),
              ),
            ],
          ),
          SizedBox(
            height: size.height * 0.3,
            width: size.width * 0.5,
            child: ListView.builder(
              itemBuilder: (context, index) {
                final itemReg = widget.regions[index];
                return GestureDetector(
                  onTap: () {
                    //при нажатии на контейнер с названием региона - проверяем выбран ли уже регион
                    //если уже выбран, то снимаем выбор
                    if (regionSelect == itemReg) {
                      setState(() {
                        regionSelect = '';
                        widget.saveRegion(WineNoteFields.region, regionSelect);
                      });
                    }

                    // если еще не выбран, то выбираем
                    else {
                      setState(() {
                        regionSelect = itemReg;
                        widget.saveRegion(WineNoteFields.region, regionSelect);
                      });
                      Navigator.pop(context);

                      //показываем сообщение о выполненной фильтрации
                      _fToast.showToast(
                          child: ToastMessage(
                            message: 'На экране вина региона: $regionSelect',
                            iconData: Icons.tune,
                          ),
                          toastDuration: const Duration(seconds: 4));
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    height: size.height * 0.065,
                    margin: const EdgeInsets.all(4.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),

                      //применяем цвет рамки, взависимости от того, выбран ли фильтр или нет
                      border: Border.all(
                        color: itemReg == regionSelect
                            ? colorScheme.primary
                            : colorScheme.onSurfaceVariant,
                      ),
                    ),
                    child: Row(
                      children: [
                        //название региона
                        Expanded(
                          child: Text(
                            itemReg,
                            style: TextStyle(
                              //цвет зависит от того - выбран ли регион или нет
                              color: itemReg == regionSelect
                                  ? colorScheme.primary
                                  : colorScheme.onSurfaceVariant,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),

                        //иконка галочки выводится в том случае, если фильтр выбран
                        itemReg == regionSelect
                            ? Icon(
                                Icons.done,
                                color: colorScheme.primary,
                              )
                            : const SizedBox(),
                      ],
                    ),
                  ),
                );
              },
              itemCount: widget.regions.length,
            ),
          ),
        ],
      ),
    );
  }
}
