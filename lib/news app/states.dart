abstract class NewsStates {}

class NewsInitialState extends NewsStates {}

class NewsBottomNavState extends NewsStates {}
//------------------------------
class NewsBusinessLoadingState extends NewsStates {}

class NewsGetBusinessSuccessState extends NewsStates {}

class NewsGetBusinessErrorState extends NewsStates
{
  late final String error;
  NewsGetBusinessErrorState(this.error);

}
//-=-------------------------------------========================-----------
class NewsSportsLoadingState extends NewsStates {}

class NewsGetSportsSuccessState extends NewsStates {}

class NewsGetSportsErrorState extends NewsStates
{
  late final String error;
  NewsGetSportsErrorState(this.error);

}

//-----------------------------------------------
class NewsScienceLoadingState extends NewsStates {}

class NewsGetScienceSuccessState extends NewsStates {}

class NewsGetScienceErrorState extends NewsStates
{
  late final String error;
  NewsGetScienceErrorState(this.error);

}

class NewsSearchLoadingState extends NewsStates {}

class NewsGetSearchSuccessState extends NewsStates {}

class NewsGetSearchErrorState extends NewsStates {
  late final String error;

  NewsGetSearchErrorState(this.error);

}
class AppChangeModeState extends  NewsStates{}