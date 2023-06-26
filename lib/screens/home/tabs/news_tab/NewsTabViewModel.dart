import 'package:flutter/material.dart';
import 'package:news_c8_online/data/api_manages.dart';
import 'package:news_c8_online/data/repos/NewsRepo.dart';
import 'package:news_c8_online/data/repos/data_sources/offline_data_source.dart';
import 'package:news_c8_online/data/repos/data_sources/online_data_source.dart';
import '../../../../model/category_dm.dart';
import '../../../../model/sources_response.dart';

class NewsTabViewModel extends ChangeNotifier{
  List<SourceDM> sources=[];
  int currentTabIndex = 0;
  late CategoryDM categoryDM;
  bool isLoading = false;
  String errorMsg = "";

  OnlineDataSource onlineDataSource = OnlineDataSource();
  OfflineDataSource offlineDataSource = OfflineDataSource();
  late NewsRepo repo;

  NewsTabViewModel(){
    repo = NewsRepo(onlineDataSource, offlineDataSource);
  }
  void getSources() async{
      isLoading = true;
      notifyListeners();
      var sourcesResponse = await repo.getSources(categoryDM.id);
      if(sourcesResponse.code == null){
        isLoading = false;
        sources = sourcesResponse.sources!;
        notifyListeners();
      }else{
        isLoading = false;
        errorMsg = sourcesResponse.code!;
        notifyListeners();
      }
  }
}