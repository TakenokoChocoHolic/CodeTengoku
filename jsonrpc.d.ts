declare module "jsonrpc" {
    declare var JSONRPCClient: {
        new(port: number, address: string);
    };
}
