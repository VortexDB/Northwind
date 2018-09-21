// Generated by Haxe 4.0.0-preview.4+1e3e5e016
package haxe.io;

import haxe.root.*;

@SuppressWarnings(value={"rawtypes", "unchecked"})
public class Bytes extends haxe.lang.HxObject
{
	public Bytes(haxe.lang.EmptyObject empty)
	{
	}
	
	
	public Bytes(int length, byte[] b)
	{
		//line 33 "C:\\HaxeToolkit\\haxe\\std\\haxe\\io\\Bytes.hx"
		haxe.io.Bytes.__hx_ctor_haxe_io_Bytes(this, length, b);
	}
	
	
	protected static void __hx_ctor_haxe_io_Bytes(haxe.io.Bytes __hx_this, int length, byte[] b)
	{
		//line 34 "C:\\HaxeToolkit\\haxe\\std\\haxe\\io\\Bytes.hx"
		__hx_this.length = length;
		//line 35 "C:\\HaxeToolkit\\haxe\\std\\haxe\\io\\Bytes.hx"
		__hx_this.b = b;
	}
	
	
	public static haxe.io.Bytes ofString(java.lang.String s)
	{
		//line 489 "C:\\HaxeToolkit\\haxe\\std\\haxe\\io\\Bytes.hx"
		try 
		{
			//line 490 "C:\\HaxeToolkit\\haxe\\std\\haxe\\io\\Bytes.hx"
			byte[] b = s.getBytes(haxe.lang.Runtime.toString("UTF-8"));
			//line 491 "C:\\HaxeToolkit\\haxe\\std\\haxe\\io\\Bytes.hx"
			return new haxe.io.Bytes(b.length, b);
		}
		catch (java.lang.Throwable catchallException)
		{
			//line 488 "C:\\HaxeToolkit\\haxe\\std\\haxe\\io\\Bytes.hx"
			haxe.lang.Exceptions.setException(catchallException);
			//line 493 "C:\\HaxeToolkit\\haxe\\std\\haxe\\io\\Bytes.hx"
			java.lang.Object realException = ( (( catchallException instanceof haxe.lang.HaxeException )) ? (((haxe.lang.HaxeException) (catchallException) ).obj) : (catchallException) );
			//line 493 "C:\\HaxeToolkit\\haxe\\std\\haxe\\io\\Bytes.hx"
			java.lang.Object e = realException;
			//line 493 "C:\\HaxeToolkit\\haxe\\std\\haxe\\io\\Bytes.hx"
			throw haxe.lang.HaxeException.wrap(e);
		}
		
		
	}
	
	
	public int length;
	
	public byte[] b;
	
