import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:news_c8_online/data/api_manages.dart';
import '../../../model/sources_response.dart';

class OfflineDataSource{
  Future<SourcesResponse?> getSources(String categoryId) async {
    var docSnapShot = await getTabsCollectionWithConverters().doc(categoryId).get();
    return docSnapShot.data();
  }

  Future saveSources(String categoryId, SourcesResponse tabs){
    return getTabsCollectionWithConverters().doc(categoryId).set(tabs);
  }

  CollectionReference<SourcesResponse> getTabsCollectionWithConverters(){
    return
        FirebaseFirestore.instance.collection(SourcesResponse.collectionName)
            .withConverter<SourcesResponse>(
            fromFirestore: (snapshot, _){
              return SourcesResponse.fromJson(snapshot.data());
            },
            toFirestore: (sourcesResponse, _){
              return sourcesResponse.toJson();
            });
  }
}