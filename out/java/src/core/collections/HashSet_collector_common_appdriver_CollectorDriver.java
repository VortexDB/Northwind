// Generated by Haxe 4.0.0-preview.4+1e3e5e016
package core.collections;

import haxe.root.*;

@SuppressWarnings(value={"rawtypes", "unchecked"})
public class HashSet_collector_common_appdriver_CollectorDriver extends haxe.lang.HxObject
{
	public HashSet_collector_common_appdriver_CollectorDriver(haxe.lang.EmptyObject empty)
	{
	}
	
	
	public HashSet_collector_common_appdriver_CollectorDriver()
	{
		//line 49 "d:\\Workspace\\Core\\src\\core\\collections\\HashSet.hx"
		core.collections.HashSet_collector_common_appdriver_CollectorDriver.__hx_ctor_core_collections_HashSet_collector_common_appdriver_CollectorDriver(this);
	}
	
	
	protected static void __hx_ctor_core_collections_HashSet_collector_common_appdriver_CollectorDriver(core.collections.HashSet_collector_common_appdriver_CollectorDriver __hx_this)
	{
		//line 50 "d:\\Workspace\\Core\\src\\core\\collections\\HashSet.hx"
		__hx_this.internalHashSet = new java.util.HashSet<java.lang.Object>();
		//line 51 "d:\\Workspace\\Core\\src\\core\\collections\\HashSet.hx"
		__hx_this.items = new haxe.root.Array<collector.common.appdriver.CollectorDriver>();
	}
	
	
	public java.util.HashSet<java.lang.Object> internalHashSet;
	
	public haxe.root.Array<collector.common.appdriver.CollectorDriver> items;
	
	
	
	@Override public java.lang.Object __hx_setField(java.lang.String field, java.lang.Object value, boolean handleProperties)
	{
		//line 27 "d:\\Workspace\\Core\\src\\core\\collections\\HashSet.hx"
		{
			//line 27 "d:\\Workspace\\Core\\src\\core\\collections\\HashSet.hx"
			boolean __temp_executeDef1 = true;
			//line 27 "d:\\Workspace\\Core\\src\\core\\collections\\HashSet.hx"
			switch (field.hashCode())
			{
				case 100526016:
				{
					//line 27 "d:\\Workspace\\Core\\src\\core\\collections\\HashSet.hx"
					if (field.equals("items")) 
					{
						//line 27 "d:\\Workspace\\Core\\src\\core\\collections\\HashSet.hx"
						__temp_executeDef1 = false;
						//line 27 "d:\\Workspace\\Core\\src\\core\\collections\\HashSet.hx"
						this.items = ((haxe.root.Array<collector.common.appdriver.CollectorDriver>) (value) );
						//line 27 "d:\\Workspace\\Core\\src\\core\\collections\\HashSet.hx"
						return value;
					}
					
					//line 27 "d:\\Workspace\\Core\\src\\core\\collections\\HashSet.hx"
					break;
				}
				
				
				case -673221897:
				{
					//line 27 "d:\\Workspace\\Core\\src\\core\\collections\\HashSet.hx"
					if (field.equals("internalHashSet")) 
					{
						//line 27 "d:\\Workspace\\Core\\src\\core\\collections\\HashSet.hx"
						__temp_executeDef1 = false;
						//line 27 "d:\\Workspace\\Core\\src\\core\\collections\\HashSet.hx"
						this.internalHashSet = ((java.util.HashSet<java.lang.Object>) (value) );
						//line 27 "d:\\Workspace\\Core\\src\\core\\collections\\HashSet.hx"
						return value;
					}
					
					//line 27 "d:\\Workspace\\Core\\src\\core\\collections\\HashSet.hx"
					break;
				}
				
				
			}
			
			//line 27 "d:\\Workspace\\Core\\src\\core\\collections\\HashSet.hx"
			if (__temp_executeDef1) 
			{
				//line 27 "d:\\Workspace\\Core\\src\\core\\collections\\HashSet.hx"
				return super.__hx_setField(field, value, handleProperties);
			}
			else
			{
				//line 27 "d:\\Workspace\\Core\\src\\core\\collections\\HashSet.hx"
				throw null;
			}
			
		}
		
	}
	
	
	@Override public java.lang.Object __hx_getField(java.lang.String field, boolean throwErrors, boolean isCheck, boolean handleProperties)
	{
		//line 27 "d:\\Workspace\\Core\\src\\core\\collections\\HashSet.hx"
		{
			//line 27 "d:\\Workspace\\Core\\src\\core\\collections\\HashSet.hx"
			boolean __temp_executeDef1 = true;
			//line 27 "d:\\Workspace\\Core\\src\\core\\collections\\HashSet.hx"
			switch (field.hashCode())
			{
				case 100526016:
				{
					//line 27 "d:\\Workspace\\Core\\src\\core\\collections\\HashSet.hx"
					if (field.equals("items")) 
					{
						//line 27 "d:\\Workspace\\Core\\src\\core\\collections\\HashSet.hx"
						__temp_executeDef1 = false;
						//line 27 "d:\\Workspace\\Core\\src\\core\\collections\\HashSet.hx"
						return this.items;
					}
					
					//line 27 "d:\\Workspace\\Core\\src\\core\\collections\\HashSet.hx"
					break;
				}
				
				
				case -673221897:
				{
					//line 27 "d:\\Workspace\\Core\\src\\core\\collections\\HashSet.hx"
					if (field.equals("internalHashSet")) 
					{
						//line 27 "d:\\Workspace\\Core\\src\\core\\collections\\HashSet.hx"
						__temp_executeDef1 = false;
						//line 27 "d:\\Workspace\\Core\\src\\core\\collections\\HashSet.hx"
						return this.internalHashSet;
					}
					
					//line 27 "d:\\Workspace\\Core\\src\\core\\collections\\HashSet.hx"
					break;
				}
				
				
			}
			
			//line 27 "d:\\Workspace\\Core\\src\\core\\collections\\HashSet.hx"
			if (__temp_executeDef1) 
			{
				//line 27 "d:\\Workspace\\Core\\src\\core\\collections\\HashSet.hx"
				return super.__hx_getField(field, throwErrors, isCheck, handleProperties);
			}
			else
			{
				//line 27 "d:\\Workspace\\Core\\src\\core\\collections\\HashSet.hx"
				throw null;
			}
			
		}
		
	}
	
	
	@Override public void __hx_getFields(haxe.root.Array<java.lang.String> baseArr)
	{
		//line 27 "d:\\Workspace\\Core\\src\\core\\collections\\HashSet.hx"
		baseArr.push("length");
		//line 27 "d:\\Workspace\\Core\\src\\core\\collections\\HashSet.hx"
		baseArr.push("items");
		//line 27 "d:\\Workspace\\Core\\src\\core\\collections\\HashSet.hx"
		baseArr.push("internalHashSet");
		//line 27 "d:\\Workspace\\Core\\src\\core\\collections\\HashSet.hx"
		super.__hx_getFields(baseArr);
	}
	
	
}


