declare module 'jsonrpc' {
    declare var JSONRPCClient {
        new (port: any, host: any): any;
        call(method: any,
             params: any,
             callback: (any, any) => any,
             errback: any,
             path: string
            ): void;
    }

    declare interface JSONRPC {
        getClient(port: number, host: string): JSONRPCClient; 
    }
}
