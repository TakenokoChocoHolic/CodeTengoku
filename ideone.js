var rpc = require("./jsonrpc")
var JsonRpcWrapper = (function () {
    function JsonRpcWrapper() {
        var _this = this;
        this.client = new rpc.JSONRPCClient(80, 'indeone.com');
        this.path = '/api/1/service.json';
        this.call = function (method, params, callback) {
            return _this.client.call(method, params, callback, null, _this.path);
        };
    }
    return JsonRpcWrapper;
})();
var Ideone = (function () {
    function Ideone(user, pass) {
        this.user = user;
        this.pass = pass;
        this.client = new rpc.JSONRPCClient(80, 'indeone.com');
        this.path = '/api/1/service.json';
    }
    Ideone.prototype.call = function (method, params, callback) {
        return this.client.call(method, params, callback, null, this.path);
    };
    Ideone.prototype.isAvailable = function (callback) {
        return this.call('testFunction', [
            this.user, 
            this.pass
        ], function (error, result) {
            return callback(result['error'] == 'OK');
        });
    };
    Ideone.prototype.wait = function () {
        this.call('getSubmissionStatus', [
            this.user, 
            this.pass, 
            this.link
        ], function (error, result) {
            if(result['status'] != 0) {
                setTimeout(this.wait, 1000);
            } else {
                this.details();
            }
        });
    };
    Ideone.prototype.details = function () {
        var _this = this;
        this.call('getSubmissionDetails', [
            this.user, 
            this.pass, 
            this.link, 
            false, 
            false, 
            true, 
            true, 
            true
        ], function (error, result) {
            return _this.callback(true, result['output']);
        });
    };
    Ideone.prototype.execute = function (language, source, input, callback) {
        this.callback = callback;
        this.link = '';
        this.call('createSubmission', [
            this.user, 
            this.pass, 
            source, 
            language, 
            input, 
            true, 
            false
        ], function (error, result) {
            if(result['error'] == 'OK') {
                this.link = result['link'];
                this.wait();
            } else {
                console.log('failed to invoke createSubmission: ' + result['error']);
                callback(false, '');
            }
        });
    };
    return Ideone;
})();
exports.Ideone = Ideone;

