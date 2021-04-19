/// import {HTML} from './imba.dom';
/// <reference path="./imba.dom.d.ts" />
/// <reference path="./imba.css.d.ts" />

type EventName<T extends string> = `${T}%`;

type LengthUnit = '%' | 'px';
type Length = `${number}${LengthUnit}` | number;

type TimeUnit = 'ms' | 's';
type Time = `${number}${TimeUnit}` | number;

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

declare class EventModifiers {
    /**
     Tells the browser that the default action should not be taken. The event will still continue to propagate up the tree. See Event.preventDefault()
    */
    prevent(): EventModifiers;
    /**
     Stops the event from propagating up the tree. Event listeners for the same event on nodes further up the tree will not be triggered. See Event.stopPropagation()
    */
    stop(): EventModifiers;
    /**
     * Indicates that the listeners should be invoked at most once. The listener will automatically be removed when invoked.
     */
    once(): EventModifiers;

    capture(): EventModifiers;

    passive(): EventModifiers;

    silence(): EventModifiers;
    silent(): EventModifiers;
    /** The wait modifier delays the execution of subsequent modifiers and callback. It defaults to wait for 250ms, which can be overridden by passing a number or time as the first/only argument. */
    wait(time?:Time): EventModifiers;

    throttle(time?:Time): EventModifiers;

    debounce(time?:Time): EventModifiers;


    /** Only trigger handler if event.target is the element itself */
    self():EventModifiers;

    /** Only trigger handler if event.target is the element itself */
    sel():EventModifiers;

    /** Only trigger handler if event.target is the element itself */
    if():EventModifiers;

    emit(data?:any): EventModifiers;
    flag(data?:any): EventModifiers;

    /** Logs to console */
    log(...data: any[]):EventModifiers;
}

declare class UIEventModifiers extends EventModifiers {

    /** Only if ctrl key is pressed */
    ctrl():EventModifiers;

    /** Only if alt key is pressed */
    alt():EventModifiers;

    /** Only if shift key is pressed */
    shift():EventModifiers;

    /** Only if meta key is pressed */
    meta():EventModifiers;

}

declare class MouseEventModifiers extends UIEventModifiers {

}

declare class KeyboardEventModifiers extends UIEventModifiers {
    /** Only if enter key is pressed */
    enter():EventModifiers;

    /** Only if left key is pressed */
    left():EventModifiers;

    /** Only if right key is pressed */
    right():EventModifiers;

    /** Only if up key is pressed */
    up():EventModifiers;

    /** Only if down key is pressed */
    down():EventModifiers;

    /** Only if tab key is pressed */
    tab():EventModifiers;

    /** Only if esc key is pressed */
    esc():EventModifiers;

    /** Only if space key is pressed */
    space():EventModifiers;

    /** Only if del key is pressed */
    del():EventModifiers;
}

declare class PointerEventModifiers extends UIEventModifiers {
    /** Only mouse */
    mouse(): EventModifiers;

    /** Only pen */
    pen(): EventModifiers;

    /** Only hand/fingers */
    touch(): EventModifiers;
}

declare class PointerGestureModifiers extends PointerEventModifiers {
    /** Only mouse */
    moved(): EventModifiers;

    "moved-x"(): EventModifiers;

    "moved-y"(): EventModifiers;

    "moved-up"(): EventModifiers;

    "moved-down"(): EventModifiers;

    /**
     * A convenient touch modifier that takes care of updating the x,y values of some data during touch. When touch starts sync will remember the initial x,y values and only add/subtract based on movement of the touch.
     * 
     * @see https://imba.io/events/touch-events#modifiers-sync
     */
    sync(data:object,xName?:string|null,yName?:string|null): EventModifiers;

    /** Only hand/fingers */
    fit(start:Length,end:Length,snap?:number): EventModifiers;
    fit(context:Element|string,snap?:number): EventModifiers;
    fit(context:Element|string,start:Length,end:Length,snap?:number): EventModifiers;
    

    /** Only hand/fingers */
    pin(): EventModifiers;

    reframe(): EventModifiers;

    /** Only hand/fingers */
    round(nearest?:number): EventModifiers;
}


type IntersectRoot = Element | Document;

type IntersectOptions = {
    rootMargin?: string;
    root?: IntersectRoot;
    thresholds?: number[];
}

declare class ImbaIntersectEventModifiers extends EventModifiers {
    in(): EventModifiers;

    out(): EventModifiers;

    css(): EventModifiers;
    
    ___setup(root?:IntersectRoot,thresholds?:number):void;
    ___setup(thresholds?:number):void;
    ___setup(rootMargin:string,thresholds?:number):void;
    ___setup(rootMargin:string,thresholds?:number):void;
    ___setup(options:IntersectOptions): void;
}

declare class ImbaResizeEventModifiers extends UIEventModifiers {
    in(): EventModifiers;

    out(): EventModifiers;

    css(): EventModifiers;
}


interface Event {
    MODIFIERS: EventModifiers;
}

interface UIEvent {
    MODIFIERS: UIEventModifiers;
}

interface MouseEvent {
    MODIFIERS: MouseEventModifiers;
}

interface KeyboardEvent {
    MODIFIERS: KeyboardEventModifiers;
}

interface PointerEvent {
    MODIFIERS: PointerEventModifiers;
}

interface ResizeEvent {
    MODIFIERS: ImbaResizeEventModifiers;
}

declare class PointerGesture extends PointerEvent {
    MODIFIERS: PointerGestureModifiers;
}

declare class ImbaIntersectEvent extends Event {
    /** The raw IntersectionObserverEntry */
    entry: IntersectionObserverEntry;
    /** Ratio of the intersectionRect to the boundingClientRect */
    ratio: number;
    /** Difference in ratio since previous event */
    delta: number;

    MODIFIERS: ImbaIntersectEventModifiers;
}

declare class ImbaResizeEvent extends UIEvent {
    MODIFIERS: ImbaResizeEventModifiers;
}

declare class ImbaSelectionEvent extends Event {

}


interface GlobalEventHandlersEventMap {
    "touch": PointerGesture;
    "intersect": ImbaIntersectEvent;
    "__unknown": CustomEvent;
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
    function commit(): Promise<void>;
    function render(): Promise<void>;

    function mount<T>(element: T): T;

    let styles: ImbaStyles;
    let colors: string[];
    let router: Router;
    let tagtypes: HTML;

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