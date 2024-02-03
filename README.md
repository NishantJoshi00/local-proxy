## Local Proxy

This project leverages the nginx proxy to perform local load balancing between ports. as per the configuration, the proxy is hosted on the port `8080` and you can register various ports as upstreams for the proxy.

The command associated with the proxy are under `make proxy` and the command associated with registering upstreams are under `make server`.

this can be used in the scenerios where you are running multiple servers on your system, and wish to have control over which server the traffic should go to.

## Example

> note. the proxy will not start until there is atleast a single valid upstream server register

Lets consider your first server is running on 8081, you can register it by simply running `make add-server PORT=8081`

To start the proxy, run `make start-proxy`, and like magic all the traffic that you are receiving on 8080 will be forwarded to 8081,

Now, you wish to switch to a different server, without interrupting the traffic:

1. First, register your new server (e.g. consider you started it on 8082) `make add-serer PORT=8082`
2. Once you are confident that the traffic is working properly, and there is not problem with the new server, you can simple unregister the old server by saying `make remove-server PORT=8081`
