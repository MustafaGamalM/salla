import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/search/cubit/states.dart';
import 'package:shop_app/newtork/remotly.dart';

import '../../../models/search_model.dart';
import '../../../newtork/end_pointes.dart';
import '../../../shared/constants.dart';

class SearchCubit extends Cubit<SearchStates> {
  SearchCubit() : super(IntialSearch());
  static SearchCubit get(context) => BlocProvider.of(context);

  SearchModel searchedModel;
  void searchItem(String text) {
    emit(LoadingSearch());
    DioHelper.postData(url: SEARCH, token: token, data: {'text': text})
        .then((value) {
      searchedModel = SearchModel.fromJson(value.data);
      emit(SuccessSearch());
    }).catchError((error) {
      emit(FailedSearch());
    });
  }
}
