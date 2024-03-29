
singleton = function() {
	static _singleton = function() {
		var _singleton = {};
		
		_singleton._clone = method(_singleton, function() {
			show_debug_message(">> _singleton.clone()");
			return self;
		});
		
		return _singleton;
	}();
	return _singleton;
}


var _global = {};
var _stc = {};
_stc.a = _stc;
_stc.b = [20, _stc];
_stc.c = {
	x: 0,
	mt: method(_stc, function() {
		
	}),
	check: method(_global, function() {
		
	}),
	
}
_stc.c.mt2 = _stc.c.mt;
_stc.s = singleton();
_stc.s2 = [singleton(), singleton()];


var _copy = UNIT_deepCopy(_stc);
show_debug_message(_stc);
show_debug_message(_copy);
show_debug_message("all: 0");
show_debug_message(_copy == _stc);
show_debug_message(_copy.a == _stc.a);
show_debug_message(_copy.b == _stc.b);
show_debug_message(_copy.b[1] == _stc.b[1]);
show_debug_message(_copy.c == _stc.c);
show_debug_message(_copy.c.mt == _stc.c.mt);
show_debug_message(_copy.c.mt2 == _stc.c.mt2);
show_debug_message(_copy.c.mt == _stc.c.mt2);
show_debug_message(_copy.c.mt2 == _stc.c.mt);
show_debug_message(_copy.c.check == _stc.c.check);
show_debug_message("all: 1");
show_debug_message(_copy.a == _copy);
show_debug_message(_copy.a == _copy);
show_debug_message(_copy.b[1] == _copy);
show_debug_message(_copy.b[0] == _stc.b[0]);
show_debug_message(_copy.c.x == _stc.c.x);
show_debug_message(_copy.c.mt == _copy.c.mt2);
show_debug_message(_copy == method_get_self(_copy.c.mt));
show_debug_message(_copy == method_get_self(_copy.c.mt2));
show_debug_message(method_get_self(_copy.c.check) == _global);
show_debug_message(_copy.s == singleton());
show_debug_message(_copy.s == _stc.s);
show_debug_message(_copy.s2[0] == singleton());
show_debug_message(_copy.s2[1] == singleton());

function UNIT_deepCopy(_value, _dpt=infinity, _nameMethodClone="_clone") {
	
	if (is_method(_value)) {
		return method(
			method_get_self(_value),
			method_get_index(_value),
		);
	}
	
	if (_dpt < 1 || not __UNIT_deepCopy_isRef(_value)) return _value;
	
	var _rmap = ds_map_create();
	
	var _refs, _size;
	var _refs_next;
	var _refs_meth = [];
	
	var _val;
	var _ref, _new;
	
	var _stmp, _ssiz, _skey;
	
	_refs_next = [_value];
	_size      = 1;
	
	while (_dpt > 1) {
		
		--_dpt;
		
		_refs = _refs_next;
		_refs_next = [];
		
		do {
			
			_val = _refs[--_size];
			_ref = __UNIT_deepCopy_metaRef(_rmap, _val);
			
			_ref.code = ___UNIT_DEEP_COPY_CODE._WRITE_IN_CELL;
			
			if (is_array(_val)) {
				
				_ssiz = array_length(_val);
				_new  = array_create(_ssiz, undefined);
				
				_ref.ref = _new;
				
				while (_ssiz > 0) {
					
					--_ssiz;
					__UNIT_deepCopy_nd_valueSet(
						"sarr",
						array_set,
						__UNIT_deepCopy_metaArrSet,
						_rmap,
						_val[_ssiz],
						_new,
						_ssiz,
						_refs_next,
						_refs_meth,
					);
				}
				
			}
			else {
				
				_stmp = (is_string(_nameMethodClone) ? _val[$ _nameMethodClone] : undefined);
				if (not is_undefined(_stmp)) {
					with (_val) {
					
					_new = _stmp(_value);
					
					}
					
					_ref.ref = _new;
				}
				else {
					
					switch (instanceof(_val)) {
					
					case "weakref":
						
						_new = weak_ref_create(_val[$ "ref"]);
						_ref.ref = _new;
						
						break;
					
					case "instance":
						
						_new = _val;
						_ref.ref = _new;
						
						break;
					
					default:
						
						_new = {};
						_ref.ref = _new;
						
						_skey = variable_struct_get_names(_val);
						_ssiz = array_length(_skey);
						while (_ssiz > 0) {
							_stmp = _skey[--_ssiz];
							__UNIT_deepCopy_nd_valueSet(
								"sstc",
								variable_struct_set,
								__UNIT_deepCopy_metaStcSet,
								_rmap,
								_val[$ _stmp],
								_new,
								_stmp,
								_refs_next,
								_refs_meth,
							);
						}
					}
				}
			}
			
			__UNIT_deepCopy_unsubscribe(_ref);
		} until (_size == 0);
		
		_size = array_length(_refs_next);
		if (_size == 0) {
			_dpt = -1;
			break;
		}
	}
	
	if (_dpt > 0) {
		do {
			
			_val = _refs_next[--_size];
			_ref = __UNIT_deepCopy_metaRef(_rmap, _val);
			
			if (is_array(_val)) {
				_ref.ref = __UNIT_deepCopy_1d_array(_val);
			}
			else {
				_ref.ref = __UNIT_deepCopy_1d_struct(_val);	
			}
			
			__UNIT_deepCopy_unsubscribe(_ref);
		} until (_size == 0);
	}
	
	_size = array_length(_refs_meth);
	while (_size > 0) {
		
		_val = _refs_meth[--_size];
		_ref = __UNIT_deepCopy_metaRef(_rmap, _val);
		
		_stmp = method_get_self(_val);
		if (_stmp == undefined) {
			_new = method(undefined, _val);	
		}
		else {
			
			_skey = _rmap[? _stmp];
			_new = method(is_undefined(_skey) ? _stmp : _skey.ref, _val);
		}
		
		_ref.ref = _new;
		__UNIT_deepCopy_unsubscribe(_ref);
	}
	
	_value = _rmap[? _value].ref;
	ds_map_destroy(_rmap);
	return _value;
}


