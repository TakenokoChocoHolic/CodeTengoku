
function extend(a, b) {
    var prop;
    for(var prop in b) {
        if(b.hasOwnProperty(prop)) {
            a[prop] = b[prop];
        }
    }
    return a;
}

