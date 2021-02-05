import 'package:meta/meta.dart';

import '../../../domain/usecases/usecases.dart';
import '../../../domain/entities/entities.dart';
import '../../../domain/helpers/helpers.dart';

import '../../cache/cache.dart';

class LocalLoadCurrentAccount implements LoadCurrentAccount{
  final FetchSecureCacheStorage fetchSecureCacheStorage;
  LocalLoadCurrentAccount({@required this.fetchSecureCacheStorage});

  Future<AccountEntity> load() async {
    try{
      final token = await fetchSecureCacheStorage.fetchSecure('token');
      return AccountEntity(token);
    }catch(ex){
      throw DomainError.unexpected;
    }
  }
}