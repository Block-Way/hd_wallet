part of project_ui_module;

class ProjectApplySubmitPage extends HookWidget {
  ProjectApplySubmitPage(this.createParams, {Key key}) : super(key: key);

  static const routeName = '/project/apply/submit';

  static Future<dynamic> open(ProjectCreateParams createParams) {
    return AppNavigator.push(
      routeName,
      params: createParams,
    );
  }

  static Route<dynamic> route(RouteSettings settings) {
    return DefaultTransition(
      settings,
      ProjectApplySubmitPage(settings.arguments as ProjectCreateParams),
    );
  }

  final ProjectCreateParams createParams;

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final remainMonth = useState('');
    final remainAmount = useState('');
    final mintCount = useState(1);
    final autovalidate = useState(false);
    final isOpenPool = useState(
      createParams.poolEnable,
    );
    final poolInitAmount = useTextEditingController(
      text: createParams.poolInitAmount,
    );
    final poolMinCurrency = useTextEditingController(
      text: createParams.poolMinCurrency,
    );
    final poolCycle = useTextEditingController(
      text: createParams.poolCycle,
    );

    final mintList = useState(
      createParams.mintList.toList(),
    );

    String getMintRemainMonths() {
      return createParams
          .getMintRemainMonths(mintList.value, poolCycle.text)
          .toString();
    }

    String getMintRemainAmount() {
      return createParams.getMintRemainAmount(
          mintList.value, poolInitAmount.text);
    }

    ProjectCreateParams getUpdatedProjectParams() {
      return createParams.setPool(
        poolInitAmount: poolInitAmount.text == '' ? '0' : poolInitAmount.text,
        poolMinCurrency: poolMinCurrency.text,
        poolCycle: poolCycle.text == '' ? '0' : poolCycle.text,
        poolEnable: isOpenPool.value,
        minBalance: poolMinCurrency.text,
        remainMonths: getMintRemainMonths(),
        remainAmount: getMintRemainAmount(),
        mintList: createParams.cacheMintConfig(mintList.value),
      );
    }

    useEffect(() {
      remainMonth.value = getMintRemainMonths();
      remainAmount.value = getMintRemainAmount();
      mintCount.value = mintList.value.length;
      return;
    }, []);

    void doSubmit(ProjectApplyVM viewModel) {
      if (isOpenPool.value) {
        final isValid = formKey.currentState.validate();

        if (!autovalidate.value) {
          autovalidate.value = true;
        }

        if (!isValid) {
          return;
        }
        final firstList = mintList.value.first;

        if (firstList.month == '' || firstList.ratio == '') {
          Toast.show(tr('project:create_tips_pool'));
          return;
        }

        if (NumberUtil.isLess(getMintRemainMonths(), 0)) {
          Toast.show(tr('project:create_tips_month'));
          return;
        }

        if (NumberUtil.isLess(getMintRemainAmount(), 0)) {
          Toast.show(tr('project:create_tips_amount'));
          return;
        }

        formKey.currentState.save();
      }

      final newParams = getUpdatedProjectParams();

      LoadingDialog.show(context);
      viewModel.doSubmitCreateProject(newParams).then(
        (_) {
          LoadingDialog.dismiss(context);
          viewModel.doSaveToCache(ProjectCreateParams());
          showAlertDialog(
            context,
            content: tr('project:create_tips_success'),
            onDismiss: () {
              AppNavigator.gotoTabBar();
            },
          );
        },
      ).catchError((error) {
        LoadingDialog.dismiss(context);
        viewModel.doSaveToCache(newParams);
        Toast.showError(error);
      }).whenComplete(() {
        LoadingDialog.dismiss(context);
      });
    }

    bool _onWillPop(ProjectApplyVM viewModel) {
      final newParams = getUpdatedProjectParams();
      viewModel.doSaveToCache(newParams);
      Navigator.pop(context, newParams);
      return false;
    }

