import rpc = module("jsonrpc");

export class Ideone {
    client: any;
    path: string;
    link: string;
    callback: (output: string) => void;

    constructor(public user: string, public pass: string) {
        this.client = new rpc.JSONRPCClient(80, 'indeone.com');
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
        this.call('getSubmissionStatus',
                  [this.user, this.pass, this.link],
                  function (error, result) {
                      if (result['status'] !== 0) {
                          setTimeout(this.wait, 1000)
                      } else {
                          this.details()
                      }
                  }
                 );
    }

    details(): void {
        this.call('getSubmissionDetails',
                  [this.user, this.pass, this.link, false, false, true, true, true],
                  (error, result) => this.callback(result['output'])
                 );
    }

    execute(language: number, source: string, input: string, callback: (output: string) => void ): void {
        this.callback = callback;
        this.link = '';
        this.call('createSubmission',
                  [this.user, this.pass, source, language, input, true, false],
                  function (error, result) {
                      if (result['error'] === 'OK') {
                          this.link = result['link'];
                          this.wait();
                      } else {
                          console.log('failed to invoke createSubmission: ' +
                                      result['error']);
                          this.callback(null);
                      }
                  }
                 );
    }
}

