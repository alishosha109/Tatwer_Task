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
      if (experts == []) {
        emit(NoExperts());
      } else {
        emit(ExpertsAdded(experts, "", online_experts));
      }
      this.experts = experts;
    });
    return experts;
  }

  getonlineExperts() {
    emit(ExpertsLoading());
    expertsrepo.getinlineExperts().then((online_experts) {
      if (experts == []) {
        emit(NoExperts());
      } else {
        emit(ExpertsAdded(experts, "", online_experts));
      }
      this.experts = experts;
    });
    return experts;
  }

  addtofavs(experts, id) {
    emit(ExpertsAdded(experts, id, online_experts));
  }
}
