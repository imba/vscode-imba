declare module "imba_css" {
    
    type LengthUnit = 'px' | 'rem' | 'em';
    type css$length = `${number}${LengthUnit}` | number;
    type css$time = `${number}ms` | `${number}s` | number;
    type css$percentage = `${number}%`;
    
    type css$number = number;
    type css$integer = number;
    type css$string = string;
    type css$identifier = string;
    type css$property = string;
    type css$box = any;
    type css$shape = any;
    type css$angle = any;
    type css$geometry_box = any;
    
    type css$padding = number;
    type css$margin = number;
    type css$side = number;

    type css$url = 'url';
    type css$image = 'url';
    
    interface css$globals {
        inherit: 'inherit'
        initial: 'initial'
        unset: 'unset'
    }
    
    interface css$prop {
    }
    
    interface css$prop$any {
        set(val: css$globals): void;
    }
    
    interface css$rule {
        [key: string]: css$prop$any
    }
    
    interface css$unicode_range {
        
    }
    
    interface css$position {
        center: 'center'
        top: 'top'
        left: 'left'
        right: 'right'
        bottom: 'bottom'
    }
    
    interface css$font {
        /** commenbt about font */
        sans: 'Sans serif'
        mono: 'monospace'
        serif: 'serif'
    }

    interface css$timing_function {
        'ease': 'ease'
        'ease-in': 'ease-in'
        'ease-out': 'ease-out'
        'ease-in-out': 'ease-in-out'
        'linear': 'linear'
        'steps-start': 'steps-start'
        'steps-end': 'steps-end'
    }

    interface css$line_style {
        none: 'none'
        hidden: 'hidden'
        dotted: 'dotted'
        dashed: 'dashed'
        solid: 'solid'
        double: 'double'
        groove: 'groove'
        ridge: 'ridge'
        inset: 'inset'
        outset: 'outset'
    }

    interface css$line_width {
        thin: 'thin'
        medium: 'medium'
        thick: 'thick'
    }
    
    interface css$enum$overflow {
        /** The behavior of the 'auto' value is UA-dependent, but should cause a scrolling mechanism to be provided for overflowing boxes. */
        auto: 'auto'

        /** Content is clipped and no scrolling mechanism should be provided to view the content outside the clipping region. */
        hidden: 'hidden'

        /** Content is clipped and if the user agent uses a scrolling mechanism that is visible on the screen (such as a scroll bar or a panner), that mechanism should be displayed for a box whether or not any of its content is clipped. */
        scroll: 'scroll'

        /** Content is not clipped, i.e., it may be rendered outside the content box. */
        visible: 'visible'
        
        
        clip: 'clip'
    }
    
    interface css$prop$overflow extends css$prop {
        /* [ visible | hidden | clip | scroll | auto ]{1,2} */
        set(x: css$enum$overflow, y: css$enum$overflow): void
    }
    
    interface css$prop$overflow_x extends css$prop {
        set(val: css$enum$overflow): void
    }
    interface css$prop$overflow_y extends css$prop {
        set(val: css$enum$overflow): void
    }
    
    interface css$enum$all {
        /** Specifies behavior that depends on the stylesheet origin to which the declaration belongs */
        revert: 'revert'
    }

    interface css$enum$grid {

    }
    
    interface css$enum$alt {
        
    }
    
    interface css$enum$mask_origin {
        
    }
}