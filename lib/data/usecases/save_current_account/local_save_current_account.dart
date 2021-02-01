import 'package:meta/meta.dart';

import '../../../domain/usecases/usecases.dart';
import '../../../domain/entities/entities.dart';
import '../../../domain/helpers/helpers.dart';

import '../../cache/cache.dart';

class LocalSaveCurrentAccount implements SaveCurrentAccount{
  final SaveSecureCacheStorage saveSecureCacheStorage;
  LocalSaveCurrentAccount({@required this.saveSecureCacheStorage});

  Future<void> save(AccountEntity account) async{
    try{
      await saveSecureCacheStorage.saveSecure(key: 'token', value: account.token);
    }catch(ex){
      throw DomainError.unexpected;
    }
  }
}