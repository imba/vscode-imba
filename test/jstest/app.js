/// <reference path="./declares.ts" />
/// <reference path="./comp.js" />
/// <reference path="./globals.d.ts" />

import './globals'

/**
 * @typedef { import("./comp").AppHeaderComponent } AppHeaderComponent
 * @typedef { import("./comp").AppItemComponent } AppItemComponent
 * @typedef { import("./comp").AppTodoComponent } AppTodoComponent
 */


class AppRootComponent extends HTMLElement {
	
	render(){
        /** @type {AppHeaderComponent} */
        var appheader = null;
        appheader.heading = '100';

        const items = /** @type {AppHeaderComponent[]} */ (Array.from(
            this.querySelectorAll('todo-item'),
        ));

        for(let item of items){
            item
        }

        /** @type {AppItemComponent} */
        var appitem = null;
        AppTodoTag;
        var apptodo = new AppTodoTag;

        apptodo.titl='1';
        
        var other = new HTMLAnchorElement;
        other.href = '123';

        /** @type {(AppItemComponent|AppHeaderComponent)} */
        var appstuff;

        appstuff.heading;
        
	}
}; 