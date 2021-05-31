declare module "imba_css" {
    /*
    px: ['pl', 'pr']
    py: ['pt', 'pb']
    mx: ['ml', 'mr']
    my: ['mt', 'mb']
    size: ['width', 'height']
    j: ['justify-content', 'justify-items']
    a: ['align-content', 'align-items']
    jai: ['justify-items', 'align-items']
    jac: ['justify-content', 'align-content']
    jas: ['justify-self', 'align-self']
    ja: ['justify-content', 'align-content', 'justify-items', 'align-items']
    rdt: ['border-top-left-radius', 'border-top-right-radius']
    rdb: ['border-bottom-left-radius', 'border-bottom-right-radius']
    rdl: ['border-top-left-radius', 'border-bottom-left-radius']
    rdr: ['border-top-right-radius', 'border-bottom-right-radius']
    */
    
    interface css$prop$px extends css$prop {
        set(x: css$padding): void;
        set(left: css$padding, right: css$padding): void;
    }
    interface css$prop$py extends css$prop {
        set(y: css$padding): void;
        set(top: css$padding, bottom: css$padding): void;
    }
    interface css$prop$mx extends css$prop {
        set(x: css$padding): void;
        set(left: css$padding, right: css$padding): void;
    }
    interface css$prop$my extends css$prop {
        set(y: css$margin): void;
        set(top: css$margin, bottom: css$margin): void;
    }
    interface css$prop$size extends css$prop {
        set(size: css$side): void;
    }
    interface css$prop$j extends css$prop {
        set(value: (css$enum$justify_content & css$enum$justify_items)): void;

    }
    interface css$prop$a extends css$prop {
        
    }
    interface css$prop$jai extends css$prop {
        
    }
    interface css$prop$jac extends css$prop {
        
    }
    interface css$prop$jas extends css$prop {
        
    }
    interface css$prop$ja extends css$prop {
        
    }
    interface css$prop$rdt extends css$prop {
        
    }
    interface css$prop$rdb extends css$prop {
        
    }
    interface css$prop$rdl extends css$prop {
        
    }
    interface css$prop$rdr extends css$prop {
        
    }
    
    interface css$rule {
        /** @proxy padding left & right */
        px: css$prop$px;
        /** @proxy padding top & bottom */
        py: css$prop$py;
        /** @proxy margin left & right */
        mx: css$prop$mx;
        /** @proxy margin top & bottom */
        my: css$prop$my;
        /** @proxy width & height */
        size: css$prop$size;
        /** @proxy justify items & content */
        j: css$prop$j;
        /** @proxy align items & content */
        a: css$prop$a;
        /** @proxy justify & align items */
        jai: css$prop$jai;
        /** @proxy justify & align content */
        jac: css$prop$jac;
        /** @proxy justify & align self */
        jas: css$prop$jas;
        /** @proxy justify & align items & content */
        ja: css$prop$ja;
        /** @proxy ◠ border-top-right-radius & border-top-left-radius */
        rdt: css$prop$rdt;
        /** @proxy ◡ border-bottom-left-radius & border-bottom-right-radius */
        rdb: css$prop$rdb;
        /** @proxy ⊂ border-top-left-radius & border-bottom-left-radius */
        rdl: css$prop$rdl;
        /** @proxy ⊃ border-top-right-radius & border-bottom-right-radius */
        rdr: css$prop$rdr;
        
    }
    
}