    return StoreConnector<AppState, ProjectApplyVM>(
      distinct: true,
      converter: ProjectApplyVM.fromStore,
      builder: (context, viewModel) => WillPopScope(
        onWillPop: () async {
          return _onWillPop(viewModel);
        },
        child: CSScaffold(
          title: tr('project:create_title_apply'),
          backgroundColor: context.whiteColor,
          scrollable: true,
          child: Form(
            key: formKey,
            autovalidateMode: autovalidate.value
                ? AutovalidateMode.onUserInteraction
                : AutovalidateMode.disabled,
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        width: 5,
                        color: context.bgSecondaryColor,
                      ),
                    ),
                  ),
                  child: Padding(
                    padding: context.edgeAll,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          tr('project:create_lbl_enable_pool'),
                          style: context.textBody(
                            bold: true,
                            color: context.labelColor,
                          ),
                        ),
                        CSSwitch(
                          onChanged: (value) {
                            isOpenPool.value = value;
                          },
                          value: isOpenPool.value,
                        ),
                      ],
                    ),
                  ),
                ),
                Opacity(
                  opacity: isOpenPool.value ? 1 : 0.5,
                  child: Column(
                    children: [
                      FormBox(
                        type: FormBoxType.inputNumber,
                        controller: poolInitAmount,
                        title: tr('project:create_lbl_init_amount'),
                        hintText: tr('project:create_input_init_amount'),
                        editable: isOpenPool.value,
                        onChanged: (value) {
                          remainAmount.value = getMintRemainAmount();
                        },
                        iconWidget: Text(
                          tr('project:create_lbl_symbol'),
                          style: context.textBody(bold: true),
                        ),
                        validator: RequiredValidator(
                            errorText: tr('project:create_input_init_amount')),
                        inputFormatters: [
                          NumberTextInputFormatter(
                            maxInteger: 20,
                            maxDecimal: 8,
                          ),
                        ],
                      ),
                      FormBox(
                        type: FormBoxType.inputNumber,
                        controller: poolMinCurrency,
                        title: tr('project:create_lbl_min_amount'),
                        hintText: tr('project:create_input_min_amount'),
                        editable: isOpenPool.value,
                        iconWidget: Text(
                          tr('project:create_lbl_symbol'),
                          style: context.textBody(bold: true),
                        ),
                        inputFormatters: [
                          NumberTextInputFormatter(
                            maxInteger: 20,
                            maxDecimal: 8,
                          ),
                        ],
                        validator: RequiredValidator(
                            errorText: tr('project:create_input_min_amount')),
                      ),
                      FormBox(
                        type: FormBoxType.inputNumber,
                        controller: poolCycle,
                        title: tr('project:create_lbl_pool_cycle'),
                        hintText: tr('project:create_input_pool_cycle'),
                        editable: isOpenPool.value,
                        iconWidget: Text(
                          tr('global:lbl_month'),
                          style: context.textBody(bold: true),
                        ),
                        onChanged: (value) {
                          remainMonth.value = getMintRemainMonths();
                        },
                        inputFormatters: [
                          NumberTextInputFormatter(
                            maxInteger: 8,
                            maxDecimal: 8,
                          ),
                        ],
                        validator: RequiredValidator(
                            errorText: tr('project:create_input_pool_cycle')),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: context.edgeHorizontal,
                            child: Text(
                              tr('project:create_lbl_pool'),
                              style: context.textBody(
                                bold: true,
                                color: context.labelColor,
                              ),
                            ),
                          ),
                          ...mintList.value.asMap().entries.map(
                                (entry) => ProjectPoolPlanItem(
                                  key: Key('${entry.value.index}'),
                                  item: entry.value,
                                  editable: isOpenPool.value,
                                  onPress: (index) {
                                    mintCount.value = mintCount.value - 1;
                                    mintList.value =
                                        createParams.removeMintConfig(
                                      mintList.value,
                                      entry.key,
                                    );
                                    remainMonth.value = getMintRemainMonths();
                                    remainAmount.value = getMintRemainAmount();
                                  },
                                  monthCallback: (month, index) {
                                    mintList.value =
                                        createParams.updateMintConfig(
                                      mintList.value,
                                      entry.key,
                                      month: month,
                                    );
                                    remainAmount.value = getMintRemainAmount();
                                    remainMonth.value = getMintRemainMonths();
                                  },
                                  ratioCallback: (ratio, index) {
                                    mintList.value =
                                        createParams.updateMintConfig(
                                      mintList.value,
                                      entry.key,
                                      ratio: ratio,
                                    );
                                    remainMonth.value = getMintRemainMonths();
                                    remainAmount.value = getMintRemainAmount();
                                  },
                                ),
                              ),
                        ],
                      ),
                      labelItem(
                        context,
                        name: tr('project:create_lbl_pool_amount'),
                        label: remainAmount.value ?? '0.00',
                      ),
                      labelItem(
                        context,
                        name: tr('project:create_lbl_month'),
                        label: remainMonth.value,
                      ),
                      CSButton(
                        label: tr('project:create_btn_add', namedArgs: {
                          'amount': mintCount.value.toString(),
                        }),
                        width: context.mediaWidth - context.edgeSizeDouble,
                        borderRadius: 10,
                        backgroundColor: Color(0xFFfff3ea),
                        textColor: Color(0xffff8c2e),
                        onPressed: () {
                          if (!isOpenPool.value) {
                            return;
                          } else {
                            if (mintCount.value == 5) {
                              Toast.show(tr('project:create_tips_add'));
                              return;
                            }
                            mintCount.value = mintCount.value + 1;

                            final list = [...mintList.value];
                            list.add(ProjectCreateMint(
                              month: '',
                              ratio: '',
                              index: mintCount.value,
                            ));
                            mintList.value = [...list];
                          }
                        },
                      ),
                    ],
                  ),
                ),
                CSButton(
                  label: tr('project:create_btn_submit'),
                  onPressed: () {
                    doSubmit(viewModel);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget labelItem(BuildContext context, {String name, String label}) {
  return Padding(
    padding: EdgeInsets.only(
      top: 20,
      left: context.edgeSize,
      right: context.edgeSize,
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          name,
          style: context.textSecondary(),
        ),
        Text(
          label,
          style: context.textSecondary(
            bold: true,
            color: context.bodyColor,
          ),
        ),
      ],
    ),
  );
}