	@Override public double __hx_setField_f(java.lang.String field, double value, boolean handleProperties)
	{
		//line 28 "C:\\HaxeToolkit\\haxe\\std\\haxe\\io\\Bytes.hx"
		{
			//line 28 "C:\\HaxeToolkit\\haxe\\std\\haxe\\io\\Bytes.hx"
			boolean __temp_executeDef1 = true;
			//line 28 "C:\\HaxeToolkit\\haxe\\std\\haxe\\io\\Bytes.hx"
			switch (field.hashCode())
			{
				case -1106363674:
				{
					//line 28 "C:\\HaxeToolkit\\haxe\\std\\haxe\\io\\Bytes.hx"
					if (field.equals("length")) 
					{
						//line 28 "C:\\HaxeToolkit\\haxe\\std\\haxe\\io\\Bytes.hx"
						__temp_executeDef1 = false;
						//line 28 "C:\\HaxeToolkit\\haxe\\std\\haxe\\io\\Bytes.hx"
						this.length = ((int) (value) );
						//line 28 "C:\\HaxeToolkit\\haxe\\std\\haxe\\io\\Bytes.hx"
						return value;
					}
					
					//line 28 "C:\\HaxeToolkit\\haxe\\std\\haxe\\io\\Bytes.hx"
					break;
				}
				
				
			}
			
			//line 28 "C:\\HaxeToolkit\\haxe\\std\\haxe\\io\\Bytes.hx"
			if (__temp_executeDef1) 
			{
				//line 28 "C:\\HaxeToolkit\\haxe\\std\\haxe\\io\\Bytes.hx"
				return super.__hx_setField_f(field, value, handleProperties);
			}
			else
			{
				//line 28 "C:\\HaxeToolkit\\haxe\\std\\haxe\\io\\Bytes.hx"
				throw null;
			}
			
		}
		
	}
	
	
	@Override public java.lang.Object __hx_setField(java.lang.String field, java.lang.Object value, boolean handleProperties)
	{
		//line 28 "C:\\HaxeToolkit\\haxe\\std\\haxe\\io\\Bytes.hx"
		{
			//line 28 "C:\\HaxeToolkit\\haxe\\std\\haxe\\io\\Bytes.hx"
			boolean __temp_executeDef1 = true;
			//line 28 "C:\\HaxeToolkit\\haxe\\std\\haxe\\io\\Bytes.hx"
			switch (field.hashCode())
			{
				case 98:
				{
					//line 28 "C:\\HaxeToolkit\\haxe\\std\\haxe\\io\\Bytes.hx"
					if (field.equals("b")) 
					{
						//line 28 "C:\\HaxeToolkit\\haxe\\std\\haxe\\io\\Bytes.hx"
						__temp_executeDef1 = false;
						//line 28 "C:\\HaxeToolkit\\haxe\\std\\haxe\\io\\Bytes.hx"
						this.b = ((byte[]) (value) );
						//line 28 "C:\\HaxeToolkit\\haxe\\std\\haxe\\io\\Bytes.hx"
						return value;
					}
					
					//line 28 "C:\\HaxeToolkit\\haxe\\std\\haxe\\io\\Bytes.hx"
					break;
				}
				
				
				case -1106363674:
				{
					//line 28 "C:\\HaxeToolkit\\haxe\\std\\haxe\\io\\Bytes.hx"
					if (field.equals("length")) 
					{
						//line 28 "C:\\HaxeToolkit\\haxe\\std\\haxe\\io\\Bytes.hx"
						__temp_executeDef1 = false;
						//line 28 "C:\\HaxeToolkit\\haxe\\std\\haxe\\io\\Bytes.hx"
						this.length = ((int) (haxe.lang.Runtime.toInt(value)) );
						//line 28 "C:\\HaxeToolkit\\haxe\\std\\haxe\\io\\Bytes.hx"
						return value;
					}
					
					//line 28 "C:\\HaxeToolkit\\haxe\\std\\haxe\\io\\Bytes.hx"
					break;
				}
				
				
			}
			
			//line 28 "C:\\HaxeToolkit\\haxe\\std\\haxe\\io\\Bytes.hx"
			if (__temp_executeDef1) 
			{
				//line 28 "C:\\HaxeToolkit\\haxe\\std\\haxe\\io\\Bytes.hx"
				return super.__hx_setField(field, value, handleProperties);
			}
			else
			{
				//line 28 "C:\\HaxeToolkit\\haxe\\std\\haxe\\io\\Bytes.hx"
				throw null;
			}
			
		}
		
	}
	
	
	@Override public java.lang.Object __hx_getField(java.lang.String field, boolean throwErrors, boolean isCheck, boolean handleProperties)
	{
		//line 28 "C:\\HaxeToolkit\\haxe\\std\\haxe\\io\\Bytes.hx"
		{
			//line 28 "C:\\HaxeToolkit\\haxe\\std\\haxe\\io\\Bytes.hx"
			boolean __temp_executeDef1 = true;
			//line 28 "C:\\HaxeToolkit\\haxe\\std\\haxe\\io\\Bytes.hx"
			switch (field.hashCode())
			{
				case 98:
				{
					//line 28 "C:\\HaxeToolkit\\haxe\\std\\haxe\\io\\Bytes.hx"
					if (field.equals("b")) 
					{
						//line 28 "C:\\HaxeToolkit\\haxe\\std\\haxe\\io\\Bytes.hx"
						__temp_executeDef1 = false;
						//line 28 "C:\\HaxeToolkit\\haxe\\std\\haxe\\io\\Bytes.hx"
						return this.b;
					}
					
					//line 28 "C:\\HaxeToolkit\\haxe\\std\\haxe\\io\\Bytes.hx"
					break;
				}
				
				
				case -1106363674:
				{
					//line 28 "C:\\HaxeToolkit\\haxe\\std\\haxe\\io\\Bytes.hx"
					if (field.equals("length")) 
					{
						//line 28 "C:\\HaxeToolkit\\haxe\\std\\haxe\\io\\Bytes.hx"
						__temp_executeDef1 = false;
						//line 28 "C:\\HaxeToolkit\\haxe\\std\\haxe\\io\\Bytes.hx"
						return this.length;
					}
					
					//line 28 "C:\\HaxeToolkit\\haxe\\std\\haxe\\io\\Bytes.hx"
					break;
				}
				
				
			}
			
			//line 28 "C:\\HaxeToolkit\\haxe\\std\\haxe\\io\\Bytes.hx"
			if (__temp_executeDef1) 
			{
				//line 28 "C:\\HaxeToolkit\\haxe\\std\\haxe\\io\\Bytes.hx"
				return super.__hx_getField(field, throwErrors, isCheck, handleProperties);
			}
			else
			{
				//line 28 "C:\\HaxeToolkit\\haxe\\std\\haxe\\io\\Bytes.hx"
				throw null;
			}
			
		}
		
	}
	
	
	@Override public double __hx_getField_f(java.lang.String field, boolean throwErrors, boolean handleProperties)
	{
		//line 28 "C:\\HaxeToolkit\\haxe\\std\\haxe\\io\\Bytes.hx"
		{
			//line 28 "C:\\HaxeToolkit\\haxe\\std\\haxe\\io\\Bytes.hx"
			boolean __temp_executeDef1 = true;
			//line 28 "C:\\HaxeToolkit\\haxe\\std\\haxe\\io\\Bytes.hx"
			switch (field.hashCode())
			{
				case -1106363674:
				{
					//line 28 "C:\\HaxeToolkit\\haxe\\std\\haxe\\io\\Bytes.hx"
					if (field.equals("length")) 
					{
						//line 28 "C:\\HaxeToolkit\\haxe\\std\\haxe\\io\\Bytes.hx"
						__temp_executeDef1 = false;
						//line 28 "C:\\HaxeToolkit\\haxe\\std\\haxe\\io\\Bytes.hx"
						return ((double) (this.length) );
					}
					
					//line 28 "C:\\HaxeToolkit\\haxe\\std\\haxe\\io\\Bytes.hx"
					break;
				}
				
				
			}
			
			//line 28 "C:\\HaxeToolkit\\haxe\\std\\haxe\\io\\Bytes.hx"
			if (__temp_executeDef1) 
			{
				//line 28 "C:\\HaxeToolkit\\haxe\\std\\haxe\\io\\Bytes.hx"
				return super.__hx_getField_f(field, throwErrors, handleProperties);
			}
			else
			{
				//line 28 "C:\\HaxeToolkit\\haxe\\std\\haxe\\io\\Bytes.hx"
				throw null;
			}
			
		}
		
	}
	
	
	@Override public void __hx_getFields(haxe.root.Array<java.lang.String> baseArr)
	{
		//line 28 "C:\\HaxeToolkit\\haxe\\std\\haxe\\io\\Bytes.hx"
		baseArr.push("b");
		//line 28 "C:\\HaxeToolkit\\haxe\\std\\haxe\\io\\Bytes.hx"
		baseArr.push("length");
		//line 28 "C:\\HaxeToolkit\\haxe\\std\\haxe\\io\\Bytes.hx"
		super.__hx_getFields(baseArr);
	}
	
	
}


