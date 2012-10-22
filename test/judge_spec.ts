///<reference path='../node/node.d.ts' />
///<reference path='mocha.d.ts' />

import assert = module('assert');
import judge = module('../judge');

describe('judge', () => {
    describe('#isCorrect()', () => {
        it('should return true', () => {
            assert.equal(judge.isCorrect("1", "1"), true);
            assert.equal(judge.isCorrect("1\r\n2", "1\r2\r\n"), true);
            assert.equal(judge.isCorrect("1\r\n\r\n", "1"), true);
        });
    });
});
