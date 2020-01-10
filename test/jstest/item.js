import { Stream } from "./stream";

export class Item {
	title = "untitled";
	buffer = new Stream(this.hello(this.title));

	hello(value){
		return value.toUpperCase();
	}
}