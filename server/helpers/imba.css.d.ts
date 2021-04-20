interface ImbaStyleModifiers {
    /** Represents elements whose numeric position in a series of siblings is odd 1, 3, 5, etc */
    odd: {name: 'nth-child', valueType: 'string',value: 'odd'};

    /** Represents elements whose numeric position in a series of siblings is even 2, 4, 6, etc */
    even: {name: 'nth-child', valueType: 'string',value: 'even'};

    /** represents the first element among a group of sibling elements */
    first: {name: 'first-child'}
    
    /** represents the last element among a group of sibling elements */
	last: {name: 'last-child'};

    /** represents an element without any siblings */
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


    /** (min-width: 480px) */
    xs: {media: '(min-width: 480px)' }
    /** (min-width: 640px) */
    sm: {media: '(min-width: 640px)' }
    /** (min-width: 768px) */
    md: {media: '(min-width: 768px)' }
    /** (min-width: 1024px) */
    lg: {media: '(min-width: 1024px)' }
    /** (min-width: 1280px) */
    xl: {media: '(min-width: 1280px)' }

    /** (max-width: 479px) */
    'lt-xs': {media: '(max-width: 479px)' }
    /** (max-width: 639px) */
    'lt-sm': {media: '(max-width: 639px)' }
    /** (max-width: 767px) */
    'lt-md': {media: '(max-width: 767px)' }
    /** (max-width: 1023px) */
    'lt-lg': {media: '(max-width: 1023px)' }
    /** (max-width: 1279px) */
    'lt-xl': {media: '(max-width: 1279px)' }

    // color modifiers

    /** Indicates that user has notified that they prefer an interface that has a dark theme. */
    dark: {media: '(prefers-color-scheme: dark)'}

    /** Indicates that user has notified that they prefer an interface that has a light theme, or has not expressed an active preference. */
    light: {media: '(prefers-color-scheme: light)'}

    touch: {flag: '_touch_'}

	suspended: {flag: '_suspended_'}

	move: {flag: '_move_'}

	hold: {flag: '_hold_'}

	ssr: {flag: '_ssr_'}

    /** The viewport is in a landscape orientation, i.e., the width is greater than the height. */
    landscape: {media: '(orientation: landscape)'}

    /** The viewport is in a portrait orientation, i.e.,  the height is greater than or equal to the width.  */
	portrait: {media: '(orientation: portrait)'}

    /** Intended for paged material and documents viewed on a screen in print preview mode. */
    print: {media: 'print'}

    /** Intended primarily for screens. */
	screen: {media: 'screen'}

}