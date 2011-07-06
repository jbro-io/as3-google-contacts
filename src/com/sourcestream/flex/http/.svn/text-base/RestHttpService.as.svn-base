/*
 * The MIT License
 *
 * Copyright (c) 2008
 * Dustin R. Callaway
 * http://www.sourcestream.com/
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */
package com.sourcestream.flex.http
{
import com.hurlant.crypto.tls.TLSSocket;

import flash.events.Event;
import flash.events.EventDispatcher;
import flash.events.IOErrorEvent;
import flash.events.ProgressEvent;
import flash.events.SecurityErrorEvent;
import flash.net.Socket;
import flash.system.Security;

import flash.utils.Dictionary;
import mx.utils.StringUtil;

// result event is fired when the web service's response is received
[Event(name="result", type="com.sourcestream.flex.http.HttpEvent")]

// fault event is fired in response to a security or IO error
[Event(name="fault", type="com.sourcestream.flex.http.HttpEvent")]

/**
 * Similar to Flex's HTTP service component but adds support for all HTTP methods.
 */
public class RestHttpService extends EventDispatcher
{
    public static const EVENT_RESULT:String = "result";
    public static const EVENT_FAULT:String = "fault";

    public static const METHOD_GET:String = "GET";
    public static const METHOD_POST:String = "POST";
    public static const METHOD_PUT:String = "PUT";
    public static const METHOD_DELETE:String = "DELETE";
    public static const METHOD_HEAD:String = "HEAD";
    public static const METHOD_OPTIONS:String = "OPTIONS";

    private static const DAYS:Array = new Array("Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat");
    private static const MONTHS:Array = new Array("Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep",
            "Oct", "Nov", "Dec");

    private var _socket:Socket;
    private var _secureSocket:TLSSocket;
    private var _server:String;
    private var _port:int;
    private var _policyFilePort:int;
    private var _method:String;
    private var _resource:String;
    private var _queryString:Dictionary;
    private var _body:String;
    private var _contentType:String;
    private var _secure:Boolean;
    private var _rawResponse:String;
    private var _policyFileLoaded:Boolean;
    private var _newSocketEachRequest:Boolean;

    /**
     * Constructs a new REST HTTP service object.
     *
     * @param server Web service provider to which this class should connect
     * @param port Port on which to connect to the server
     * @param secure Indicates whether or not service calls must be encrypted
     */
    public function RestHttpService(server:String=null, port:int=0, secure:Boolean=false, policyFilePort:int=0,
        newSocketEachRequest:Boolean=true)
    {
        _server = server;
        _port = port;
        _secure = secure;
        _policyFilePort = policyFilePort;
        _newSocketEachRequest = newSocketEachRequest;
    }

    /**
     * Before establishing socket connections from a flash application, a socket policy file must be loaded from the
     * target server (i.e., the server hosting the REST service). If the client has not already loaded such a
     * policy file, this can be accomplished by calling this convenience method. This call is not necessary if the
     * socket policy file is being served from port 843 (the well-known port for Flash policy files).
     *
     * @see http://www.adobe.com/devnet/flashplayer/articles/socket_policy_files.html
     *
     * @param server Server hosting the REST service
     * @param policyFilePort Port on which the server is listening for policy file requests
     */
    public static function loadPolicyFile(server:String, policyFilePort:int):void
    {
        Security.loadPolicyFile("xmlsocket://" + server + ":" + policyFilePort);
    }

    /**
     * Gets the address of the web service provider.
     *
     * @return Web service provider
     */
    public function get server():String
    {
        return _server;
    }

    /**
     * Sets the address of the web service provider.
     *
     * @param server Web service provider
     */
    public function set server(server:String):void
    {
        _server = server;
    }

    /**
     * Gets the port on which the web service provider is listening.
     *
     * @return Port on web service provider
     */
    public function get port():int
    {
        return _port;
    }

    /**
     * Sets the port on which the web service provider is listening.
     *
     * @param port Port on web service provider
     */
    public function set port(port:int):void
    {
        _port = port;
    }

    /**
     * Gets the port on which the server is listening for policy file requests.
     *
     * @return Port on which the server is listening for policy file requests
     */
    public function get policyFilePort():int
    {
        return _policyFilePort;
    }

    /**
     * Sets the port on which the server is listening for policy file requests.
     *
     * @param policyFilePort Port on which the server is listening for policy file requests
     */
    public function set policyFilePort(policyFilePort:int):void
    {
        _policyFilePort = policyFilePort;
    }

    /**
     * Gets the value indicating if a new socket should be created for each request. It has been observed that when
     * making multiple calls from the same event using the same socket, the socket does not connect after the first
     * call. Though not as efficient, creating a new socket each time resolves the problem.
     *
     * @return New socket indicator
     */
    public function get newSocketEachRequest():Boolean
    {
        return _newSocketEachRequest;
    }

    /**
     * Sets the value indicating if a new socket should be created for each request. It has been observed that when
     * making multiple calls from the same event using the same socket, the socket does not connect after the first
     * call. Though not as efficient, creating a new socket each time resolves the problem.
     *
     * @param newSocketEachRequest New socket indicator
     */
    public function set newSocketEachRequest(newSocketEachRequest:Boolean):void
    {
        _newSocketEachRequest = newSocketEachRequest;
    }

    /**
     * Gets the HTTP method to be used by this service (GET, POST, PUT, DELETE, HEAD, OPTIONS).
     *
     * @return HTTP method
     */
    [Inspectable(defaultValue="GET", enumeration="GET,POST,PUT,DELETE,HEAD,OPTIONS")]
    public function get method():String
    {
        return _method;
    }

    /**
     * Sets the HTTP method to be used by this service (GET, POST, PUT, DELETE, HEAD, OPTIONS).
     *
     * @param method HTTP method
     */
    [Inspectable(defaultValue="GET", enumeration="GET,POST,PUT,DELETE,HEAD,OPTIONS")]
    public function set method(method:String):void
    {
        _method = method;
    }

    /**
     * Gets the path to the resource (minus the server and port information).
     *
     * @return Path to resource
     */
    public function get resource():String
    {
        return _resource;
    }

    /**
     * Sets the path to the resource (minus the server and port information).
     *
     * @param resource Path to resource
     */
    public function set resource(resource:String):void
    {
        _resource = resource;
    }

    /**
     * Gets the content type of the request body.
     *
     * @return Content type of the request
     */
    public function get contentType():String
    {
        return _contentType;
    }

    /**
     * Sets the content type of the request body.
     *
     * @param contentType Content type of the request
     */
    public function set contentType(contentType:String):void
    {
        _contentType = contentType;
    }

    /**
     * Indicates whether or not a secure SSL connection should be used.
     *
     * @return Secure connection indicator
     */
    public function get secure():Boolean
    {
        return _secure;
    }

    /**
     * Sets whether or not a secure SSL connection should be used.
     *
     * @param secure Secure connection indicator
     */
    public function set secure(secure:Boolean):void
    {
        _secure = secure;
    }

    /**
     * Creates a socket and adds CONNECT and SOCKET_DATA event listeners.
     */
    private function createSocket():void
    {
        if (_server != null && _port != 0)
        {
            if (_policyFilePort > 0 && !_policyFileLoaded)
            {
                loadPolicyFile(_server, _policyFilePort);
                _policyFileLoaded = true;
            }

            if (_secure)
            {
                if (_newSocketEachRequest || _secureSocket == null)
                {
                    _secureSocket = new TLSSocket();
                    _secureSocket.addEventListener(Event.CONNECT, connectHandler);
                    _secureSocket.addEventListener(Event.CLOSE, closeHandler);
                    _secureSocket.addEventListener(ProgressEvent.SOCKET_DATA, dataHandler);
                    _secureSocket.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
                    _secureSocket.addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);
                }
            }
            else if (_newSocketEachRequest || _socket == null)
            {
                _socket = new Socket();
                _socket.addEventListener(Event.CONNECT, connectHandler);
                _socket.addEventListener(Event.CLOSE, closeHandler);
                _socket.addEventListener(ProgressEvent.SOCKET_DATA, dataHandler);
                _socket.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
                _socket.addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);
            }
        }
    }

    /**
     * Performs a GET operation.
     *
     * @param path Path to resource on which to perform the GET
     */
    public function doGet(resource:String, queryString:Dictionary=null):void
    {
        _contentType = null;
        sendRequest(METHOD_GET, resource, queryString);
    }

    /**
     * Performs a POST operation.
     *
     * @param resource Path to resource on which to perform the POST
     */
    public function doPost(resource:String, body:String, contentType:String=null, queryString:Dictionary=null):void
    {
        _contentType = contentType;
        sendRequest(METHOD_POST, resource, queryString, body);
    }

    /**
     * Performs a PUT operation.
     *
     * @param resource Path to resource on which to perform the PUT
     */
    public function doPut(resource:String, body:String, contentType:String=null, queryString:Dictionary=null):void
    {
        _contentType = contentType;
        sendRequest(METHOD_PUT, resource, queryString, body);
    }

    /**
     * Performs a DELETE operation.
     *
     * @param resource Path to resource on which to perform the DELETE
     */
    public function doDelete(resource:String, queryString:Dictionary=null):void
    {
        _contentType = null;
        sendRequest(METHOD_DELETE, resource, queryString);
    }

    /**
     * Performs a HEAD operation.
     *
     * @param resource Path to resource on which to perform the HEAD
     */
    public function doHead(resource:String, queryString:Dictionary=null):void
    {
        _contentType = null;
        sendRequest(METHOD_HEAD, resource, queryString, _body);
    }

    /**
     * Performs a OPTIONS operation.
     *
     * @param resource Path to resource on which to perform the OPTIONS
     */
    public function doOptions(resource:String, body:String=null, queryString:Dictionary=null):void
    {
        _contentType = null;
        sendRequest(METHOD_OPTIONS, resource, queryString, body);
    }

    /**
     * Called by the client to initiate sending a request.
     *
     * @param body Body of request
     */
    public function send(body:String=null, queryString:Dictionary=null):void
    {
        _body = body;
        _queryString = queryString;
        createSocket();

        if (_secure)
        {
            _secureSocket.connect(_server, _port);
        }
        else
        {
            _socket.connect(_server, _port);
        }
    }

    /**
     * Called internally to initiate sending a request.
     *
     * @param method HTTP method
     * @param resource Path to resource
     * @param queryString Query string
     * @param body Request body
     */
    private function sendRequest(method:String, resource:String, queryString:Dictionary=null, body:String=null):void
    {
        createSocket();

        if (_secure)
        {
            _secureSocket.connect(_server, _port);
        }
        else
        {
            _socket.connect(_server, _port);
        }

        _method = method;
        _resource = resource;
        _queryString = queryString;
        _body = body;
    }

    /**
     * Handler for the socket's CONNECT event.
     *
     * @param event CONNECT event
     */
    private function connectHandler(event:Event):void
    {
        _rawResponse = ""; //clear response buffer for each new socket connection

        var queryString:String = "";
        for (var name:String in _queryString)
        {
            queryString += (queryString.length == 0 ? "?" : "&") + escape(name);

            if (_queryString[name])
            {
                queryString += "=" + escape(_queryString[name]);
            }
        }

        var requestLine:String = _method + " " + _resource + queryString + " HTTP/1.0\n";

        var now:Date = new Date();
        var headers:String = "Date: " + DAYS[now.day] + ", " + now.date + " " + MONTHS[now.month] + " " + now.fullYear +
            " " + now.hours + ":" + now.minutes + ":" + now.seconds + "\n";

        if (_contentType != null)
        {
            headers += "Content-Type: " + _contentType + "\n";
        }

        if (_body == null)
        {
            _body = "";
        }
        else
        {
            headers += "Content-Length: " + _body.length + "\n";
        }

        var request:String = requestLine + headers + "\n" + _body;

        if (_secure)
        {
            _secureSocket.writeUTFBytes(request);
            _secureSocket.flush();
        }
        else
        {
            _socket.writeUTFBytes(request);
            _socket.flush();
        }

        _body = null;
    }

    /**
     * Handler for the socket's SOCKET_DATA event. Reads data from the socket into an instance variable.
     *
     * @param event SOCKET_DATA event
     */
    private function dataHandler(event:ProgressEvent):void
    {
        if (_secure)
        {
            while (_secureSocket.bytesAvailable)
            {
                _rawResponse += _secureSocket.readUTFBytes(_socket.bytesAvailable);
            }
        }
        else
        {
            while (_socket.bytesAvailable)
            {
                _rawResponse += _socket.readUTFBytes(_socket.bytesAvailable);
            }
        }
    }

    /**
     * Handler for the socket's CLOSE event. Reads the instance variable populated by the dataHandler() method.
     *
     * @param event CLOSE event
     */
    private function closeHandler(event:Event):void
    {
        var lines:Array = _rawResponse.split("\n");

        var isFirstLine:Boolean = true;
        var isBody:Boolean = false;
        var statusCode:int;
        var statusMessage:String;
        var headers:Object = new Object();
        var body:String = "";

        for each (var line:String in lines)
        {
            if (isFirstLine)
            {
                var startStatusCode:int = line.indexOf(" ");
                var endStatusCode:int = line.indexOf(" ", startStatusCode+1);
                statusCode = parseInt(line.substr(startStatusCode, endStatusCode));
                statusMessage = StringUtil.trim(line.substr(endStatusCode+1));
                isFirstLine = false;
            }
            else if (StringUtil.trim(line) == "")
            {
                isBody = true; // blank line separates headers from body
            }
            else if (isBody)
            {
                body += line;
            }
            else // headers
            {
                var colonIndex:int = line.indexOf(":");
                var headerName:String = line.substr(0, colonIndex);
                var headerValue:String = line.substr(colonIndex+1);
                headers[headerName] = StringUtil.trim(headerValue);
            }
        }

        var httpEvent:HttpEvent = new HttpEvent(EVENT_RESULT, _method, _resource);
        httpEvent.data = _rawResponse;
        httpEvent.response = new HttpResponse(statusCode, statusMessage, headers, body);
        dispatchEvent(httpEvent);
    }

    /**
     * Handles security errors.
     *
     * @param event Security error event
     */
    private function securityErrorHandler(event:SecurityErrorEvent):void
    {
        var httpEvent:HttpEvent = new HttpEvent(EVENT_FAULT, _method, _resource);
        httpEvent.text = event.text;
        httpEvent.response = new HttpResponse(500, "Internal Server Error", null, null);

        dispatchEvent(httpEvent);
    }

    /**
     * Handles IO errors.
     *
     * @param event IO error event
     */
    private function ioErrorHandler(event:IOErrorEvent):void
    {
        var httpEvent:HttpEvent = new HttpEvent(EVENT_FAULT, _method, _resource);
        httpEvent.text = event.text;
        httpEvent.response = new HttpResponse(500, "Internal Server Error", null, null);

        dispatchEvent(httpEvent);
    }
}
}
