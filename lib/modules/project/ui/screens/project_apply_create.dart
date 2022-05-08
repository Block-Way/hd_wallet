part of project_ui_module;

class ProjectApplyCreatePage extends HookWidget {
  ProjectApplyCreatePage(
    this.defaultCreateParams, {
    Key key,
  }) : super(key: key);

  static const routeName = '/project/apply/create';

  static void open(ProjectCreateParams createParams, {bool replace}) {
    AppNavigator.push(
      routeName,
      params: createParams,
      replace: replace,
    );
  }

  static Route<dynamic> route(RouteSettings settings) {
    return DefaultTransition(
      settings,
      ProjectApplyCreatePage(settings.arguments as ProjectCreateParams),
    );
  }

  final ProjectCreateParams defaultCreateParams;

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final createParamsState = useState(defaultCreateParams);
    final createParams = createParamsState.value;
    final autovalidate = useState(false);
    final projectName = useTextEditingController(
      text: createParams.projectName,
    );
    final coinName = useTextEditingController(
      text: createParams.coinName,
    );
    final price = useTextEditingController(
      text: createParams.price,
    );
    final amount = useTextEditingController(
      text: createParams.amount,
    );
    final issuerName = useTextEditingController(
      text: createParams.issuerName,
    );
    final webUrl = useTextEditingController(
      text: createParams.webUrl,
    );
    final email = useTextEditingController(
      text: createParams.email,
    );
    final projectDescription = useTextEditingController(
      text: createParams.projectDescription,
    );

    ProjectCreateParams getUpdatedProjectParams() {
      // Update with local params
      return createParams.rebuild(
        (a) => a
          ..projectName = projectName.text
          ..coinName = coinName.text
          ..price = price.text
          ..amount = amount.text
          ..issuerName = issuerName.text
          ..webUrl = webUrl.text
          ..email = email.text
          ..projectDescription = projectDescription.text,
      );
    }

    void doNext() {
      final isValid = formKey.currentState.validate();

      if (!autovalidate.value) {
        autovalidate.value = true;
      }

      if (!isValid) {
        return;
      }

      formKey.currentState.save();

      ProjectApplySubmitPage.open(getUpdatedProjectParams()).then((newParams) {
        createParamsState.value = newParams as ProjectCreateParams;
      });
    }

    Future<bool> showDialog(ProjectApplyVM viewModel) {
      final response = Completer<bool>();
      showConfirmDialog(
        context,
        title: tr('project:create_dialog_title'),
        content: tr('project:create_dialog_info'),
        cancelBtnText: tr('project:create_dialog_cancel'),
        confirmBtnText: tr('project:create_dialog_confirm'),
        onConfirm: () {
          viewModel.doSaveToCache(getUpdatedProjectParams());
          response.complete(true);
        },
        onCancel: () {
          viewModel.doSaveToCache(
            ProjectCreateParams(),
          );
          response.complete(true);
        },
      );
      return response.future;
    }

    bool isNotEmpty() {
      if (projectName.text != '' ||
          coinName.text != '' ||
          price.text != '' ||
          amount.text != '' ||
          issuerName.text != '' ||
          webUrl.text != '' ||
          email.text != '' ||
          projectDescription.text != '') {
        return true;
      }
      return false;
    }

    return StoreConnector<AppState, ProjectApplyVM>(
      distinct: true,
      converter: ProjectApplyVM.fromStore,
      builder: (context, viewModel) => WillPopScope(
        onWillPop: () async {
          if (isNotEmpty()) {
            return showDialog(viewModel);
          }
          return true;
        },
        child: CSScaffold(
          title: tr('project:create_title_apply'),
          scrollable: true,
          child: Form(
            key: formKey,
            autovalidateMode: autovalidate.value
                ? AutovalidateMode.onUserInteraction
                : AutovalidateMode.disabled,
            child: Column(
              children: [
                FormBox(
                  type: FormBoxType.inputText,
                  controller: projectName,
                  title: tr('project:create_lbl_project_name'),
                  hintText: tr('project:create_input_project_name'),
                  maxLength: 128,
                  validator: ProjectNameValidator(
                    errorText: tr('project:create_lbl_req_project_name'),
                  ),
                ),
                FormBox(
                  type: FormBoxType.inputText,
                  controller: coinName,
                  title: tr('project:create_lbl_coin_symbol'),
                  hintText: tr('project:create_input_coin_symbol'),
                  maxLength: 50,
                  validator: SymbolValidator(
                    errorText: tr('project:create_lbl_req_coin_symbol'),
                  ),
                ),
                FormBox(
                  type: FormBoxType.inputNumber,
                  controller: price,
                  title: tr('project:create_lbl_price'),
                  hintText: tr('project:create_input_price'),
                  iconWidget: Text(
                    'USDT',
                    style: context.textBody(bold: true),
                  ),
                  inputFormatters: [
                    NumberTextInputFormatter(
                      maxDecimal: 2,
                      maxInteger: 20,
                    ),
                  ],
                  validator: RequiredValidator(
                    errorText: tr('project:create_input_price'),
                  ),
                ),
                FormBox(
                  type: FormBoxType.inputNumber,
                  controller: amount,
                  title: tr('project:create_lbl_amount'),
                  hintText: tr('project:create_lbl_req_amount'),
                  iconWidget: Text(
                    tr('project:create_lbl_symbol'),
                    style: context.textBody(bold: true),
                  ),
                  validator: RequiredValidator(
                    errorText: tr('project:create_lbl_req_amount'),
                  ),
                  inputFormatters: [
                    NumberTextInputFormatter(
                      maxInteger: 20,
                      maxDecimal: 10,
                    ),
                  ],
                ),
                FormBox(
                  type: FormBoxType.inputText,
                  controller: issuerName,
                  title: tr('project:create_lbl_issuer_name'),
                  maxLength: 128,
                  hintText: tr('project:create_lbl_req_issuer_name'),
                  validator: RequiredValidator(
                    errorText: tr('project:create_lbl_req_issuer_name'),
                  ),
                ),
                FormBox(
                  type: FormBoxType.inputText,
                  controller: webUrl,
                  title: tr('project:create_lbl_web_url'),
                  hintText: tr('project:create_input_web_url'),
                  validator: WebUrlValidator(
                    errorText: tr('project:create_lbl_req_web_url'),
                  ),
                ),
                FormBox(
                  type: FormBoxType.inputText,
                  controller: email,
                  maxLength: 128,
                  title: tr('project:create_lbl_email'),
                  hintText: tr('project:create_input_email'),
                  validator: EmailValidator(
                    errorText: tr('project:create_lbl_req_email'),
                  ),
                ),
                FormBox(
                  title: tr('project:create_lbl_description'),
                  controller: projectDescription,
                  type: FormBoxType.inputText,
                  maxLines: 5,
                  hintText: tr('project:create_input_description'),
                  validator: RequiredValidator(
                    errorText: tr(
                      tr('project:create_lbl_req_description'),
                    ),
                  ),
                  maxLength: 1000,
                  maxLengthChineseDouble: true,
                ),
                CSButton(
                  label: tr('global:btn_next'),
                  onPressed: () {
                    doNext();
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
