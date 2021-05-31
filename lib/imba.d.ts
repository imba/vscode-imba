/// import {HTML} from './imba.dom';
/// <reference path="./imba.types.d.ts" />
/// <reference path="./imba.dom.d.ts" />
/// <reference path="./imba.css.d.ts" />
/// <reference path="./imba.css.types.d.ts" />
/// <reference path="./imba.css.theme.d.ts" />
/// <reference path="./css.d.ts" />
/// <reference path="./imba.css.custom.d.ts" />
/// <reference path="./imba.events.d.ts" />
/// <reference path="./imba.router.d.ts" />

type Selector = string;

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
    router: ImbaRouter;
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

    log(...arguments: any[]): void;
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

    function setInterval(handler: TimerHandler, timeout?: number, ...arguments: any[]): number;
    function setTimeout(handler: TimerHandler, timeout?: number, ...arguments: any[]): number;
    function clearInterval(handle?: number): void;
    function clearTimeout(handle?: number): void;
    function commit(): Promise<void>;
    function render(): Promise<void>;

    function mount<T>(element: T): T;

    let styles: ImbaStyles;
    let colors: string[];
    let router: ImbaRouter;

    namespace types {
        let events: GlobalEventHandlersEventMap;
        let eventHandlers: GlobalEventHandlers;

        namespace html {
            let tags: HTMLElementTagNameMap;
            let events: GlobalEventHandlersEventMap;
        }

        namespace svg {
            let tags: SVGElementTagNameMap;
            let events: SVGElementEventMap;
        }
    }

    let stylemodifiers: ImbaStyleModifiers;
    let Element:ImbaElement;

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

declare module "imba/compiler" {
    export function compile(fileName:string,options:any): any;
}

declare module "imba" {
    export function compile(fileName:string,options:any): any;
}