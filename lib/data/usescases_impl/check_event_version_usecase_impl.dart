
import 'package:f_project_1/domain/datasources/i_event_local_data_source.dart';
import 'package:f_project_1/domain/datasources/i_version_remote_data_source.dart';
import 'package:f_project_1/domain/usecases/i_check_event_version_usecase.dart';

class CheckEventVersionUseCaseImpl implements ICheckEventVersionUseCase {
  final IEventLocalDataSource local;
  final IVersionRemoteDataSource remote;

  CheckEventVersionUseCaseImpl({
    required this.local,
    required this.remote,
  });

  @override
  Future<bool> hasNewVersion() async {
    final localVersion = await local.getLocalVersion();
    final remoteVersion = await remote.fetchRemoteVersion();

    return remoteVersion > localVersion;
  }
  

    @override
  Future<void> setLocalVersion(int version) async {
    await local.setLocalVersion(version);
  }
}
