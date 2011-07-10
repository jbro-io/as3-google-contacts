package labs.tierseven.google.contacts
{
	//--------------------------------------------------------------------------
	//
	//  Imports
	//
	//--------------------------------------------------------------------------
	import com.adobe.xml.syndication.Namespaces;
	import com.adobe.xml.syndication.ParsingTools;
	import com.adobe.xml.syndication.atom.Atom10;
	
	
	/**
	 * Description of this class.
	 *
	 * @author Jonathan Broquist
	 * @modified Mar 9, 2010
	 */
	public class ContactFeed extends Atom10
	{
		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------
		private var atom:Namespace = Namespaces.ATOM_NS;
		private var _entries:Array;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		/**
		 * Constructor.
		 */
		public function ContactFeed()
		{
			super();
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
		override public function get entries():Array
		{
			if(ParsingTools.nullCheck(this.x.atom::entry) == null)
			{
				return null;
			}
			
			if(this._entries == null)
			{
				this._entries = [];
				var i:XML;
				for each(i in this.x.atom::entry)
				{
					this._entries.push(new ContactEntry(XMLList(i)));
				}
			}
			
			return this._entries;
		}
	}
}