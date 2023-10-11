class GridContent {
  // Fields
  final bool _isMine;
  final String
      _position; // This will be the position of the item in the dictionary
  late bool _isFlagged;
  late bool _isRevealed;

  GridContent(this._isMine, this._position, this._isFlagged, this._isRevealed);

  // Getters
  bool get isMine => _isMine;
  String get position => _position;
  bool get isFlagged => _isFlagged;
  bool get isRevealed => _isRevealed;

  void revealSquare() => _isRevealed = true;

  void toggleFlag() => (isFlagged) ? _removeFlag() : _flagSquare();

  void _flagSquare() => _isFlagged = true;
  void _removeFlag() => _isFlagged = false;
}
