const CommandTypeMapping = {
  'turn': CommandType.TURN,
};


class Command {
  CommandType _type;
  String _value;
  int _uid;

  Command(Map<String, dynamic> dataObj){
    this._type = CommandTypeMapping[dataObj['type']];
    this._value = dataObj['value'];
  }

  CommandType get type => _type;
  String get value => _value;
  int get uid => _uid;
}

class CommandType {
  static const TURN = CommandType._('TURN');

  const CommandType._(this.name);

  final String name;

  @override
  String toString() => name;
}