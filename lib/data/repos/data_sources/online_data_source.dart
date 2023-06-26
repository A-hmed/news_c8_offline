import 'package:news_c8_online/data/api_manages.dart';

import '../../../model/sources_response.dart';

class OnlineDataSource{

  Future<SourcesResponse> getSources(String categoryId){
    return ApiManager.getSources(categoryId);
  }
}