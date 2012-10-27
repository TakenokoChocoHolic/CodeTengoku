import rpc = module("jsonrpc");

export class Ideone {
    client: rpc.JSONRPCClient;
    path: string;
    link: string;
    callback: (output: string) => void;

    constructor(public user: string, public pass: string) {
        this.client = new rpc.JSONRPCClient(80, 'ideone.com');
        this.path = '/api/1/service.json';
    }

    call(method: string, params: any[], callback: (p1: any, p2: any) => any): void {
        this.client.call(method, params, callback, this.path);
    }

    isAvailable(callback: (result: bool) => void): void {
        this.call('testFunction',
                  [this.user, this.pass],
                  (error, result) => callback(result['error'] === 'OK'));
    }

    wait(): void {
        var self = this;
        this.call('getSubmissionStatus',
                  [this.user, this.pass, this.link],
                  function (error, result) {
                      if (result['status'] !== 0) {
                          setTimeout(self.wait, 1000)
                      } else {
                          self.details()
                      }
                  }
                 );
    }

    details(): void {
        var self = this;
        this.call('getSubmissionDetails',
                  [this.user, this.pass, this.link, false, false, true, true, true],
                  (error, result) => self.callback(result['output'])
                 );
    }

    execute(language: number, source: string, input: string, callback: (output: string) => void ): void {
        var self = this;
        this.callback = callback;
        this.link = '';
        this.call('createSubmission',
                  [this.user, this.pass, source, language, input, true, false],
                  function (error, result) {
                      if (result['error'] === 'OK') {
                          self.link = result['link'];
                          self.wait();
                      } else {
                          console.log('failed to invoke createSubmission: ' +
                                      result['error']);
                          self.callback(null);
                      }
                  }
                 );
    }
}

