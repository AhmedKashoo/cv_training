abstract class NewsState{}
class InitialState extends NewsState{}
class BottomNavState extends NewsState{}
class NewsGetBusinessSucessState extends NewsState{}
class SportGetBusinessSucessState extends NewsState{}
class scienceGetBusinessSucessState extends NewsState{}

class NewsLoadingState extends NewsState{}
class NewsGetBusinessErrorState extends NewsState{
  final String error;
  NewsGetBusinessErrorState(this.error);

}
class SportGetBusinessErrorState extends NewsState{
  final String error;
  SportGetBusinessErrorState(this.error);

}
class scienceGetBusinessErrorState extends NewsState{
  final String error;
  scienceGetBusinessErrorState(this.error);

}