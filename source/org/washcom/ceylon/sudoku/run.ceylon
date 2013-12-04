"Run the module `org.washcom.ceylon.sudoku`."
shared void run() {
    SodokuGrid grid = SodokuGrid(3, 3);
	assert (!grid.isCompleted());
	assert (!grid.isSolved());
	grid.fillAllSequentialy();
	assert (grid.isCompleted());
	assert (grid.isSolved());
	assert ([1, 2, 3] == grid.row(1));
	assert ([4, 5, 6] == grid.row(2));
	assert ([7, 8, 9] == grid.row(3));
	assert ([1, 4, 7] == grid.col(1));
	assert ([2, 5, 8] == grid.col(2));
	assert ([3, 6, 9] == grid.col(3));

}