import imba from 'imba/rollup.js';
import resolve from 'rollup-plugin-node-resolve';
import commonjs from 'rollup-plugin-commonjs';


export default [{
    input: './src/index.imba',
    output: {
        file: './index.js',
        format: 'cjs',
        name: 'bundle',
        sourcemap: 'inline'
    },
    external: function(id){
        return id[0] != '.' && id.indexOf('imba') != 0;
    },
    plugins: [
        imba({target: 'node',format: 'esm'}),
        resolve({
            extensions: ['.imba','.imba2'],
            preferBuiltins: true
        }),
        commonjs()
    ]
}]