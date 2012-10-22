import http = module("http");

export class JSONRPCClient {
    port: any;
    host: any;

    constructor(port, host) {
        this.port = port;
        this.host = host;
    }

    call(method, params, callback, errback, path) {
        // First we encode the request into JSON
        var requestJSON = JSON.stringify({
            'id': '' + (new Date()).getTime(),
            'method': method,
            'params': params
        });
        // Then we build some basic headers.
        var headers = {
            'host': this.host,
            'Content-Length': requestJSON.length
        };

        if(path===null) {
            path = '/';
        }

        var options = {
            host: this.host,
            port: this.port,
            path: path,
            headers: headers,
            method: 'POST'
        }

        var buffer = '';

        var req = http.request(options, function(res) {
            res.on('data', function(chunk) {
                buffer = buffer + chunk;
            });

            res.on('end', function() {
                var decoded = JSON.parse(buffer);
                if(decoded.hasOwnProperty('result')) {
                    callback(null, decoded.result);
                } else {
                    callback(decoded.error, null);
                }
            });

            res.on('error', function(err) {
                callback(err, null);
            });
        });

        req.write(requestJSON);
        req.end();
    }
}
