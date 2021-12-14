
#region modify

/// @function		UNIT_dsListResize(id, size);
/// @description	Аналог array_resize
function UNIT_dsListResize(_id, _size) {
	var _idSize = ds_list_size(_id);
	if (_size > _idSize) {
		
		repeat (_size - _idSize) ds_list_add(_id, 0);
	}
	else {
		
		while (_size != _idSize) ds_list_delete(_id, --_idSize);
	}
}

/// @function		UNIT_dsListDel(id, index, count);
/// @description	Аналог array_delete
function UNIT_dsListDel(_id, _index, _count) {
	
	var _idSize = ds_list_size(_id);
	var _mSize = _idSize - _index;
	
	_count = min(_count, _mSize);
	if (_count <= 0) exit;
	
	repeat (_mSize - _count) {
		
		_id[| _index] = _id[| _index + _count];
		++_index;
	}
	UNIT_dsListResize(_id, _idSize - _count);
}

#endregion

#region build

/// @param			...value
/// @description	Строит список из аргументов
function UNIT_dsListBul() {
	var _id = ds_list_create();
	var _argSize = argument_count;
	
	for (var _i = 0; _i < _argSize; ++_i)
		ds_list_add(_id, argument[_i]);
	
	return _id;
}

/// @param			id
/// @description	Клонирует список (глубиной 1)
function UNIT_dsListBulDup1d(_id) {
	var _id_new = ds_list_create();
	ds_list_copy(_id_new, _id);
	return _id_new;
}

#endregion

#region other

/// @param			id
/// @description	Запишет список в массив
function UNIT_dsListToArr(_id) {
	var _idSize = ds_list_size(_id);
	var _array = array_create(_idSize);
	
	while (_idSize > 0) {
		
		--_idSize;
		_array[_idSize] = _id[| _idSize];
	}
	
	return _array;
}

#endregion


#region __private

function UNIT_dsList() {};

#endregion
