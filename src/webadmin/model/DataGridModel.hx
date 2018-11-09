package webadmin.model;

import coconut.data.Model;

/**
 * Grid column model
 */
class GridColumnModel implements Model {
    /**
	 * Column title
	 */
	@:constant public var index:Int;

	/**
	 * Column title
	 */
	@:constant public var title:String;
}

/**
 * Grid row model
 */
class GridRowModel implements Model {
    /**
     * Return value for row by column index
     * @param index 
     */
    public function getValue(index:Int) {
        return "GOOD";
    }
}

/**
 * Model for data grid
 */
class DataGridModel implements Model {
	/**
	 * Columns of grid
	 */
	@:constant public var columns:tink.pure.List<GridColumnModel> = @byDefault new tink.pure.List<GridColumnModel>();

	/**
	 * Rows of grid
	 */
	@:constant public var rows:tink.pure.List<GridRowModel> = @byDefault new tink.pure.List<GridRowModel>();
}
