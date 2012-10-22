///<reference path='mocha.d.ts' />
import assert = module('assert');
import ideone = module('ideone');

var user = 'exkazuu'
var pass = 'almond-choco'

describe('Ideone', () => {
    describe('#constructor()', () => {
        it('should return a object', () => {
            assert.notEqual(new ideone.Ideone(user, pass), null);
        });
    });

    describe('#isAvailable()', () => {
        it('should be available', done => {
            var ide = new ideone.Ideone(user, pass)
            ide.isAvailable(success => {
                assert.equal(success, true);
            });
            done();
        });
    });

    describe('#execute()', () => {
        it('should execute Python code', done => {
            var ide = new ideone.Ideone(user, pass);
            ide.execute(4, "print 'it works!'", "", output => {
                assert.equal(output, 'it works!');
            });
            done();
        });
    });
});