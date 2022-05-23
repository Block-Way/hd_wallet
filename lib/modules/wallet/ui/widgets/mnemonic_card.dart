part of wallet_ui_module;

class MnemonicCard extends StatelessWidget {
  const MnemonicCard({
    @required this.mnemonic,
    this.selected,
    this.onSelect,
  });

  final List<String> mnemonic;
  final List<String> selected;
  final Function(String item) onSelect;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: context.edgeHorizontal,
      child: GridView.builder(
        shrinkWrap: true,
        itemCount: mnemonic.length,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 8, // 上下间距
          crossAxisSpacing: 8, // 左右间距
          childAspectRatio: 2.2, // child width / height
        ),
        itemBuilder: (context, index) {
          final item = mnemonic[index];
          final isSelect = selected != null && selected.contains(item);
          return InkWell(
            borderRadius: context.radiusAll,
            onTap: onSelect != null
                ? () {
                    onSelect(item);
                  }
                : null,
            child: Container(
              decoration: context.boxDecoration(
                color: isSelect ? context.primaryColor : null,
              ),
              child: Stack(
                children: [
                  if (onSelect == null)
                    Positioned(
                      left: 8,
                      bottom: 5,
                      child: Text(
                        '${index < 9 ? '0' : ''}${index + 1}',
                        style: context.textTiny(),
                      ),
                    ),
                  Center(
                    child: Text(
                      item.split('_')[0] ?? '',
                      style: context.textBody(bold: true),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
