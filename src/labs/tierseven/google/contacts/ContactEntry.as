package labs.tierseven.google.contacts
{
	//--------------------------------------------------------------------------
	//
	//  Imports
	//
	//--------------------------------------------------------------------------
	import com.adobe.xml.syndication.ParsingTools;
	import com.adobe.xml.syndication.atom.Entry;
	
	import mx.collections.ArrayCollection;
	
	
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
			//instantiate return string
			var rtrn:String = "";
			
			//retrieve xml email list
			var emailList:XMLList = this.x.gd::email.@address;
			
			//check for multiple address
			if(emailList.length() > 1)
			{
				//consolidate multiple addresses into single comma separated string
				for(var i:int=0; i<emailList.length(); i++)
				{
					if(i != emailList.length()-1)
						rtrn += emailList[i] + ", ";
					else
						rtrn += emailList[i];
				}
			}
			else
			{
				rtrn = emailList.toString();
			}
			
			return rtrn;
		}
		
		/*public function get emails():ArrayCollection
		{
			//instantiate return array
			var returnEmails:ArrayCollection = new ArrayCollection();;
			
			//retrieve xml email list
			var emailList:XMLList = this.x.gd::email.@address;
			
			if(emailList.length() > 0)
			{
				//iterate email list
				var totalEmails:int = emailList.length();
				for(var i:int=0; i<totalEmails; i++)
				{
					returnEmails.addItem(emailList[i].toString());
				}
			}
			
			return returnEmails;
		}*/
	}
}