class GridContent{

  // Fields
  bool _isMine = false;
  String _position = ""; // This will be the position of the item in the dictionary
  bool _isFlagged = false;
  bool _isRevealed = false;

  GridContent(this._isMine, this._position, this._isFlagged, this._isRevealed);

  // Getters
  bool get IsMine => _isMine;
  String get Position => _position;
  bool get IsFlagged => _isFlagged;
  bool get IsRevealed => _isRevealed;
}