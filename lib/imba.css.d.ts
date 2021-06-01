type ImbaStyleGlobal = 'inherit' | 'auto'

type BorderWidth = number | 'none'




interface CSSDisplayProp {
    block: this
    inline: this
    "inline-flex": this
    none: this
}


declare module "imba_css" {

    interface css$repeat {
        'repeat-x': css$repeat
    }
    
    interface css$modifiers {
        /** Represents elements whose numeric position in a series of siblings is odd 1, 3, 5, etc 
         * @detail :nth-child(odd)
        */
        odd: { name: 'nth-child', valueType: 'string', value: 'odd' };

        /** Represents elements whose numeric position in a series of siblings is even 2, 4, 6, etc 
         * @detail :nth-child(even)
        */
        even: { name: 'nth-child', valueType: 'string', value: 'even' };

        /** represents the first element among a group of sibling elements
         * @detail :first-child
         */
        first: { name: 'first-child' }

        /** represents the last element among a group of sibling elements 
         * @detail :last-child
        */
        last: { name: 'last-child' };

        /** represents an element without any siblings 
         * @detail :only-child
        */
        only: { name: 'only-child' };

        /** Generally triggered when the user hovers over an element with the cursor (mouse pointer) */
        hover: void;

        /** Element is being activated by the user. When using a mouse, "activation" typically starts when the user presses down the primary mouse button. */
        active: void;

        visited: void;

        link: void;

        enabled: void;

        checked: void;

        /** element has focus */
        focus: void;

        /** element OR descendant of element has focus */
        focin: void;


        /** @detail (min-width: 480px) */
        xs: { media: '(min-width: 480px)' }
        /** @detail (min-width: 640px) */
        sm: { media: '(min-width: 640px)' }
        /** @detail (min-width: 768px) */
        md: { media: '(min-width: 768px)' }
        /** @detail (min-width: 1024px) */
        lg: { media: '(min-width: 1024px)' }
        /** @detail (min-width: 1280px) */
        xl: { media: '(min-width: 1280px)' }

        /** @detail (max-width: 479px) */
        'lt-xs': { media: '(max-width: 479px)' }
        /** @detail (max-width: 639px) */
        'lt-sm': { media: '(max-width: 639px)' }
        /** @detail (max-width: 767px) */
        'lt-md': { media: '(max-width: 767px)' }
        /** @detail (max-width: 1023px) */
        'lt-lg': { media: '(max-width: 1023px)' }
        /** @detail (max-width: 1279px) */
        'lt-xl': { media: '(max-width: 1279px)' }

        // color modifiers

        /** Indicates that user has notified that they prefer an interface that has a dark theme. 
         * @detail (prefers-color-scheme: dark)
        */
        dark: { media: '(prefers-color-scheme: dark)' }

        /** Indicates that user has notified that they prefer an interface that has a light theme, or has not expressed an active preference. 
         * @detail (prefers-color-scheme: light)
        */
        light: { media: '(prefers-color-scheme: light)' }

        touch: { flag: '_touch_' }

        suspended: { flag: '_suspended_' }

        move: { flag: '_move_' }

        hold: { flag: '_hold_' }

        ssr: { flag: '_ssr_' }

        /** 
         * @detail (orientation: landscape)
         * The viewport is in a landscape orientation, i.e., the width is greater than the height. */
        landscape: { media: '(orientation: landscape)' }

        /** 
         * @detail (orientation: portrait)
         * The viewport is in a portrait orientation, i.e.,  the height is greater than or equal to the width.  */
        portrait: { media: '(orientation: portrait)' }

        /** Intended for paged material and documents viewed on a screen in print preview mode. 
         * @detail (media: print)
        */
        print: { media: 'print' }

        /** Intended primarily for screens.
         * @detail (media: screen)
        */
        screen: { media: 'screen' }

        /** Pseudo-element that is the first child of the selected element 
         * @detail ::before { ... }
        */
        before: void;

        /** Pseudo-element that is the last child of the selected element 
         * @detail ::after { ... }
        */
        after: void;
    }
}


declare module "css" {
    type LengthUnit = '%' | 'px' | 'rem' | 'em';
    type Length = `${number}${LengthUnit}` | number;
    type Time = `${number}ms` | `${number}s` | number;
    
    interface border_style {
        solid: border_style;
        dotted: border_style;
        dashed: border_style;
        outset: border_style;
        inset: border_style;
        none: border_style;
    }
    
    type border_width = 'medium' | Length;
    type bstyle = 'solid' | 'dotted' | 'dashed' | 'outset' | 'inset';
    
    interface globals {
        inherit: globals
        initial: globals
        unset: globals
    }
    
    interface image {
        
    }
    interface list_style_type {
        /** list style something */
        space_counter: this
        disc: this
        circle: this
    }
    
    interface list_style_position {
        inside: this
        outside: this
    }

