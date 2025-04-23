import 'package:chat/data/enum/state_handler.dart';
import 'package:chat/data/repositories/user_repository.dart';
import 'package:flutter/widgets.dart';

class GhostProvider with ChangeNotifier {
  bool _isGhostMode = false;
  bool get isGhostMode => _isGhostMode;

  StateHandler ghostState = StateHandler.initial;

  Future toggleGhostMode() async {
    ghostState = StateHandler.loading;
    notifyListeners();
    try {
      final result = await UserRepository.changeGhostMode(!_isGhostMode);
      _isGhostMode = result;
      ghostState = StateHandler.loaded;
    } catch (e) {
      ghostState = StateHandler.error;
    }
    notifyListeners();
  }

  void setGhostMode(final bool value) {
    _isGhostMode = value;
    notifyListeners();
  }
}
