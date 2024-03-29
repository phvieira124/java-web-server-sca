Java Web Server
===============

A simple multi-threaded HTTP 1.0 Server implemented in Java for educational 
purposes based on W3C specifications (http://www.w3.org/Protocols/):

* [W3](https://www.w3.org/Protocols/HTTP/AsImplemented.html) Hypertext Transfer Protocol -- HTTP/0.9
* [RFC 1945](http://www.ietf.org/rfc/rfc1945.txt) Hypertext Transfer Protocol -- HTTP/1.0
* [RFC 2616](http://www.ietf.org/rfc/rfc2616.txt) Hypertext Transfer Protocol -- HTTP/1.1
* [RFC 2617](http://www.ietf.org/rfc/rfc2617.txt) HTTP Authentication: Basic and Digest Access Authentication
* [RFC 6265](http://tools.ietf.org/html/rfc6265) HTTP State Management Mechanism (Cookies)

For a more reliable solution, please check Jigsaw, W3C Java HTTP 1.1 server
implementation (http://www.w3.org/Jigsaw/) or other existing open source Java  
web servers (http://java-source.net/open-source/web-servers).

This software is released under FreeBSD license.

[Author info and contact](http://dasanjos.com) 


RUNNING
=======

The Java Web Server runs on any Operational System with Java (JRE) 1.6+ installed 

To start the Java Web Server, download the application jar file and run the following command:

    $ java -jar web-server.jar <PORT_NUMBER>
 
To stop the Simple Web server, just press Cntr+C on the command line.
(The parameter PORT_NUMBER is optional, default port is 8080)


COMPILING
=========

Step 1 - Install Requirements
-----------------------------
To download and compile the source code you need to install: 

- Java SDK v1.6+
- Maven v2.0+
- Git v1.7+

Step 2 - Get the source code
----------------------------
Download the project source code from GitHub repository (https://github.com/dasanjos/java-WebServer) 

    $ git clone git://github.com/dasanjos/java-WebServer

This will create a folder "java-WebServer" containing the project source files. 

Step 3 - Compile it!
--------------------
Go to the project root folder and run the following command:

    $ mvn clean package

This will create a "target" folder containing the application jar file: java-WebServer-1.0-jar-with-dependencies.jar  

https://teams.microsoft.com/l/meetup-join/19:meeting_NjgxMDk4YmYtYjllNC00YTdlLTlmZTAtYmYwYzg5NDgyNDJm@thread.v2/0?context=%7B%22Tid%22:%22ccd25372-eb59-436a-ad74-78a49d784cf3%22,%22Oid%22:%22757b2a92-53bf-42b1-adb6-2d915433abe2%22%7D

https://teams.microsoft.com/l/meetup-join/19%3ameeting_MzIyZTViNjUtYWQ4Mi00NmIwLWE1N2EtYjUyOWU3ZmM5NGQ1%40thread.v2/0?context=%7b%22Tid%22%3a%2276a2ae5a-9f00-4f6b-95ed-5d33d77c4d61%22%2c%22Oid%22%3a%22094bd1f5-4ba2-412f-8c23-981e82d3ba1a%22%7d