    interface display {
        /** this is a comment about block */
        block: this
        /** The element generates an inline-level box. */
        inline: this
        /** The element itself does not generate any boxes, but its children and pseudo-elements still generate boxes as normal. */
        contents: this
        /** The element generates a principal flex container box and establishes a flex formatting context. */
        flex: this
        /** Inline-level flex container. */
        inline_flex: this
        
        /** The element and its descendants generates no boxes. */
        none: this
    }
    
    interface Color {
        red1: Color;
        red2: Color;
        red3: Color;
        red4: Color;
        red5: Color;
    }
    
    interface Types {
        display: display;
        list_style: list_style_type & list_style_position;
        list_style_type: list_style_type
        url: image;
        color: Color;
        border: border_style & globals & Color;
    }
    
    interface Border {
       set(a: Length, b: border_style): void
       set(a: border_style, b: Color): void
       set(a: border_width, b: border_style, c: Color): void
       set(a: border_style): void
       set(a: globals): void
    }
    
    interface Props {
        display: [display];
        list_style:
        [list_style_type | list_style_position | image] |
        [list_style_type, list_style_position] |
        [list_style_type, image, list_style_position]
        
        border(a: Length, b: border_style): void
        border(a: border_style, b: Color): void
        border(a: border_width, b:border_style,c:Color): void
        border(a: border_style): void
        border(a: globals): void
        _border: Border
        // border(a: border_width): void
    }
    
    

    export const s: Props;
    export const t: Types;
}

interface ImbaStyleModifiers {
    /** Represents elements whose numeric position in a series of siblings is odd 1, 3, 5, etc 
     * @detail :nth-child(odd)
    */
    odd: {name: 'nth-child', valueType: 'string',value: 'odd'};

    /** Represents elements whose numeric position in a series of siblings is even 2, 4, 6, etc 
     * @detail :nth-child(even)
    */
    even: {name: 'nth-child', valueType: 'string',value: 'even'};

    /** represents the first element among a group of sibling elements
     * @detail :first-child
     */
    first: {name: 'first-child'}
    
    /** represents the last element among a group of sibling elements 
     * @detail :last-child
    */
	last: {name: 'last-child'};

    /** represents an element without any siblings 
     * @detail :only-child
    */
	only: {name: 'only-child'};

    /** Generally triggered when the user hovers over an element with the cursor (mouse pointer) */
    hover: void;

    /** Element is being activated by the user. When using a mouse, "activation" typically starts when the user presses down the primary mouse button. */
    active: void;

    visited: void;

    link: void;

    enabled: void;

    checked: void;

    /** element has focus */
    focus: void;

    /** element OR descendant of element has focus */
    focin: void;


    /** @detail (min-width: 480px) */
    xs: {media: '(min-width: 480px)' }
    /** @detail (min-width: 640px) */
    sm: {media: '(min-width: 640px)' }
    /** @detail (min-width: 768px) */
    md: {media: '(min-width: 768px)' }
    /** @detail (min-width: 1024px) */
    lg: {media: '(min-width: 1024px)' }
    /** @detail (min-width: 1280px) */
    xl: {media: '(min-width: 1280px)' }

    /** @detail (max-width: 479px) */
    'lt-xs': {media: '(max-width: 479px)' }
    /** @detail (max-width: 639px) */
    'lt-sm': {media: '(max-width: 639px)' }
    /** @detail (max-width: 767px) */
    'lt-md': {media: '(max-width: 767px)' }
    /** @detail (max-width: 1023px) */
    'lt-lg': {media: '(max-width: 1023px)' }
    /** @detail (max-width: 1279px) */
    'lt-xl': {media: '(max-width: 1279px)' }

    // color modifiers

    /** Indicates that user has notified that they prefer an interface that has a dark theme. 
     * @detail (prefers-color-scheme: dark)
    */
    dark: {media: '(prefers-color-scheme: dark)'}

    /** Indicates that user has notified that they prefer an interface that has a light theme, or has not expressed an active preference. 
     * @detail (prefers-color-scheme: light)
    */
    light: {media: '(prefers-color-scheme: light)'}

    touch: {flag: '_touch_'}

	suspended: {flag: '_suspended_'}

	move: {flag: '_move_'}

	hold: {flag: '_hold_'}

	ssr: {flag: '_ssr_'}

    /** 
     * @detail (orientation: landscape)
     * The viewport is in a landscape orientation, i.e., the width is greater than the height. */
    landscape: {media: '(orientation: landscape)'}

    /** 
     * @detail (orientation: portrait)
     * The viewport is in a portrait orientation, i.e.,  the height is greater than or equal to the width.  */
	portrait: {media: '(orientation: portrait)'}

    /** Intended for paged material and documents viewed on a screen in print preview mode. 
     * @detail (media: print)
    */
    print: {media: 'print'}

    /** Intended primarily for screens.
     * @detail (media: screen)
    */
	screen: {media: 'screen'}

    /** Pseudo-element that is the first child of the selected element 
     * @detail ::before { ... }
    */
    before: void;

    /** Pseudo-element that is the last child of the selected element 
     * @detail ::after { ... }
    */
    after: void;
}