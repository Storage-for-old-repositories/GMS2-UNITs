
/*
	Эти переменные используются в качестве результата функций:
		UNIT_simcollMove_single
		UNIT_simcollMove_double
		UNIT_simcollJump
*/

global.UNIT_simcollDist = 0; // Используется для сохранения найденной скорости/растояния

function UNIT_simcollGetDist() {
	return global.UNIT_simcollDist;
}

