import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:news_c8_online/data/api_manages.dart';
import 'package:news_c8_online/data/repos/data_sources/offline_data_source.dart';
import 'package:news_c8_online/data/repos/data_sources/online_data_source.dart';

import '../../model/sources_response.dart';

class NewsRepo {
  OnlineDataSource onlineDataSource;
  OfflineDataSource offlineDataSource;
  NewsRepo(this.onlineDataSource, this.offlineDataSource);

  Future<SourcesResponse> getSources(String categoryId) async{
    final connectivityResult = await (Connectivity().checkConnectivity());
    if(connectivityResult == ConnectivityResult.mobile
        || connectivityResult == ConnectivityResult.wifi){
      var response = await onlineDataSource.getSources(categoryId);
      await offlineDataSource.saveSources(categoryId, response);
      return response;
    }else {
      var response =  await offlineDataSource.getSources(categoryId);
      if(response == null){
        return SourcesResponse(message: "Please make sure you good network connection");
      }
      return response;
    }
  }
}