import '../../../../Models/ShopApp/SearchModel.dart';

abstract class SearchState{}
class SearchInitialState extends SearchState{}
class SearchLoadingState extends SearchState{}
class SearchSucessState extends SearchState{
  final SearchModel model;
  SearchSucessState(this.model);

}
class SearchErrorState extends SearchState{}