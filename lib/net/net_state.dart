import 'package:novel_flutter_bit/base/base_state.dart';
import 'package:novel_flutter_bit/net/service_result.dart';

class NetStateTools {
  /// successCode 即后端返回数据成功的code,这个参数是为了后端接口返回code不一致.
  static NetState handle(ServiceResultData responseModel,
      {int? successCode = 1}) {
    if (responseModel.code == successCode) {
      return NetState.dataSuccessState;
    } else if (responseModel.code == 404) {
      return NetState.error404State;
    } else if (responseModel.code == 403) {
      return NetState.error403State;
    } else if (responseModel.code == -100) {
      return NetState.timeOutState;
    } else if (responseModel.code == 500) {
      return NetState.errorShowRefresh;
    } else if (responseModel.code == -1) {
      return NetState.cancelRequest;
    }
    return NetState.unknown;
  }
}
