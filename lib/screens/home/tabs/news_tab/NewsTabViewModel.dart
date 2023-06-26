import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_c8_online/data/api_manages.dart';
import 'package:news_c8_online/data/repos/NewsRepo.dart';
import 'package:news_c8_online/data/repos/data_sources/offline_data_source.dart';
import 'package:news_c8_online/data/repos/data_sources/online_data_source.dart';
import '../../../../model/category_dm.dart';
import '../../../../model/sources_response.dart';

class NewsTabViewModel extends Cubit<NewsViewModelState>{
  List<SourceDM> sources=[];
  int currentTabIndex = 0;
  late CategoryDM categoryDM;
  bool isLoading = false;
  String errorMsg = "";

  OnlineDataSource onlineDataSource = OnlineDataSource();
  OfflineDataSource offlineDataSource = OfflineDataSource();
  late NewsRepo repo;

   NewsTabViewModel(): super(LoadingState()){
       repo = NewsRepo(onlineDataSource, offlineDataSource);
   }
  void getSources() async{
      isLoading = true;
      emit(LoadingState());
      var sourcesResponse = await repo.getSources(categoryDM.id);
      if(sourcesResponse.code == null){
        isLoading = false;
        sources = sourcesResponse.sources!;
       emit(SuccessState());
      }else{
        isLoading = false;
        errorMsg = sourcesResponse.code!;
        emit(ErrorState());
      }
  }
}
abstract class NewsViewModelState{}

class LoadingState extends NewsViewModelState{}
class SuccessState extends NewsViewModelState{}
class ErrorState extends NewsViewModelState{}