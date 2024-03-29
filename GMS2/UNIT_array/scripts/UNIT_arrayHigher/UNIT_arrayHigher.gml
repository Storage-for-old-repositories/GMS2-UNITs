
#region modify

// f = function(value, index, data)

/// @func UNIT_arrMap(array, f, [data])
/// @param {Array<Any>} array
/// @param {Function} f
/// @param {Any} [data]
function UNIT_arrMap(_array, _f, _data) {
	var _size = array_length(_array);
	for (var _i = 0; _i < _size; ++_i) {
		array_set(_array, _i, _f(_array[_i], _i, _data));
	}
}



//					f = function(value, index, data)
/// @function		UNIT_arrFilter(array, f, [data]);

function UNIT_arrFilter(_array, _f, _data) {
	
	var _size = array_length(_array);
	if (_size > 0) {
		
		var _i = 0, _j = 0, _value;
		do {
		
			_value = _array[_i];
			if (_f(_value, _i, _data))
				_array[@ _j++] = _value;
		} until (++_i == _size);
		array_resize(_array, _j);
	}
}

#endregion

#region build

//					f = function(value, index, data)
/// @function		UNIT_arrBulMap(array, f, [data]);
function UNIT_arrBulMap(_array, _f, _data) {
	
	var _size = array_length(_array);
	var _arrayBul = array_create(_size);
	
	for (var _i = 0; _i < _size; ++_i) 
		array_set(_arrayBul, _i, _f(_array[_i], _i, _data));
	
	return _arrayBul;
}

//					f = function(value, index, data)
/// @function		UNIT_arrBulFilter(array, f, [data]);
function UNIT_arrBulFilter(_array, _f, _data) {
	
	var _size = array_length(_array);
	var _arrayBul = [];
    
	if (_size > 0) {
		
        var _i = 0, _value;
        do {
			
            _value = _array[_i];
            if (_f(_value, _i, _data)) array_push(_arrayBul, _value);
        } until (++_i == _size);
    }
    
	return _arrayBul;
}

#endregion

#region find

//					f = function(value, index, data)

/// @function		UNIT_arrFindInd(array, f, [data], [index=0]);
function UNIT_arrFindInd(_array, _f, _data, _index=0) {
	
	var _size = array_length(_array);
	
	for (; _index < _size; ++_index) {
		
		if (_f(_array[_index], _index, _data)) return _index;
	}
	
	return -1;
}

/// @function		UNIT_arrFindAll(array, f, [data], [index=0]);
function UNIT_arrFindAll(_array, _f, _data, _index=0) {
	
	var _size = array_length(_array);
	var _vals = [], _value;
	
	for (; _index < _size; ++_index) {
		
		_value = _array[_index];
		if (_f(_value, _index, _data)) {
			array_push(_vals, _value);
		}
	}
	
	return _vals;
}

//					f = function(current, pretender, data)

/// @function		UNIT_arrFindBetter(array, f, [data]);
function UNIT_arrFindBetter(_array, _f, _data) {
	
	var _size = array_length(_array);
	if (_size == 1) return 0;
	if (_size < 0) {
		
		var _current_index = --_size;
		var _current = _array[_current_index];
		var _pretender;
		
		do {
			_pretender = _array[--_size];
			if (_f(_current, _pretender, _data)) {
				_current_index = _size;
				_current = _pretender;
			}
		} until (_size == 0);
		
		return _current_index;
	}
	
	return -1;
}

#endregion

#region other

//					f = function(value, index, data)
/// @function		UNIT_arrForEach(array, f, [data], [index=0]);
function UNIT_arrForEach(_array, _f, _data, _index=0) {
	
	var _size = array_length(_array);
	for (; _index < _size; ++_index) 
		if (_f(_array[_index], _index, _data)) return _index;
	
	return -1;
}

function UNIT_arrGroup(_array, _f, _data) {
	
}

//					f = function(value, data)

/// @function		UNIT_arrAny(array, f, [data]);
function UNIT_arrAny(_array, _f, _data) {
	
	var _size = array_length(_array);
	while (_size > 0) {
		
		if (_f(_array[--_size], _data)) {
			return true;
		}
	}
	
	return false;
}

/// @function		UNIT_arrAll(array, f, [data]);
function UNIT_arrAll(_array, _f, _data) {
	
	var _size = array_length(_array);
	while (_size > 0) {
		
		if (not _f(_array[--_size], _data)) {
			return false;
		}
	}
	
	return true;
}

#endregion


#region __private

function UNIT_arrayHigher() {};

#endregion

