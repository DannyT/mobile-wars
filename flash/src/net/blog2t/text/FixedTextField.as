/*---------------------------------------------------------------------------------------------

	[AS3] FixedTextField
	=======================================================================================

	Fixes the kerning bug of the TextField

	TextField.htmlText kerning bug fix trick discovered by Destroy Today
	@see http://www.destroytoday.com/?id=120

	VERSION HISTORY:
	v0.1	Born on 22/04/2009
	v0.2	9/6/2009	Added TextFormat cloning
	v0.3	27/6/2009	Added Extra height depends on the default TextFormat leading
						@see http://www.lukesturgeon.co.uk/lab/2009/06/fixed-vertical-scrolling-text-bug

	USAGE:

	var textTF:FixedTextField = new FixedTextField(new TextMC().textTF);
	var textTF:FixedTextField = new FixedTextField();

	TODOs:

	DEV IDEAS:

	KNOWN ISSUES:

---------------------------------------------------------------------------------------------*/

package net.blog2t.text
{
	// IMPORTS ////////////////////////////////////////////////////////////////////////////////

	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;

	import flash.utils.describeType;

	// CLASS //////////////////////////////////////////////////////////////////////////////////

	public class FixedTextField extends TextField
	{
		// MEMBERS ////////////////////////////////////////////////////////////////////////////
	
		private var recordedHeight:Number;
		private var heightLock:Boolean = false; 
		
		// CONSTRUCTOR ////////////////////////////////////////////////////////////////////////
		
		public function FixedTextField(referenceTextField:TextField = null, debug:Boolean = false) 
		{
			super();
			
			// as we can't clone (duplicate) a TextField directly, we need to clone properties of the reference one
			if (referenceTextField)
			{
				var description:XML = describeType(referenceTextField);
			
				for each (var item:XML in description.accessor)
				{
					// clone passed textfield properties that are not readonly
					if (item.@access != "readonly" && item.@access != "writeonly") this[item.@name] = referenceTextField[item.@name];
				}
			}
		
			// specifies whether extra white space (spaces, line breaks, and so on) in a text field with HTML text should be removed
			condenseWhite = true;
			
			// clone the textFormat of referenceTextField as well
			defaultTextFormat = referenceTextField.getTextFormat();
			
			// store current referenceTextField height
			recordedHeight = super.height;
			
			// draws border when debug is on
			if (debug)
			{
				border = true;
				borderColor = 0xFF0000;
			}
		}
		
		// GETTERS & SETTERS //////////////////////////////////////////////////////////////////
		
		override public function set htmlText(value:String):void
		{	
			heightLock = true;
			
			autoSize = TextFieldAutoSize.LEFT;
			super.htmlText = value;
			recordedHeight = height;
			autoSize = TextFieldAutoSize.NONE;
			// adding extra height will prevent "vertical scroll on text select" bug
			// the extra height value should be just bigger than the default leading – discovered by Luke Sturgeon
			// @see http://www.lukesturgeon.co.uk/lab/2009/06/fixed-vertical-scrolling-text-bug/
			height = recordedHeight + getTextFormat().leading + 1;
			
			heightLock = false;
		}
		
		override public function get height():Number
		{
			// heightLock used to return the original (unmodified) TextField height 
			return (heightLock) ? super.height : recordedHeight;
		}
	}
}