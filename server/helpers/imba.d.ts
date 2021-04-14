interface Element {
    /**
     * Schedule this element to render after imba.commit()
     */
    schedule(): this;
    unschedule(): this;
    data: any;
    hotkey: any;
    hotkey__: any;
    route: any;
    route__: any;
    $key: any;

    emit(event:string, params?: any, options?: any): Event;
    focus(options?: any): void;
    blur(): void;
    
    [key: string]: any;

    setAttribute(name: string, value: boolean): void;
    setAttribute(name: string, value: number): void;

    addEventListener(event: string, listener: (event: Event) => void, options?: {
        passive?: boolean;
        once?: boolean;
        capture?: boolean;
    });

    removeEventListener(event: string, listener: (event: Event) => void, options?: {
        passive?: boolean;
        once?: boolean;
        capture?: boolean;
    });
}

interface EventListenerOptions {
    passive?: boolean;
    once?: boolean;
}

interface Storage {
    setItem(key: string, value: number): void;
}


declare class ImbaElement extends HTMLElement {
    /**
  * Creates an instance of documenter.
  */
    suspend(): this;
    unsuspend(): this;
    [key: string]: any;
}

interface ImbaStyles {
    [key: string]: any;
}

interface ImbaAsset {
    body: string;
    url: string;
    absPath: string;
    path: string;
}

interface Event {
    detail: any;
    originalEvent: Event | null;
}

interface Object {
    [key: string]: any;
}



declare namespace imba {
    interface Router {
        refresh(): void;
        alias(from:string,to:string): void;
    }

    function setInterval(handler: TimerHandler, timeout?: number, ...arguments: any[]): number;
    function setTimeout(handler: TimerHandler, timeout?: number, ...arguments: any[]): number;
    function clearInterval(handle?: number): void;
    function clearTimeout(handle?: number): void;
    function commit(): Promise<this>;
    function render(): Promise<this>;

    function mount<T>(element: T): T;

    let styles: ImbaStyles;
    let colors: string[];
    let router: Router;

    function createIndexedFragment(...arguments: any[]): DocumentFragment;
    function createKeyedFragment(...arguments: any[]): DocumentFragment;
    function createLiveFragment(...arguments: any[]): DocumentFragment;
    
    function emit(source: any, event:string, params: any[]): void;
    function listen(target: any, event:string, listener:any, path?: any): void;
    function once(target: any, event:string, listener:any, path?: any): void;
    function unlisten(target: any, event:string, listener:any, path?: any): void;
    function indexOf(target: any, source:any): boolean;
    function serve(target: any, options?:any): any;
}

declare module "data:text/asset;*" {
    const value: ImbaAsset;
    export default value;
    export const body: string;
    export const url: string;
    export const absPath: string;
    export const path: string;
}