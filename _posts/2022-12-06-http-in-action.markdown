---
layout: post
title:  "HTTP in Action"
date:   2022-12-06 12:00:00 +0800
categories: [TCP/IP]
tags:
  - HTTP
  - TCP/IP

---

* Do not remove this line (it will not be displayed)
{:toc}


# [REST API Introduction](https://www.geeksforgeeks.org/node-js/rest-api-introduction/)

**REST API** stands for **RE**presentational **S**tate **T**ransfer **API**. It is a type of **API** (**Application Programming Interface**) that allows communication between different systems over the internet. **REST APIs** work by sending requests and receiving responses, typically in `JSON` format, between the client and server.

**REST APIs** use **HTTP methods** (such as `GET`, `POST`, `PUT`, `DELETE`) to define actions that can be performed on resources. These methods align with **CRUD** (`Create`, `Read`, `Update`, `Delete`) operations, which are used to manipulate resources over the web.


![rest_api](/assets/images/202508/rest_api.png)

A request is sent from the **client** to the **server** via a **web URL**, using one of the `HTTP` methods. The **server** then responds with the requested resource, which could be `HTML`, `XML`, `Image`, or `JSON`, with `JSON` being the most commonly used format for modern web services.

> **Note**
>
> **REST** is an architectural design style for APIs, while **HTTP** is the communication protocol used for data transfer over the web. **REST APIs** use **HTTP** methods to interact with resources, but they are not the same thing. **REST defines how the APIs should behave, while HTTP defines the rules for communication over the web**. They commonly work together, but they serve different purposes.


Key Features of REST APIs:

* **Stateless**: Each request from a client to a server must contain all the information the server needs to fulfill the request. No session state is stored on the server.

* **Client-Server Architecture**: RESTful APIs are based on a client-server model, where the client and server operate independently, allowing scalability.

* **Cacheable**: Responses from the server can be explicitly marked as cacheable or non-cacheable to improve performance.

* **Uniform Interface**: REST APIs follow a set of conventions and constraints, such as consistent URL paths, standardized HTTP methods, and status codes, to ensure smooth communication.

* **Layered System**: REST APIs can be deployed on multiple layers, which helps with scalability and security.






# Hypertext Transfer Protocol

