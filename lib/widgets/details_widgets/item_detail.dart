//виджет для вывода одного свойства заметки
import 'package:flutter/material.dart';

//один элемент в детальном описании вина
class ItemDetailInfo extends StatelessWidget {
  //информация, заполненная пользователем
  final String info;
  final String title;

  //необходимо ли иметь возможность тапа по информации
  //для расширения экрана
  final bool isTap;

  //иконка свойства
  final IconData icon;
  const ItemDetailInfo({
    Key? key,
    required this.info,
    required this.icon,
    required this.title,
    required this.isTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //проверяем, заполнено ли свойство
    //если да, то выводим иконоку и информацию
    if (info.isNotEmpty) {
      //проверяем - должен ли работать тап по свойству
      return isTap

          //если должен - то выводим свойства с возможностью перехода
          // в окно с подробным описанием свойства
          ? InkWell(
              onTap: () {
                showGeneralDialog(
                  context: context,
                  pageBuilder: (context, animOne, animTwo) {
                    return const SizedBox();
                  },
                  transitionBuilder: (context, animOne, animTwo, widget) {
                    return Transform.scale(
                      scale: animOne.value,
                      child: Opacity(
                        opacity: animOne.value,
                        child: Dialog(
                          backgroundColor: Colors.transparent,
                          child: DetailDescription(info: info, title: title),
                        ),
                      ),
                    );
                  },
                  transitionDuration: const Duration(milliseconds: 150),
                  barrierDismissible: true,
                  barrierLabel: '',
                  barrierColor: Colors.transparent,
                );
              },
              child: InfoContainer(info: info, title: title, icon: icon),
            )

          //иначе просто выводим заголовок и информацию
          : InfoContainer(info: info, title: title, icon: icon);

      //если информация не заполнена, то ничего не выводим
    } else {
      return const SizedBox.shrink();
    }
  }
}

// заголовок и данные
class InfoContainer extends StatelessWidget {
  final String info;
  final String title;
  final IconData icon;

  const InfoContainer(
      {Key? key, required this.info, required this.title, required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _colors = Theme.of(context).colorScheme;
    return Container(
      decoration: BoxDecoration(
        color: _colors.surfaceVariant,
        borderRadius: BorderRadius.circular(8.0),
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 8,
      ),
      margin: const EdgeInsets.symmetric(
        horizontal: 4,
        vertical: 4,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 4, bottom: 6.0),

            //заголовок
            child: Text(
              title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: _colors.onSurfaceVariant,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),

          //контейнер с информацией по данному типу
          Container(
            decoration: BoxDecoration(
              color: _colors.onSurfaceVariant,
              borderRadius: BorderRadius.circular(8.0),
            ),
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
            child: LayoutBuilder(
              builder: (ctx, BoxConstraints constraints) {
                return Row(
                  children: [
                    //иконка
                    Container(
                      padding: const EdgeInsets.only(right: 5),
                      width: constraints.maxWidth * 0.1,
                      child: Icon(
                        icon,
                        color: _colors.surfaceVariant,
                      ),
                    ),

                    //информаця
                    SizedBox(
                      width: constraints.maxWidth * 0.9 - 5,
                      child: Text(
                        info,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: _colors.surfaceVariant,
                        ),
                        softWrap: true,
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

//виджет, который открывается при нажатии на аромат/вкус/комментарий,
//чтобы прочитать подробный отчет
class DetailDescription extends StatelessWidget {
  final String info;
  final String title;
  const DetailDescription({Key? key, required this.info, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // лимитируем высоту виджета
    return LimitedBox(
      maxHeight: MediaQuery.of(context).size.height * 0.4,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surfaceVariant,
          borderRadius: BorderRadius.circular(8.0),
        ),
        padding: const EdgeInsets.all(20),
        margin: const EdgeInsets.all(8.0),
        child: SizedBox(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //заголовок
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Text(
                  title,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                  ),
                ),
              ),

              //прокручиваемый бокс с подробной информацией
              LimitedBox(
                maxHeight: MediaQuery.of(context).size.height * 0.3,
                child: SingleChildScrollView(
                  child: Text(
                    info,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                      fontWeight: FontWeight.w400,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
