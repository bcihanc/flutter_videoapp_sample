import 'package:shared_preferences/shared_preferences.dart';

class PlaylistSharedPreferences extends BaseSharedPreferences {
  const PlaylistSharedPreferences() : super('playlist');
}

abstract class BaseSharedPreferences {
  const BaseSharedPreferences(this._key);
  final String _key;

  Future<void> _createKeyIfNotExists() async {
    final instance = await SharedPreferences.getInstance();
    final check = instance.containsKey(_key);

    if (!check) {
      await instance.setStringList(_key, <String>[]);
    }
  }

  Future<List<String>> gets() async {
    await _createKeyIfNotExists();
    final instance = await SharedPreferences.getInstance();

    return instance.getStringList(_key);
  }

  Future<void> add(String id) async {
    final instance = await SharedPreferences.getInstance();
    await _createKeyIfNotExists();

    final list = instance.getStringList(_key);

    if (!list.contains(id)) {
      list.add(id);
      await instance.setStringList(_key, list);
    }
  }

  Future<void> clear(String id) async {
    await _createKeyIfNotExists();
    final instance = await SharedPreferences.getInstance();

    final list = instance.getStringList(_key);

    if (list.isNotEmpty) {
      list.remove(id);
      await instance.setStringList(_key, list);
    }
  }

  Future<bool> contains(String id) async {
    await _createKeyIfNotExists();

    final instance = await SharedPreferences.getInstance();

    final playlist = instance.getStringList(_key);
    return playlist.contains(id);
  }

  Future<void> clearAll() async {
    final instance = await SharedPreferences.getInstance();

    if (instance.containsKey(_key)) {
      instance.setStringList(_key, <String>[]);
    }
  }
}
