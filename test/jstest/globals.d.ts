declare interface CustomEventItem {
    /**
     * Schedule this element to render after imba.commit()
     */
    schedule(): this;
    unschedule(): this;
}