import 'package:http/http.dart';

import '../../../data/http/http.dart';
import '../../../intra/http/http.dart';

HttpClient makeHttpAdapter(){
  final client = Client();
  return HttpAdapter(client);
}
