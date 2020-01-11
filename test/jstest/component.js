export class MyComponent {
	setup(){
		return this;
	}
};

class AppItemComponent extends HTMLElement {
	
	hello(){
		return "test";
	}
};

class AppTodoComponent extends AppItemComponent {
	other(){
		this.hello().toUpperCase();
		// @hanimate()
		return this;
	}
};

class AppLinkComponent extends HTMLAnchorElement {
	
	hello(){
		this.href = '#';
		return this;
	}
};

globalThis.AppHeaderComponent = class AppHeaderComponent extends HTMLLabelElement {
	
	hello(){
		return this;
	}
};

//# sourceMappingURL=data:application/json;base64,eyJ2ZXJzaW9uIjozLCJmaWxlIjoiY29tcG9uZW50LmpzIiwic291cmNlUm9vdCI6IiIsInNvdXJjZXMiOlsiL1VzZXJzL3NpbmRyZS9yZXBvcy92c2NvZGUtaW1iYS90ZXN0L2NvbXBvbmVudC5pbWJhIl0sInNvdXJjZXNDb250ZW50IjpbImV4cG9ydCBjbGFzcyBNeUNvbXBvbmVudFxuICAgIGRlZiBzZXR1cFxuICAgICAgICBzZWxmXG5cbnRhZyBhcHAtaXRlbVxuXG4gICAgZGVmIGhlbGxvXG4gICAgICAgIFwidGVzdFwiXG5cbnRhZyBhcHAtdG9kbyA8IGFwcC1pdGVtXG4gICAgZGVmIG90aGVyXG4gICAgICAgIEBoZWxsbygpLnRvVXBwZXJDYXNlKClcbiAgICAgICAgIyBAaGFuaW1hdGUoKVxuICAgICAgICB0aGlzXG5cbnRhZyBhcHAtbGluayA8IGFcblxuICAgIGRlZiBoZWxsb1xuICAgICAgICBAaHJlZiA9ICcjJ1xuICAgICAgICBzZWxmXG5cbnRhZyBhcHAtaGVhZGVyIDwgbGFiZWxcblxuICAgIGRlZiBoZWxsb1xuICAgICAgICBzZWxmIl0sIm5hbWVzIjpbXSwibWFwcGluZ3MiOiJPQUFPLEtBQUssQ0FBQyxXQUFXO0NBQ2hCLEtBQUs7RUFDTCxPQUFBLElBQUk7Ozs7QUFFWixLQUFHLENBQUMsZ0JBQVE7O0NBRUosS0FBSztFQUNMLE9BQUEsTUFBTTs7OztBQUVkLEtBQUcsQ0FBQyxnQkFBUSxTQUFHLGdCQUFRO0NBQ2YsS0FBSztFQUNMLElBQUMsQ0FBQSxLQUFLLEVBQUUsQ0FBQyxXQUFXLEVBQUU7O0VBRXRCLE9BQUEsSUFBSTs7OztBQUVaLEtBQUcsQ0FBQyxnQkFBUSxTQUFHLGlCQUFDOztDQUVSLEtBQUs7RUFDTCxJQUFDLENBQUEsSUFBSSxHQUFHLEdBQUc7RUFDWCxPQUFBLElBQUk7Ozs7QUFFWixLQUFHLENBQUMsa0JBQVUsU0FBRyxnQkFBSzs7Q0FFZCxLQUFLO0VBQ0wsT0FBQSxJQUFJOzs7OyIsIm1hcHMiOltbW1sxLDhdLFsxLDhdXSxbWzEsMTNdLFsxLDEzXV0sW1sxLDE0XSxbMSwxNF1dLFtbMSwyNV0sWzEsMjVdXV0sW1tbMiw5XSxbMiwyXV0sW1syLDE0XSxbMiw3XV1dLFtbWzMsOV0sWzMsM11dLFtbMyw5XSxbMywxMF1dLFtbMywxM10sWzMsMTRdXV0sW10sW10sW10sW1tbNSwxXSxbNywxXV0sW1s1LDRdLFs3LDZdXSxbWzUsNV0sWzcsN11dLFtbNSwxM10sWzcsMjNdXV0sW10sW1tbNyw5XSxbOSwyXV0sW1s3LDE0XSxbOSw3XV1dLFtbWzgsOV0sWzEwLDNdXSxbWzgsOV0sWzEwLDEwXV0sW1s4LDE1XSxbMTAsMTZdXV0sW10sW10sW10sW1tbMTAsMV0sWzE0LDFdXSxbWzEwLDRdLFsxNCw2XV0sW1sxMCw1XSxbMTQsN11dLFtbMTAsMTNdLFsxNCwyM11dLFtbMTAsMTZdLFsxNCwzMl1dLFtbMTAsMjRdLFsxNCw0OF1dXSxbW1sxMSw5XSxbMTUsMl1dLFtbMTEsMTRdLFsxNSw3XV1dLFtbWzEyLDldLFsxNiwzXV0sW1sxMiwxMF0sWzE2LDddXSxbWzEyLDEwXSxbMTYsOF1dLFtbMTIsMTVdLFsxNiwxM11dLFtbMTIsMTddLFsxNiwxNV1dLFtbMTIsMThdLFsxNiwxNl1dLFtbMTIsMjldLFsxNiwyN11dLFtbMTIsMzFdLFsxNiwyOV1dXSxbXSxbW1sxNCw5XSxbMTgsM11dLFtbMTQsOV0sWzE4LDEwXV0sW1sxNCwxM10sWzE4LDE0XV1dLFtdLFtdLFtdLFtbWzE2LDFdLFsyMiwxXV0sW1sxNiw0XSxbMjIsNl1dLFtbMTYsNV0sWzIyLDddXSxbWzE2LDEzXSxbMjIsMjNdXSxbWzE2LDE2XSxbMjIsMzJdXSxbWzE2LDE3XSxbMjIsNDldXV0sW10sW1tbMTgsOV0sWzI0LDJdXSxbWzE4LDE0XSxbMjQsN11dXSxbW1sxOSw5XSxbMjUsM11dLFtbMTksMTBdLFsyNSw3XV0sW1sxOSwxMF0sWzI1LDhdXSxbWzE5LDE0XSxbMjUsMTJdXSxbWzE5LDE3XSxbMjUsMTVdXSxbWzE5LDIwXSxbMjUsMThdXV0sW1tbMjAsOV0sWzI2LDNdXSxbWzIwLDldLFsyNiwxMF1dLFtbMjAsMTNdLFsyNiwxNF1dXSxbXSxbXSxbXSxbW1syMiwxXSxbMzAsMV1dLFtbMjIsNF0sWzMwLDZdXSxbWzIyLDVdLFszMCw3XV0sW1syMiwxNV0sWzMwLDI1XV0sW1syMiwxOF0sWzMwLDM0XV0sW1syMiwyM10sWzMwLDUwXV1dLFtdLFtbWzI0LDldLFszMiwyXV0sW1syNCwxNF0sWzMyLDddXV0sW1tbMjUsOV0sWzMzLDNdXSxbWzI1LDldLFszMywxMF1dLFtbMjUsMTNdLFszMywxNF1dXSxbXSxbXSxbXV19