The [Hypertext Transfer Protocol](https://en.wikipedia.org/wiki/Hypertext_Transfer_Protocol) (**HTTP**) is an [application layer](https://en.wikipedia.org/wiki/Application_layer) protocol in the [Internet protocol suite](https://en.wikipedia.org/wiki/Internet_protocol_suite) model for distributed, collaborative, [hypermedia](https://en.wikipedia.org/wiki/Hypermedia) information systems.

HTTP is the foundation of data communication for the [World Wide Web](https://en.wikipedia.org/wiki/World_Wide_Web), where [hypertext](https://en.wikipedia.org/wiki/Hypertext) documents include [hyperlinks](https://en.wikipedia.org/wiki/Hyperlink) to other resources that the user can easily access, for example by a mouse click or by tapping the screen in a web browser.

## HTTP/1

HTTP/1 was finalized and fully documented (as version 1.0) in 1996. It evolved (as version 1.1) in 1997 and then its specifications were updated in 1999, 2014, and 2022.

## HTTP/2

HTTP/2, published in 2015, provides a more efficient expression of HTTP's semantics "on the wire". It is now used by 41% of websites and supported by almost all web browsers (over 97% of users).

It is also supported by major web servers over [Transport Layer Security](https://en.wikipedia.org/wiki/Transport_Layer_Security) (**TLS**) using an [Application-Layer Protocol Negotiation](https://en.wikipedia.org/wiki/Application-Layer_Protocol_Negotiation) (**ALPN**) extension where TLS 1.2 or newer is required.

## HTTP/3

[HTTP/3](https://en.wikipedia.org/wiki/HTTP/3), the successor to HTTP/2, was published in 2022. It is now used by over 25% of websites and is supported by many web browsers (over 75% of users).

HTTP/3 uses [QUIC](https://en.wikipedia.org/wiki/QUIC) instead of [TCP](https://en.wikipedia.org/wiki/Transmission_Control_Protocol) for the underlying transport protocol.

Like HTTP/2, it does not obsolesce previous major versions of the protocol. Support for HTTP/3 was added to Cloudflare and Google Chrome first, and is also enabled in Firefox. HTTP/3 has lower latency for real-world web pages, if enabled on the server, load faster than with HTTP/2, and even faster than HTTP/1.1, in some cases **over 3× faster than HTTP/1.1** (which is still commonly only enabled).


## HTTPS

Its secure variant named [HTTPS](https://en.wikipedia.org/wiki/HTTPS) is used by more than 80% of websites.


# URL (Uniform Resource Locator)

A [Uniform Resource Locator](https://en.wikipedia.org/wiki/URL) (**URL**), colloquially termed a **web address**, is a reference to a [web resource](https://en.wikipedia.org/wiki/Web_resource) that specifies its location on a [computer network](https://en.wikipedia.org/wiki/Computer_network) and a mechanism for retrieving it.

A **URL** is a specific type of Uniform Resource Identifier (**URI**), although many people use the two terms interchangeably. **URLs** occur most commonly to reference [web pages](https://en.wikipedia.org/wiki/Web_page) ([HTTP](https://en.wikipedia.org/wiki/Hypertext_Transfer_Protocol)) but are also used for file transfer (FTP), email (mailto), database access (JDBC), and many other applications.


# URI (Uniform Resource Identifier)

A [Uniform Resource Identifier](https://en.wikipedia.org/wiki/Uniform_Resource_Identifier) (**URI**) is a unique sequence of characters that identifies a logical or physical resource used by web technologies. URIs may be used to identify anything, including real-world objects, such as people and places, concepts, or information resources such as web pages and books.


# Query string

A [query string](https://en.wikipedia.org/wiki/Query_string) is a part of a uniform resource locator (**URL**) that assigns values to specified parameters. A query string commonly includes fields added to a base URL by a Web browser or other client application, for example as part of an HTML, choosing the appearance of a page, or jumping to positions in multimedia content.

```text
https://en.wikipedia.org/w/index.php?title=Query_string&action=edit
```


An address bar on Google Chrome showing a URL with the query string `title=Query_string&action=edit`

# URL encoding

Some characters cannot be part of a URL (for example, the space) and some other characters have a special meaning in a URL: for example, the character `#` can be used to further specify a subsection (or fragment) of a document. In HTML forms, the character `=` is used to separate a name from a value. The URI generic syntax uses [URL encoding](https://en.wikipedia.org/wiki/Percent-encoding#Percent-encoding_reserved_characters) to deal with this problem.


# POST (有状态，不满足幂等)

In computing, [POST](https://en.wikipedia.org/wiki/POST_(HTTP)) is a request method supported by HTTP used by the World Wide Web. By design, the POST request method requests that a web server accept the data enclosed in the body of the request message, most likely for storing it. It is often used when uploading a file or when submitting a completed web form.

In contrast, the HTTP [GET](https://en.wikipedia.org/wiki/Hypertext_Transfer_Protocol#Request_methods) request method retrieves information from the server. As part of a GET request, some data can be passed within the URL's query string, specifying (for example) search terms, date ranges, or other information that defines the query.

As part of a POST request, an arbitrary amount of data of any type can be sent to the server in the body of the request message. A [header field](https://en.wikipedia.org/wiki/List_of_HTTP_header_fields) in the POST request usually indicates the message body's Internet media type.

# GET (无状态，幂等的)

The GET method requests that the target resource transfer a representation of its state. GET requests should only retrieve data and should have no other effect. (This is also true of some other HTTP methods.) For retrieving resources without making changes, GET is preferred over POST, as they can be addressed through a URL. This enables bookmarking and sharing and makes GET responses eligible for caching, which can save bandwidth.


#  Internet media type (application/x-www-form-urlencoded)

When a web browser sends a **POST** request from a web form element, the default [Internet media type](https://en.wikipedia.org/wiki/Internet_media_type) is "[application/x-www-form-urlencoded](https://en.wikipedia.org/wiki/Application/x-www-form-urlencoded)". This is a format for encoding [key-value pairs](https://en.wikipedia.org/wiki/Associative_array) with possibly duplicate keys. Each key-value pair is separated by an '&' character, and each key is separated from its value by an '=' character. Keys and values are both escaped by replacing spaces with the '+' character and then using [percent-encoding](https://en.wikipedia.org/wiki/Percent-encoding) on all other non-alphanumeric characters.

For example, the key-value pairs

```text
Name: Gareth Wylie
Age: 24
Formula: a+b == 21
```


are encoded as

```text
Name=Gareth+Wylie&Age=24&Formula=a%2Bb+%3D%3D+21
```



# Compatibility issues

According to the HTTP specification:

> Various ad hoc limitations on request-line length are found in practice. It is RECOMMENDED that all HTTP senders and recipients support, at a minimum, request-line lengths of 8000 octets (字节).

If the URL is too long, the web server fails with the [414 Request-URI Too Long](https://en.wikipedia.org/wiki/List_of_HTTP_status_codes#414) HTTP status code.

The common workaround for these problems is to use [POST](https://en.wikipedia.org/wiki/POST_(HTTP)) instead of [GET](https://en.wikipedia.org/wiki/GET_(HTTP)) and store the parameters in the request body. The length limits on request bodies are typically much higher than those on URL length. For example, the limit on POST size, by default, is 2 MB on IIS 4.0 and 128 KB on IIS 5.0. The limit is configurable on Apache2 using the `LimitRequestBody` directive, which specifies the number of bytes from 0 (meaning unlimited) to 2147483647 (2 GB) that are allowed in a request body.

**There are times when HTTP GET is less suitable even for data retrieval**. An example of this is when a great deal of data would need to be specified in the URL. Browsers and web servers can have limits on the length of the URL that they will handle without truncation or error. **Percent-encoding of reserved characters in URLs and query strings can significantly increase their length, and while Apache HTTP Server can handle up to 4,000 characters in a URL, Microsoft Internet Explorer is limited to 2,048 characters in any URL.** Equally, **HTTP GET should not be used where sensitive information**, such as usernames and passwords, have to be submitted along with other data for the request to complete. Even if **HTTPS** is used, preventing the data from being intercepted in transit, the browser history and the web server's logs will likely contain the full URL in plaintext, which may be exposed if either system is hacked. **In these cases, HTTP POST should be used**.


# Web Server

## Web Server 实现 (Python)

支持 GET 或 POST 请求打印，支持 keep-alive 检查，并返回固定的应答参数。

```python
#!/usr/bin/env python3
# web_server.py

from http.server import HTTPServer, BaseHTTPRequestHandler
from urllib.parse import urlparse, parse_qs
import json
from datetime import datetime

class RequestHandler(BaseHTTPRequestHandler):
    protocol_version = 'HTTP/1.1'

    def do_GET(self):
        self.handle_request("GET")

    def do_POST(self):
        self.handle_request("POST")

    def handle_request(self, method):
        # Parse request path and query parameters
        parsed_path = urlparse(self.path)
        query_params = parse_qs(parsed_path.query)

        # Get and validate content length
        content_length = 0
        try:
            content_length = int(self.headers.get('Content-Length', 0))
        except ValueError:
            pass

        # Read request body (for POST requests)
        body_data = b''
        if method == "POST" and content_length > 0:
            try:
                body_data = self.rfile.read(content_length)
            except Exception as e:
                print(f"Error reading request body: {e}")
                body_data = b''

        # Print request information
        self.print_request_info(method, parsed_path, query_params, self.headers, body_data)

        # Check if client wants keep-alive connection
        keep_alive = self.headers.get('Connection', '').lower() == 'keep-alive'

        # Prepare response data
        response = {
            "status": "success",
            "message": f"{method} request received and processed",
            "timestamp": datetime.now().isoformat(),
            "method": method,
            "path": self.path,
            "client_ip": self.client_address[0],
            "client_port": self.client_address[1],
            "connection": "keep-alive" if keep_alive else "close"
        }
        response_data = json.dumps(response).encode('utf-8')

        # Send response with proper headers
        self.send_response(200)
        self.send_header('Content-Type', 'application/json')
        self.send_header('Content-Length', str(len(response_data)))

        # Handle connection type based on client preference
        # For keep-alive requests, we set the appropriate headers
        if keep_alive:
            self.send_header('Connection', 'keep-alive')
            self.send_header('Keep-Alive', 'timeout=5, max=100')
        else:
            self.send_header('Connection', 'close')

        self.end_headers()
        self.wfile.write(response_data)

        # Log connection status
        print(f"Connection will be: {'kept alive' if keep_alive else 'closed'}")

    def print_request_info(self, method, parsed_path, query_params, headers, body_data):
        print("\n" + "="*80)
        print(f"[{datetime.now().strftime('%Y-%m-%d %H:%M:%S')}] Received {method} Request")
        print("="*80)

        # Print client IP and port
        client_ip, client_port = self.client_address
        print(f"Client: {client_ip}:{client_port}")

        # Print request method and path
        print(f"Request Method: {method}")
        print(f"Request Path: {parsed_path.path}")
        print(f"Full URL: {self.path}")

        # Print query parameters
        print("\nQuery Parameters:")
        if query_params:
            for key, value in query_params.items():
                print(f"  {key}: {value[0] if len(value) == 1 else value}")
        else:
            print("  (No query parameters)")

        # Print request headers
        print("\nRequest Headers:")
        for header, value in headers.items():
            print(f"  {header}: {value}")

        # Print request body (for POST requests)
        if method == "POST":
            print("\nRequest Body:")
            if body_data:
                try:
                    # Try to parse as JSON
                    json_data = json.loads(body_data.decode('utf-8'))
                    print("Content-Type: JSON")
                    print(json.dumps(json_data, indent=2, ensure_ascii=False))
                except:
                    # If not JSON, print raw data
                    print("Content-Type: Raw/Text")
                    print(body_data.decode('utf-8', errors='replace'))
            else:
                print("(Empty)")

        print("="*80)

    def log_message(self, format, *args):
        # Disable default log output, we use custom printing
        pass

def run_server(host='0.0.0.0', port=8088):
    server_address = (host, port)
    httpd = HTTPServer(server_address, RequestHandler)

    print(f"Server started at http://{host}:{port}")
    print("Waiting for requests...")
    print("Press Ctrl+C to stop the server")

    try:
        httpd.serve_forever()
    except KeyboardInterrupt:
        print("\nServer stopped")
        httpd.shutdown()

if __name__ == '__main__':
    # Using port 8088 to avoid permission issues
    run_server(host='0.0.0.0', port=8088)
```



## 客户端测试命令 (短连接)

```bash
#!/bin/bash

curl -X POST 'http://localhost:8088/cgi-bin/Test.fcgi?cmd=test&appid=1&timestamp=1554802545&nonce=100000&sign=73ea834b1ed7637dd9776f22269a8451' \
-H 'Content-Type: application/json' \
-H 'Connection: close' \
-d '{"data": "test", "action": "process"}'
```


Web Server 服务端请求内容：


```text
================================================================================
[2025-10-27 15:34:54] Received POST Request
================================================================================
Client: 127.0.0.1:49302
Request Method: POST
Request Path: /cgi-bin/Test.fcgi
Full URL: /cgi-bin/Test.fcgi?cmd=test&appid=1&timestamp=1554802545&nonce=100000&sign=73ea834b1ed7637dd9776f22269a8451

Query Parameters:
  cmd: test
  appid: 1
  timestamp: 1554802545
  nonce: 100000
  sign: 73ea834b1ed7637dd9776f22269a8451

Request Headers:
  Host: localhost:8088
  User-Agent: curl/7.61.1
  Accept: */*
  Content-Type: application/json
  Connection: close
  Content-Length: 37

Request Body:
Content-Type: JSON
{
  "data": "test",
  "action": "process"
}
================================================================================
Connection will be: closed
```


应答内容：

```json
{"status": "success", "message": "POST request received and processed", "timestamp": "2025-10-27T15:34:54.009649", "method": "POST", "path": "/cgi-bin/Test.fcgi?cmd=test&appid=1&timestamp=1554802545&nonce=100000&sign=73ea834b1ed7637dd9776f22269a8451", "client_ip": "127.0.0.1", "client_port": 49302, "connection": "close"}
```


## 客户端测试命令 (长连接)

```bash
#!/bin/bash

curl -X POST 'http://localhost:8088/cgi-bin/Test.fcgi?cmd=test&appid=1&timestamp=1554802545&nonce=100000&sign=73ea834b1ed7637dd9776f22269a8451' \
-H 'Content-Type: application/json' \
-H 'Connection: keep-alive' \
-d '{"data": "test", "action": "process"}' \
--max-time 5
```


Web Server 服务端请求内容：


```text
================================================================================
[2025-10-27 15:34:47] Received POST Request
================================================================================
Client: 127.0.0.1:49290
Request Method: POST
Request Path: /cgi-bin/Test.fcgi
Full URL: /cgi-bin/Test.fcgi?cmd=test&appid=1&timestamp=1554802545&nonce=100000&sign=73ea834b1ed7637dd9776f22269a8451

Query Parameters:
  cmd: test
  appid: 1
  timestamp: 1554802545
  nonce: 100000
  sign: 73ea834b1ed7637dd9776f22269a8451

Request Headers:
  Host: localhost:8088
  User-Agent: curl/7.61.1
  Accept: */*
  Content-Type: application/json
  Connection: keep-alive
  Content-Length: 37

Request Body:
Content-Type: JSON
{
  "data": "test",
  "action": "process"
}
================================================================================
Connection will be: kept alive
```


应答内容：

```json
{"status": "success", "message": "POST request received and processed", "timestamp": "2025-10-27T15:34:47.469851", "method": "POST", "path": "/cgi-bin/Test.fcgi?cmd=test&appid=1&timestamp=1554802545&nonce=100000&sign=73ea834b1ed7637dd9776f22269a8451", "client_ip": "127.0.0.1", "client_port": 49290, "connection": "keep-alive"}
```






# Refer

* https://en.wikipedia.org/wiki/List_of_HTTP_status_codes
* https://developer.mozilla.org/zh-CN/docs/Web/HTTP


