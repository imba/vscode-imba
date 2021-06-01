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
    /** The wait modifier delays the execution of subsequent modifiers and callback. It defaults to wait for 250ms, which can be overridden by passing a number or time as the first/only argument. 
     * @detail (time = 500ms)
     */
    wait(time?:Time): EventModifiers;

    /**
     * Hello there
     * @detail (time = 500ms)
     */
    throttle(time?:Time): EventModifiers;

    /**
     * Hello there
     * @detail (time = 500ms)
     */
    debounce(time?:Time): EventModifiers;


    /** Only trigger handler if event.target is the element itself */
    self():EventModifiers;

    /** Only trigger handler if event.target matches selector */
    sel(selector:Selector):EventModifiers;

    /**
     * Only trigger condition is truthy
     * @detail (condition)
     * */
    if(condition:unknown):EventModifiers;

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

interface ImbaEvents {
    /** The loading of a resource has been aborted. */
    abort: UIEvent;
    animationcancel: AnimationEvent;
    /** A CSS animation has completed. */
    animationend: AnimationEvent;
    /** A CSS animation is repeated. */
    animationiteration: AnimationEvent;
    /** A CSS animation has started. */
    animationstart: AnimationEvent;

    auxclick: MouseEvent;
    /** An element has lost focus (does not bubble). */
    blur: FocusEvent;

    cancel: Event;
    /** The user agent can play the media, but estimates that not enough data has been loaded to play the media up to its end without having to stop for further buffering of content. */
    canplay: Event;
    /** The user agent can play the media up to its end without having to stop for further buffering of content. */
    canplaythrough: Event;
    /** The change event is fired for <input>, <select>, and <textarea> elements when a change to the element's value is committed by the user. */
    change: Event;
    /** A pointing device button has been pressed and released on an element. */
    click: MouseEvent;
    close: Event;
    contextmenu: MouseEvent;
    cuechange: Event;
    dblclick: MouseEvent;
    drag: DragEvent;
    dragend: DragEvent;
    dragenter: DragEvent;
    dragexit: Event;
    dragleave: DragEvent;
    dragover: DragEvent;
    dragstart: DragEvent;
    drop: DragEvent;
    durationchange: Event;
    emptied: Event;
    ended: Event;
    error: ErrorEvent;
    focus: FocusEvent;
    focusin: FocusEvent;
    focusout: FocusEvent;
    gotpointercapture: PointerEvent;
    input: Event;
    invalid: Event;
    keydown: KeyboardEvent;
    keypress: KeyboardEvent;
    keyup: KeyboardEvent;
    load: Event;
    loadeddata: Event;
    loadedmetadata: Event;
    loadstart: Event;
    lostpointercapture: PointerEvent;
    mousedown: MouseEvent;
    mouseenter: MouseEvent;
    mouseleave: MouseEvent;
    mousemove: MouseEvent;
    mouseout: MouseEvent;
    mouseover: MouseEvent;
    mouseup: MouseEvent;
    pause: Event;
    play: Event;
    playing: Event;
    pointercancel: PointerEvent;
    pointerdown: PointerEvent;
    pointerenter: PointerEvent;
    pointerleave: PointerEvent;
    pointermove: PointerEvent;
    pointerout: PointerEvent;
    pointerover: PointerEvent;
    pointerup: PointerEvent;
    progress: ProgressEvent;
    ratechange: Event;
    reset: Event;
    resize: UIEvent;
    scroll: Event;
    securitypolicyviolation: SecurityPolicyViolationEvent;
    seeked: Event;
    seeking: Event;
    select: Event;
    selectionchange: Event;
    selectstart: Event;
    stalled: Event;
    submit: Event;
    suspend: Event;
    timeupdate: Event;
    toggle: Event;
    touch: PointerGesture;
    touchcancel: TouchEvent;
    touchend: TouchEvent;
    touchmove: TouchEvent;
    touchstart: TouchEvent;
    transitioncancel: TransitionEvent;
    transitionend: TransitionEvent;
    transitionrun: TransitionEvent;
    transitionstart: TransitionEvent;
    volumechange: Event;
    waiting: Event;
    wheel: WheelEvent;
    [event: string]: Event;
}