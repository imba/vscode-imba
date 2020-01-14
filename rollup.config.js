import imba from 'imba/rollup.js';
import resolve from 'rollup-plugin-node-resolve';
import commonjs from 'rollup-plugin-commonjs';

export default [{
    input: './client/src/index.imba',
    output: {
        file: './client/index.js',
        format: 'cjs',
        name: 'bundle',
        sourcemap: 'inline'
    },
    external: function(id){
        return id[0] != '.' && id.indexOf('imba') != 0;
    },
    plugins: [
        imba({target: 'node'}),
        resolve({
            extensions: ['.imba'],
            preferBuiltins: true
        }),
        commonjs()
    ]
},{
    input: './server/src/index.imba',
    output: {
        file: './server/index.js',
        format: 'cjs',
        name: 'bundle',
        sourcemap: 'inline'
    },
    external: function(id){
        return id[0] != '.' && id.indexOf('imba') != 0;
    },
    plugins: [
        imba({target: 'node'}),
        resolve({
            extensions: ['.imba'],
            preferBuiltins: true
        }),
        commonjs()
    ]
}]