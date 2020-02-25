export class AppHeaderComponent extends HTMLElement {
    heading = 'something'

	hello(){
		return "test";
	}
};

export class AppItemComponent extends HTMLElement {
    item = 123;
	hello(){
		return "test";
	}
};

export class AppTodoComponent extends AppItemComponent {
	
    titl = "10"
	other(){
		
		// this.schedule();
		// @hello().toUpperCase()
		// @hanimate()
		return this;
	}
	
	set kind(value){
		
		// #value = value
		
		true;
	}
};

globalThis.AppTodoTag = AppTodoComponent;

class AppItemElement extends HTMLElement {
	hello(){
		return "test";
	}
};