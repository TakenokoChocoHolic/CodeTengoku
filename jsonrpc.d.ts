declare module "jsonrpc" {
    export function getClient(port: number, address: string): JSONRPCClient;

    export interface JSONRPCClient {
        call(method: string, params: any[], callback: (p1: any, p2: any) => any, path: string): void;
    }
}
