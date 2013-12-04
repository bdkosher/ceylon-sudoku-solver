doc("Represents the entire Sodoku puzzle game")
by("Joe Wolf")
class SodokuPuzzle(Integer gridLength, Integer gridWidth) {

	Integer length = gridLength * gridLength;
	Integer width = gridWidth * gridWidth;
	SodokuGrid[] grids = [for (l in 1..gridLength) for (w in 1..gridWidth) SodokuGrid(gridLength, gridWidth)];
	
	SodokuGrid indexer = SodokuGrid(gridLength, gridWidth);
	indexer.fillAllSequentialy();

	shared void clear(Integer rowNumber, Integer colNumber) {
		fill(rowNumber, colNumber, null);
	}

	Integer gridRow(Integer rowNumber) {
		assert (rowNumber > 0, rowNumber <= length);
		return rowNumber / gridLength;
	}

	Integer gridCol(Integer colNumber) {
		assert (colNumber > 0, colNumber <= width);
		return colNumber / gridWidth;
	}

	SodokuGrid gridFor(Integer rowNumber, Integer colNumber) {
		Integer? gridNumber = indexer.row(gridRow(rowNumber)).get(gridCol(colNumber));
		assert (exists gridNumber);
		SodokuGrid? grid = grids.get(gridNumber);
		assert (exists grid);
		return grid;
	}

	SodokuGrid[] gridsForRow(Integer rowNumber) {
		assert (rowNumber > 0, rowNumber <= length);
		return [ for (gridCol in 0..gridWidth) gridFor(rowNumber, gridCol * gridWidth) ];
	}

	SodokuGrid[] gridsForCol(Integer colNumber) {
		assert (colNumber > 0, colNumber <= width);
		return [ for (gridRow in 0..gridLength) gridFor(gridRow * gridLength, colNumber) ];
	}

	/*Integer?[] flatten(Integer?[][] nested) {
		Array<Integer?> flattened = arrayOfSize<Integer?>(size, null);
		variable Integer index = 0;
		for (ne in nested) {
			for (e in ne) {
				flattened.set(index, e);
				index = index + 1;
			}
		}
		return flattened.sequence;
	}*/

	shared Integer?[] row(Integer rowNumber) {
		return concatenate(*[ for (grid in gridsForRow(rowNumber)) grid.row(gridRow(rowNumber))]);
	}

	shared Integer?[] col(Integer colNumber) {
		return concatenate(*[ for (grid in gridsForCol(colNumber)) grid.row(gridCol(colNumber))]);
	}
	
	shared void fill(Integer rowNumber, Integer colNumber, Integer? val) {
		gridFor(rowNumber, colNumber).fill(gridRow(rowNumber), gridCol(colNumber), val);
	}

	shared Integer? valueAt(Integer rowNumber, Integer colNumber) {
		return gridFor(rowNumber, colNumber).valueAt(gridRow(rowNumber), gridCol(colNumber));
	}
	
	doc("A completed grid is one that is entirely non-empty")
	shared Boolean isCompleted() {
		for (grid in grids) {
			if (!grid.isCompleted()) {
				return false;
			}
		}
		return true;
	}

	shared Boolean check(Integer?[] values) {
		return SodokuGrid(gridLength, gridWidth).fillWith(values).isSolved();
	}

	shared Boolean isSolved() {
		// each grid must be solved
		for (grid in grids) {
			if (!grid.isSolved()) {
				return false;
			}
		}
		// each row must be complete and contain unique values
		for (rowNumber in 1..length) {
			if (!check(row(rowNumber))) {
				return false;
			}
		}
		// each column must be complete and contain unqiue values
		for (colNumber in 1..width) {
			if (!check(col(colNumber))) {
				return false;
			}
		}
		return true;
	}
}