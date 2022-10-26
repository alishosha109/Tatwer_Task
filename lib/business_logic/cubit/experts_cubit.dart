import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tatwer_task/data/models/experts_model.dart';
import 'package:tatwer_task/data/repos/experts_repo.dart';

part 'experts_state.dart';

class ExpertsCubit extends Cubit<ExpertsState> {
  final ExpertsRepo expertsrepo;
  List<Expert> experts = [];
  List<Expert> online_experts = [];
  ExpertsCubit(this.expertsrepo) : super(ExpertsInitial());

  getExperts() {
    emit(ExpertsLoading());
    expertsrepo.getExperts().then((experts) {
      expertsrepo.getonlineExperts().then((online_exp) {
        if (experts == []) {
          emit(NoExperts());
        } else {
          emit(ExpertsAdded(experts, "", online_exp));
        }
        this.online_experts = online_exp;
        this.experts = experts;
      });
    });
    return experts;
  }

  addtofavs(experts, id) {
    emit(ExpertsAdded(experts, id, online_experts));
  }
}
