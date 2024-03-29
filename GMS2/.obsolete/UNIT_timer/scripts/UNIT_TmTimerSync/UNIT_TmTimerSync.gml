
/*
	finit = function(handler, timer);
	ftick = function(handler, timer, super);
	ffree = function(handler, timer, inTick);
*/


/// @function		UNIT_TmTimerSync(steps, [ftick], [finit], [ffree]);
/// @description	Синхронный таймер
function UNIT_TmTimerSync(_steps, _ftick, _finit, _ffree) : __UNIT_TmTimerTimelapse(_steps, _ftick, _finit, _ffree) constructor {
	
	#region __private
	
	static __tick = function(_handler, _timer, _super) {
		
		if (_timer.__step > 0) {
		
			--_timer.__step;
			
			#region PREPROCESSOR
			__UNIT_TM_SKIP_VOID_TICK_TIMELAPSE;
			#endregion
			
			if (_timer.__ftick(_handler, _timer, _super) == true) {
				return true;
			}
			
			return (_timer.__step == 0);
		}
	}
	
	#endregion
	
	static _clone = function() {
		if (UNIT_PREPROCESSOR_TM_ENABLE_CLONE) {
		
		return self.__clone(UNIT_TmTimerSync);
		
		}
		else {
		
		show_error(__UNIT_TM_ERROR_CLONE, true);
		
		}
	}
	
}

/// @function		UNIT_TmTimerSyncExt(steps, [ftick], [finit], [ffree]);
/// @description	Синхронный таймер
function UNIT_TmTimerSyncExt(_steps, _ftick, _finit, _ffree) : __UNIT_TmTimerTimelapseExt(_steps, _ftick, _finit, _ffree) constructor {
	
	#region __private
	
	static __tickStep = 1;
	
	static __tick = function(_handler, _timer, _super) {
		
		if (_timer.__step > 0) {
		
			_timer.__step = max(0, _timer.__step - _timer.__tickStep);
			
			#region PREPROCESSOR
			__UNIT_TM_SKIP_VOID_TICK_TIMELAPSE;
			#endregion
			
			if (_timer.__ftick(_handler, _timer, _super) == true) {
				return true;
			}
			
			return (_timer.__step == 0);
		}
	}
	
	#endregion
	
	static setStep = function(_step=1) {
		self.__tickStep = _step;
		return self;
	}
	
	static getStep = function() {
		return self.__tickStep;
	}
	
	static _clone = function() {
		if (UNIT_PREPROCESSOR_TM_ENABLE_CLONE) {
		
		var _timer = self.__clone(UNIT_TmTimerSyncExt);
		_timer.__tickStep = self.__tickStep;
		
		return _timer;
		
		}
		else {
		
		show_error(__UNIT_TM_ERROR_CLONE, true);
		
		}
	}
	
}