#region __private

enum ___UNIT_DEEP_COPY_CODE { 
	_CREATE_CELL = 0x1,
	_EXISTS_CELL = 0x2,
	_WRITE_IN_CELL = 0x4,
};

function __UNIT_deepCopy_isRef(_value) {
	var _type = typeof(_value);
	return (_type == "array" || _type == "struct");
}

function __UNIT_deepCopy_metaRef(_id, _ref) {
	var _meta = _id[? _ref];
	if (_meta == undefined) {
		
		_meta = {
			code: ___UNIT_DEEP_COPY_CODE._CREATE_CELL,
			sarr: [],
			sstc: [],
		}
		
		_id[? _ref] = _meta;
		return _meta;
	}
	
	_meta.code = max(___UNIT_DEEP_COPY_CODE._EXISTS_CELL, _meta.code);
	return _meta;
}

function __UNIT_deepCopy_metaArrSet(_array, _key, _id, _ref) {
	var _meta = __UNIT_deepCopy_metaRef(_id, _ref);
	if (_meta.code == ___UNIT_DEEP_COPY_CODE._WRITE_IN_CELL) {
		array_set(_array, _key, _meta.ref);
	}
	else {
		array_push(_meta.sarr, _array, _key);
	}
	return _meta.code;
}

function __UNIT_deepCopy_metaStcSet(_struct, _key, _id, _ref) {
	var _meta = __UNIT_deepCopy_metaRef(_id, _ref);
	if (_meta.code == ___UNIT_DEEP_COPY_CODE._WRITE_IN_CELL) {
		variable_struct_set(_struct, _key, _meta.ref);
	}
	else {
		array_push(_meta.sstc, _struct, _key);
	}
	return _meta.code;
}

function __UNIT_deepCopy_unsubscribe(_ref) {
	
	var _arrs;
	var _size;
	var _reff = _ref.ref;
	
	_arrs = _ref.sarr;
	_size = array_length(_arrs);
	while (_size > 0) {
		_size -= 2;
		array_set(_arrs[_size], _arrs[_size + 1], _reff);
	}
	
	_arrs = _ref.sstc;
	_size = array_length(_arrs);
	while (_size > 0) {
		_size -= 2;
		variable_struct_set(_arrs[_size], _arrs[_size + 1], _reff);
	}
	
	variable_struct_remove(_ref, "sarr");
	variable_struct_remove(_ref, "sstc");
}

function __UNIT_deepCopy_1d_array(_array) {
	var _size = array_length(_array);
	var _narr = array_create(_size);
	array_copy(_narr, 0, _array, 0, _size);
	return _narr;
}

function __UNIT_deepCopy_1d_struct(_struct) {
	var _keys = variable_struct_get_names(_struct);
	var _size = array_length(_keys), _key;
	var _nstc = {};
	while (_size > 0) {
		_key = _keys[$ --_size];
		_nstc[$ _key] = _struct[$ _key];
	}
	return _nstc;
}

function __UNIT_deepCopy_nd_valueSet(_sname, _sSet, _sMetaSet, _rmap, _value, _data, _key, _refs_next, _refs_meth) {
	
	if (is_method(_value)) {
		
		var _ref = __UNIT_deepCopy_metaRef(_rmap, _value);
		array_push(_ref[$ _sname], _data, _key);
		
		if (_ref.code == ___UNIT_DEEP_COPY_CODE._CREATE_CELL) {
			array_push(_refs_meth, _value);
		}
	}
	else
	if (__UNIT_deepCopy_isRef(_value)) {
		
		if (_sMetaSet(_data, _key, _rmap, _value) == ___UNIT_DEEP_COPY_CODE._CREATE_CELL) {
			array_push(_refs_next, _value);
		}
	}
	else {
		_sSet(_data, _key, _value);
	}
}

#endregion

