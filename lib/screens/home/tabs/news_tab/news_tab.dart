import 'package:flutter/material.dart';
import 'package:news_c8_online/data/api_manages.dart';
import 'package:news_c8_online/model/api_exception.dart';
import 'package:news_c8_online/model/category_dm.dart';
import 'package:news_c8_online/model/sources_response.dart';
import 'package:news_c8_online/screens/home/tabs/news_tab/NewsTabViewModel.dart';
import 'package:news_c8_online/screens/home/tabs/news_tab/tab_content.dart';
import 'package:provider/provider.dart';

class NewsTab extends StatefulWidget {
  CategoryDM categoryDM;
  NewsTab(this.categoryDM);
  @override
  State<NewsTab> createState() => _NewsTabState();
}

class _NewsTabState extends State<NewsTab> {
 NewsTabViewModel viewModel = NewsTabViewModel();

 @override
  void initState() {
    super.initState();
    viewModel.categoryDM = widget.categoryDM;
    viewModel.getSources();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => viewModel,
      builder: (context, _){
        var viewModel = Provider.of<NewsTabViewModel>(context);
        print("BUILDER WITH viewModel.Loading = ${viewModel.isLoading}");
        if(viewModel.isLoading){
          return Center(child: CircularProgressIndicator());
        }
        else {
          if(viewModel.errorMsg.isEmpty){
            return buildSuccessState();
          }else {
            return buildErrorState();
          }
        }
      },
    );
  }
 Widget buildErrorState(){
   return Container(
     child: Column(
       mainAxisAlignment: MainAxisAlignment.center,
       crossAxisAlignment: CrossAxisAlignment.stretch,
       children: [
         Center(child: Text(viewModel.errorMsg)),
         Center(
           child: ElevatedButton(onPressed: (){
             viewModel.getSources();
           },
               child: Text("Retry")),
         )
       ],
     ),
   );
 }

  Widget buildSuccessState(){
    return Container(
      child: DefaultTabController(
        length: viewModel.sources.length,
        child: Column(
          children: [
            SizedBox(height: 8,),
            TabBar(tabs: viewModel.sources.map((sourceDM) {
              return buildTabWidget(sourceDM.name ?? "unkown",
                  viewModel.currentTabIndex == viewModel.sources.indexOf(sourceDM));
            }).toList(),
              isScrollable: true,
              indicatorColor: Colors.transparent,
              onTap: (index){
                viewModel.currentTabIndex = index;
                setState(() {});
              },
            ),
            Expanded(
              child: TabBarView(children: viewModel.sources.map((sourceDM) {
                return TabContent(sourceDM);
              }).toList()),
            )
          ],
        ),
      ),
    );
  }

  Widget buildTabWidget(String sourceName, bool isSelected){
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: isSelected ?Colors.blue : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.blue, width: 2)
      ),
      child: Text(sourceName, style: TextStyle(color: isSelected ? Colors.white : Colors.blue),),
    );
  }
}