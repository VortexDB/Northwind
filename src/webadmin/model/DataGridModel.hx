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

	@:constant public var values:tink.pure.List<Dynamic> = @byDefault new tink.pure.List<Dynamic>();
}

/**
 * Adapter for DataGridModel
 */
@:pure
interface IDataGridModelAdapter {
	/**
	 * Return columns
	 */
	public function getColumns():tink.pure.List<GridColumnModel>;

	/**
	 * Return rows
	 */
	public function getRows():tink.pure.List<GridRowModel>;

	/**
     * Return value as formatted string for row by column index
     * @param index 
     */
    public function getValue(values:tink.pure.List<Dynamic>, index:Int):String;
}

/**
 * Model for data grid
 */
class DataGridModel implements Model {
	/**
	 * Adapter for
	 */
	public var adapter:IDataGridModelAdapter;

	/**
	 * Columns of grid
	 */
	@:computed public var columns:tink.pure.List<GridColumnModel> = return adapter.getColumns();

	/**
	 * Rows of grid
	 */
	@:computed public var rows:tink.pure.List<GridRowModel> = return adapter.getRows();
}
