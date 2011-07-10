package labs.tierseven.google.contacts
{
	//--------------------------------------------------------------------------
	//
	//  Imports
	//
	//--------------------------------------------------------------------------
	import flash.events.Event;
	
	
	/**
	 * Description of this class.
	 *
	 * @author Jonathan Broquist
	 * @modified Mar 9, 2010
	 */
	public class ContactServiceEvent extends Event
	{
		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------
		public static const LOGIN_SUCCESS:String = "googleContactLoginSuccess";
		public static const CONTACTS_RECEIVED:String = "googleContactsReceived";
		
		public var feed:ContactFeed;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		/**
		 * Constructor.
		 */
		public function ContactServiceEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
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
	}
}