part of app_module;

class AppDrawerMenuLanguage extends HookWidget {
  const AppDrawerMenuLanguage({
    @required this.onSelected,
    Key key,
  }) : super(key: key);

  final void Function(String) onSelected;

  @override
  Widget build(BuildContext context) {
    final isExpanded = useState(false);
    final currentLangCode = context.locale.languageCode;

    return CSExpansionTile(
      tileMargin: context.edgeAll.copyWith(bottom: 2),
      tilePadding: EdgeInsets.all(15),
      tileRadius: 16,
      childrenPadding: context.edgeAll,
      expandedAlignment: Alignment.topLeft,
      onExpansionChanged: (state) {
        isExpanded.value = state;
      },
      title: Text(
        tr('user:menu_language'),
        style: context.textBody(bold: true),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: context.bgSecondaryColor,
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(16),
          ),
        ),
        width: double.infinity,
        height: context.mediaHeight * 0.2,
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: AppLanguages.languages.length,
          itemBuilder: (context, index) => FormCell(
            hideAccess: true,
            height: 50,
            showBorderTop: index != 0,
            borderTop: BorderSide(
              color: context.greyColor,
            ),
            label: AppLanguages.languages[index].name,
            onPress: () {
              onSelected(AppLanguages.languages[index].languageCode);
              Navigator.pop(context);
            },
            cmpRight: Container(
              decoration: CheckDecorator(
                isCheck: currentLangCode ==
                    AppLanguages.languages[index].languageCode,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
