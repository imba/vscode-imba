/// <reference path="./comp.js" />

import * as ah from "./comp";

class AppRootComponent extends HTMLElement {
	
	render(){
        
        var appheader:ah.AppHeaderComponent = null;
        var appitem:ah.AppItemComponent = null;
        var apptodo:ah.AppTodoComponent = new ah.AppTodoComponent();

		apptodo.titl='1';
	}
}; 