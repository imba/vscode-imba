import { Stream } from "./stream";
import "./component";

export class Item {
	title = "untitled";

	hello(value){
		return value.toUpperCase();
	}
}