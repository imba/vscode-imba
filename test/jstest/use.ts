import { Stream } from "./stream";
import "./component";

var a = (globalThis.something as AppItemTag);
a.hello

export class Item {
	title = "untitled";

	hello(value){
		return value.toUpperCase();
	}
}