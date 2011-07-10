package labs.tierseven.google.contacts
{
	//--------------------------------------------------------------------------
	//
	//  Imports
	//
	//--------------------------------------------------------------------------
	import com.adobe.xml.syndication.ParsingTools;
	import com.adobe.xml.syndication.atom.Entry;
	
	
	/**
	 * Description of this class.
	 *
	 * @author Jonathan Broquist
	 * @modified Mar 9, 2010
	 */
	public class ContactEntry extends Entry
	{
		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------
		private var gd:Namespace = new Namespace("http://schemas.google.com/g/2005");
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		/**
		 * Constructor.
		 */
		public function ContactEntry(x:XMLList)
		{
			super(x);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Methods
		//
		//--------------------------------------------------------------------------
		
		//--------------------------------------------------------------------------
		//
		//  Event Handlers
		//
		//--------------------------------------------------------------------------
		
		//--------------------------------------------------------------------------
		//
		//  Properties
		//
		//--------------------------------------------------------------------------
		public function get phoneNumber():String
		{
			return ParsingTools.nullCheck(this.x.gd::phoneNumber);
		}
		
		public function get email():String
		{
			return ParsingTools.nullCheck(this.x.gd::email);
		}
	}
}