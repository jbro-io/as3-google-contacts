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
	 * @modified Feb 26, 2010
	 */
	public class ServiceResponse extends Event
	{
		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------
		public static const ALL_CONTACTS:String = "allContactsReceived";
		
		private var _contactData:Object;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		/**
		 * Constructor definition.
		 */
		public function ServiceResponse(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Properties
		//
		//--------------------------------------------------------------------------
		/**
		 * contactData description here.
		 * 
		 * @public
		 */
		public function get contactData():Object
		{
			return _contactData;
		}
		
		public function set contactData(value:Object):void
		{
			_contactData = value;
		}
	}
}