import '../../domain/entities/entities.dart';

import '../../data/http/http.dart';

class RemoteAccountModel {
  final String accessToken;
  RemoteAccountModel(this.accessToken);

  factory RemoteAccountModel.fromJson(Map json) {
    if(!json.containsKey('access_token')){
      throw HttpError.invalidData;
    }
    return RemoteAccountModel(json['access_token']);
  }

  AccountEntity toEntity() => AccountEntity(accessToken);
}