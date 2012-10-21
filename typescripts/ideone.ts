import rpc = module('./jsonprc')

class JsonRpcWrapper {
    constructor() {
        this.client = rpc.getClient(80, 'indeone.com');
        this.path = '/api/1/service.json';
        this.call = (method, params, callback) =>
            this.client.call(method, params, callback, null, this.path);
    }
}

export class Ideone {
    constructor(public user, public pass) {
        this.client = rpc.getClient(80, 'indeone.com');
        this.path = '/api/1/service.json';
    }

    call(method, params, callback) {
        return this.client.call(method, params, callback, null, this.path);
    }

    isAvailable(callback) {
        return this.call('testFunction',
                         [this.user, this.pass],
                         (error, result) => callback(result['error'] == 'OK'));
    }

    wait() {
        this.call('getSubmissionStatus',
                  [this.user, this.pass, this.link],
                  function (error, result) {
                      if(result['status'] != 0) {
                          setTimeout(this.wait, 1000)
                      } else {
                          this.details()
                      }
                  }
                 );
    }

    details() {
        this.call('getSubmissionDetails',
                  [this.user, this.pass, this.link, false, false, true, true, true],
                  (error, result) =>
                      this.callback(true, result['output'])
                 );
    }

    execute(language, source, input, callback) {
        this.callback = callback;
        this.link = '';
        this.call('createSubmission',
                  [this.user, this.pass, source, language, input, true, false],
                  function (error, result) {
                      if(result['error'] == 'OK') {
                          this.link = result['link'];
                          this.wait();
                      } else {
                          console.log('failed to invoke createSubmission: ' +
                                      result['error']);
                          callback(false, '');
                      }
                  }
                 );
    }
}
