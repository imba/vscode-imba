import imba from 'imba/rollup.js';
import resolve from 'rollup-plugin-node-resolve';
import commonjs from 'rollup-plugin-commonjs';
import json from '@rollup/plugin-json';

export default [{
    input: './client/src/index.imba',
    output: {
        file: './client/index.js',
        format: 'cjs',
        name: 'bundle',
        sourcemap: 'inline'
    },
    external: function(id){
        return id[0] != '.' && id.indexOf('imba') == -1;
    },
    plugins: [
        imba({target: 'node'}),
        resolve({
            extensions: ['.imba','.js','.json'],
            preferBuiltins: true
        }),
        commonjs(),
        json()
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
        return id[0] != '.' && id.indexOf('imba') == -1;
    },
    plugins: [
        imba({target: 'node'}),
        resolve({
            extensions: ['.imba','.js','.json'],
            preferBuiltins: true
        }),
        commonjs(),
        json()
    ]
},{
    input: './server/src/test.imba',
    output: {
        file: './server/test.js',
        format: 'cjs',
        name: 'bundle',
        sourcemap: 'inline'
    },
    external: function(id){
        console.log('check external?',id);
        return id[0] != '.' && id.indexOf('imba') == -1;
    },
    plugins: [
        imba({target: 'node'}),
        resolve({
            extensions: ['.imba','.js','.json'],
            preferBuiltins: true
        }),
        commonjs(),
        json()
    ]
}]