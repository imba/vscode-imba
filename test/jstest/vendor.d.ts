
interface Element2 {
    /**
     * Schedule this element to render after imba.commit()
     */
    schedule: () => this;
    unschedule: () => this;
}

interface Imba2 {
    /**
     * Schedule this element to render after imba.commit()
     */
    setInterval(handler: TimerHandler, timeout?: number, ...arguments: any[]): number;
    setTimeout(handler: TimerHandler, timeout?: number, ...arguments: any[]): number;
    clearInterval(handle?: number): void;
    clearTimeout(handle?: number): void;
    commit(): Promise<null>;
}

declare const imba2: Imba2