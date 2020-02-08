/** @class Array */

/**
 * Returns this model's attributes as...
 *
 * @memberof Array.prototype
 * @function
 * @name each
**/
Array.prototype.each = function( callback ) {

    var context = this;

    for( var i = 0; i < context.length; i++ ) {
        callback( context[ i ] );
    }

}

Array.prototype['hello'] = 100;

class HelloThere {
    
}