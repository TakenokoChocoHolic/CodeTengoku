import http = module("http")

function extend(a: any, b: any): void {
  var prop;
  for (var prop in b) {
    if (b.hasOwnProperty(prop)) {
      a[prop] = b[prop];
    }
  }
  return a;
}
