import '../../domain/entities/entities.dart';

import '../../data/http/http.dart';

class RemoteAccountModel {
  final String accessToken;
  RemoteAccountModel(this.accessToken);

  factory RemoteAccountModel.fromJson(Map json) {
    if(!json.containsKey('token')){
      throw HttpError.invalidData;
    }
    return RemoteAccountModel(json['token']);
  }

  AccountEntity toEntity() => AccountEntity(accessToken);
}