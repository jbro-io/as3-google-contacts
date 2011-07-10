package labs.tierseven.google.contacts
{
	//--------------------------------------------------------------------------
	//
	//  Imports
	//
	//--------------------------------------------------------------------------
	import com.adobe.xml.syndication.atom.Atom10;
	import com.sourcestream.flex.http.HttpEvent;
	import com.sourcestream.flex.http.HttpResponse;
	import com.sourcestream.flex.http.RestHttpService;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.utils.Dictionary;
	
	import mx.collections.ArrayCollection;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.utils.ObjectUtil;
	
	//TODO Write class description.
	/**
	 * Insert Class Description
	 */
	public class ContactService extends EventDispatcher
	{
		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------
		private var _serv:RestHttpService;
		private var _username:String;
		private var _password:String;
		private var _securityToken:String;
		private var _uniqueId:String;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		public function ContactService(username:String=null, password:String=null,uniqueId:String=null)
		{
			//initialize service
			_serv = new RestHttpService();
			_serv.server = "www.google.com";
			_serv.secure = true;
			_serv.port = 443;
			_serv.method = "POST";
			_serv.contentType = "application/x-www-form-urlencoded";
			//add service event listeners
			_serv.addEventListener(ResultEvent.RESULT, onResult);
			_serv.addEventListener(FaultEvent.FAULT, onFault);
			
			_username = username;
			_password = password;
			_uniqueId = uniqueId;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Functions
		//
		//--------------------------------------------------------------------------
		/**
		 * Sends a login request to the Google Contacts API. If successful, the
		 * authorization id sent back from Google will be set.
		 * 
		 * @public
		 */
		public function connect():void
		{
			if(_username && _password)
			{
				_serv.doPost(googleLogin,"");
			}
			else
			{
				throw new Error("Missing google login credentials.");
			}
		}
		
		/**
		 * Requests a list of google contacts for the logged in user.
		 * 
		 * @param limit Maximum number of contact results to return. Defualt value is 50.
		 * @default 50
		 * @public
		 */
		public function getAllContacts(limit:int=50):void
		{
			//Set Parameters
			var params:Dictionary = new Dictionary();
			params["max-results"] = limit;
			//Request All Contacts
			_serv.doGet("/m8/feeds/contacts/"+_username+"/full",params);
		}
		
		/**
		 * Parses a feed returned from Google and returns a collection of
		 * results.
		 * 
		 * @private
		 */
		private function parseFeed(feed:XML):ArrayCollection
		{
			//todo parse xml feed as Atom 1.0
			
			return null;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Event Handlers
		//
		//--------------------------------------------------------------------------
		/**
		 * @private
		 */
		private function onResult(ev:HttpEvent):void
		{
			//get response
			var e:HttpResponse = ev.response;
			//trace("EVENT RESULT:\n"+ ObjectUtil.toString(ev));
			
			//check if the response was successful
			if(e.statusCode == 200)
			{
				//Dispatch proper event function
				switch(ev.resource)
				{
					case googleLogin:
						onLogin(e);
						break;
					case googleContactsFeed:
						onGoogleContactsFeed(e);
						break;
				}
			}
		}
		
		/**
		 * @private
		 */
		private function onFault(ev:Event):void
		{
			//output fault to console
			/*
			trace("[---------------------------- ERROR: FAULT ----------------------------]\n"+
				ObjectUtil.toString(ev) + "\n" +
				"[----------------------------------------------------------------------]"
			);
			*/
		}
		
		/**
		 * @private
		 */
		private function onLogin(ev:HttpResponse):void
		{
			//set authorization id
			var authToken:String = ev.body.split("Auth=")[1];
			_serv.googleAuthToken = authToken;
			
			dispatchEvent(new ContactServiceEvent(ContactServiceEvent.LOGIN_SUCCESS));
		}
		
		/**
		 * @private
		 */
		private function onGoogleContactsFeed(ev:HttpResponse):void
		{
			//parse returned atom feed
			var feed:ContactFeed = new ContactFeed();
			feed.parse(ev.body);
			
			//dispatch contacts reveived event
			var cr:ContactServiceEvent = new ContactServiceEvent(ContactServiceEvent.CONTACTS_RECEIVED);
			cr.feed = feed;
			dispatchEvent(cr);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Properties
		//
		//--------------------------------------------------------------------------
		/**
		 * Google account username.
		 * GMail:
		 * <em><your_name>@gmail.com</em>
		 * Google Apps:
		 * <em><your_name>@<your_domain>.com</em>
		 * 
		 * @public
		 */
		public function get username():String
		{
			return _username;
		}
		
		public function set username(value:String):void
		{
			_username = value;
		}
		
		/**
		 * Google account password.
		 * 
		 * @public
		 */
		public function get password():String
		{
			return _password;
		}
		
		public function set password(value:String):void
		{
			_password = value;
		}
		
		/**
		 * Unique application Id.
		 * 
		 * @public
		 */
		public function get uniqueId():String
		{
			return _uniqueId;
		}
		
		public function set uniqueId(value:String):void
		{
			_uniqueId = value;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Google Resource Strings
		//
		//--------------------------------------------------------------------------
		/**
		 * Login string for google contacts API.
		 * 
		 * @private
		 */
		private function get googleLogin():String
		{
			return "/accounts/ClientLogin?accountType=HOSTED_OR_GOOGLE&Email="+_username+"&Passwd="+_password+"&service=cp&source="+_uniqueId;
		}
		
		private function get googleContactsFeed():String
		{
			return "/m8/feeds/contacts/"+_username+"/full";
		}
		
	}
}