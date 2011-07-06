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
/**
 * This class encapsulates information pertinent to an HTTP response such as status code, HTTP headers, and body.
 */
public class HttpResponse
{
    private var _statusCode:int;
    private var _statusMessage:String;
    private var _headers:Object = new Object();
    private var _body:String = "";

    /**
     * Construct an HTTP response.
     *
     * @param statusCode HTTP status code
     * @param statusMessage Status description
     * @param headers HTTP headers
     * @param body Response body
     */
    public function HttpResponse(statusCode:int, statusMessage:String, headers:Object, body:String="")
    {
        _statusCode = statusCode;
        _statusMessage = statusMessage;
        _headers = headers;
        _body = body;
    }

    /**
     * Gets the HTTP status code (200, 201, 404, etc.).
     *
     * @return HTTP status code
     */
    public function get statusCode():int
    {
        return _statusCode;
    }

    /**
     * Gets the HTTP status description ("OK", "Created", "Not Found", etc.).
     *
     * @return HTTP status description
     */
    public function get statusMessage():String
    {
        return _statusMessage;
    }

    /**
     * Gets a collection of HTTP header objects.
     *
     * @return HTTP header objects
     */
    public function get headers():Object
    {
        return _headers;
    }

    /**
     * Gets the body of the HTTP response.
     *
     * @return Body of HTTP response
     */
    public function get body():String
    {
        return _body;
    }
}
}