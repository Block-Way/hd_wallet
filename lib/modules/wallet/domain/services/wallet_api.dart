part of wallet_domain_module;

class WalletApi {
  /// Check with wallet status
  Future<Map<String, dynamic>> getWalletStatus({
    required String walletId,
    required String deviceId,
  }) async {
    return {};
  }
  /* =>
      addAuthSignature(
        walletId,
        {'device': deviceId},
        (params, auth) => Request().post(
          '/v1/hd/auth/register/status',
          params,
          authorization: auth,
        ),
      );*/

  /// 钱包注册
  Future<void> postWalletRegister({
    required String walletId,
    required String deviceId,
    required dynamic options,
    required List<Map<String, dynamic>> coins,
  }) =>
      addAuthSignature<void>(
        walletId,
        {'wallet': coins, 'device': deviceId, 'options': options},
        (params, auth) async {
          final dio = Dio();
          dio.post(
            '${AppConstants.randomApiUrl}/register',
            data: {'params': params, 'authorization': auth},
          );
          return;
        },
      );

  //String walletId,
  // Map<String, dynamic> params,
  // Future<T> Function(Map<String, dynamic>, String) request,

  Future<Map<String, dynamic>> getFee({
    required String chain,
    required String symbol,
    String? toAddress,
    String? fromAddress,
    String? data,
  }) async {
    if (symbol == 'HAH') {
      final dio = Dio();
      final response = await dio.get(
          '${AppConstants.randomApiUrl}/fee?address=$fromAddress&symbol=$symbol');
      return response.data as Map<String, dynamic>;
    } else {
      return {'nonce': 0, 'gas_price': 5000000000, 'gas_limit': 600000};
    }
  }

  //
  Future<Map<String, dynamic>> createtransaction({
    String? toAddress,
    String? fromAddress,
    int? time,
    int? nonce,
    String? amount,
  }) async {
    final dio = Dio();
    final response =
        await dio.post('${AppConstants.randomApiUrl}/createtransaction', data: {
      'from': fromAddress,
      'to': toAddress,
      'time': time,
      'nonce': nonce,
      'amount': amount
    });
    return response.data as Map<String, dynamic>;
  }

  Future<List<Map<String, dynamic>>> getUnspent({
    required String chain,
    required String symbol,
    required String address,
    required String type,
  }) async {
    return [];
  }

  //Broadcast transaction submit
  Future<String> submitTransaction({
    required String chain,
    required String symbol,
    required String tx,
    required String walletId,
    required String type,
  }) async {
    final dio = Dio();
    final response =
        await dio.get('${AppConstants.randomApiUrl}/sendtransaction?hex=$tx');
    return response.data.toString();
  }

//  ▼▼▼▼▼▼ Dex Methods ▼▼▼▼▼▼  //

  Future<Map<String, dynamic>> getDexApproveBalance({
    required String chain,
    required String symbol,
    required String contract,
    required String sellAddress,
  }) async {
    return {};
  }

  /*=>
      Request().getObject(
        '/v1/hd/wallet/$chain/$symbol/approve_balance',
        params: {
          'sell_token': contract,
          'sell_address': sellAddress,
        },
      );
*/
  Future<String> getDexOrderBalance({
    required String chain,
    required String symbol,
    required String primaryKey,
    required String sellAddress,
  }) async {
    return '';
  }

  /*=>
      Request().getValue<String>(
        '/v1/hd/wallet/$chain/$symbol/dex_order_balance',
        params: {
          'primary_key': primaryKey,
          'sell_address': sellAddress,
        },
      );
*/
  Future<Map<String, dynamic>> dexCreateApproveTransaction({
    required String chain,
    required String symbol,
    required int sellAmount,
    required String sellAddress,
    required String sellContract,
  }) async {
    return {};
  } /* =>
      Request().getObject(
        '/v1/hd/wallet/$chain/$symbol/approve',
        params: {
          'sell_token': sellContract,
          'sell_amount': sellAmount,
          'sell_address': sellAddress,
        },
      );*/

  Future<Map<String, dynamic>> getDexOrderCreateRawTx({
    required String chain,
    required String symbol,
    required String recvAddress,
    required int sellAmount,
    required String sellAddress,
    required String sellContract,
    required int buyAmount,
    required String buyContract,
    required String dealAddress,
    required String matchAddress,
    required int validHeight,
    required int fee,
    required String primaryKey,
  }) async {
    return {};
  }

  /*async =>
      Request().getObject(
        '/v1/hd/wallet/$chain/$symbol/create_by_contract',
        params: {
          'sell_address': sellAddress,
          'recv_address': recvAddress,
          'sell_token': sellContract,
          'sell_amount': sellAmount,
          'buy_token_fork_hash': buyContract,
          'buy_amount': buyAmount,
          'match_address': matchAddress,
          'deal_address': dealAddress,
          'valid_height': validHeight,
          'primary_key': primaryKey,
          'fee': fee,
        },
      );
*/
  Future<Map<String, dynamic>> getDexOrderCancelRawTx({
    required String chain,
    required String symbol,
    required String primaryKey,
    required String sellAddress,
  }) async {
    return {};
  }

  /*=>
      Request().getObject(
        '/v1/hd/wallet/$chain/$symbol/cancel_dex_order',
        params: {
          'primary_key': primaryKey,
          'sell_address': sellAddress,
        },
      );
*/
  Future<String> postTRXCreateTransaction({
    required String chain,
    required String symbol,
    required String address,
    required int amount,
    required int fee,
    required String from,
  }) async {
    return '';
  }
  /* =>
      Request().post<String>(
        '/v1/hd/wallet/$chain/$symbol/transaction',
        {
          'from_public_key': '',
          'to_address': address,
          'from_address': from,
          'fee': fee,
          'amount': amount,
        },
      );*/
}
