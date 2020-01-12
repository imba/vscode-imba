
exportz class AppItemComponent extends HTMLElement {
	
	hello(){
		return "test";
	}
};

declare type AppItemTag = AppItemComponent

class AppTodoComponent extends AppItemComponent {
	
	other(){
		// @hello().toUpperCase()
		// @hanimate()
		return this;
	}
	
	set kind(value){
		// #value = value
		true;
	}
};

class AppLinkComponent extends HTMLAnchorElement {
	
	hello(){
		this.href = '#';
		return this;
	}
};

class AppHeaderComponent extends HTMLLabelElement {
	
	hello(){
		return this;
	}
};