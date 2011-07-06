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
import flash.events.DataEvent;

/**
 * This class add HTTP-specific values to the existing DataEvent class.
 */
public class HttpEvent extends DataEvent
{
    public var _response:HttpResponse;
    public var _method:String;
    public var _resource:String;

    public function HttpEvent(type:String, method:String, resource:String, bubbles:Boolean=false,
        cancelable:Boolean=false)
    {
        super(type, bubbles, cancelable);
        _method = method;
        _resource = resource;
    }

    /**
     * Gets the HTTP response for this event.
     *
     * @return HttpResponse
     */
    public function get response():HttpResponse
    {
        return _response;
    }

    /**
     * Sets the HTTP response for this event.
     *
     * @param response HttpResponse
     */
    public function set response(response:HttpResponse):void
    {
        _response = response;
    }

    /**
     * Gets the HTTP method used in the request.
     *
     * @return HTTP method
     */
    public function get method():String
    {
        return _method;
    }

    /**
     * Gets the HTTP resource being requested.
     *
     * @return HTTP resource
     */
    public function get resource():String
    {
        return _resource;
    }
}
}