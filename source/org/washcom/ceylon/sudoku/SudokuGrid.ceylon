doc("A Grid is a segment of a Sodoku puzzle that is filled with sequential integers, typically 3x3")
class SodokuGrid(Integer length, Integer width) satisfies Solvable {
	
	assert (length > 0 && length <= 3);
	assert (width > 0 && width <= 3);

	Integer gridSize = length * width;
	Array<Integer?> numbers = arrayOfSize<Integer?>(gridSize, null);

	doc("Returns the elements of the grid that are non-empty")
	Integer[] filled() {
		return [for (n in numbers) if (exists n) n];
	}

	shared void clear(Integer rowNumber, Integer colNumber) {
		fill(rowNumber, colNumber, null);
	}

	shared void fill(Integer rowNumber, Integer colNumber, Integer? val) {
		assert (rowNumber > 0 && rowNumber <= length);
		assert (colNumber > 0 && colNumber <= width);
		if (exists val) {
			assert (val > 0 && val <= gridSize);
		}
		numbers.set((rowNumber - 1) * width + colNumber - 1, val);
	}

	shared SodokuGrid fillWith(Integer?[] values) {
		variable Integer index = 0;
		for (row in 1..length) {
			for (col in 1..width) {
				if (index == values.size) {
					return this;
				}
				fill(row, col, values.get(index));
				index = index + 1;
			}
		}
		return this;
	}

	shared SodokuGrid fillAllSequentialy() {
		//variable Integer val = 1;
		//for (row in 1..length) {
		//	for (col in 1..width) {
		//		fill(row, col, val);
		//		val = val + 1;
		//	}
		//}
		return fillWith([ for (id in 1..gridSize) id]);
	}

	doc("A completed grid is one that is entirely non-empty")
	shared Boolean isCompleted() {
		return filled().size == gridSize;
	}

	doc("A solved grid has is complete and does not repeat numbers, i.e. contains 1-9 for a 3x3 grid")
	shared actual Boolean isSolved() {
		for (n in 0..gridSize - 1) {
			if (!numbers.contains(n)) {
				return false;
			}
		}
		return true;
	}

	// row 1->0, 1, 2; row 2->3, 4, 5; row 3->6, 7, 8
	shared Integer?[] row(Integer rowNumber) {
		assert (rowNumber > 0 && rowNumber <= length);
		Integer start = (rowNumber - 1) * width;
		return [for (col in 0..width - 1) numbers[start + col]];
	}

	// col 1 -> 0, 3, 6; col 2->1, 4, 7; col 3->2, 5, 8
	shared Integer?[] col(Integer colNumber) {
		assert (colNumber > 0 && colNumber <= width);
		Integer start = colNumber - 1;
		return [for (row in 0..length - 1) numbers[start + (width * row)]];
	}

	shared Integer? valueAt(Integer rowNumber, Integer colNumber) {
		return numbers.get((rowNumber - 1) * width + colNumber - 1);
	}

}