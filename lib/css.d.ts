declare module "imba_css" {
	interface css$enum$width {
		/** The width depends on the values of other properties. */
		auto: 'auto'

		/** Use the fit-content inline size or fit-content block size, as appropriate to the writing mode. */
		'fit-content': 'fit-content'

		/** Use the max-content inline size or max-content block size, as appropriate to the writing mode. */
		'max-content': 'max-content'

		/** Use the min-content inline size or min-content block size, as appropriate to the writing mode. */
		'min-content': 'min-content'

	}

	interface css$prop$width extends css$prop {
		/* auto | <length> | <percentage> | min-content | max-content | fit-content(<length-percentage>) */
		set(val:css$enum$width|css$length|css$percentage): void

	}

	interface css$enum$height {
		/** The height depends on the values of other properties. */
		auto: 'auto'

		/** Use the fit-content inline size or fit-content block size, as appropriate to the writing mode. */
		'fit-content': 'fit-content'

		/** Use the max-content inline size or max-content block size, as appropriate to the writing mode. */
		'max-content': 'max-content'

		/** Use the min-content inline size or min-content block size, as appropriate to the writing mode. */
		'min-content': 'min-content'

	}

	interface css$prop$height extends css$prop {
		/* [ <length> | <percentage> ] && [ border-box | content-box ]? | available | min-content | max-content | fit-content | auto */
		set(val:css$enum$height|css$length|css$percentage): void

	}

	interface css$enum$display {
		/** The element generates a block-level box */
		block: 'block'

		/** The element itself does not generate any boxes, but its children and pseudo-elements still generate boxes as normal. */
		contents: 'contents'

		/** The element generates a principal flex container box and establishes a flex formatting context. */
		flex: 'flex'

		/** Flex with flex-direction set to row */
		hflex: 'hflex'

		/** Flex with flex-direction set to column */
		vflex: 'vflex'

		/** The element generates a block container box, and lays out its contents using flow layout. */
		'flow-root': 'flow-root'

		/** The element generates a principal grid container box, and establishes a grid formatting context. */
		grid: 'grid'

		/** Grid with grid-auto-flow set to column */
		hgrid: 'hgrid'

		/** Grid with grid-auto-flow set to row */
		vgrid: 'vgrid'

		/** The element generates an inline-level box. */
		inline: 'inline'

		/** A block box, which itself is flowed as a single inline box, similar to a replaced element. The inside of an inline-block is formatted as a block box, and the box itself is formatted as an inline box. */
		'inline-block': 'inline-block'

		/** Inline-level flex container. */
		'inline-flex': 'inline-flex'

		/** Inline-level table wrapper box containing table box. */
		'inline-table': 'inline-table'

		/** One or more block boxes and one marker box. */
		'list-item': 'list-item'

		/** The element lays out its contents using flow layout (block-and-inline layout). Standardized as 'flex'. */
		'-moz-box': '-moz-box'

		'-moz-deck': '-moz-deck'

		'-moz-grid': '-moz-grid'

		'-moz-grid-group': '-moz-grid-group'

		'-moz-grid-line': '-moz-grid-line'

		'-moz-groupbox': '-moz-groupbox'

		/** Inline-level flex container. Standardized as 'inline-flex' */
		'-moz-inline-box': '-moz-inline-box'

		'-moz-inline-grid': '-moz-inline-grid'

		'-moz-inline-stack': '-moz-inline-stack'

		'-moz-marker': '-moz-marker'

		'-moz-popup': '-moz-popup'

		'-moz-stack': '-moz-stack'

		/** The element lays out its contents using flow layout (block-and-inline layout). Standardized as 'flex'. */
		'-ms-flexbox': '-ms-flexbox'

		/** The element generates a principal grid container box, and establishes a grid formatting context. */
		'-ms-grid': '-ms-grid'

		/** Inline-level flex container. Standardized as 'inline-flex' */
		'-ms-inline-flexbox': '-ms-inline-flexbox'

		/** Inline-level grid container. */
		'-ms-inline-grid': '-ms-inline-grid'

		/** The element and its descendants generates no boxes. */
		none: 'none'

		/** The element generates a principal ruby container box, and establishes a ruby formatting context. */
		ruby: 'ruby'

		'ruby-base': 'ruby-base'

		'ruby-base-container': 'ruby-base-container'

		'ruby-text': 'ruby-text'

		'ruby-text-container': 'ruby-text-container'

		/** The element generates a run-in box. Run-in elements act like inlines or blocks, depending on the surrounding elements. */
		'run-in': 'run-in'

		/** The element generates a principal table wrapper box containing an additionally-generated table box, and establishes a table formatting context. */
		table: 'table'

		'table-caption': 'table-caption'

		'table-cell': 'table-cell'

		'table-column': 'table-column'

		'table-column-group': 'table-column-group'

		'table-footer-group': 'table-footer-group'

		'table-header-group': 'table-header-group'

		'table-row': 'table-row'

		'table-row-group': 'table-row-group'

		/** The element lays out its contents using flow layout (block-and-inline layout). Standardized as 'flex'. */
		'-webkit-box': '-webkit-box'

		/** The element lays out its contents using flow layout (block-and-inline layout). */
		'-webkit-flex': '-webkit-flex'

		/** Inline-level flex container. Standardized as 'inline-flex' */
		'-webkit-inline-box': '-webkit-inline-box'

		/** Inline-level flex container. */
		'-webkit-inline-flex': '-webkit-inline-flex'

	}

	interface css$prop$display extends css$prop {
		/* [ <display-outside> || <display-inside> ] | <display-listitem> | <display-internal> | <display-box> | <display-legacy> */
		set(val:css$enum$display): void

	}

	interface css$prop$padding extends css$prop {
		/* [ <length> | <percentage> ]{1,4} */
		set(val:css$length|css$percentage, arg1: any, arg2: any, arg3: any): void

	}

	interface css$enum$position {
		/** The box's position (and possibly size) is specified with the 'top', 'right', 'bottom', and 'left' properties. These properties specify offsets with respect to the box's 'containing block'. */
		absolute: 'absolute'

		/** The box's position is calculated according to the 'absolute' model, but in addition, the box is fixed with respect to some reference. As with the 'absolute' model, the box's margins do not collapse with any other margins. */
		fixed: 'fixed'

		/** The box's position is calculated according to the 'absolute' model. */
		'-ms-page': '-ms-page'

		/** The box's position is calculated according to the normal flow (this is called the position in normal flow). Then the box is offset relative to its normal position. */
		relative: 'relative'

		/** The box is a normal box, laid out according to the normal flow. The 'top', 'right', 'bottom', and 'left' properties do not apply. */
		static: 'static'

		/** The box's position is calculated according to the normal flow. Then the box is offset relative to its flow root and containing block and in all cases, including table elements, does not affect the position of any following boxes. */
		sticky: 'sticky'

		/** The box's position is calculated according to the normal flow. Then the box is offset relative to its flow root and containing block and in all cases, including table elements, does not affect the position of any following boxes. */
		'-webkit-sticky': '-webkit-sticky'

	}

	interface css$prop$position extends css$prop {
		/* static | relative | absolute | sticky | fixed */
		set(val:css$enum$position): void

	}

	interface css$prop$border extends css$prop {
		/* <br-width> || <br-style> || <color> */
		set(val:css$length|css$line_width|css$line_style|css$color): void

	}

	interface css$enum$margin {
		auto: 'auto'

	}

	interface css$prop$margin extends css$prop {
		/* [ <length> | <percentage> | auto ]{1,4} */
		set(val:css$enum$margin|css$length|css$percentage, arg1: any, arg2: any, arg3: any): void

	}

	interface css$prop$svg extends css$prop {
		/* undefined */
		set(val:any): void

	}

	interface css$enum$top {
		/** For non-replaced elements, the effect of this value depends on which of related properties have the value 'auto' as well */
		auto: 'auto'

	}

	interface css$prop$top extends css$prop {
		/* <length> | <percentage> | auto */
		set(val:css$enum$top|css$length|css$percentage): void

	}

	interface css$enum$left {
		/** For non-replaced elements, the effect of this value depends on which of related properties have the value 'auto' as well */
		auto: 'auto'

	}

	interface css$prop$left extends css$prop {
		/* <length> | <percentage> | auto */
		set(val:css$enum$left|css$length|css$percentage): void

	}

	interface css$enum$margin_top {
		auto: 'auto'

	}

	interface css$prop$margin_top extends css$prop {
		/* <length> | <percentage> | auto */
		set(val:css$enum$margin_top|css$length|css$percentage): void

	}

	interface css$prop$color extends css$prop {
		/* undefined */
		set(val:css$color): void

	}

	interface css$enum$font_size {
		large: 'large'

		larger: 'larger'

		medium: 'medium'

		small: 'small'

		smaller: 'smaller'

		'x-large': 'x-large'

		'x-small': 'x-small'

		'xx-large': 'xx-large'

		'xx-small': 'xx-small'

	}

	interface css$prop$font_size extends css$prop {
		/* <absolute-size> | <relative-size> | <length-percentage> */
		set(val:css$enum$font_size|css$length|css$percentage): void

	}

	interface css$prop$background_color extends css$prop {
		/* <color> */
		set(val:css$color): void

	}

	interface css$enum$text_align {
		/** The inline contents are centered within the line box. */
		center: 'center'

		/** The inline contents are aligned to the end edge of the line box. */
		end: 'end'

		/** The text is justified according to the method specified by the 'text-justify' property. */
		justify: 'justify'

		/** The inline contents are aligned to the left edge of the line box. In vertical text, 'left' aligns to the edge of the line box that would be the start edge for left-to-right text. */
		left: 'left'

		/** The inline contents are aligned to the right edge of the line box. In vertical text, 'right' aligns to the edge of the line box that would be the end edge for left-to-right text. */
		right: 'right'

		/** The inline contents are aligned to the start edge of the line box. */
		start: 'start'

	}

	interface css$prop$text_align extends css$prop {
		/* start | end | left | right | center | justify | match-parent */
		set(val:css$enum$text_align|css$string): void

	}

	interface css$prop$opacity extends css$prop {
		/* <alpha-value> */
		set(val:css$number): void

	}

	interface css$enum$background {
		/** The background is fixed with regard to the viewport. In paged media where there is no viewport, a 'fixed' background is fixed with respect to the page box and therefore replicated on every page. */
		fixed: 'fixed'

		/** The background is fixed with regard to the element's contents: if the element has a scrolling mechanism, the background scrolls with the element's contents. */
		local: 'local'

		/** A value of 'none' counts as an image layer but draws nothing. */
		none: 'none'

		/** The background is fixed with regard to the element itself and does not scroll with its contents. (It is effectively attached to the element's border.) */
		scroll: 'scroll'

	}

	interface css$prop$background extends css$prop {
		/* [ <bg-layer> , ]* <final-bg-layer> */
		set(val:css$enum$background|css$image|css$color|css$position|css$length|css$repeat|css$percentage|css$box, arg1: any, arg2: any, arg3: any): void

	}

	interface css$enum$font_weight {
		/** Thin */
		'100': '100'

		/** Extra Light (Ultra Light) */
		'200': '200'

		/** Light */
		'300': '300'

		/** Normal */
		'400': '400'

		/** Medium */
		'500': '500'

		/** Semi Bold (Demi Bold) */
		'600': '600'

		/** Bold */
		'700': '700'

		/** Extra Bold (Ultra Bold) */
		'800': '800'

		/** Black (Heavy) */
		'900': '900'

		/** Same as 700 */
		bold: 'bold'

		/** Specifies the weight of the face bolder than the inherited value. */
		bolder: 'bolder'

		/** Specifies the weight of the face lighter than the inherited value. */
		lighter: 'lighter'

		/** Same as 400 */
		normal: 'normal'

	}

	interface css$prop$font_weight extends css$prop {
		/* <font-weight-absolute> | bolder | lighter */
		set(val:css$enum$font_weight): void

	}

	interface css$enum$font_family {
		cursive: 'cursive'

		fantasy: 'fantasy'

		monospace: 'monospace'

		'sans-serif': 'sans-serif'

		serif: 'serif'

	}

	interface css$prop$font_family extends css$prop {
		/* [ <family-name> | <generic-family> ]# */
		set(val:css$enum$font_family|css$font, arg1: any, arg2: any, arg3: any): void

	}

	interface css$enum$float {
		/** A keyword indicating that the element must float on the end side of its containing block. That is the right side with ltr scripts, and the left side with rtl scripts. */
		'inline-end': 'inline-end'

		/** A keyword indicating that the element must float on the start side of its containing block. That is the left side with ltr scripts, and the right side with rtl scripts. */
		'inline-start': 'inline-start'

		/** The element generates a block box that is floated to the left. Content flows on the right side of the box, starting at the top (subject to the 'clear' property). */
		left: 'left'

		/** The box is not floated. */
		none: 'none'

		/** Similar to 'left', except the box is floated to the right, and content flows on the left side of the box, starting at the top. */
		right: 'right'

	}

	interface css$prop$float extends css$prop {
		/* left | right | none | inline-start | inline-end */
		set(val:css$enum$float): void

	}

	interface css$enum$line_height {
		/** Tells user agents to set the computed value to a 'reasonable' value based on the font size of the element. */
		normal: 'normal'

	}

	interface css$prop$line_height extends css$prop {
		/* normal | <number> | <length> | <percentage> */
		set(val:css$enum$line_height|css$number|css$length|css$percentage): void

	}

	interface css$enum$box_sizing {
		/** The specified width and height (and respective min/max properties) on this element determine the border box of the element. */
		'border-box': 'border-box'

		/** Behavior of width and height as specified by CSS2.1. The specified width and height (and respective min/max properties) apply to the width and height respectively of the content box of the element. */
		'content-box': 'content-box'

	}

	interface css$prop$box_sizing extends css$prop {
		/* content-box | border-box */
		set(val:css$enum$box_sizing): void

	}

	interface css$enum$text_decoration {
		/** Produces a dashed line style. */
		dashed: 'dashed'

		/** Produces a dotted line. */
		dotted: 'dotted'

		/** Produces a double line. */
		double: 'double'

		/** Each line of text has a line through the middle. */
		'line-through': 'line-through'

		/** Produces no line. */
		none: 'none'

		/** Each line of text has a line above it. */
		overline: 'overline'

		/** Produces a solid line. */
		solid: 'solid'

		/** Each line of text is underlined. */
		underline: 'underline'

		/** Produces a wavy line. */
		wavy: 'wavy'

	}

	interface css$prop$text_decoration extends css$prop {
		/* <'text-decoration-line'> || <'text-decoration-style'> || <'text-decoration-color'> || <'text-decoration-thickness'> */
		set(val:css$enum$text_decoration|css$color): void

	}

	interface css$enum$z_index {
		/** The stack level of the generated box in the current stacking context is 0. The box does not establish a new stacking context unless it is the root element. */
		auto: 'auto'

	}

	interface css$prop$z_index extends css$prop {
		/* auto | <integer> */
		set(val:css$enum$z_index|css$integer): void

	}

	interface css$enum$vertical_align {
		/** Align the dominant baseline of the parent box with the equivalent, or heuristically reconstructed, baseline of the element inline box. */
		auto: 'auto'

		/** Align the 'alphabetic' baseline of the element with the 'alphabetic' baseline of the parent element. */
		baseline: 'baseline'

		/** Align the after edge of the extended inline box with the after-edge of the line box. */
		bottom: 'bottom'

		/** Align the 'middle' baseline of the inline element with the middle baseline of the parent. */
		middle: 'middle'

		/** Lower the baseline of the box to the proper position for subscripts of the parent's box. (This value has no effect on the font size of the element's text.) */
		sub: 'sub'

		/** Raise the baseline of the box to the proper position for superscripts of the parent's box. (This value has no effect on the font size of the element's text.) */
		super: 'super'

		/** Align the bottom of the box with the after-edge of the parent element's font. */
		'text-bottom': 'text-bottom'

		/** Align the top of the box with the before-edge of the parent element's font. */
		'text-top': 'text-top'

		/** Align the before edge of the extended inline box with the before-edge of the line box. */
		top: 'top'

		'-webkit-baseline-middle': '-webkit-baseline-middle'

	}

	interface css$prop$vertical_align extends css$prop {
		/* baseline | sub | super | text-top | text-bottom | middle | top | bottom | <percentage> | <length> */
		set(val:css$enum$vertical_align|css$percentage|css$length): void

	}

	interface css$enum$cursor {
		/** Indicates an alias of/shortcut to something is to be created. Often rendered as an arrow with a small curved arrow next to it. */
		alias: 'alias'

		/** Indicates that the something can be scrolled in any direction. Often rendered as arrows pointing up, down, left, and right with a dot in the middle. */
		'all-scroll': 'all-scroll'

		/** The UA determines the cursor to display based on the current context. */
		auto: 'auto'

		/** Indicates that a cell or set of cells may be selected. Often rendered as a thick plus-sign with a dot in the middle. */
		cell: 'cell'

		/** Indicates that the item/column can be resized horizontally. Often rendered as arrows pointing left and right with a vertical bar separating them. */
		'col-resize': 'col-resize'

		/** A context menu is available for the object under the cursor. Often rendered as an arrow with a small menu-like graphic next to it. */
		'context-menu': 'context-menu'

		/** Indicates something is to be copied. Often rendered as an arrow with a small plus sign next to it. */
		copy: 'copy'

		/** A simple crosshair (e.g., short line segments resembling a '+' sign). Often used to indicate a two dimensional bitmap selection mode. */
		crosshair: 'crosshair'

		/** The platform-dependent default cursor. Often rendered as an arrow. */
		default: 'default'

		/** Indicates that east edge is to be moved. */
		'e-resize': 'e-resize'

		/** Indicates a bidirectional east-west resize cursor. */
		'ew-resize': 'ew-resize'

		/** Indicates that something can be grabbed. */
		grab: 'grab'

		/** Indicates that something is being grabbed. */
		grabbing: 'grabbing'

		/** Help is available for the object under the cursor. Often rendered as a question mark or a balloon. */
		help: 'help'

		/** Indicates something is to be moved. */
		move: 'move'

		/** Indicates that something can be grabbed. */
		'-moz-grab': '-moz-grab'

		/** Indicates that something is being grabbed. */
		'-moz-grabbing': '-moz-grabbing'

		/** Indicates that something can be zoomed (magnified) in. */
		'-moz-zoom-in': '-moz-zoom-in'

		/** Indicates that something can be zoomed (magnified) out. */
		'-moz-zoom-out': '-moz-zoom-out'

		/** Indicates that movement starts from north-east corner. */
		'ne-resize': 'ne-resize'

		/** Indicates a bidirectional north-east/south-west cursor. */
		'nesw-resize': 'nesw-resize'

		/** Indicates that the dragged item cannot be dropped at the current cursor location. Often rendered as a hand or pointer with a small circle with a line through it. */
		'no-drop': 'no-drop'

		/** No cursor is rendered for the element. */
		none: 'none'

		/** Indicates that the requested action will not be carried out. Often rendered as a circle with a line through it. */
		'not-allowed': 'not-allowed'

		/** Indicates that north edge is to be moved. */
		'n-resize': 'n-resize'

		/** Indicates a bidirectional north-south cursor. */
		'ns-resize': 'ns-resize'

		/** Indicates that movement starts from north-west corner. */
		'nw-resize': 'nw-resize'

		/** Indicates a bidirectional north-west/south-east cursor. */
		'nwse-resize': 'nwse-resize'

		/** The cursor is a pointer that indicates a link. */
		pointer: 'pointer'

		/** A progress indicator. The program is performing some processing, but is different from 'wait' in that the user may still interact with the program. Often rendered as a spinning beach ball, or an arrow with a watch or hourglass. */
		progress: 'progress'

		/** Indicates that the item/row can be resized vertically. Often rendered as arrows pointing up and down with a horizontal bar separating them. */
		'row-resize': 'row-resize'

		/** Indicates that movement starts from south-east corner. */
		'se-resize': 'se-resize'

		/** Indicates that south edge is to be moved. */
		's-resize': 's-resize'

		/** Indicates that movement starts from south-west corner. */
		'sw-resize': 'sw-resize'

		/** Indicates text that may be selected. Often rendered as a vertical I-beam. */
		text: 'text'

		/** Indicates vertical-text that may be selected. Often rendered as a horizontal I-beam. */
		'vertical-text': 'vertical-text'

		/** Indicates that the program is busy and the user should wait. Often rendered as a watch or hourglass. */
		wait: 'wait'

		/** Indicates that something can be grabbed. */
		'-webkit-grab': '-webkit-grab'

		/** Indicates that something is being grabbed. */
		'-webkit-grabbing': '-webkit-grabbing'

		/** Indicates that something can be zoomed (magnified) in. */
		'-webkit-zoom-in': '-webkit-zoom-in'

		/** Indicates that something can be zoomed (magnified) out. */
		'-webkit-zoom-out': '-webkit-zoom-out'

		/** Indicates that west edge is to be moved. */
		'w-resize': 'w-resize'

		/** Indicates that something can be zoomed (magnified) in. */
		'zoom-in': 'zoom-in'

		/** Indicates that something can be zoomed (magnified) out. */
		'zoom-out': 'zoom-out'

	}

	interface css$prop$cursor extends css$prop {
		/* [ [ <url> [ <integer> <integer> ]? , ]* [ auto | default | none | context-menu | help | pointer | progress | wait | cell | crosshair | text | vertical-text | alias | copy | move | no-drop | not-allowed | e-resize | n-resize | ne-resize | nw-resize | s-resize | se-resize | sw-resize | w-resize | ew-resize | ns-resize | nesw-resize | nwse-resize | col-resize | row-resize | all-scroll | zoom-in | zoom-out | grab | grabbing ] ] */
		set(val:css$enum$cursor|css$url|css$number): void

	}

	interface css$enum$margin_left {
		auto: 'auto'

	}

	interface css$prop$margin_left extends css$prop {
		/* <length> | <percentage> | auto */
		set(val:css$enum$margin_left|css$length|css$percentage): void

	}

	interface css$prop$border_radius extends css$prop {
		/* <length-percentage>{1,4} [ / <length-percentage>{1,4} ]? */
		set(val:css$length|css$percentage, arg1: any, arg2: any, arg3: any): void

	}

	interface css$enum$margin_bottom {
		auto: 'auto'

	}

	interface css$prop$margin_bottom extends css$prop {
		/* <length> | <percentage> | auto */
		set(val:css$enum$margin_bottom|css$length|css$percentage): void

	}

	interface css$enum$margin_right {
		auto: 'auto'

	}

	interface css$prop$margin_right extends css$prop {
		/* <length> | <percentage> | auto */
		set(val:css$enum$margin_right|css$length|css$percentage): void

	}

	interface css$enum$right {
		/** For non-replaced elements, the effect of this value depends on which of related properties have the value 'auto' as well */
		auto: 'auto'

	}

	interface css$prop$right extends css$prop {
		/* <length> | <percentage> | auto */
		set(val:css$enum$right|css$length|css$percentage): void

	}

	interface css$prop$padding_left extends css$prop {
		/* <length> | <percentage> */
		set(val:css$length|css$percentage): void

	}

	interface css$prop$padding_top extends css$prop {
		/* <length> | <percentage> */
		set(val:css$length|css$percentage): void

	}

	interface css$enum$max_width {
		/** No limit on the width of the box. */
		none: 'none'

		/** Use the fit-content inline size or fit-content block size, as appropriate to the writing mode. */
		'fit-content': 'fit-content'

		/** Use the max-content inline size or max-content block size, as appropriate to the writing mode. */
		'max-content': 'max-content'

		/** Use the min-content inline size or min-content block size, as appropriate to the writing mode. */
		'min-content': 'min-content'

	}

	interface css$prop$max_width extends css$prop {
		/* <length> | <percentage> | none | max-content | min-content | fit-content | fill-available */
		set(val:css$enum$max_width|css$length|css$percentage): void

	}

	interface css$enum$bottom {
		/** For non-replaced elements, the effect of this value depends on which of related properties have the value 'auto' as well */
		auto: 'auto'

	}

	interface css$prop$bottom extends css$prop {
		/* <length> | <percentage> | auto */
		set(val:css$enum$bottom|css$length|css$percentage): void

	}

	interface css$enum$content {
		/** The attr(n) function returns as a string the value of attribute n for the subject of the selector. */
		attr(): 'attr()'

		/** Counters are denoted by identifiers (see the 'counter-increment' and 'counter-reset' properties). */
		counter(name): 'counter(name)'

		/** The (pseudo-)element is replaced in its entirety by the resource referenced by its 'icon' property, and treated as a replaced element. */
		icon: 'icon'

		/** On elements, this inhibits the children of the element from being rendered as children of this element, as if the element was empty. On pseudo-elements it causes the pseudo-element to have no content. */
		none: 'none'

		/** See http://www.w3.org/TR/css3-content/#content for computation rules. */
		normal: 'normal'

		url(): 'url()'

	}

	interface css$prop$content extends css$prop {
		/* normal | none | [ <content-replacement> | <content-list> ] [/ <string> ]? */
		set(val:css$enum$content|css$string|css$url): void

	}

	interface css$enum$box_shadow {
		/** Changes the drop shadow from an outer shadow (one that shadows the box onto the canvas, as if it were lifted above the canvas) to an inner shadow (one that shadows the canvas onto the box, as if the box were cut out of the canvas and shifted behind it). */
		inset: 'inset'

		/** No shadow. */
		none: 'none'

	}

	interface css$prop$box_shadow extends css$prop {
		/* none | <shadow># */
		set(val:css$enum$box_shadow|css$length|css$color): void

	}

	interface css$enum$background_image {
		/** Counts as an image layer but draws nothing. */
		none: 'none'

	}

	interface css$prop$background_image extends css$prop {
		/* <bg-image># */
		set(val:css$enum$background_image|css$image, arg1: any, arg2: any, arg3: any): void

	}

	interface css$prop$padding_right extends css$prop {
		/* <length> | <percentage> */
		set(val:css$length|css$percentage): void

	}

	interface css$enum$white_space {
		/** Sets 'white-space-collapsing' to 'collapse' and 'text-wrap' to 'normal'. */
		normal: 'normal'

		/** Sets 'white-space-collapsing' to 'collapse' and 'text-wrap' to 'none'. */
		nowrap: 'nowrap'

		/** Sets 'white-space-collapsing' to 'preserve' and 'text-wrap' to 'none'. */
		pre: 'pre'

		/** Sets 'white-space-collapsing' to 'preserve-breaks' and 'text-wrap' to 'normal'. */
		'pre-line': 'pre-line'

		/** Sets 'white-space-collapsing' to 'preserve' and 'text-wrap' to 'normal'. */
		'pre-wrap': 'pre-wrap'

	}

	interface css$prop$white_space extends css$prop {
		/* normal | pre | nowrap | pre-wrap | pre-line | break-spaces */
		set(val:css$enum$white_space): void

	}

	interface css$prop$padding_bottom extends css$prop {
		/* <length> | <percentage> */
		set(val:css$length|css$percentage): void

	}

	interface css$enum$min_height {
		auto: 'auto'

		/** Use the fit-content inline size or fit-content block size, as appropriate to the writing mode. */
		'fit-content': 'fit-content'

		/** Use the max-content inline size or max-content block size, as appropriate to the writing mode. */
		'max-content': 'max-content'

		/** Use the min-content inline size or min-content block size, as appropriate to the writing mode. */
		'min-content': 'min-content'

	}

	interface css$prop$min_height extends css$prop {
		/* <length> | <percentage> | none | max-content | min-content | fit-content | fill-available */
		set(val:css$enum$min_height|css$length|css$percentage): void

	}

	interface css$enum$transform {
		/** Specifies a 2D transformation in the form of a transformation matrix of six values. matrix(a,b,c,d,e,f) is equivalent to applying the transformation matrix [a b c d e f] */
		matrix(): 'matrix()'

		/** Specifies a 3D transformation as a 4x4 homogeneous matrix of 16 values in column-major order. */
		matrix3d(): 'matrix3d()'

		none: 'none'

		/** Specifies a perspective projection matrix. */
		perspective(): 'perspective()'

		/** Specifies a 2D rotation by the angle specified in the parameter about the origin of the element, as defined by the transform-origin property. */
		rotate(): 'rotate()'

		/** Specifies a clockwise 3D rotation by the angle specified in last parameter about the [x,y,z] direction vector described by the first 3 parameters. */
		rotate3d(): 'rotate3d()'

		/** Specifies a 2D scale operation by the [sx,sy] scaling vector described by the 2 parameters. If the second parameter is not provided, it is takes a value equal to the first. */
		scale(): 'scale()'

		/** Specifies a 3D scale operation by the [sx,sy,sz] scaling vector described by the 3 parameters. */
		scale3d(): 'scale3d()'

		/** Specifies a scale operation using the [sx,1] scaling vector, where sx is given as the parameter. */
		scaleX(): 'scaleX()'

		/** Specifies a scale operation using the [sy,1] scaling vector, where sy is given as the parameter. */
		scaleY(): 'scaleY()'

		/** Specifies a scale operation using the [1,1,sz] scaling vector, where sz is given as the parameter. */
		scaleZ(): 'scaleZ()'

		/** Specifies a skew transformation along the X and Y axes. The first angle parameter specifies the skew on the X axis. The second angle parameter specifies the skew on the Y axis. If the second parameter is not given then a value of 0 is used for the Y angle (ie: no skew on the Y axis). */
		skew(): 'skew()'

		/** Specifies a skew transformation along the X axis by the given angle. */
		skewX(): 'skewX()'

		/** Specifies a skew transformation along the Y axis by the given angle. */
		skewY(): 'skewY()'

		/** Specifies a 2D translation by the vector [tx, ty], where tx is the first translation-value parameter and ty is the optional second translation-value parameter. */
		translate(): 'translate()'

		/** Specifies a 3D translation by the vector [tx,ty,tz], with tx, ty and tz being the first, second and third translation-value parameters respectively. */
		translate3d(): 'translate3d()'

		/** Specifies a translation by the given amount in the X direction. */
		translateX(): 'translateX()'

		/** Specifies a translation by the given amount in the Y direction. */
		translateY(): 'translateY()'

		/** Specifies a translation by the given amount in the Z direction. Note that percentage values are not allowed in the translateZ translation-value, and if present are evaluated as 0. */
		translateZ(): 'translateZ()'

	}

	interface css$prop$transform extends css$prop {
		/* none | <transform-list> */
		set(val:css$enum$transform): void

	}

	interface css$prop$border_bottom extends css$prop {
		/* <br-width> || <br-style> || <color> */
		set(val:css$length|css$line_width|css$line_style|css$color): void

	}

	interface css$enum$visibility {
		/** Table-specific. If used on elements other than rows, row groups, columns, or column groups, 'collapse' has the same meaning as 'hidden'. */
		collapse: 'collapse'

		/** The generated box is invisible (fully transparent, nothing is drawn), but still affects layout. */
		hidden: 'hidden'

		/** The generated box is visible. */
		visible: 'visible'

	}

	interface css$prop$visibility extends css$prop {
		/* visible | hidden | collapse */
		set(val:css$enum$visibility): void

	}

	interface css$prop$background_position extends css$prop {
		/* <bg-position># */
		set(val:css$position|css$length|css$percentage, arg1: any, arg2: any, arg3: any): void

	}

	interface css$prop$border_top extends css$prop {
		/* <br-width> || <br-style> || <color> */
		set(val:css$length|css$line_width|css$line_style|css$color): void

	}

	interface css$enum$min_width {
		auto: 'auto'

		/** Use the fit-content inline size or fit-content block size, as appropriate to the writing mode. */
		'fit-content': 'fit-content'

		/** Use the max-content inline size or max-content block size, as appropriate to the writing mode. */
		'max-content': 'max-content'

		/** Use the min-content inline size or min-content block size, as appropriate to the writing mode. */
		'min-content': 'min-content'

	}

	interface css$prop$min_width extends css$prop {
		/* auto | <length> | <percentage> | min-content | max-content | fit-content(<length-percentage>) */
		set(val:css$enum$min_width|css$length|css$percentage): void

	}

	interface css$enum$outline {
		/** Permits the user agent to render a custom outline style, typically the default platform style. */
		auto: 'auto'

		/** Performs a color inversion on the pixels on the screen. */
		invert: 'invert'

	}

	interface css$prop$outline extends css$prop {
		/* [ <'outline-color'> || <'outline-style'> || <'outline-width'> ] */
		set(val:css$enum$outline|css$length|css$line_width|css$line_style|css$color): void

	}

	interface css$enum$transition {
		/** Every property that is able to undergo a transition will do so. */
		all: 'all'

		/** background-color, border-color, color, fill, stroke, opacity, box-shadow, transform */
		styles: 'styles'

		/** width, height, left, top, right, bottom, margin, padding */
		sizes: 'sizes'

		/** background-color, border-color, color, fill, stroke */
		colors: 'colors'

		/** No property will transition. */
		none: 'none'

	}

	interface css$prop$transition extends css$prop {
		/* <single-transition># */
		set(val:css$enum$transition|css$time|css$property|css$timing_function, arg1: any, arg2: any, arg3: any): void

	}

	interface css$prop$border_color extends css$prop {
		/* <color>{1,4} */
		set(val:css$color, arg1: any, arg2: any, arg3: any): void

	}

	interface css$prop$background_repeat extends css$prop {
		/* <repeat-style># */
		set(val:css$repeat, arg1: any, arg2: any, arg3: any): void

	}

	interface css$enum$text_transform {
		/** Puts the first typographic letter unit of each word in titlecase. */
		capitalize: 'capitalize'

		/** Puts all letters in lowercase. */
		lowercase: 'lowercase'

		/** No effects. */
		none: 'none'

		/** Puts all letters in uppercase. */
		uppercase: 'uppercase'

	}

	interface css$prop$text_transform extends css$prop {
		/* none | capitalize | uppercase | lowercase | full-width | full-size-kana */
		set(val:css$enum$text_transform): void

	}

	interface css$enum$background_size {
		/** Resolved by using the image’s intrinsic ratio and the size of the other dimension, or failing that, using the image’s intrinsic size, or failing that, treating it as 100%. */
		auto: 'auto'

		/** Scale the image, while preserving its intrinsic aspect ratio (if any), to the largest size such that both its width and its height can fit inside the background positioning area. */
		contain: 'contain'

		/** Scale the image, while preserving its intrinsic aspect ratio (if any), to the smallest size such that both its width and its height can completely cover the background positioning area. */
		cover: 'cover'

	}

	interface css$prop$background_size extends css$prop {
		/* <bg-size># */
		set(val:css$enum$background_size|css$length|css$percentage, arg1: any, arg2: any, arg3: any): void

	}

	interface css$enum$clear {
		/** The clearance of the generated box is set to the amount necessary to place the top border edge below the bottom outer edge of any right-floating and left-floating boxes that resulted from elements earlier in the source document. */
		both: 'both'

		/** The clearance of the generated box is set to the amount necessary to place the top border edge below the bottom outer edge of any left-floating boxes that resulted from elements earlier in the source document. */
		left: 'left'

		/** No constraint on the box's position with respect to floats. */
		none: 'none'

		/** The clearance of the generated box is set to the amount necessary to place the top border edge below the bottom outer edge of any right-floating boxes that resulted from elements earlier in the source document. */
		right: 'right'

	}

	interface css$prop$clear extends css$prop {
		/* none | left | right | both | inline-start | inline-end */
		set(val:css$enum$clear): void

	}

	interface css$enum$max_height {
		/** No limit on the height of the box. */
		none: 'none'

		/** Use the fit-content inline size or fit-content block size, as appropriate to the writing mode. */
		'fit-content': 'fit-content'

		/** Use the max-content inline size or max-content block size, as appropriate to the writing mode. */
		'max-content': 'max-content'

		/** Use the min-content inline size or min-content block size, as appropriate to the writing mode. */
		'min-content': 'min-content'

	}

	interface css$prop$max_height extends css$prop {
		/* <length> | <percentage> | none | max-content | min-content | fit-content | fill-available */
		set(val:css$enum$max_height|css$length|css$percentage): void

	}

	interface css$enum$list_style {
		armenian: 'armenian'

		/** A hollow circle. */
		circle: 'circle'

		decimal: 'decimal'

		'decimal-leading-zero': 'decimal-leading-zero'

		/** A filled circle. */
		disc: 'disc'

		georgian: 'georgian'

		/** The marker box is outside the principal block box, as described in the section on the ::marker pseudo-element below. */
		inside: 'inside'

		'lower-alpha': 'lower-alpha'

		'lower-greek': 'lower-greek'

		'lower-latin': 'lower-latin'

		'lower-roman': 'lower-roman'

		none: 'none'

		/** The ::marker pseudo-element is an inline element placed immediately before all ::before pseudo-elements in the principal block box, after which the element's content flows. */
		outside: 'outside'

		/** A filled square. */
		square: 'square'

		/** Allows a counter style to be defined inline. */
		symbols(): 'symbols()'

		'upper-alpha': 'upper-alpha'

		'upper-latin': 'upper-latin'

		'upper-roman': 'upper-roman'

		url(): 'url()'

	}

	interface css$prop$list_style extends css$prop {
		/* <'list-style-type'> || <'list-style-position'> || <'list-style-image'> */
		set(val:css$enum$list_style|css$image|css$url): void

	}

	interface css$enum$font_style {
		/** Selects a font that is labeled as an 'italic' face, or an 'oblique' face if one is not */
		italic: 'italic'

		/** Selects a face that is classified as 'normal'. */
		normal: 'normal'

		/** Selects a font that is labeled as an 'oblique' face, or an 'italic' face if one is not. */
		oblique: 'oblique'

	}

	interface css$prop$font_style extends css$prop {
		/* normal | italic | oblique */
		set(val:css$enum$font_style): void

	}

	interface css$enum$font {
		/** Thin */
		'100': '100'

		/** Extra Light (Ultra Light) */
		'200': '200'

		/** Light */
		'300': '300'

		/** Normal */
		'400': '400'

		/** Medium */
		'500': '500'

		/** Semi Bold (Demi Bold) */
		'600': '600'

		/** Bold */
		'700': '700'

		/** Extra Bold (Ultra Bold) */
		'800': '800'

		/** Black (Heavy) */
		'900': '900'

		/** Same as 700 */
		bold: 'bold'

		/** Specifies the weight of the face bolder than the inherited value. */
		bolder: 'bolder'

		/** The font used for captioned controls (e.g., buttons, drop-downs, etc.). */
		caption: 'caption'

		/** The font used to label icons. */
		icon: 'icon'

		/** Selects a font that is labeled 'italic', or, if that is not available, one labeled 'oblique'. */
		italic: 'italic'

		large: 'large'

		larger: 'larger'

		/** Specifies the weight of the face lighter than the inherited value. */
		lighter: 'lighter'

		medium: 'medium'

		/** The font used in menus (e.g., dropdown menus and menu lists). */
		menu: 'menu'

		/** The font used in dialog boxes. */
		'message-box': 'message-box'

		/** Specifies a face that is not labeled as a small-caps font. */
		normal: 'normal'

		/** Selects a font that is labeled 'oblique'. */
		oblique: 'oblique'

		small: 'small'

		/** Specifies a font that is labeled as a small-caps font. If a genuine small-caps font is not available, user agents should simulate a small-caps font. */
		'small-caps': 'small-caps'

		/** The font used for labeling small controls. */
		'small-caption': 'small-caption'

		smaller: 'smaller'

		/** The font used in window status bars. */
		'status-bar': 'status-bar'

		'x-large': 'x-large'

		'x-small': 'x-small'

		'xx-large': 'xx-large'

		'xx-small': 'xx-small'

	}

	interface css$prop$font extends css$prop {
		/* [ [ <'font-style'> || <font-variant-css21> || <'font-weight'> || <'font-stretch'> ]? <'font-size'> [ / <'line-height'> ]? <'font-family'> ] | caption | icon | menu | message-box | small-caption | status-bar */
		set(val:css$enum$font|css$font): void

	}

	interface css$prop$border_left extends css$prop {
		/* <br-width> || <br-style> || <color> */
		set(val:css$length|css$line_width|css$line_style|css$color): void

	}

	interface css$prop$border_right extends css$prop {
		/* <br-width> || <br-style> || <color> */
		set(val:css$length|css$line_width|css$line_style|css$color): void

	}

	interface css$enum$text_overflow {
		/** Clip inline content that overflows. Characters may be only partially rendered. */
		clip: 'clip'

		/** Render an ellipsis character (U+2026) to represent clipped inline content. */
		ellipsis: 'ellipsis'

	}

	interface css$prop$text_overflow extends css$prop {
		/* [ clip | ellipsis | <string> ]{1,2} */
		set(val:css$enum$text_overflow|css$string, arg1: any): void

	}

	interface css$prop$border_width extends css$prop {
		/* <br-width>{1,4} */
		set(val:css$length|css$line_width, arg1: any, arg2: any, arg3: any): void

	}

	interface css$enum$justify_content {
		/** Flex items are packed toward the center of the line. */
		center: 'center'

		/** The items are packed flush to each other toward the start edge of the alignment container in the main axis. */
		start: 'start'

		/** The items are packed flush to each other toward the end edge of the alignment container in the main axis. */
		end: 'end'

		/** The items are packed flush to each other toward the left edge of the alignment container in the main axis. */
		left: 'left'

		/** The items are packed flush to each other toward the right edge of the alignment container in the main axis. */
		right: 'right'

		/** If the size of the item overflows the alignment container, the item is instead aligned as if the alignment mode were start. */
		safe: 'safe'

		/** Regardless of the relative sizes of the item and alignment container, the given alignment value is honored. */
		unsafe: 'unsafe'

		/** If the combined size of the alignment subjects is less than the size of the alignment container, any auto-sized alignment subjects have their size increased equally (not proportionally), while still respecting the constraints imposed by max-height/max-width (or equivalent functionality), so that the combined size exactly fills the alignment container. */
		stretch: 'stretch'

		/** The items are evenly distributed within the alignment container along the main axis. */
		'space-evenly': 'space-evenly'

		/** Flex items are packed toward the end of the line. */
		'flex-end': 'flex-end'

		/** Flex items are packed toward the start of the line. */
		'flex-start': 'flex-start'

		/** Flex items are evenly distributed in the line, with half-size spaces on either end. */
		'space-around': 'space-around'

		/** Flex items are evenly distributed in the line. */
		'space-between': 'space-between'

		/** Specifies participation in first-baseline alignment. */
		baseline: 'baseline'

		/** Specifies participation in first-baseline alignment. */
		'first baseline': 'first baseline'

		/** Specifies participation in last-baseline alignment. */
		'last baseline': 'last baseline'

	}

	interface css$prop$justify_content extends css$prop {
		/* normal | <content-distribution> | <overflow-position>? [ <content-position> | left | right ] */
		set(val:css$enum$justify_content): void

	}

	interface css$enum$align_items {
		/** If the flex item’s inline axis is the same as the cross axis, this value is identical to 'flex-start'. Otherwise, it participates in baseline alignment. */
		baseline: 'baseline'

		/** The flex item’s margin box is centered in the cross axis within the line. */
		center: 'center'

		/** The cross-end margin edge of the flex item is placed flush with the cross-end edge of the line. */
		'flex-end': 'flex-end'

		/** The cross-start margin edge of the flex item is placed flush with the cross-start edge of the line. */
		'flex-start': 'flex-start'

		/** If the cross size property of the flex item computes to auto, and neither of the cross-axis margins are auto, the flex item is stretched. */
		stretch: 'stretch'

	}

	interface css$prop$align_items extends css$prop {
		/* normal | stretch | <baseline-position> | [ <overflow-position>? <self-position> ] */
		set(val:css$enum$align_items): void

	}

	interface css$enum$overflow_y {
		/** The behavior of the 'auto' value is UA-dependent, but should cause a scrolling mechanism to be provided for overflowing boxes. */
		auto: 'auto'

		/** Content is clipped and no scrolling mechanism should be provided to view the content outside the clipping region. */
		hidden: 'hidden'

		/** Content is clipped and if the user agent uses a scrolling mechanism that is visible on the screen (such as a scroll bar or a panner), that mechanism should be displayed for a box whether or not any of its content is clipped. */
		scroll: 'scroll'

		/** Content is not clipped, i.e., it may be rendered outside the content box. */
		visible: 'visible'

	}

	interface css$enum$pointer_events {
		/** The given element can be the target element for pointer events whenever the pointer is over either the interior or the perimeter of the element. */
		all: 'all'

		/** The given element can be the target element for pointer events whenever the pointer is over the interior of the element. */
		fill: 'fill'

		/** The given element does not receive pointer events. */
		none: 'none'

		/** The given element can be the target element for pointer events when the pointer is over a "painted" area.  */
		painted: 'painted'

		/** The given element can be the target element for pointer events whenever the pointer is over the perimeter of the element. */
		stroke: 'stroke'

		/** The given element can be the target element for pointer events when the ‘visibility’ property is set to visible and the pointer is over either the interior or the perimete of the element. */
		visible: 'visible'

		/** The given element can be the target element for pointer events when the ‘visibility’ property is set to visible and when the pointer is over the interior of the element. */
		visibleFill: 'visibleFill'

		/** The given element can be the target element for pointer events when the ‘visibility’ property is set to visible and when the pointer is over a ‘painted’ area. */
		visiblePainted: 'visiblePainted'

		/** The given element can be the target element for pointer events when the ‘visibility’ property is set to visible and when the pointer is over the perimeter of the element. */
		visibleStroke: 'visibleStroke'

	}

	interface css$prop$pointer_events extends css$prop {
		/* auto | none | visiblePainted | visibleFill | visibleStroke | visible | painted | fill | stroke | all | inherit */
		set(val:css$enum$pointer_events): void

	}

	interface css$prop$border_style extends css$prop {
		/* [object Object] */
		set(val:css$line_style): void

	}

	interface css$enum$letter_spacing {
		/** The spacing is the normal spacing for the current font. It is typically zero-length. */
		normal: 'normal'

	}

	interface css$prop$letter_spacing extends css$prop {
		/* normal | <length> */
		set(val:css$enum$letter_spacing|css$length): void

	}

	interface css$enum$animation {
		/** The animation cycle iterations that are odd counts are played in the normal direction, and the animation cycle iterations that are even counts are played in a reverse direction. */
		alternate: 'alternate'

		/** The animation cycle iterations that are odd counts are played in the reverse direction, and the animation cycle iterations that are even counts are played in a normal direction. */
		'alternate-reverse': 'alternate-reverse'

		/** The beginning property value (as defined in the first @keyframes at-rule) is applied before the animation is displayed, during the period defined by 'animation-delay'. */
		backwards: 'backwards'

		/** Both forwards and backwards fill modes are applied. */
		both: 'both'

		/** The final property value (as defined in the last @keyframes at-rule) is maintained after the animation completes. */
		forwards: 'forwards'

		/** Causes the animation to repeat forever. */
		infinite: 'infinite'

		/** No animation is performed */
		none: 'none'

		/** Normal playback. */
		normal: 'normal'

		/** All iterations of the animation are played in the reverse direction from the way they were specified. */
		reverse: 'reverse'

	}

	interface css$prop$animation extends css$prop {
		/* <single-animation># */
		set(val:css$enum$animation|css$time|css$timing_function|css$identifier|css$number, arg1: any, arg2: any, arg3: any): void

	}

	interface css$enum$overflow_x {
		/** The behavior of the 'auto' value is UA-dependent, but should cause a scrolling mechanism to be provided for overflowing boxes. */
		auto: 'auto'

		/** Content is clipped and no scrolling mechanism should be provided to view the content outside the clipping region. */
		hidden: 'hidden'

		/** Content is clipped and if the user agent uses a scrolling mechanism that is visible on the screen (such as a scroll bar or a panner), that mechanism should be displayed for a box whether or not any of its content is clipped. */
		scroll: 'scroll'

		/** Content is not clipped, i.e., it may be rendered outside the content box. */
		visible: 'visible'

	}

	interface css$enum$flex_direction {
		/** The flex container’s main axis has the same orientation as the block axis of the current writing mode. */
		column: 'column'

		/** Same as 'column', except the main-start and main-end directions are swapped. */
		'column-reverse': 'column-reverse'

		/** The flex container’s main axis has the same orientation as the inline axis of the current writing mode. */
		row: 'row'

		/** Same as 'row', except the main-start and main-end directions are swapped. */
		'row-reverse': 'row-reverse'

	}

	interface css$prop$flex_direction extends css$prop {
		/* row | row-reverse | column | column-reverse */
		set(val:css$enum$flex_direction): void

	}

	interface css$enum$word_wrap {
		/** An otherwise unbreakable sequence of characters may be broken at an arbitrary point if there are no otherwise-acceptable break points in the line. */
		'break-word': 'break-word'

		/** Lines may break only at allowed break points. */
		normal: 'normal'

	}

	interface css$prop$word_wrap extends css$prop {
		/* normal | break-word | anywhere */
		set(val:css$enum$word_wrap): void

	}

	interface css$enum$flex {
		/** Retrieves the value of the main size property as the used 'flex-basis'. */
		auto: 'auto'

		/** Indicates automatic sizing, based on the flex item’s content. */
		content: 'content'

		/** Expands to '0 0 auto'. */
		none: 'none'

	}

	interface css$prop$flex extends css$prop {
		/* none | [ <'flex-grow'> <'flex-shrink'>? || <'flex-basis'> ] */
		set(val:css$enum$flex|css$length|css$number|css$percentage): void

	}

	interface css$enum$border_collapse {
		/** Selects the collapsing borders model. */
		collapse: 'collapse'

		/** Selects the separated borders border model. */
		separate: 'separate'

	}

	interface css$prop$border_collapse extends css$prop {
		/* collapse | separate */
		set(val:css$enum$border_collapse): void

	}

	interface css$enum$zoom {
		normal: 'normal'

	}

	interface css$prop$zoom extends css$prop {
		/* undefined */
		set(val:css$enum$zoom|css$integer|css$number|css$percentage): void

	}

	interface css$enum$list_style_type {
		/** Traditional uppercase Armenian numbering. */
		armenian: 'armenian'

		/** A hollow circle. */
		circle: 'circle'

		/** Western decimal numbers. */
		decimal: 'decimal'

		/** Decimal numbers padded by initial zeros. */
		'decimal-leading-zero': 'decimal-leading-zero'

		/** A filled circle. */
		disc: 'disc'

		/** Traditional Georgian numbering. */
		georgian: 'georgian'

		/** Lowercase ASCII letters. */
		'lower-alpha': 'lower-alpha'

		/** Lowercase classical Greek. */
		'lower-greek': 'lower-greek'

		/** Lowercase ASCII letters. */
		'lower-latin': 'lower-latin'

		/** Lowercase ASCII Roman numerals. */
		'lower-roman': 'lower-roman'

		/** No marker */
		none: 'none'

		/** A filled square. */
		square: 'square'

		/** Allows a counter style to be defined inline. */
		symbols(): 'symbols()'

		/** Uppercase ASCII letters. */
		'upper-alpha': 'upper-alpha'

		/** Uppercase ASCII letters. */
		'upper-latin': 'upper-latin'

		/** Uppercase ASCII Roman numerals. */
		'upper-roman': 'upper-roman'

	}

	interface css$prop$list_style_type extends css$prop {
		/* [object Object] */
		set(val:css$enum$list_style_type|css$string): void

	}

	interface css$prop$border_bottom_left_radius extends css$prop {
		/* <length-percentage>{1,2} */
		set(val:css$length|css$percentage, arg1: any): void

	}

	interface css$enum$fill {
		/** A URL reference to a paint server element, which is an element that defines a paint server: ‘hatch’, ‘linearGradient’, ‘mesh’, ‘pattern’, ‘radialGradient’ and ‘solidcolor’. */
		url(): 'url()'

		/** No paint is applied in this layer. */
		none: 'none'

	}

	interface css$prop$fill extends css$prop {
		/* undefined */
		set(val:css$enum$fill|css$color|css$url): void

	}

	interface css$prop$transform_origin extends css$prop {
		/* [ <length-percentage> | left | center | right | top | bottom ] | [ [ <length-percentage> | left | center | right ] && [ <length-percentage> | top | center | bottom ] ] <length>? */
		set(val:css$position|css$length|css$percentage): void

	}

	interface css$enum$flex_wrap {
		/** The flex container is single-line. */
		nowrap: 'nowrap'

		/** The flexbox is multi-line. */
		wrap: 'wrap'

		/** Same as 'wrap', except the cross-start and cross-end directions are swapped. */
		'wrap-reverse': 'wrap-reverse'

	}

	interface css$prop$flex_wrap extends css$prop {
		/* nowrap | wrap | wrap-reverse */
		set(val:css$enum$flex_wrap): void

	}

	interface css$enum$text_shadow {
		/** No shadow. */
		none: 'none'

	}

	interface css$prop$text_shadow extends css$prop {
		/* none | <shadow-t># */
		set(val:css$enum$text_shadow|css$length|css$color): void

	}

	interface css$prop$border_top_left_radius extends css$prop {
		/* <length-percentage>{1,2} */
		set(val:css$length|css$percentage, arg1: any): void

	}

	interface css$enum$user_select {
		/** The content of the element must be selected atomically */
		all: 'all'

		auto: 'auto'

		/** UAs must not allow a selection which is started in this element to be extended outside of this element. */
		contain: 'contain'

		/** The UA must not allow selections to be started in this element. */
		none: 'none'

		/** The element imposes no constraint on the selection. */
		text: 'text'

	}

	interface css$prop$user_select extends css$prop {
		/* undefined */
		set(val:css$enum$user_select): void

	}

	interface css$enum$clip {
		/** The element does not clip. */
		auto: 'auto'

		/** Specifies offsets from the edges of the border box. */
		rect(): 'rect()'

	}

	interface css$prop$clip extends css$prop {
		/* undefined */
		set(val:css$enum$clip): void

	}

	interface css$prop$border_bottom_right_radius extends css$prop {
		/* <length-percentage>{1,2} */
		set(val:css$length|css$percentage, arg1: any): void

	}

	interface css$enum$word_break {
		/** Lines may break between any two grapheme clusters for non-CJK scripts. */
		'break-all': 'break-all'

		/** Block characters can no longer create implied break points. */
		'keep-all': 'keep-all'

		/** Breaks non-CJK scripts according to their own rules. */
		normal: 'normal'

	}

	interface css$prop$word_break extends css$prop {
		/* normal | break-all | keep-all | break-word */
		set(val:css$enum$word_break): void

	}

	interface css$prop$border_top_right_radius extends css$prop {
		/* <length-percentage>{1,2} */
		set(val:css$length|css$percentage, arg1: any): void

	}

	interface css$prop$flex_grow extends css$prop {
		/* [object Object] */
		set(val:css$number): void

	}

	interface css$prop$border_top_color extends css$prop {
		/* <color> */
		set(val:css$color): void

	}

	interface css$prop$border_bottom_color extends css$prop {
		/* <color> */
		set(val:css$color): void

	}

	interface css$prop$flex_shrink extends css$prop {
		/* [object Object] */
		set(val:css$number): void

	}

	interface css$enum$text_rendering {
		auto: 'auto'

		/** Indicates that the user agent shall emphasize geometric precision over legibility and rendering speed. */
		geometricPrecision: 'geometricPrecision'

		/** Indicates that the user agent shall emphasize legibility over rendering speed and geometric precision. */
		optimizeLegibility: 'optimizeLegibility'

		/** Indicates that the user agent shall emphasize rendering speed over legibility and geometric precision. */
		optimizeSpeed: 'optimizeSpeed'

	}

	interface css$prop$text_rendering extends css$prop {
		/* auto | optimizeSpeed | optimizeLegibility | geometricPrecision */
		set(val:css$enum$text_rendering): void

	}

	interface css$enum$align_self {
		/** Computes to the value of 'align-items' on the element’s parent, or 'stretch' if the element has no parent. On absolutely positioned elements, it computes to itself. */
		auto: 'auto'

		/** If the flex item’s inline axis is the same as the cross axis, this value is identical to 'flex-start'. Otherwise, it participates in baseline alignment. */
		baseline: 'baseline'

		/** The flex item’s margin box is centered in the cross axis within the line. */
		center: 'center'

		/** The cross-end margin edge of the flex item is placed flush with the cross-end edge of the line. */
		'flex-end': 'flex-end'

		/** The cross-start margin edge of the flex item is placed flush with the cross-start edge of the line. */
		'flex-start': 'flex-start'

		/** If the cross size property of the flex item computes to auto, and neither of the cross-axis margins are auto, the flex item is stretched. */
		stretch: 'stretch'

	}

	interface css$prop$align_self extends css$prop {
		/* auto | normal | stretch | <baseline-position> | <overflow-position>? <self-position> */
		set(val:css$enum$align_self): void

	}

	interface css$prop$text_indent extends css$prop {
		/* <length-percentage> && hanging? && each-line? */
		set(val:css$percentage|css$length): void

	}

	interface css$prop$animation_timing_function extends css$prop {
		/* <single-timing-function># */
		set(val:css$timing_function, arg1: any, arg2: any, arg3: any): void

	}

	interface css$prop$border_spacing extends css$prop {
		/* <length> <length>? */
		set(val:css$length): void

	}

	interface css$enum$direction {
		/** Left-to-right direction. */
		ltr: 'ltr'

		/** Right-to-left direction. */
		rtl: 'rtl'

	}

	interface css$prop$direction extends css$prop {
		/* ltr | rtl */
		set(val:css$enum$direction): void

	}

	interface css$prop$background_clip extends css$prop {
		/* <box># */
		set(val:css$box, arg1: any, arg2: any, arg3: any): void

	}

	interface css$prop$border_left_color extends css$prop {
		/* <color> */
		set(val:css$color): void

	}

	interface css$enum$src {
		/** Reference font by URL */
		url(): 'url()'

		/** Optional hint describing the format of the font resource. */
		format(): 'format()'

		/** Format-specific string that identifies a locally available copy of a given font. */
		local(): 'local()'

	}

	interface css$prop$src extends css$prop {
		/* undefined */
		set(val:css$enum$src|css$url|css$identifier, arg1: any, arg2: any, arg3: any): void

	}

	interface css$enum$touch_action {
		/** The user agent may determine any permitted touch behaviors for touches that begin on the element. */
		auto: 'auto'

		'cross-slide-x': 'cross-slide-x'

		'cross-slide-y': 'cross-slide-y'

		'double-tap-zoom': 'double-tap-zoom'

		/** The user agent may consider touches that begin on the element only for the purposes of scrolling and continuous zooming. */
		manipulation: 'manipulation'

		/** Touches that begin on the element must not trigger default touch behaviors. */
		none: 'none'

		/** The user agent may consider touches that begin on the element only for the purposes of horizontally scrolling the element’s nearest ancestor with horizontally scrollable content. */
		'pan-x': 'pan-x'

		/** The user agent may consider touches that begin on the element only for the purposes of vertically scrolling the element’s nearest ancestor with vertically scrollable content. */
		'pan-y': 'pan-y'

		'pinch-zoom': 'pinch-zoom'

	}

	interface css$prop$touch_action extends css$prop {
		/* auto | none | [ [ pan-x | pan-left | pan-right ] || [ pan-y | pan-up | pan-down ] || pinch-zoom ] | manipulation */
		set(val:css$enum$touch_action): void

	}

	interface css$prop$border_right_color extends css$prop {
		/* <color> */
		set(val:css$color): void

	}

	interface css$enum$transition_property {
		/** Every property that is able to undergo a transition will do so. */
		all: 'all'

		/** No property will transition. */
		none: 'none'

	}

	interface css$prop$transition_property extends css$prop {
		/* none | <single-transition-property># */
		set(val:css$enum$transition_property|css$property): void

	}

	interface css$enum$animation_name {
		/** No animation is performed */
		none: 'none'

	}

	interface css$prop$animation_name extends css$prop {
		/* [ none | <keyframes-name> ]# */
		set(val:css$enum$animation_name|css$identifier, arg1: any, arg2: any, arg3: any): void

	}

	interface css$enum$filter {
		/** No filter effects are applied. */
		none: 'none'

		/** Applies a Gaussian blur to the input image. */
		blur(): 'blur()'

		/** Applies a linear multiplier to input image, making it appear more or less bright. */
		brightness(): 'brightness()'

		/** Adjusts the contrast of the input. */
		contrast(): 'contrast()'

		/** Applies a drop shadow effect to the input image. */
		'drop-shadow()': 'drop-shadow()'

		/** Converts the input image to grayscale. */
		grayscale(): 'grayscale()'

		/** Applies a hue rotation on the input image.  */
		'hue-rotate()': 'hue-rotate()'

		/** Inverts the samples in the input image. */
		invert(): 'invert()'

		/** Applies transparency to the samples in the input image. */
		opacity(): 'opacity()'

		/** Saturates the input image. */
		saturate(): 'saturate()'

		/** Converts the input image to sepia. */
		sepia(): 'sepia()'

		/** A filter reference to a <filter> element. */
		url(): 'url()'

	}

	interface css$prop$filter extends css$prop {
		/* undefined */
		set(val:css$enum$filter|css$url): void

	}

	interface css$prop$animation_duration extends css$prop {
		/* <time># */
		set(val:css$time, arg1: any, arg2: any, arg3: any): void

	}

	interface css$enum$overflow_wrap {
		/** An otherwise unbreakable sequence of characters may be broken at an arbitrary point if there are no otherwise-acceptable break points in the line. */
		'break-word': 'break-word'

		/** Lines may break only at allowed break points. */
		normal: 'normal'

	}

	interface css$prop$overflow_wrap extends css$prop {
		/* normal | break-word | anywhere */
		set(val:css$enum$overflow_wrap): void

	}

	interface css$prop$transition_delay extends css$prop {
		/* <time># */
		set(val:css$time, arg1: any, arg2: any, arg3: any): void

	}

	interface css$enum$stroke {
		/** A URL reference to a paint server element, which is an element that defines a paint server: ‘hatch’, ‘linearGradient’, ‘mesh’, ‘pattern’, ‘radialGradient’ and ‘solidcolor’. */
		url(): 'url()'

		/** No paint is applied in this layer. */
		none: 'none'

	}

	interface css$prop$stroke extends css$prop {
		/* undefined */
		set(val:css$enum$stroke|css$color|css$url): void

	}

	interface css$enum$font_variant {
		/** Specifies a face that is not labeled as a small-caps font. */
		normal: 'normal'

		/** Specifies a font that is labeled as a small-caps font. If a genuine small-caps font is not available, user agents should simulate a small-caps font. */
		'small-caps': 'small-caps'

	}

	interface css$prop$font_variant extends css$prop {
		/* normal | none | [ <common-lig-values> || <discretionary-lig-values> || <historical-lig-values> || <contextual-alt-values> || stylistic( <feature-value-name> ) || historical-forms || styleset( <feature-value-name># ) || character-variant( <feature-value-name># ) || swash( <feature-value-name> ) || ornaments( <feature-value-name> ) || annotation( <feature-value-name> ) || [ small-caps | all-small-caps | petite-caps | all-petite-caps | unicase | titling-caps ] || <numeric-figure-values> || <numeric-spacing-values> || <numeric-fraction-values> || ordinal || slashed-zero || <east-asian-variant-values> || <east-asian-width-values> || ruby ] */
		set(val:css$enum$font_variant): void

	}

	interface css$prop$border_bottom_width extends css$prop {
		/* <br-width> */
		set(val:css$length|css$line_width): void

	}

	interface css$prop$animation_delay extends css$prop {
		/* <time># */
		set(val:css$time, arg1: any, arg2: any, arg3: any): void

	}

	interface css$prop$border_top_width extends css$prop {
		/* <br-width> */
		set(val:css$length|css$line_width): void

	}

	interface css$prop$transition_duration extends css$prop {
		/* <time># */
		set(val:css$time, arg1: any, arg2: any, arg3: any): void

	}

	interface css$enum$flex_basis {
		/** Retrieves the value of the main size property as the used 'flex-basis'. */
		auto: 'auto'

		/** Indicates automatic sizing, based on the flex item’s content. */
		content: 'content'

	}

	interface css$prop$flex_basis extends css$prop {
		/* [object Object] */
		set(val:css$enum$flex_basis|css$length|css$number|css$percentage): void

	}

	interface css$enum$will_change {
		/** Expresses no particular intent. */
		auto: 'auto'

		/** Indicates that the author expects to animate or change something about the element’s contents in the near future. */
		contents: 'contents'

		/** Indicates that the author expects to animate or change the scroll position of the element in the near future. */
		'scroll-position': 'scroll-position'

	}

	interface css$prop$will_change extends css$prop {
		/* auto | <animateable-feature># */
		set(val:css$enum$will_change|css$identifier): void

	}

	interface css$enum$animation_fill_mode {
		/** The beginning property value (as defined in the first @keyframes at-rule) is applied before the animation is displayed, during the period defined by 'animation-delay'. */
		backwards: 'backwards'

		/** Both forwards and backwards fill modes are applied. */
		both: 'both'

		/** The final property value (as defined in the last @keyframes at-rule) is maintained after the animation completes. */
		forwards: 'forwards'

		/** There is no change to the property value between the time the animation is applied and the time the animation begins playing or after the animation completes. */
		none: 'none'

	}

	interface css$prop$animation_fill_mode extends css$prop {
		/* <single-animation-fill-mode># */
		set(val:css$enum$animation_fill_mode, arg1: any, arg2: any, arg3: any): void

	}

	interface css$prop$outline_width extends css$prop {
		/* [object Object] */
		set(val:css$length|css$line_width): void

	}

	interface css$enum$table_layout {
		/** Use any automatic table layout algorithm. */
		auto: 'auto'

		/** Use the fixed table layout algorithm. */
		fixed: 'fixed'

	}

	interface css$prop$table_layout extends css$prop {
		/* auto | fixed */
		set(val:css$enum$table_layout): void

	}

	interface css$enum$object_fit {
		/** The replaced content is sized to maintain its aspect ratio while fitting within the element’s content box: its concrete object size is resolved as a contain constraint against the element's used width and height. */
		contain: 'contain'

		/** The replaced content is sized to maintain its aspect ratio while filling the element's entire content box: its concrete object size is resolved as a cover constraint against the element’s used width and height. */
		cover: 'cover'

		/** The replaced content is sized to fill the element’s content box: the object's concrete object size is the element's used width and height. */
		fill: 'fill'

		/** The replaced content is not resized to fit inside the element's content box */
		none: 'none'

		/** Size the content as if ‘none’ or ‘contain’ were specified, whichever would result in a smaller concrete object size. */
		'scale-down': 'scale-down'

	}

	interface css$prop$object_fit extends css$prop {
		/* fill | contain | cover | none | scale-down */
		set(val:css$enum$object_fit): void

	}

	interface css$prop$order extends css$prop {
		/* <integer> */
		set(val:css$integer): void

	}

	interface css$prop$transition_timing_function extends css$prop {
		/* <timing-function># */
		set(val:css$timing_function, arg1: any, arg2: any, arg3: any): void

	}

	interface css$enum$resize {
		/** The UA presents a bidirectional resizing mechanism to allow the user to adjust both the height and the width of the element. */
		both: 'both'

		/** The UA presents a unidirectional horizontal resizing mechanism to allow the user to adjust only the width of the element. */
		horizontal: 'horizontal'

		/** The UA does not present a resizing mechanism on the element, and the user is given no direct manipulation mechanism to resize the element. */
		none: 'none'

		/** The UA presents a unidirectional vertical resizing mechanism to allow the user to adjust only the height of the element. */
		vertical: 'vertical'

	}

	interface css$prop$resize extends css$prop {
		/* none | both | horizontal | vertical | block | inline */
		set(val:css$enum$resize): void

	}

	interface css$enum$outline_style {
		/** Permits the user agent to render a custom outline style, typically the default platform style. */
		auto: 'auto'

	}

	interface css$prop$outline_style extends css$prop {
		/* [object Object] */
		set(val:css$enum$outline_style|css$line_style): void

	}

	interface css$prop$border_right_width extends css$prop {
		/* <br-width> */
		set(val:css$length|css$line_width): void

	}

	interface css$prop$stroke_width extends css$prop {
		/* undefined */
		set(val:css$percentage|css$length): void

	}

	interface css$enum$animation_iteration_count {
		/** Causes the animation to repeat forever. */
		infinite: 'infinite'

	}

	interface css$prop$animation_iteration_count extends css$prop {
		/* <single-animation-iteration-count># */
		set(val:css$enum$animation_iteration_count|css$number, arg1: any, arg2: any, arg3: any): void

	}

	interface css$enum$align_content {
		/** Lines are packed toward the center of the flex container. */
		center: 'center'

		/** Lines are packed toward the end of the flex container. */
		'flex-end': 'flex-end'

		/** Lines are packed toward the start of the flex container. */
		'flex-start': 'flex-start'

		/** Lines are evenly distributed in the flex container, with half-size spaces on either end. */
		'space-around': 'space-around'

		/** Lines are evenly distributed in the flex container. */
		'space-between': 'space-between'

		/** Lines stretch to take up the remaining space. */
		stretch: 'stretch'

	}

	interface css$prop$align_content extends css$prop {
		/* normal | <baseline-position> | <content-distribution> | <overflow-position>? <content-position> */
		set(val:css$enum$align_content): void

	}

	interface css$prop$outline_offset extends css$prop {
		/* <length> */
		set(val:css$length): void

	}

	interface css$enum$backface_visibility {
		/** Back side is hidden. */
		hidden: 'hidden'

		/** Back side is visible. */
		visible: 'visible'

	}

	interface css$prop$backface_visibility extends css$prop {
		/* undefined */
		set(val:css$enum$backface_visibility): void

	}

	interface css$prop$border_left_width extends css$prop {
		/* <br-width> */
		set(val:css$length|css$line_width): void

	}

	interface css$enum$flex_flow {
		/** The flex container’s main axis has the same orientation as the block axis of the current writing mode. */
		column: 'column'

		/** Same as 'column', except the main-start and main-end directions are swapped. */
		'column-reverse': 'column-reverse'

		/** The flex container is single-line. */
		nowrap: 'nowrap'

		/** The flex container’s main axis has the same orientation as the inline axis of the current writing mode. */
		row: 'row'

		/** Same as 'row', except the main-start and main-end directions are swapped. */
		'row-reverse': 'row-reverse'

		/** The flexbox is multi-line. */
		wrap: 'wrap'

		/** Same as 'wrap', except the cross-start and cross-end directions are swapped. */
		'wrap-reverse': 'wrap-reverse'

	}

	interface css$prop$flex_flow extends css$prop {
		/* <'flex-direction'> || <'flex-wrap'> */
		set(val:css$enum$flex_flow): void

	}

	interface css$prop$appearance extends css$prop {
		/* undefined */
		set(val:any): void

	}

	interface css$enum$unicode_bidi {
		/** Inside the element, reordering is strictly in sequence according to the 'direction' property; the implicit part of the bidirectional algorithm is ignored. */
		'bidi-override': 'bidi-override'

		/** If the element is inline-level, this value opens an additional level of embedding with respect to the bidirectional algorithm. The direction of this embedding level is given by the 'direction' property. */
		embed: 'embed'

		/** The contents of the element are considered to be inside a separate, independent paragraph. */
		isolate: 'isolate'

		/** This combines the isolation behavior of 'isolate' with the directional override behavior of 'bidi-override' */
		'isolate-override': 'isolate-override'

		/** The element does not open an additional level of embedding with respect to the bidirectional algorithm. For inline-level elements, implicit reordering works across element boundaries. */
		normal: 'normal'

		/** For the purposes of the Unicode bidirectional algorithm, the base directionality of each bidi paragraph for which the element forms the containing block is determined not by the element's computed 'direction'. */
		plaintext: 'plaintext'

	}

	interface css$prop$unicode_bidi extends css$prop {
		/* normal | embed | isolate | bidi-override | isolate-override | plaintext */
		set(val:css$enum$unicode_bidi): void

	}

	interface css$enum$stroke_dasharray {
		/** Indicates that no dashing is used. */
		none: 'none'

	}

	interface css$prop$stroke_dasharray extends css$prop {
		/* undefined */
		set(val:css$enum$stroke_dasharray|css$length|css$percentage|css$number): void

	}

	interface css$prop$stroke_dashoffset extends css$prop {
		/* undefined */
		set(val:css$percentage|css$length): void

	}

	interface css$enum$unicode_range {
		/** Ampersand. */
		'U+26': 'U+26'

		/** Basic Latin (ASCII). */
		'U+00-7F': 'U+00-7F'

		/** Latin-1 Supplement. Accented characters for Western European languages, common punctuation characters, multiplication and division signs. */
		'U+80-FF': 'U+80-FF'

		/** Latin Extended-A. Accented characters for for Czech, Dutch, Polish, and Turkish. */
		'U+100-17F': 'U+100-17F'

		/** Latin Extended-B. Croatian, Slovenian, Romanian, Non-European and historic latin, Khoisan, Pinyin, Livonian, Sinology. */
		'U+180-24F': 'U+180-24F'

		/** Latin Extended Additional. Vietnamese, German captial sharp s, Medievalist, Latin general use. */
		'U+1E00-1EFF': 'U+1E00-1EFF'

		/** International Phonetic Alphabet Extensions. */
		'U+250-2AF': 'U+250-2AF'

		/** Greek and Coptic. */
		'U+370-3FF': 'U+370-3FF'

		/** Greek Extended. Accented characters for polytonic Greek. */
		'U+1F00-1FFF': 'U+1F00-1FFF'

		/** Cyrillic. */
		'U+400-4FF': 'U+400-4FF'

		/** Cyrillic Supplement. Extra letters for Komi, Khanty, Chukchi, Mordvin, Kurdish, Aleut, Chuvash, Abkhaz, Azerbaijani, and Orok. */
		'U+500-52F': 'U+500-52F'

		/** Armenian. */
		'U+530–58F': 'U+530–58F'

		/** Hebrew. */
		'U+590–5FF': 'U+590–5FF'

		/** Arabic. */
		'U+600–6FF': 'U+600–6FF'

		/** Arabic Supplement. Additional letters for African languages, Khowar, Torwali, Burushaski, and early Persian. */
		'U+750–77F': 'U+750–77F'

		/** Arabic Extended-A. Additional letters for African languages, European and Central Asian languages, Rohingya, Tamazight, Arwi, and Koranic annotation signs. */
		'U+8A0–8FF': 'U+8A0–8FF'

		/** Syriac. */
		'U+700–74F': 'U+700–74F'

		/** Devanagari. */
		'U+900–97F': 'U+900–97F'

		/** Bengali. */
		'U+980–9FF': 'U+980–9FF'

		/** Gurmukhi. */
		'U+A00–A7F': 'U+A00–A7F'

		/** Gujarati. */
		'U+A80–AFF': 'U+A80–AFF'

		/** Oriya. */
		'U+B00–B7F': 'U+B00–B7F'

		/** Tamil. */
		'U+B80–BFF': 'U+B80–BFF'

		/** Telugu. */
		'U+C00–C7F': 'U+C00–C7F'

		/** Kannada. */
		'U+C80–CFF': 'U+C80–CFF'

		/** Malayalam. */
		'U+D00–D7F': 'U+D00–D7F'

		/** Sinhala. */
		'U+D80–DFF': 'U+D80–DFF'

		/** Warang Citi. */
		'U+118A0–118FF': 'U+118A0–118FF'

		/** Thai. */
		'U+E00–E7F': 'U+E00–E7F'

		/** Tai Tham. */
		'U+1A20–1AAF': 'U+1A20–1AAF'

		/** Tai Viet. */
		'U+AA80–AADF': 'U+AA80–AADF'

		/** Lao. */
		'U+E80–EFF': 'U+E80–EFF'

		/** Tibetan. */
		'U+F00–FFF': 'U+F00–FFF'

		/** Myanmar (Burmese). */
		'U+1000–109F': 'U+1000–109F'

		/** Georgian. */
		'U+10A0–10FF': 'U+10A0–10FF'

		/** Ethiopic. */
		'U+1200–137F': 'U+1200–137F'

		/** Ethiopic Supplement. Extra Syllables for Sebatbeit, and Tonal marks */
		'U+1380–139F': 'U+1380–139F'

		/** Ethiopic Extended. Extra Syllables for Me'en, Blin, and Sebatbeit. */
		'U+2D80–2DDF': 'U+2D80–2DDF'

		/** Ethiopic Extended-A. Extra characters for Gamo-Gofa-Dawro, Basketo, and Gumuz. */
		'U+AB00–AB2F': 'U+AB00–AB2F'

		/** Khmer. */
		'U+1780–17FF': 'U+1780–17FF'

		/** Mongolian. */
		'U+1800–18AF': 'U+1800–18AF'

		/** Sundanese. */
		'U+1B80–1BBF': 'U+1B80–1BBF'

		/** Sundanese Supplement. Punctuation. */
		'U+1CC0–1CCF': 'U+1CC0–1CCF'

		/** CJK (Chinese, Japanese, Korean) Unified Ideographs. Most common ideographs for modern Chinese and Japanese. */
		'U+4E00–9FD5': 'U+4E00–9FD5'

		/** CJK Unified Ideographs Extension A. Rare ideographs. */
		'U+3400–4DB5': 'U+3400–4DB5'

		/** Kangxi Radicals. */
		'U+2F00–2FDF': 'U+2F00–2FDF'

		/** CJK Radicals Supplement. Alternative forms of Kangxi Radicals. */
		'U+2E80–2EFF': 'U+2E80–2EFF'

		/** Hangul Jamo. */
		'U+1100–11FF': 'U+1100–11FF'

		/** Hangul Syllables. */
		'U+AC00–D7AF': 'U+AC00–D7AF'

		/** Hiragana. */
		'U+3040–309F': 'U+3040–309F'

		/** Katakana. */
		'U+30A0–30FF': 'U+30A0–30FF'

		/** Lisu. */
		'U+A4D0–A4FF': 'U+A4D0–A4FF'

		/** Yi Syllables. */
		'U+A000–A48F': 'U+A000–A48F'

		/** Yi Radicals. */
		'U+A490–A4CF': 'U+A490–A4CF'

		/** General Punctuation. */
		'U+2000-206F': 'U+2000-206F'

		/** CJK Symbols and Punctuation. */
		'U+3000–303F': 'U+3000–303F'

		/** Superscripts and Subscripts. */
		'U+2070–209F': 'U+2070–209F'

		/** Currency Symbols. */
		'U+20A0–20CF': 'U+20A0–20CF'

		/** Letterlike Symbols. */
		'U+2100–214F': 'U+2100–214F'

		/** Number Forms. */
		'U+2150–218F': 'U+2150–218F'

		/** Arrows. */
		'U+2190–21FF': 'U+2190–21FF'

		/** Mathematical Operators. */
		'U+2200–22FF': 'U+2200–22FF'

		/** Miscellaneous Technical. */
		'U+2300–23FF': 'U+2300–23FF'

		/** Private Use Area. */
		'U+E000-F8FF': 'U+E000-F8FF'

		/** Alphabetic Presentation Forms. Ligatures for latin, Armenian, and Hebrew. */
		'U+FB00–FB4F': 'U+FB00–FB4F'

		/** Arabic Presentation Forms-A. Contextual forms / ligatures for Persian, Urdu, Sindhi, Central Asian languages, etc, Arabic pedagogical symbols, word ligatures. */
		'U+FB50–FDFF': 'U+FB50–FDFF'

		/** Emoji: Emoticons. */
		'U+1F600–1F64F': 'U+1F600–1F64F'

		/** Emoji: Miscellaneous Symbols. */
		'U+2600–26FF': 'U+2600–26FF'

		/** Emoji: Miscellaneous Symbols and Pictographs. */
		'U+1F300–1F5FF': 'U+1F300–1F5FF'

		/** Emoji: Supplemental Symbols and Pictographs. */
		'U+1F900–1F9FF': 'U+1F900–1F9FF'

		/** Emoji: Transport and Map Symbols. */
		'U+1F680–1F6FF': 'U+1F680–1F6FF'

	}

	interface css$prop$unicode_range extends css$prop {
		/* undefined */
		set(val:css$enum$unicode_range|css$unicode_range): void

	}

	interface css$enum$word_spacing {
		/** No additional spacing is applied. Computes to zero. */
		normal: 'normal'

	}

	interface css$prop$word_spacing extends css$prop {
		/* normal | <length-percentage> */
		set(val:css$enum$word_spacing|css$length|css$percentage): void

	}

	interface css$prop$text_size_adjust extends css$prop {
		/* undefined */
		set(val:any): void

	}

	interface css$prop$border_top_style extends css$prop {
		/* <br-style> */
		set(val:css$line_style): void

	}

	interface css$prop$border_bottom_style extends css$prop {
		/* <br-style> */
		set(val:css$line_style): void

	}

	interface css$enum$animation_direction {
		/** The animation cycle iterations that are odd counts are played in the normal direction, and the animation cycle iterations that are even counts are played in a reverse direction. */
		alternate: 'alternate'

		/** The animation cycle iterations that are odd counts are played in the reverse direction, and the animation cycle iterations that are even counts are played in a normal direction. */
		'alternate-reverse': 'alternate-reverse'

		/** Normal playback. */
		normal: 'normal'

		/** All iterations of the animation are played in the reverse direction from the way they were specified. */
		reverse: 'reverse'

	}

	interface css$prop$animation_direction extends css$prop {
		/* <single-animation-direction># */
		set(val:css$enum$animation_direction, arg1: any, arg2: any, arg3: any): void

	}

	interface css$enum$image_rendering {
		/** The image should be scaled with an algorithm that maximizes the appearance of the image. */
		auto: 'auto'

		/** The image must be scaled with an algorithm that preserves contrast and edges in the image, and which does not smooth colors or introduce blur to the image in the process. */
		'crisp-edges': 'crisp-edges'

		'-moz-crisp-edges': '-moz-crisp-edges'

		/** Deprecated. */
		optimizeQuality: 'optimizeQuality'

		/** Deprecated. */
		optimizeSpeed: 'optimizeSpeed'

		/** When scaling the image up, the 'nearest neighbor' or similar algorithm must be used, so that the image appears to be simply composed of very large pixels. */
		pixelated: 'pixelated'

	}

	interface css$prop$image_rendering extends css$prop {
		/* undefined */
		set(val:css$enum$image_rendering): void

	}

	interface css$enum$perspective {
		/** No perspective transform is applied. */
		none: 'none'

	}

	interface css$prop$perspective extends css$prop {
		/* none | <length> */
		set(val:css$enum$perspective|css$length): void

	}

	interface css$enum$grid_template_columns {
		/** There is no explicit grid; any rows/columns will be implicitly generated. */
		none: 'none'

		/** Represents the largest min-content contribution of the grid items occupying the grid track. */
		'min-content': 'min-content'

		/** Represents the largest max-content contribution of the grid items occupying the grid track. */
		'max-content': 'max-content'

		/** As a maximum, identical to 'max-content'. As a minimum, represents the largest minimum size (as specified by min-width/min-height) of the grid items occupying the grid track. */
		auto: 'auto'

		/** Indicates that the grid will align to its parent grid in that axis. */
		subgrid: 'subgrid'

		/** Defines a size range greater than or equal to min and less than or equal to max. */
		minmax(): 'minmax()'

		/** Represents a repeated fragment of the track list, allowing a large number of columns or rows that exhibit a recurring pattern to be written in a more compact form. */
		repeat(): 'repeat()'

	}

	interface css$prop$grid_template_columns extends css$prop {
		/* none | <track-list> | <auto-track-list> */
		set(val:css$enum$grid_template_columns|css$identifier|css$length|css$percentage): void

	}

	interface css$enum$list_style_position {
		/** The marker box is outside the principal block box, as described in the section on the ::marker pseudo-element below. */
		inside: 'inside'

		/** The ::marker pseudo-element is an inline element placed immediately before all ::before pseudo-elements in the principal block box, after which the element's content flows. */
		outside: 'outside'

	}

	interface css$prop$list_style_position extends css$prop {
		/* [object Object] */
		set(val:css$enum$list_style_position): void

	}

	interface css$enum$font_feature_settings {
		/** No change in glyph substitution or positioning occurs. */
		normal: 'normal'

		/** Disable feature. */
		off: 'off'

		/** Enable feature. */
		on: 'on'

	}

	interface css$prop$font_feature_settings extends css$prop {
		/* normal | <feature-tag-value># */
		set(val:css$enum$font_feature_settings|css$string|css$integer): void

	}

	interface css$enum$contain {
		/** Indicates that the property has no effect. */
		none: 'none'

		/** Turns on all forms of containment for the element. */
		strict: 'strict'

		/** All containment rules except size are applied to the element. */
		content: 'content'

		/** For properties that can have effects on more than just an element and its descendants, those effects don't escape the containing element. */
		size: 'size'

		/** Turns on layout containment for the element. */
		layout: 'layout'

		/** Turns on style containment for the element. */
		style: 'style'

		/** Turns on paint containment for the element. */
		paint: 'paint'

	}

	interface css$prop$contain extends css$prop {
		/* undefined */
		set(val:css$enum$contain): void

	}

	interface css$enum$background_position_x {
		/** Equivalent to '50%' ('left 50%') for the horizontal position if the horizontal position is not otherwise specified, or '50%' ('top 50%') for the vertical position if it is. */
		center: 'center'

		/** Equivalent to '0%' for the horizontal position if one or two values are given, otherwise specifies the left edge as the origin for the next offset. */
		left: 'left'

		/** Equivalent to '100%' for the horizontal position if one or two values are given, otherwise specifies the right edge as the origin for the next offset. */
		right: 'right'

	}

	interface css$prop$background_position_x extends css$prop {
		/* undefined */
		set(val:css$enum$background_position_x|css$length|css$percentage, arg1: any, arg2: any, arg3: any): void

	}

	interface css$enum$transform_style {
		/** All children of this element are rendered flattened into the 2D plane of the element. */
		flat: 'flat'

		/** Flattening is not performed, so children maintain their position in 3D space. */
		'preserve-3d': 'preserve-3d'

	}

	interface css$prop$transform_style extends css$prop {
		/* flat | preserve-3d */
		set(val:css$enum$transform_style): void

	}

	interface css$prop$background_origin extends css$prop {
		/* <box># */
		set(val:css$box, arg1: any, arg2: any, arg3: any): void

	}

	interface css$prop$border_left_style extends css$prop {
		/* <br-style> */
		set(val:css$line_style): void

	}

	interface css$prop$font_display extends css$prop {
		/* undefined */
		set(val:any): void

	}

	interface css$enum$clip_path {
		/** No clipping path gets created. */
		none: 'none'

		/** References a <clipPath> element to create a clipping path. */
		url(): 'url()'

	}

	interface css$prop$clip_path extends css$prop {
		/* <clip-source> | [ <basic-shape> || <geometry-box> ] | none */
		set(val:css$enum$clip_path|css$url|css$shape|css$geometry_box): void

	}

	interface css$enum$hyphens {
		/** Conditional hyphenation characters inside a word, if present, take priority over automatic resources when determining hyphenation points within the word. */
		auto: 'auto'

		/** Words are only broken at line breaks where there are characters inside the word that suggest line break opportunities */
		manual: 'manual'

		/** Words are not broken at line breaks, even if characters inside the word suggest line break points. */
		none: 'none'

	}

	interface css$prop$hyphens extends css$prop {
		/* none | manual | auto */
		set(val:css$enum$hyphens): void

	}

	interface css$enum$background_attachment {
		/** The background is fixed with regard to the viewport. In paged media where there is no viewport, a 'fixed' background is fixed with respect to the page box and therefore replicated on every page. */
		fixed: 'fixed'

		/** The background is fixed with regard to the element’s contents: if the element has a scrolling mechanism, the background scrolls with the element’s contents. */
		local: 'local'

		/** The background is fixed with regard to the element itself and does not scroll with its contents. (It is effectively attached to the element’s border.) */
		scroll: 'scroll'

	}

	interface css$prop$background_attachment extends css$prop {
		/* <attachment># */
		set(val:css$enum$background_attachment, arg1: any, arg2: any, arg3: any): void

	}

	interface css$prop$border_right_style extends css$prop {
		/* <br-style> */
		set(val:css$line_style): void

	}

	interface css$enum$outline_color {
		/** Performs a color inversion on the pixels on the screen. */
		invert: 'invert'

	}

	interface css$prop$outline_color extends css$prop {
		/* [object Object] */
		set(val:css$enum$outline_color|css$color): void

	}

	interface css$enum$margin_block_end {
		auto: 'auto'

	}

	interface css$prop$margin_block_end extends css$prop {
		/* undefined */
		set(val:css$enum$margin_block_end|css$length|css$percentage): void

	}

	interface css$enum$animation_play_state {
		/** A running animation will be paused. */
		paused: 'paused'

		/** Resume playback of a paused animation. */
		running: 'running'

	}

	interface css$prop$animation_play_state extends css$prop {
		/* running | paused */
		set(val:css$enum$animation_play_state): void

	}

	interface css$enum$quotes {
		/** The 'open-quote' and 'close-quote' values of the 'content' property produce no quotations marks, as if they were 'no-open-quote' and 'no-close-quote' respectively. */
		none: 'none'

	}

	interface css$prop$quotes extends css$prop {
		/* none | auto | [ <string> <string> ]+ */
		set(val:css$enum$quotes|css$string): void

	}

	interface css$enum$background_position_y {
		/** Equivalent to '100%' for the vertical position if one or two values are given, otherwise specifies the bottom edge as the origin for the next offset. */
		bottom: 'bottom'

		/** Equivalent to '50%' ('left 50%') for the horizontal position if the horizontal position is not otherwise specified, or '50%' ('top 50%') for the vertical position if it is. */
		center: 'center'

		/** Equivalent to '0%' for the vertical position if one or two values are given, otherwise specifies the top edge as the origin for the next offset. */
		top: 'top'

	}

	interface css$prop$background_position_y extends css$prop {
		/* undefined */
		set(val:css$enum$background_position_y|css$length|css$percentage, arg1: any, arg2: any, arg3: any): void

	}

	interface css$enum$font_stretch {
		condensed: 'condensed'

		expanded: 'expanded'

		'extra-condensed': 'extra-condensed'

		'extra-expanded': 'extra-expanded'

		/** Indicates a narrower value relative to the width of the parent element. */
		narrower: 'narrower'

		normal: 'normal'

		'semi-condensed': 'semi-condensed'

		'semi-expanded': 'semi-expanded'

		'ultra-condensed': 'ultra-condensed'

		'ultra-expanded': 'ultra-expanded'

		/** Indicates a wider value relative to the width of the parent element. */
		wider: 'wider'

	}

	interface css$prop$font_stretch extends css$prop {
		/* [object Object] */
		set(val:css$enum$font_stretch): void

	}

	interface css$enum$stroke_linecap {
		/** Indicates that the stroke for each subpath does not extend beyond its two endpoints. */
		butt: 'butt'

		/** Indicates that at each end of each subpath, the shape representing the stroke will be extended by a half circle with a radius equal to the stroke width. */
		round: 'round'

		/** Indicates that at the end of each subpath, the shape representing the stroke will be extended by a rectangle with the same width as the stroke width and whose length is half of the stroke width. */
		square: 'square'

	}

	interface css$prop$stroke_linecap extends css$prop {
		/* undefined */
		set(val:css$enum$stroke_linecap): void

	}

	interface css$prop$object_position extends css$prop {
		/* <position> */
		set(val:css$position|css$length|css$percentage): void

	}

	interface css$enum$counter_reset {
		/** The counter is not modified. */
		none: 'none'

	}

	interface css$prop$counter_reset extends css$prop {
		/* [ <custom-ident> <integer>? ]+ | none */
		set(val:css$enum$counter_reset|css$identifier|css$integer): void

	}

	interface css$enum$margin_block_start {
		auto: 'auto'

	}

	interface css$prop$margin_block_start extends css$prop {
		/* undefined */
		set(val:css$enum$margin_block_start|css$length|css$percentage): void

	}

	interface css$enum$counter_increment {
		/** This element does not alter the value of any counters. */
		none: 'none'

	}

	interface css$prop$counter_increment extends css$prop {
		/* [ <custom-ident> <integer>? ]+ | none */
		set(val:css$enum$counter_increment|css$identifier|css$integer): void

	}

	interface css$prop$size extends css$prop {
		/* undefined */
		set(val:css$length): void

	}

	interface css$prop$text_decoration_color extends css$prop {
		/* [object Object] */
		set(val:css$color): void

	}

	interface css$enum$list_style_image {
		/** The default contents of the of the list item’s marker are given by 'list-style-type' instead. */
		none: 'none'

	}

	interface css$prop$list_style_image extends css$prop {
		/* [object Object] */
		set(val:css$enum$list_style_image|css$image): void

	}

	interface css$enum$column_count {
		/** Determines the number of columns by the 'column-width' property and the element width. */
		auto: 'auto'

	}

	interface css$prop$column_count extends css$prop {
		/* <integer> | auto */
		set(val:css$enum$column_count|css$integer): void

	}

	interface css$enum$border_image {
		/** If 'auto' is specified then the border image width is the intrinsic width or height (whichever is applicable) of the corresponding image slice. If the image does not have the required intrinsic dimension then the corresponding border-width is used instead. */
		auto: 'auto'

		/** Causes the middle part of the border-image to be preserved. */
		fill: 'fill'

		/** Use the border styles. */
		none: 'none'

		/** The image is tiled (repeated) to fill the area. */
		repeat: 'repeat'

		/** The image is tiled (repeated) to fill the area. If it does not fill the area with a whole number of tiles, the image is rescaled so that it does. */
		round: 'round'

		/** The image is tiled (repeated) to fill the area. If it does not fill the area with a whole number of tiles, the extra space is distributed around the tiles. */
		space: 'space'

		/** The image is stretched to fill the area. */
		stretch: 'stretch'

		url(): 'url()'

	}

	interface css$prop$border_image extends css$prop {
		/* <'border-image-source'> || <'border-image-slice'> [ / <'border-image-width'> | / <'border-image-width'>? / <'border-image-outset'> ]? || <'border-image-repeat'> */
		set(val:css$enum$border_image|css$length|css$percentage|css$number|css$url): void

	}

	interface css$enum$column_gap {
		/** User agent specific and typically equivalent to 1em. */
		normal: 'normal'

	}

	interface css$prop$column_gap extends css$prop {
		/* normal | <length-percentage> */
		set(val:css$enum$column_gap|css$length): void

	}

	interface css$enum$page_break_inside {
		/** Neither force nor forbid a page break inside the generated box. */
		auto: 'auto'

		/** Avoid a page break inside the generated box. */
		avoid: 'avoid'

	}

	interface css$prop$page_break_inside extends css$prop {
		/* undefined */
		set(val:css$enum$page_break_inside): void

	}

	interface css$prop$fill_opacity extends css$prop {
		/* undefined */
		set(val:css$number): void

	}

	interface css$prop$padding_inline_start extends css$prop {
		/* <'padding-left'> */
		set(val:css$length|css$percentage): void

	}

	interface css$enum$empty_cells {
		/** No borders or backgrounds are drawn around/behind empty cells. */
		hide: 'hide'

		'-moz-show-background': '-moz-show-background'

		/** Borders and backgrounds are drawn around/behind empty cells (like normal cells). */
		show: 'show'

	}

	interface css$prop$empty_cells extends css$prop {
		/* show | hide */
		set(val:css$enum$empty_cells): void

	}

	interface css$enum$font_variant_ligatures {
		/** Enables display of additional ligatures. */
		'additional-ligatures': 'additional-ligatures'

		/** Enables display of common ligatures. */
		'common-ligatures': 'common-ligatures'

		/** Enables display of contextual alternates. */
		contextual: 'contextual'

		/** Enables display of discretionary ligatures. */
		'discretionary-ligatures': 'discretionary-ligatures'

		/** Enables display of historical ligatures. */
		'historical-ligatures': 'historical-ligatures'

		/** Disables display of additional ligatures. */
		'no-additional-ligatures': 'no-additional-ligatures'

		/** Disables display of common ligatures. */
		'no-common-ligatures': 'no-common-ligatures'

		/** Disables display of contextual alternates. */
		'no-contextual': 'no-contextual'

		/** Disables display of discretionary ligatures. */
		'no-discretionary-ligatures': 'no-discretionary-ligatures'

		/** Disables display of historical ligatures. */
		'no-historical-ligatures': 'no-historical-ligatures'

		/** Disables all ligatures. */
		none: 'none'

		/** Implies that the defaults set by the font are used. */
		normal: 'normal'

	}

	interface css$prop$font_variant_ligatures extends css$prop {
		/* normal | none | [ <common-lig-values> || <discretionary-lig-values> || <historical-lig-values> || <contextual-alt-values> ] */
		set(val:css$enum$font_variant_ligatures): void

	}

	interface css$prop$text_decoration_skip extends css$prop {
		/* undefined */
		set(val:any): void

	}

	interface css$enum$justify_self {
		auto: 'auto'

		normal: 'normal'

		end: 'end'

		start: 'start'

		/** "Flex items are packed toward the end of the line." */
		'flex-end': 'flex-end'

		/** "Flex items are packed toward the start of the line." */
		'flex-start': 'flex-start'

		/** The item is packed flush to the edge of the alignment container of the end side of the item, in the appropriate axis. */
		'self-end': 'self-end'

		/** The item is packed flush to the edge of the alignment container of the start side of the item, in the appropriate axis.. */
		'self-start': 'self-start'

		/** The items are packed flush to each other toward the center of the of the alignment container. */
		center: 'center'

		left: 'left'

		right: 'right'

		baseline: 'baseline'

		'first baseline': 'first baseline'

		'last baseline': 'last baseline'

		/** If the cross size property of the flex item computes to auto, and neither of the cross-axis margins are auto, the flex item is stretched. */
		stretch: 'stretch'

		save: 'save'

		unsave: 'unsave'

	}

	interface css$prop$justify_self extends css$prop {
		/* auto | normal | stretch | <baseline-position> | <overflow-position>? [ <self-position> | left | right ] */
		set(val:css$enum$justify_self): void

	}

	interface css$enum$page_break_after {
		/** Always force a page break after the generated box. */
		always: 'always'

		/** Neither force nor forbid a page break after generated box. */
		auto: 'auto'

		/** Avoid a page break after the generated box. */
		avoid: 'avoid'

		/** Force one or two page breaks after the generated box so that the next page is formatted as a left page. */
		left: 'left'

		/** Force one or two page breaks after the generated box so that the next page is formatted as a right page. */
		right: 'right'

	}

	interface css$prop$page_break_after extends css$prop {
		/* undefined */
		set(val:css$enum$page_break_after): void

	}

	interface css$enum$grid_template_rows {
		/** There is no explicit grid; any rows/columns will be implicitly generated. */
		none: 'none'

		/** Represents the largest min-content contribution of the grid items occupying the grid track. */
		'min-content': 'min-content'

		/** Represents the largest max-content contribution of the grid items occupying the grid track. */
		'max-content': 'max-content'

		/** As a maximum, identical to 'max-content'. As a minimum, represents the largest minimum size (as specified by min-width/min-height) of the grid items occupying the grid track. */
		auto: 'auto'

		/** Indicates that the grid will align to its parent grid in that axis. */
		subgrid: 'subgrid'

		/** Defines a size range greater than or equal to min and less than or equal to max. */
		minmax(): 'minmax()'

		/** Represents a repeated fragment of the track list, allowing a large number of columns or rows that exhibit a recurring pattern to be written in a more compact form. */
		repeat(): 'repeat()'

	}

	interface css$prop$grid_template_rows extends css$prop {
		/* none | <track-list> | <auto-track-list> */
		set(val:css$enum$grid_template_rows|css$identifier|css$length|css$percentage|css$string): void

	}

	interface css$prop$padding_inline_end extends css$prop {
		/* <'padding-left'> */
		set(val:css$length|css$percentage): void

	}

	interface css$prop$grid_gap extends css$prop {
		/* <'row-gap'> <'column-gap'>? */
		set(val:css$length): void

	}

	interface css$prop$all extends css$prop {
		/* revert */
		set(val:css$enum$all): void

	}

	interface css$enum$grid_column {
		/** The property contributes nothing to the grid item’s placement, indicating auto-placement, an automatic span, or a default span of one. */
		auto: 'auto'

		/** Contributes a grid span to the grid item’s placement such that the corresponding edge of the grid item’s grid area is N lines from its opposite edge. */
		span: 'span'

	}

	interface css$prop$grid_column extends css$prop {
		/* <grid-line> [ / <grid-line> ]? */
		set(val:css$enum$grid_column|css$identifier|css$integer): void

	}

	interface css$prop$stroke_opacity extends css$prop {
		/* undefined */
		set(val:css$number): void

	}

	interface css$enum$margin_inline_start {
		auto: 'auto'

	}

	interface css$prop$margin_inline_start extends css$prop {
		/* undefined */
		set(val:css$enum$margin_inline_start|css$length|css$percentage): void

	}

	interface css$enum$margin_inline_end {
		auto: 'auto'

	}

	interface css$prop$margin_inline_end extends css$prop {
		/* undefined */
		set(val:css$enum$margin_inline_end|css$length|css$percentage): void

	}

	interface css$enum$caret_color {
		/** The user agent selects an appropriate color for the caret. This is generally currentcolor, but the user agent may choose a different color to ensure good visibility and contrast with the surrounding content, taking into account the value of currentcolor, the background, shadows, and other factors. */
		auto: 'auto'

	}

	interface css$prop$caret_color extends css$prop {
		/* auto | <color> */
		set(val:css$enum$caret_color|css$color): void

	}

	interface css$prop$orphans extends css$prop {
		/* <integer> */
		set(val:css$integer): void

	}

	interface css$enum$caption_side {
		/** Positions the caption box below the table box. */
		bottom: 'bottom'

		/** Positions the caption box above the table box. */
		top: 'top'

	}

	interface css$prop$caption_side extends css$prop {
		/* top | bottom */
		set(val:css$enum$caption_side): void

	}

	interface css$prop$perspective_origin extends css$prop {
		/* <position> */
		set(val:css$position|css$percentage|css$length): void

	}

	interface css$prop$stop_color extends css$prop {
		/* undefined */
		set(val:css$color): void

	}

	interface css$prop$widows extends css$prop {
		/* <integer> */
		set(val:css$integer): void

	}

	interface css$enum$scroll_behavior {
		/** Scrolls in an instant fashion. */
		auto: 'auto'

		/** Scrolls in a smooth fashion using a user-agent-defined timing function and time period. */
		smooth: 'smooth'

	}

	interface css$prop$scroll_behavior extends css$prop {
		/* auto | smooth */
		set(val:css$enum$scroll_behavior): void

	}

	interface css$prop$grid_column_gap extends css$prop {
		/* undefined */
		set(val:css$length): void

	}

	interface css$enum$columns {
		/** The width depends on the values of other properties. */
		auto: 'auto'

	}

	interface css$prop$columns extends css$prop {
		/* <'column-width'> || <'column-count'> */
		set(val:css$enum$columns|css$length|css$integer): void

	}

	interface css$enum$column_width {
		/** The width depends on the values of other properties. */
		auto: 'auto'

	}

	interface css$prop$column_width extends css$prop {
		/* [object Object] */
		set(val:css$enum$column_width|css$length): void

	}

	interface css$enum$mix_blend_mode {
		/** Default attribute which specifies no blending */
		normal: 'normal'

		/** The source color is multiplied by the destination color and replaces the destination. */
		multiply: 'multiply'

		/** Multiplies the complements of the backdrop and source color values, then complements the result. */
		screen: 'screen'

		/** Multiplies or screens the colors, depending on the backdrop color value. */
		overlay: 'overlay'

		/** Selects the darker of the backdrop and source colors. */
		darken: 'darken'

		/** Selects the lighter of the backdrop and source colors. */
		lighten: 'lighten'

		/** Brightens the backdrop color to reflect the source color. */
		'color-dodge': 'color-dodge'

		/** Darkens the backdrop color to reflect the source color. */
		'color-burn': 'color-burn'

		/** Multiplies or screens the colors, depending on the source color value. */
		'hard-light': 'hard-light'

		/** Darkens or lightens the colors, depending on the source color value. */
		'soft-light': 'soft-light'

		/** Subtracts the darker of the two constituent colors from the lighter color.. */
		difference: 'difference'

		/** Produces an effect similar to that of the Difference mode but lower in contrast. */
		exclusion: 'exclusion'

		/** Creates a color with the hue of the source color and the saturation and luminosity of the backdrop color. */
		hue: 'hue'

		/** Creates a color with the saturation of the source color and the hue and luminosity of the backdrop color. */
		saturation: 'saturation'

		/** Creates a color with the hue and saturation of the source color and the luminosity of the backdrop color. */
		color: 'color'

		/** Creates a color with the luminosity of the source color and the hue and saturation of the backdrop color. */
		luminosity: 'luminosity'

	}

	interface css$prop$mix_blend_mode extends css$prop {
		/* <blend-mode> */
		set(val:css$enum$mix_blend_mode): void

	}

	interface css$enum$font_kerning {
		/** Specifies that kerning is applied at the discretion of the user agent. */
		auto: 'auto'

		/** Specifies that kerning is not applied. */
		none: 'none'

		/** Specifies that kerning is applied. */
		normal: 'normal'

	}

	interface css$prop$font_kerning extends css$prop {
		/* auto | normal | none */
		set(val:css$enum$font_kerning): void

	}

	interface css$enum$border_image_slice {
		/** Causes the middle part of the border-image to be preserved. */
		fill: 'fill'

	}

	interface css$prop$border_image_slice extends css$prop {
		/* [object Object] */
		set(val:css$enum$border_image_slice|css$number|css$percentage): void

	}

	interface css$enum$border_image_repeat {
		/** The image is tiled (repeated) to fill the area. */
		repeat: 'repeat'

		/** The image is tiled (repeated) to fill the area. If it does not fill the area with a whole number of tiles, the image is rescaled so that it does. */
		round: 'round'

		/** The image is tiled (repeated) to fill the area. If it does not fill the area with a whole number of tiles, the extra space is distributed around the tiles. */
		space: 'space'

		/** The image is stretched to fill the area. */
		stretch: 'stretch'

	}

	interface css$prop$border_image_repeat extends css$prop {
		/* [object Object] */
		set(val:css$enum$border_image_repeat): void

	}

	interface css$enum$border_image_width {
		/** The border image width is the intrinsic width or height (whichever is applicable) of the corresponding image slice. If the image does not have the required intrinsic dimension then the corresponding border-width is used instead. */
		auto: 'auto'

	}

	interface css$prop$border_image_width extends css$prop {
		/* [object Object] */
		set(val:css$enum$border_image_width|css$length|css$percentage|css$number): void

	}

	interface css$enum$grid_row {
		/** The property contributes nothing to the grid item’s placement, indicating auto-placement, an automatic span, or a default span of one. */
		auto: 'auto'

		/** Contributes a grid span to the grid item’s placement such that the corresponding edge of the grid item’s grid area is N lines from its opposite edge. */
		span: 'span'

	}

	interface css$prop$grid_row extends css$prop {
		/* <grid-line> [ / <grid-line> ]? */
		set(val:css$enum$grid_row|css$identifier|css$integer): void

	}

	interface css$prop$tab_size extends css$prop {
		/* <integer> | <length> */
		set(val:css$integer|css$length): void

	}

	interface css$prop$grid_row_gap extends css$prop {
		/* normal | <length-percentage> */
		set(val:css$length): void

	}

	interface css$enum$text_decoration_style {
		/** Produces a dashed line style. */
		dashed: 'dashed'

		/** Produces a dotted line. */
		dotted: 'dotted'

		/** Produces a double line. */
		double: 'double'

		/** Produces no line. */
		none: 'none'

		/** Produces a solid line. */
		solid: 'solid'

		/** Produces a wavy line. */
		wavy: 'wavy'

	}

	interface css$prop$text_decoration_style extends css$prop {
		/* [object Object] */
		set(val:css$enum$text_decoration_style): void

	}

	interface css$enum$line_break {
		/** The UA determines the set of line-breaking restrictions to use for CJK scripts, and it may vary the restrictions based on the length of the line; e.g., use a less restrictive set of line-break rules for short lines. */
		auto: 'auto'

		/** Breaks text using the least restrictive set of line-breaking rules. Typically used for short lines, such as in newspapers. */
		loose: 'loose'

		/** Breaks text using the most common set of line-breaking rules. */
		normal: 'normal'

		/** Breaks CJK scripts using a more restrictive set of line-breaking rules than 'normal'. */
		strict: 'strict'

	}

	interface css$prop$line_break extends css$prop {
		/* auto | loose | normal | strict */
		set(val:css$enum$line_break): void

	}

	interface css$prop$border_image_outset extends css$prop {
		/* [object Object] */
		set(val:css$length|css$number): void

	}

	interface css$prop$column_rule extends css$prop {
		/* <'column-rule-width'> || <'column-rule-style'> || <'column-rule-color'> */
		set(val:css$length|css$line_width|css$line_style|css$color): void

	}

	interface css$enum$justify_items {
		auto: 'auto'

		normal: 'normal'

		end: 'end'

		start: 'start'

		/** "Flex items are packed toward the end of the line." */
		'flex-end': 'flex-end'

		/** "Flex items are packed toward the start of the line." */
		'flex-start': 'flex-start'

		/** The item is packed flush to the edge of the alignment container of the end side of the item, in the appropriate axis. */
		'self-end': 'self-end'

		/** The item is packed flush to the edge of the alignment container of the start side of the item, in the appropriate axis.. */
		'self-start': 'self-start'

		/** The items are packed flush to each other toward the center of the of the alignment container. */
		center: 'center'

		left: 'left'

		right: 'right'

		baseline: 'baseline'

		'first baseline': 'first baseline'

		'last baseline': 'last baseline'

		/** If the cross size property of the flex item computes to auto, and neither of the cross-axis margins are auto, the flex item is stretched. */
		stretch: 'stretch'

		save: 'save'

		unsave: 'unsave'

		legacy: 'legacy'

	}

	interface css$prop$justify_items extends css$prop {
		/* normal | stretch | <baseline-position> | <overflow-position>? [ <self-position> | left | right ] | legacy | legacy && [ left | right | center ] */
		set(val:css$enum$justify_items): void

	}

	interface css$enum$grid_area {
		/** The property contributes nothing to the grid item’s placement, indicating auto-placement, an automatic span, or a default span of one. */
		auto: 'auto'

		/** Contributes a grid span to the grid item’s placement such that the corresponding edge of the grid item’s grid area is N lines from its opposite edge. */
		span: 'span'

	}

	interface css$prop$grid_area extends css$prop {
		/* <grid-line> [ / <grid-line> ]{0,3} */
		set(val:css$enum$grid_area|css$identifier|css$integer): void

	}

	interface css$prop$stroke_miterlimit extends css$prop {
		/* undefined */
		set(val:css$number): void

	}

	interface css$enum$text_align_last {
		/** Content on the affected line is aligned per 'text-align' unless 'text-align' is set to 'justify', in which case it is 'start-aligned'. */
		auto: 'auto'

		/** The inline contents are centered within the line box. */
		center: 'center'

		/** The text is justified according to the method specified by the 'text-justify' property. */
		justify: 'justify'

		/** The inline contents are aligned to the left edge of the line box. In vertical text, 'left' aligns to the edge of the line box that would be the start edge for left-to-right text. */
		left: 'left'

		/** The inline contents are aligned to the right edge of the line box. In vertical text, 'right' aligns to the edge of the line box that would be the end edge for left-to-right text. */
		right: 'right'

	}

	interface css$prop$text_align_last extends css$prop {
		/* auto | start | end | left | right | center | justify */
		set(val:css$enum$text_align_last): void

	}

	interface css$prop$backdrop_filter extends css$prop {
		/* undefined */
		set(val:any): void

	}

	interface css$enum$grid_auto_rows {
		/** Represents the largest min-content contribution of the grid items occupying the grid track. */
		'min-content': 'min-content'

		/** Represents the largest max-content contribution of the grid items occupying the grid track. */
		'max-content': 'max-content'

		/** As a maximum, identical to 'max-content'. As a minimum, represents the largest minimum size (as specified by min-width/min-height) of the grid items occupying the grid track. */
		auto: 'auto'

		/** Defines a size range greater than or equal to min and less than or equal to max. */
		minmax(): 'minmax()'

	}

	interface css$prop$grid_auto_rows extends css$prop {
		/* <track-size>+ */
		set(val:css$enum$grid_auto_rows|css$length|css$percentage, arg1: any, arg2: any, arg3: any): void

	}

	interface css$enum$stroke_linejoin {
		/** Indicates that a bevelled corner is to be used to join path segments. */
		bevel: 'bevel'

		/** Indicates that a sharp corner is to be used to join path segments. */
		miter: 'miter'

		/** Indicates that a round corner is to be used to join path segments. */
		round: 'round'

	}

	interface css$prop$stroke_linejoin extends css$prop {
		/* undefined */
		set(val:css$enum$stroke_linejoin): void

	}

	interface css$enum$shape_outside {
		/** The background is painted within (clipped to) the margin box. */
		'margin-box': 'margin-box'

		/** The float area is unaffected. */
		none: 'none'

	}

	interface css$prop$shape_outside extends css$prop {
		/* none | <shape-box> || <basic-shape> | <image> */
		set(val:css$enum$shape_outside|css$image|css$box|css$shape): void

	}

	interface css$enum$text_decoration_line {
		/** Each line of text has a line through the middle. */
		'line-through': 'line-through'

		/** Neither produces nor inhibits text decoration. */
		none: 'none'

		/** Each line of text has a line above it. */
		overline: 'overline'

		/** Each line of text is underlined. */
		underline: 'underline'

	}

	interface css$prop$text_decoration_line extends css$prop {
		/* [object Object] */
		set(val:css$enum$text_decoration_line): void

	}

	interface css$prop$scroll_snap_align extends css$prop {
		/* [ none | start | end | center ]{1,2} */
		set(val:any, arg1: any): void

	}

	interface css$enum$fill_rule {
		/** Determines the ‘insideness’ of a point on the canvas by drawing a ray from that point to infinity in any direction and counting the number of path segments from the given shape that the ray crosses. */
		evenodd: 'evenodd'

		/** Determines the ‘insideness’ of a point on the canvas by drawing a ray from that point to infinity in any direction and then examining the places where a segment of the shape crosses the ray. */
		nonzero: 'nonzero'

	}

	interface css$prop$fill_rule extends css$prop {
		/* undefined */
		set(val:css$enum$fill_rule): void

	}

	interface css$enum$grid_auto_flow {
		/** The auto-placement algorithm places items by filling each row in turn, adding new rows as necessary. */
		row: 'row'

		/** The auto-placement algorithm places items by filling each column in turn, adding new columns as necessary. */
		column: 'column'

		/** If specified, the auto-placement algorithm uses a “dense” packing algorithm, which attempts to fill in holes earlier in the grid if smaller items come up later. */
		dense: 'dense'

	}

	interface css$prop$grid_auto_flow extends css$prop {
		/* [ row | column ] || dense */
		set(val:css$enum$grid_auto_flow): void

	}

	interface css$enum$scroll_snap_type {
		/** The visual viewport of this scroll container must ignore snap points, if any, when scrolled. */
		none: 'none'

		/** The visual viewport of this scroll container is guaranteed to rest on a snap point when there are no active scrolling operations. */
		mandatory: 'mandatory'

		/** The visual viewport of this scroll container may come to rest on a snap point at the termination of a scroll at the discretion of the UA given the parameters of the scroll. */
		proximity: 'proximity'

	}

	interface css$prop$scroll_snap_type extends css$prop {
		/* none | [ x | y | block | inline | both ] [ mandatory | proximity ]? */
		set(val:css$enum$scroll_snap_type): void

	}

	interface css$enum$page_break_before {
		/** Always force a page break before the generated box. */
		always: 'always'

		/** Neither force nor forbid a page break before the generated box. */
		auto: 'auto'

		/** Avoid a page break before the generated box. */
		avoid: 'avoid'

		/** Force one or two page breaks before the generated box so that the next page is formatted as a left page. */
		left: 'left'

		/** Force one or two page breaks before the generated box so that the next page is formatted as a right page. */
		right: 'right'

	}

	interface css$prop$page_break_before extends css$prop {
		/* undefined */
		set(val:css$enum$page_break_before): void

	}

	interface css$enum$grid_column_start {
		/** The property contributes nothing to the grid item’s placement, indicating auto-placement, an automatic span, or a default span of one. */
		auto: 'auto'

		/** Contributes a grid span to the grid item’s placement such that the corresponding edge of the grid item’s grid area is N lines from its opposite edge. */
		span: 'span'

	}

	interface css$prop$grid_column_start extends css$prop {
		/* <grid-line> */
		set(val:css$enum$grid_column_start|css$identifier|css$integer): void

	}

	interface css$enum$grid_template_areas {
		/** The grid container doesn’t define any named grid areas. */
		none: 'none'

	}

	interface css$prop$grid_template_areas extends css$prop {
		/* none | <string>+ */
		set(val:css$enum$grid_template_areas|css$string): void

	}

	interface css$enum$break_inside {
		/** Impose no additional breaking constraints within the box. */
		auto: 'auto'

		/** Avoid breaks within the box. */
		avoid: 'avoid'

		/** Avoid a column break within the box. */
		'avoid-column': 'avoid-column'

		/** Avoid a page break within the box. */
		'avoid-page': 'avoid-page'

	}

	interface css$prop$break_inside extends css$prop {
		/* auto | avoid | avoid-page | avoid-column | avoid-region */
		set(val:css$enum$break_inside): void

	}

	interface css$enum$column_fill {
		/** Fills columns sequentially. */
		auto: 'auto'

		/** Balance content equally between columns, if possible. */
		balance: 'balance'

	}

	interface css$prop$column_fill extends css$prop {
		/* auto | balance | balance-all */
		set(val:css$enum$column_fill): void

	}

	interface css$enum$grid_column_end {
		/** The property contributes nothing to the grid item’s placement, indicating auto-placement, an automatic span, or a default span of one. */
		auto: 'auto'

		/** Contributes a grid span to the grid item’s placement such that the corresponding edge of the grid item’s grid area is N lines from its opposite edge. */
		span: 'span'

	}

	interface css$prop$grid_column_end extends css$prop {
		/* <grid-line> */
		set(val:css$enum$grid_column_end|css$identifier|css$integer): void

	}

	interface css$enum$border_image_source {
		/** Use the border styles. */
		none: 'none'

	}

	interface css$prop$border_image_source extends css$prop {
		/* [object Object] */
		set(val:css$enum$border_image_source|css$image): void

	}

	interface css$prop$overflow_anchor extends css$prop {
		/* undefined */
		set(val:any): void

	}

	interface css$enum$grid_row_start {
		/** The property contributes nothing to the grid item’s placement, indicating auto-placement, an automatic span, or a default span of one. */
		auto: 'auto'

		/** Contributes a grid span to the grid item’s placement such that the corresponding edge of the grid item’s grid area is N lines from its opposite edge. */
		span: 'span'

	}

	interface css$prop$grid_row_start extends css$prop {
		/* <grid-line> */
		set(val:css$enum$grid_row_start|css$identifier|css$integer): void

	}

	interface css$enum$grid_row_end {
		/** The property contributes nothing to the grid item’s placement, indicating auto-placement, an automatic span, or a default span of one. */
		auto: 'auto'

		/** Contributes a grid span to the grid item’s placement such that the corresponding edge of the grid item’s grid area is N lines from its opposite edge. */
		span: 'span'

	}

	interface css$prop$grid_row_end extends css$prop {
		/* <grid-line> */
		set(val:css$enum$grid_row_end|css$identifier|css$integer): void

	}

	interface css$enum$font_variant_numeric {
		/** Enables display of lining diagonal fractions. */
		'diagonal-fractions': 'diagonal-fractions'

		/** Enables display of lining numerals. */
		'lining-nums': 'lining-nums'

		/** None of the features are enabled. */
		normal: 'normal'

		/** Enables display of old-style numerals. */
		'oldstyle-nums': 'oldstyle-nums'

		/** Enables display of letter forms used with ordinal numbers. */
		ordinal: 'ordinal'

		/** Enables display of proportional numerals. */
		'proportional-nums': 'proportional-nums'

		/** Enables display of slashed zeros. */
		'slashed-zero': 'slashed-zero'

		/** Enables display of lining stacked fractions. */
		'stacked-fractions': 'stacked-fractions'

		/** Enables display of tabular numerals. */
		'tabular-nums': 'tabular-nums'

	}

	interface css$prop$font_variant_numeric extends css$prop {
		/* normal | [ <numeric-figure-values> || <numeric-spacing-values> || <numeric-fraction-values> || ordinal || slashed-zero ] */
		set(val:css$enum$font_variant_numeric): void

	}

	interface css$enum$background_blend_mode {
		/** Default attribute which specifies no blending */
		normal: 'normal'

		/** The source color is multiplied by the destination color and replaces the destination. */
		multiply: 'multiply'

		/** Multiplies the complements of the backdrop and source color values, then complements the result. */
		screen: 'screen'

		/** Multiplies or screens the colors, depending on the backdrop color value. */
		overlay: 'overlay'

		/** Selects the darker of the backdrop and source colors. */
		darken: 'darken'

		/** Selects the lighter of the backdrop and source colors. */
		lighten: 'lighten'

		/** Brightens the backdrop color to reflect the source color. */
		'color-dodge': 'color-dodge'

		/** Darkens the backdrop color to reflect the source color. */
		'color-burn': 'color-burn'

		/** Multiplies or screens the colors, depending on the source color value. */
		'hard-light': 'hard-light'

		/** Darkens or lightens the colors, depending on the source color value. */
		'soft-light': 'soft-light'

		/** Subtracts the darker of the two constituent colors from the lighter color.. */
		difference: 'difference'

		/** Produces an effect similar to that of the Difference mode but lower in contrast. */
		exclusion: 'exclusion'

		/** Creates a color with the hue of the source color and the saturation and luminosity of the backdrop color. */
		hue: 'hue'

		/** Creates a color with the saturation of the source color and the hue and luminosity of the backdrop color. */
		saturation: 'saturation'

		/** Creates a color with the hue and saturation of the source color and the luminosity of the backdrop color. */
		color: 'color'

		/** Creates a color with the luminosity of the source color and the hue and saturation of the backdrop color. */
		luminosity: 'luminosity'

	}

	interface css$prop$background_blend_mode extends css$prop {
		/* normal | multiply | screen | overlay | darken | lighten | color-dodge | color-burn | hard-light | soft-light | difference | exclusion | hue | saturation | color | luminosity */
		set(val:css$enum$background_blend_mode): void

	}

	interface css$prop$text_decoration_skip_ink extends css$prop {
		/* undefined */
		set(val:any): void

	}

	interface css$prop$column_rule_color extends css$prop {
		/* [object Object] */
		set(val:css$color): void

	}

	interface css$enum$isolation {
		/** Elements are not isolated unless an operation is applied that causes the creation of a stacking context. */
		auto: 'auto'

		/** In CSS will turn the element into a stacking context. */
		isolate: 'isolate'

	}

	interface css$prop$isolation extends css$prop {
		/* auto | isolate */
		set(val:css$enum$isolation): void

	}

	interface css$enum$shape_rendering {
		/** Suppresses aural rendering. */
		auto: 'auto'

		/** Emphasize the contrast between clean edges of artwork over rendering speed and geometric precision. */
		crispEdges: 'crispEdges'

		/** Emphasize geometric precision over speed and crisp edges. */
		geometricPrecision: 'geometricPrecision'

		/** Emphasize rendering speed over geometric precision and crisp edges. */
		optimizeSpeed: 'optimizeSpeed'

	}

	interface css$prop$shape_rendering extends css$prop {
		/* undefined */
		set(val:css$enum$shape_rendering): void

	}

	interface css$prop$column_rule_style extends css$prop {
		/* [object Object] */
		set(val:css$line_style): void

	}

	interface css$prop$border_inline_end_width extends css$prop {
		/* undefined */
		set(val:css$length|css$line_width): void

	}

	interface css$prop$border_inline_start_width extends css$prop {
		/* undefined */
		set(val:css$length|css$line_width): void

	}

	interface css$enum$grid_auto_columns {
		/** Represents the largest min-content contribution of the grid items occupying the grid track. */
		'min-content': 'min-content'

		/** Represents the largest max-content contribution of the grid items occupying the grid track. */
		'max-content': 'max-content'

		/** As a maximum, identical to 'max-content'. As a minimum, represents the largest minimum size (as specified by min-width/min-height) of the grid items occupying the grid track. */
		auto: 'auto'

		/** Defines a size range greater than or equal to min and less than or equal to max. */
		minmax(): 'minmax()'

	}

	interface css$prop$grid_auto_columns extends css$prop {
		/* <track-size>+ */
		set(val:css$enum$grid_auto_columns|css$length|css$percentage, arg1: any, arg2: any, arg3: any): void

	}

	interface css$enum$writing_mode {
		/** Top-to-bottom block flow direction. The writing mode is horizontal. */
		'horizontal-tb': 'horizontal-tb'

		/** Left-to-right block flow direction. The writing mode is vertical, while the typographic mode is horizontal. */
		'sideways-lr': 'sideways-lr'

		/** Right-to-left block flow direction. The writing mode is vertical, while the typographic mode is horizontal. */
		'sideways-rl': 'sideways-rl'

		/** Left-to-right block flow direction. The writing mode is vertical. */
		'vertical-lr': 'vertical-lr'

		/** Right-to-left block flow direction. The writing mode is vertical. */
		'vertical-rl': 'vertical-rl'

	}

	interface css$prop$writing_mode extends css$prop {
		/* horizontal-tb | vertical-rl | vertical-lr | sideways-rl | sideways-lr */
		set(val:css$enum$writing_mode): void

	}

	interface css$enum$clip_rule {
		/** Determines the ‘insideness’ of a point on the canvas by drawing a ray from that point to infinity in any direction and counting the number of path segments from the given shape that the ray crosses. */
		evenodd: 'evenodd'

		/** Determines the ‘insideness’ of a point on the canvas by drawing a ray from that point to infinity in any direction and then examining the places where a segment of the shape crosses the ray. */
		nonzero: 'nonzero'

	}

	interface css$prop$clip_rule extends css$prop {
		/* undefined */
		set(val:css$enum$clip_rule): void

	}

	interface css$enum$font_variant_caps {
		/** Enables display of petite capitals for both upper and lowercase letters. */
		'all-petite-caps': 'all-petite-caps'

		/** Enables display of small capitals for both upper and lowercase letters. */
		'all-small-caps': 'all-small-caps'

		/** None of the features are enabled. */
		normal: 'normal'

		/** Enables display of petite capitals. */
		'petite-caps': 'petite-caps'

		/** Enables display of small capitals. Small-caps glyphs typically use the form of uppercase letters but are reduced to the size of lowercase letters. */
		'small-caps': 'small-caps'

		/** Enables display of titling capitals. */
		'titling-caps': 'titling-caps'

		/** Enables display of mixture of small capitals for uppercase letters with normal lowercase letters. */
		unicase: 'unicase'

	}

	interface css$prop$font_variant_caps extends css$prop {
		/* normal | small-caps | all-small-caps | petite-caps | all-petite-caps | unicase | titling-caps */
		set(val:css$enum$font_variant_caps): void

	}

	interface css$enum$text_anchor {
		/** The rendered characters are aligned such that the end of the resulting rendered text is at the initial current text position. */
		end: 'end'

		/** The rendered characters are aligned such that the geometric middle of the resulting rendered text is at the initial current text position. */
		middle: 'middle'

		/** The rendered characters are aligned such that the start of the resulting rendered text is at the initial current text position. */
		start: 'start'

	}

	interface css$prop$text_anchor extends css$prop {
		/* undefined */
		set(val:css$enum$text_anchor): void

	}

	interface css$prop$stop_opacity extends css$prop {
		/* undefined */
		set(val:css$number): void

	}

	interface css$prop$mask extends css$prop {
		/* <mask-layer># */
		set(val:any, arg1: any, arg2: any, arg3: any): void

	}

	interface css$enum$column_span {
		/** The element spans across all columns. Content in the normal flow that appears before the element is automatically balanced across all columns before the element appear. */
		all: 'all'

		/** The element does not span multiple columns. */
		none: 'none'

	}

	interface css$prop$column_span extends css$prop {
		/* none | all */
		set(val:css$enum$column_span): void

	}

	interface css$enum$font_variant_east_asian {
		/** Enables rendering of full-width variants. */
		'full-width': 'full-width'

		/** Enables rendering of JIS04 forms. */
		jis04: 'jis04'

		/** Enables rendering of JIS78 forms. */
		jis78: 'jis78'

		/** Enables rendering of JIS83 forms. */
		jis83: 'jis83'

		/** Enables rendering of JIS90 forms. */
		jis90: 'jis90'

		/** None of the features are enabled. */
		normal: 'normal'

		/** Enables rendering of proportionally-spaced variants. */
		'proportional-width': 'proportional-width'

		/** Enables display of ruby variant glyphs. */
		ruby: 'ruby'

		/** Enables rendering of simplified forms. */
		simplified: 'simplified'

		/** Enables rendering of traditional forms. */
		traditional: 'traditional'

	}

	interface css$prop$font_variant_east_asian extends css$prop {
		/* normal | [ <east-asian-variant-values> || <east-asian-width-values> || ruby ] */
		set(val:css$enum$font_variant_east_asian): void

	}

	interface css$enum$text_underline_position {
		above: 'above'

		/** The user agent may use any algorithm to determine the underline’s position. In horizontal line layout, the underline should be aligned as for alphabetic. In vertical line layout, if the language is set to Japanese or Korean, the underline should be aligned as for over. */
		auto: 'auto'

		/** The underline is aligned with the under edge of the element’s content box. */
		below: 'below'

	}

	interface css$prop$text_underline_position extends css$prop {
		/* auto | from-font | [ under || [ left | right ] ] */
		set(val:css$enum$text_underline_position): void

	}

	interface css$enum$break_after {
		/** Always force a page break before/after the generated box. */
		always: 'always'

		/** Neither force nor forbid a page/column break before/after the principal box. */
		auto: 'auto'

		/** Avoid a break before/after the principal box. */
		avoid: 'avoid'

		/** Avoid a column break before/after the principal box. */
		'avoid-column': 'avoid-column'

		/** Avoid a page break before/after the principal box. */
		'avoid-page': 'avoid-page'

		/** Always force a column break before/after the principal box. */
		column: 'column'

		/** Force one or two page breaks before/after the generated box so that the next page is formatted as a left page. */
		left: 'left'

		/** Always force a page break before/after the principal box. */
		page: 'page'

		/** Force one or two page breaks before/after the generated box so that the next page is formatted as a right page. */
		right: 'right'

	}

	interface css$prop$break_after extends css$prop {
		/* auto | avoid | avoid-page | page | left | right | recto | verso | avoid-column | column | avoid-region | region */
		set(val:css$enum$break_after): void

	}

	interface css$enum$break_before {
		/** Always force a page break before/after the generated box. */
		always: 'always'

		/** Neither force nor forbid a page/column break before/after the principal box. */
		auto: 'auto'

		/** Avoid a break before/after the principal box. */
		avoid: 'avoid'

		/** Avoid a column break before/after the principal box. */
		'avoid-column': 'avoid-column'

		/** Avoid a page break before/after the principal box. */
		'avoid-page': 'avoid-page'

		/** Always force a column break before/after the principal box. */
		column: 'column'

		/** Force one or two page breaks before/after the generated box so that the next page is formatted as a left page. */
		left: 'left'

		/** Always force a page break before/after the principal box. */
		page: 'page'

		/** Force one or two page breaks before/after the generated box so that the next page is formatted as a right page. */
		right: 'right'

	}

	interface css$prop$break_before extends css$prop {
		/* auto | avoid | avoid-page | page | left | right | recto | verso | avoid-column | column | avoid-region | region */
		set(val:css$enum$break_before): void

	}

	interface css$enum$mask_type {
		/** Indicates that the alpha values of the mask should be used. */
		alpha: 'alpha'

		/** Indicates that the luminance values of the mask should be used. */
		luminance: 'luminance'

	}

	interface css$prop$mask_type extends css$prop {
		/* luminance | alpha */
		set(val:css$enum$mask_type): void

	}

	interface css$prop$column_rule_width extends css$prop {
		/* [object Object] */
		set(val:css$length|css$line_width): void

	}

	interface css$prop$row_gap extends css$prop {
		/* [object Object] */
		set(val:any): void

	}

	interface css$enum$text_orientation {
		/** This value is equivalent to 'sideways-right' in 'vertical-rl' writing mode and equivalent to 'sideways-left' in 'vertical-lr' writing mode. */
		sideways: 'sideways'

		/** In vertical writing modes, this causes text to be set as if in a horizontal layout, but rotated 90° clockwise. */
		'sideways-right': 'sideways-right'

		/** In vertical writing modes, characters from horizontal-only scripts are rendered upright, i.e. in their standard horizontal orientation. */
		upright: 'upright'

	}

	interface css$prop$text_orientation extends css$prop {
		/* mixed | upright | sideways */
		set(val:css$enum$text_orientation): void

	}

	interface css$prop$scroll_padding extends css$prop {
		/* [ auto | <length-percentage> ]{1,4} */
		set(val:any, arg1: any, arg2: any, arg3: any): void

	}

	interface css$enum$grid_template {
		/** Sets all three properties to their initial values. */
		none: 'none'

		/** Represents the largest min-content contribution of the grid items occupying the grid track. */
		'min-content': 'min-content'

		/** Represents the largest max-content contribution of the grid items occupying the grid track. */
		'max-content': 'max-content'

		/** As a maximum, identical to 'max-content'. As a minimum, represents the largest minimum size (as specified by min-width/min-height) of the grid items occupying the grid track. */
		auto: 'auto'

		/** Sets 'grid-template-rows' and 'grid-template-columns' to 'subgrid', and 'grid-template-areas' to its initial value. */
		subgrid: 'subgrid'

		/** Defines a size range greater than or equal to min and less than or equal to max. */
		minmax(): 'minmax()'

		/** Represents a repeated fragment of the track list, allowing a large number of columns or rows that exhibit a recurring pattern to be written in a more compact form. */
		repeat(): 'repeat()'

	}

	interface css$prop$grid_template extends css$prop {
		/* none | [ <'grid-template-rows'> / <'grid-template-columns'> ] | [ <line-names>? <string> <track-size>? <line-names>? ]+ [ / <explicit-track-list> ]? */
		set(val:css$enum$grid_template|css$identifier|css$length|css$percentage|css$string): void

	}

	interface css$prop$border_inline_end_color extends css$prop {
		/* undefined */
		set(val:css$color): void

	}

	interface css$prop$border_inline_start_color extends css$prop {
		/* undefined */
		set(val:css$color): void

	}

	interface css$prop$scroll_snap_stop extends css$prop {
		/* normal | always */
		set(val:any): void

	}

	interface css$prop$shape_margin extends css$prop {
		/* <length-percentage> */
		set(val:css$url|css$length|css$percentage): void

	}

	interface css$prop$shape_image_threshold extends css$prop {
		/* <alpha-value> */
		set(val:css$number): void

	}

	interface css$prop$gap extends css$prop {
		/* undefined */
		set(val:any): void

	}

	interface css$prop$min_inline_size extends css$prop {
		/* <'min-width'> */
		set(val:css$length|css$percentage): void

	}

	interface css$enum$image_orientation {
		/** After rotating by the precededing angle, the image is flipped horizontally. Defaults to 0deg if the angle is ommitted. */
		flip: 'flip'

		/** If the image has an orientation specified in its metadata, such as EXIF, this value computes to the angle that the metadata specifies is necessary to correctly orient the image. */
		'from-image': 'from-image'

	}

	interface css$prop$image_orientation extends css$prop {
		/* undefined */
		set(val:css$enum$image_orientation|css$angle): void

	}

	interface css$enum$inline_size {
		/** Depends on the values of other properties. */
		auto: 'auto'

	}

	interface css$prop$inline_size extends css$prop {
		/* undefined */
		set(val:css$enum$inline_size|css$length|css$percentage): void

	}

	interface css$prop$padding_block_start extends css$prop {
		/* <'padding-left'> */
		set(val:css$length|css$percentage): void

	}

	interface css$prop$padding_block_end extends css$prop {
		/* <'padding-left'> */
		set(val:css$length|css$percentage): void

	}

	interface css$prop$text_combine_upright extends css$prop {
		/* none | all | [ digits <integer>? ] */
		set(val:any): void

	}

	interface css$enum$block_size {
		/** Depends on the values of other properties. */
		auto: 'auto'

	}

	interface css$prop$block_size extends css$prop {
		/* undefined */
		set(val:css$enum$block_size|css$length|css$percentage): void

	}

	interface css$prop$min_block_size extends css$prop {
		/* <'min-width'> */
		set(val:css$length|css$percentage): void

	}

	interface css$prop$scroll_padding_top extends css$prop {
		/* auto | <length-percentage> */
		set(val:any): void

	}

	interface css$prop$border_inline_end_style extends css$prop {
		/* undefined */
		set(val:css$line_style): void

	}

	interface css$prop$border_block_start_width extends css$prop {
		/* undefined */
		set(val:css$length|css$line_width): void

	}

	interface css$prop$border_block_end_width extends css$prop {
		/* undefined */
		set(val:css$length|css$line_width): void

	}

	interface css$prop$border_block_end_color extends css$prop {
		/* undefined */
		set(val:css$color): void

	}

	interface css$prop$border_inline_start_style extends css$prop {
		/* undefined */
		set(val:css$line_style): void

	}

	interface css$prop$border_block_start_color extends css$prop {
		/* undefined */
		set(val:css$color): void

	}

	interface css$prop$border_block_end_style extends css$prop {
		/* undefined */
		set(val:css$line_style): void

	}

	interface css$prop$border_block_start_style extends css$prop {
		/* undefined */
		set(val:css$line_style): void

	}

	interface css$prop$font_variation_settings extends css$prop {
		/* undefined */
		set(val:any): void

	}

	interface css$enum$paint_order {
		fill: 'fill'

		markers: 'markers'

		/** The element is painted with the standard order of painting operations: the 'fill' is painted first, then its 'stroke' and finally its markers. */
		normal: 'normal'

		stroke: 'stroke'

	}

	interface css$prop$paint_order extends css$prop {
		/* undefined */
		set(val:css$enum$paint_order): void

	}

	interface css$enum$color_interpolation_filters {
		/** Color operations are not required to occur in a particular color space. */
		auto: 'auto'

		/** Color operations should occur in the linearized RGB color space. */
		linearRGB: 'linearRGB'

		/** Color operations should occur in the sRGB color space. */
		sRGB: 'sRGB'

	}

	interface css$prop$color_interpolation_filters extends css$prop {
		/* undefined */
		set(val:css$enum$color_interpolation_filters): void

	}

	interface css$enum$marker_end {
		/** Indicates that no marker symbol will be drawn at the given vertex or vertices. */
		none: 'none'

		/** Indicates that the <marker> element referenced will be used. */
		url(): 'url()'

	}

	interface css$prop$marker_end extends css$prop {
		/* undefined */
		set(val:css$enum$marker_end|css$url): void

	}

	interface css$prop$scroll_padding_left extends css$prop {
		/* auto | <length-percentage> */
		set(val:any): void

	}

	interface css$prop$flood_color extends css$prop {
		/* undefined */
		set(val:css$color): void

	}

	interface css$prop$flood_opacity extends css$prop {
		/* undefined */
		set(val:css$number|css$percentage): void

	}

	interface css$prop$lighting_color extends css$prop {
		/* undefined */
		set(val:css$color): void

	}

	interface css$enum$marker_start {
		/** Indicates that no marker symbol will be drawn at the given vertex or vertices. */
		none: 'none'

		/** Indicates that the <marker> element referenced will be used. */
		url(): 'url()'

	}

	interface css$prop$marker_start extends css$prop {
		/* undefined */
		set(val:css$enum$marker_start|css$url): void

	}

	interface css$enum$marker_mid {
		/** Indicates that no marker symbol will be drawn at the given vertex or vertices. */
		none: 'none'

		/** Indicates that the <marker> element referenced will be used. */
		url(): 'url()'

	}

	interface css$prop$marker_mid extends css$prop {
		/* undefined */
		set(val:css$enum$marker_mid|css$url): void

	}

	interface css$enum$marker {
		/** Indicates that no marker symbol will be drawn at the given vertex or vertices. */
		none: 'none'

		/** Indicates that the <marker> element referenced will be used. */
		url(): 'url()'

	}

	interface css$prop$marker extends css$prop {
		/* undefined */
		set(val:css$enum$marker|css$url): void

	}

	interface css$prop$place_content extends css$prop {
		/* <'align-content'> <'justify-content'>? */
		set(val:any): void

	}

	interface css$prop$offset_path extends css$prop {
		/* undefined */
		set(val:any): void

	}

	interface css$prop$offset_rotate extends css$prop {
		/* undefined */
		set(val:any): void

	}

	interface css$prop$offset_distance extends css$prop {
		/* undefined */
		set(val:any): void

	}

	interface css$prop$transform_box extends css$prop {
		/* content-box | border-box | fill-box | stroke-box | view-box */
		set(val:any): void

	}

	interface css$prop$place_items extends css$prop {
		/* <'align-items'> <'justify-items'>? */
		set(val:any): void

	}

	interface css$enum$max_inline_size {
		/** No limit on the height of the box. */
		none: 'none'

	}

	interface css$prop$max_inline_size extends css$prop {
		/* undefined */
		set(val:css$enum$max_inline_size|css$length|css$percentage): void

	}

	interface css$enum$max_block_size {
		/** No limit on the width of the box. */
		none: 'none'

	}

	interface css$prop$max_block_size extends css$prop {
		/* undefined */
		set(val:css$enum$max_block_size|css$length|css$percentage): void

	}

	interface css$enum$ruby_position {
		/** The ruby text appears after the base. This is a relatively rare setting used in ideographic East Asian writing systems, most easily found in educational text. */
		after: 'after'

		/** The ruby text appears before the base. This is the most common setting used in ideographic East Asian writing systems. */
		before: 'before'

		inline: 'inline'

		/** The ruby text appears on the right of the base. Unlike 'before' and 'after', this value is not relative to the text flow direction. */
		right: 'right'

	}

	interface css$prop$ruby_position extends css$prop {
		/* undefined */
		set(val:css$enum$ruby_position): void

	}

	interface css$prop$scroll_padding_right extends css$prop {
		/* auto | <length-percentage> */
		set(val:any): void

	}

	interface css$prop$scroll_padding_bottom extends css$prop {
		/* auto | <length-percentage> */
		set(val:any): void

	}

	interface css$prop$scroll_padding_inline_start extends css$prop {
		/* auto | <length-percentage> */
		set(val:any): void

	}

	interface css$prop$scroll_padding_block_start extends css$prop {
		/* auto | <length-percentage> */
		set(val:any): void

	}

	interface css$prop$scroll_padding_block_end extends css$prop {
		/* auto | <length-percentage> */
		set(val:any): void

	}

	interface css$prop$scroll_padding_inline_end extends css$prop {
		/* auto | <length-percentage> */
		set(val:any): void

	}

	interface css$prop$place_self extends css$prop {
		/* <'align-self'> <'justify-self'>? */
		set(val:any): void

	}

	interface css$prop$font_optical_sizing extends css$prop {
		/* undefined */
		set(val:any): void

	}

	interface css$prop$grid extends css$prop {
		/* <'grid-template'> | <'grid-template-rows'> / [ auto-flow && dense? ] <'grid-auto-columns'>? | [ auto-flow && dense? ] <'grid-auto-rows'>? / <'grid-template-columns'> */
		set(val:css$identifier|css$length|css$percentage|css$string|css$enum$grid): void

	}

	interface css$prop$border_inline_start extends css$prop {
		/* undefined */
		set(val:css$length|css$line_width|css$line_style|css$color): void

	}

	interface css$prop$border_inline_end extends css$prop {
		/* undefined */
		set(val:css$length|css$line_width|css$line_style|css$color): void

	}

	interface css$prop$border_block_end extends css$prop {
		/* undefined */
		set(val:css$length|css$line_width|css$line_style|css$color): void

	}

	interface css$prop$offset extends css$prop {
		/* undefined */
		set(val:any): void

	}

	interface css$prop$border_block_start extends css$prop {
		/* undefined */
		set(val:css$length|css$line_width|css$line_style|css$color): void

	}

	interface css$prop$scroll_padding_block extends css$prop {
		/* [ auto | <length-percentage> ]{1,2} */
		set(val:any, arg1: any): void

	}

	interface css$prop$scroll_padding_inline extends css$prop {
		/* [ auto | <length-percentage> ]{1,2} */
		set(val:any, arg1: any): void

	}

	interface css$prop$overscroll_behavior_block extends css$prop {
		/* undefined */
		set(val:any): void

	}

	interface css$prop$overscroll_behavior_inline extends css$prop {
		/* undefined */
		set(val:any): void

	}

	interface css$enum$motion {
		/** No motion path gets created. */
		none: 'none'

		/** Defines an SVG path as a string, with optional 'fill-rule' as the first argument. */
		path(): 'path()'

		/** Indicates that the object is rotated by the angle of the direction of the motion path. */
		auto: 'auto'

		/** Indicates that the object is rotated by the angle of the direction of the motion path plus 180 degrees. */
		reverse: 'reverse'

	}

	interface css$prop$motion extends css$prop {
		/* undefined */
		set(val:css$enum$motion|css$url|css$length|css$percentage|css$angle|css$shape|css$geometry_box): void

	}

	interface css$enum$font_size_adjust {
		/** Do not preserve the font’s x-height. */
		none: 'none'

	}

	interface css$prop$font_size_adjust extends css$prop {
		/* none | <number> */
		set(val:css$enum$font_size_adjust|css$number): void

	}

	interface css$prop$inset extends css$prop {
		/* undefined */
		set(val:any, arg1: any, arg2: any, arg3: any): void

	}

	interface css$enum$text_justify {
		/** The UA determines the justification algorithm to follow, based on a balance between performance and adequate presentation quality. */
		auto: 'auto'

		/** Justification primarily changes spacing both at word separators and at grapheme cluster boundaries in all scripts except those in the connected and cursive groups. This value is sometimes used in e.g. Japanese, often with the 'text-align-last' property. */
		distribute: 'distribute'

		'distribute-all-lines': 'distribute-all-lines'

		/** Justification primarily changes spacing at word separators and at grapheme cluster boundaries in clustered scripts. This value is typically used for Southeast Asian scripts such as Thai. */
		'inter-cluster': 'inter-cluster'

		/** Justification primarily changes spacing at word separators and at inter-graphemic boundaries in scripts that use no word spaces. This value is typically used for CJK languages. */
		'inter-ideograph': 'inter-ideograph'

		/** Justification primarily changes spacing at word separators. This value is typically used for languages that separate words using spaces, like English or (sometimes) Korean. */
		'inter-word': 'inter-word'

		/** Justification primarily stretches Arabic and related scripts through the use of kashida or other calligraphic elongation. */
		kashida: 'kashida'

		newspaper: 'newspaper'

	}

	interface css$prop$text_justify extends css$prop {
		/* auto | inter-character | inter-word | none */
		set(val:css$enum$text_justify): void

	}

	interface css$enum$motion_path {
		/** No motion path gets created. */
		none: 'none'

		/** Defines an SVG path as a string, with optional 'fill-rule' as the first argument. */
		path(): 'path()'

	}

	interface css$prop$motion_path extends css$prop {
		/* undefined */
		set(val:css$enum$motion_path|css$url|css$shape|css$geometry_box): void

	}

	interface css$prop$inset_inline_start extends css$prop {
		/* undefined */
		set(val:any): void

	}

	interface css$prop$inset_inline_end extends css$prop {
		/* undefined */
		set(val:any): void

	}

	interface css$prop$scale extends css$prop {
		/* none | <number>{1,3} */
		set(val:any): void

	}

	interface css$prop$rotate extends css$prop {
		/* none | <angle> | [ x | y | z | <number>{3} ] && <angle> */
		set(val:any): void

	}

	interface css$prop$translate extends css$prop {
		/* none | <length-percentage> [ <length-percentage> <length>? ]? */
		set(val:any): void

	}

	interface css$prop$offset_anchor extends css$prop {
		/* undefined */
		set(val:any): void

	}

	interface css$prop$offset_position extends css$prop {
		/* undefined */
		set(val:any): void

	}

	interface css$prop$padding_block extends css$prop {
		/* <'padding-left'>{1,2} */
		set(val:any, arg1: any): void

	}

	interface css$prop$orientation extends css$prop {
		/* undefined */
		set(val:any): void

	}

	interface css$prop$user_zoom extends css$prop {
		/* undefined */
		set(val:any): void

	}

	interface css$prop$margin_block extends css$prop {
		/* undefined */
		set(val:any, arg1: any): void

	}

	interface css$prop$margin_inline extends css$prop {
		/* undefined */
		set(val:any, arg1: any): void

	}

	interface css$prop$padding_inline extends css$prop {
		/* <'padding-left'>{1,2} */
		set(val:any, arg1: any): void

	}

	interface css$prop$inset_block extends css$prop {
		/* undefined */
		set(val:any, arg1: any): void

	}

	interface css$prop$inset_inline extends css$prop {
		/* undefined */
		set(val:any, arg1: any): void

	}

	interface css$prop$border_block_color extends css$prop {
		/* undefined */
		set(val:any, arg1: any): void

	}

	interface css$prop$border_block extends css$prop {
		/* undefined */
		set(val:any): void

	}

	interface css$prop$border_inline extends css$prop {
		/* undefined */
		set(val:any): void

	}

	interface css$prop$inset_block_start extends css$prop {
		/* undefined */
		set(val:any): void

	}

	interface css$prop$inset_block_end extends css$prop {
		/* undefined */
		set(val:any): void

	}

	interface css$enum$enable_background {
		/** If the ancestor container element has a property of new, then all graphics elements within the current container are rendered both on the parent's background image and onto the target. */
		accumulate: 'accumulate'

		/** Create a new background image canvas. All children of the current container element can access the background, and they will be rendered onto both the parent's background image canvas in addition to the target device. */
		new: 'new'

	}

	interface css$prop$enable_background extends css$prop {
		/* undefined */
		set(val:css$enum$enable_background|css$integer|css$length|css$percentage): void

	}

	interface css$prop$glyph_orientation_horizontal extends css$prop {
		/* undefined */
		set(val:css$angle|css$number): void

	}

	interface css$enum$glyph_orientation_vertical {
		/** Sets the orientation based on the fullwidth or non-fullwidth characters and the most common orientation. */
		auto: 'auto'

	}

	interface css$prop$glyph_orientation_vertical extends css$prop {
		/* undefined */
		set(val:css$enum$glyph_orientation_vertical|css$angle|css$number): void

	}

	interface css$enum$kerning {
		/** Indicates that the user agent should adjust inter-glyph spacing based on kerning tables that are included in the font that will be used. */
		auto: 'auto'

	}

	interface css$prop$kerning extends css$prop {
		/* undefined */
		set(val:css$enum$kerning|css$length): void

	}

	interface css$prop$image_resolution extends css$prop {
		/* undefined */
		set(val:any): void

	}

	interface css$prop$max_zoom extends css$prop {
		/* undefined */
		set(val:any): void

	}

	interface css$prop$min_zoom extends css$prop {
		/* undefined */
		set(val:any): void

	}

	interface css$prop$motion_offset extends css$prop {
		/* undefined */
		set(val:css$length|css$percentage): void

	}

	interface css$enum$motion_rotation {
		/** Indicates that the object is rotated by the angle of the direction of the motion path. */
		auto: 'auto'

		/** Indicates that the object is rotated by the angle of the direction of the motion path plus 180 degrees. */
		reverse: 'reverse'

	}

	interface css$prop$motion_rotation extends css$prop {
		/* undefined */
		set(val:css$enum$motion_rotation|css$angle): void

	}

	interface css$enum$scroll_snap_points_x {
		/** No snap points are defined by this scroll container. */
		none: 'none'

		/** Defines an interval at which snap points are defined, starting from the container’s relevant start edge. */
		repeat(): 'repeat()'

	}

	interface css$prop$scroll_snap_points_x extends css$prop {
		/* undefined */
		set(val:css$enum$scroll_snap_points_x): void

	}

	interface css$enum$scroll_snap_points_y {
		/** No snap points are defined by this scroll container. */
		none: 'none'

		/** Defines an interval at which snap points are defined, starting from the container’s relevant start edge. */
		repeat(): 'repeat()'

	}

	interface css$prop$scroll_snap_points_y extends css$prop {
		/* undefined */
		set(val:css$enum$scroll_snap_points_y): void

	}

	interface css$enum$scroll_snap_coordinate {
		/** Specifies that this element does not contribute a snap point. */
		none: 'none'

	}

	interface css$prop$scroll_snap_coordinate extends css$prop {
		/* undefined */
		set(val:css$enum$scroll_snap_coordinate|css$position|css$length|css$percentage): void

	}

	interface css$prop$scroll_snap_destination extends css$prop {
		/* undefined */
		set(val:css$position|css$length|css$percentage): void

	}

	interface css$prop$viewport_fit extends css$prop {
		/* undefined */
		set(val:any): void

	}

	interface css$prop$border_block_style extends css$prop {
		/* undefined */
		set(val:any): void

	}

	interface css$prop$border_block_width extends css$prop {
		/* undefined */
		set(val:any): void

	}

	interface css$prop$border_inline_color extends css$prop {
		/* undefined */
		set(val:any, arg1: any): void

	}

	interface css$prop$border_inline_style extends css$prop {
		/* undefined */
		set(val:any): void

	}

	interface css$prop$border_inline_width extends css$prop {
		/* undefined */
		set(val:any): void

	}

	interface css$prop$overflow_block extends css$prop {
		/* undefined */
		set(val:any): void

	}

	interface css$prop$additive_symbols extends css$prop {
		/* undefined */
		set(val:css$integer|css$string|css$image|css$identifier): void

	}

	interface css$prop$alt extends css$prop {
		/* undefined */
		set(val:css$string|css$enum$alt): void

	}

	interface css$prop$behavior extends css$prop {
		/* undefined */
		set(val:css$url): void

	}

	interface css$enum$box_decoration_break {
		/** Each box is independently wrapped with the border and padding. */
		clone: 'clone'

		/** The effect is as though the element were rendered with no breaks present, and then sliced by the breaks afterward. */
		slice: 'slice'

	}

	interface css$prop$box_decoration_break extends css$prop {
		/* undefined */
		set(val:css$enum$box_decoration_break): void

	}

	interface css$prop$fallback extends css$prop {
		/* undefined */
		set(val:css$identifier): void

	}

	interface css$enum$font_language_override {
		/** Implies that when rendering with OpenType fonts the language of the document is used to infer the OpenType language system, used to select language specific features when rendering. */
		normal: 'normal'

	}

	interface css$prop$font_language_override extends css$prop {
		/* normal | <string> */
		set(val:css$enum$font_language_override|css$string): void

	}

	interface css$enum$font_synthesis {
		/** Disallow all synthetic faces. */
		none: 'none'

		/** Allow synthetic italic faces. */
		style: 'style'

		/** Allow synthetic bold faces. */
		weight: 'weight'

	}

	interface css$prop$font_synthesis extends css$prop {
		/* none | [ weight || style ] */
		set(val:css$enum$font_synthesis): void

	}

	interface css$enum$font_variant_alternates {
		/** Enables display of alternate annotation forms. */
		annotation(): 'annotation()'

		/** Enables display of specific character variants. */
		'character-variant()': 'character-variant()'

		/** Enables display of historical forms. */
		'historical-forms': 'historical-forms'

		/** None of the features are enabled. */
		normal: 'normal'

		/** Enables replacement of default glyphs with ornaments, if provided in the font. */
		ornaments(): 'ornaments()'

		/** Enables display with stylistic sets. */
		styleset(): 'styleset()'

		/** Enables display of stylistic alternates. */
		stylistic(): 'stylistic()'

		/** Enables display of swash glyphs. */
		swash(): 'swash()'

	}

	interface css$prop$font_variant_alternates extends css$prop {
		/* normal | [ stylistic( <feature-value-name> ) || historical-forms || styleset( <feature-value-name># ) || character-variant( <feature-value-name># ) || swash( <feature-value-name> ) || ornaments( <feature-value-name> ) || annotation( <feature-value-name> ) ] */
		set(val:css$enum$font_variant_alternates): void

	}

	interface css$enum$font_variant_position {
		/** None of the features are enabled. */
		normal: 'normal'

		/** Enables display of subscript variants (OpenType feature: subs). */
		sub: 'sub'

		/** Enables display of superscript variants (OpenType feature: sups). */
		super: 'super'

	}

	interface css$prop$font_variant_position extends css$prop {
		/* normal | sub | super */
		set(val:css$enum$font_variant_position): void

	}

	interface css$enum$ime_mode {
		/** The input method editor is initially active; text entry is performed using it unless the user specifically dismisses it. */
		active: 'active'

		/** No change is made to the current input method editor state. This is the default. */
		auto: 'auto'

		/** The input method editor is disabled and may not be activated by the user. */
		disabled: 'disabled'

		/** The input method editor is initially inactive, but the user may activate it if they wish. */
		inactive: 'inactive'

		/** The IME state should be normal; this value can be used in a user style sheet to override the page setting. */
		normal: 'normal'

	}

	interface css$prop$ime_mode extends css$prop {
		/* undefined */
		set(val:css$enum$ime_mode): void

	}

	interface css$enum$mask_image {
		/** Counts as a transparent black image layer. */
		none: 'none'

		/** Reference to a <mask element or to a CSS image. */
		url(): 'url()'

	}

	interface css$prop$mask_image extends css$prop {
		/* <mask-reference># */
		set(val:css$enum$mask_image|css$url|css$image, arg1: any, arg2: any, arg3: any): void

	}

	interface css$enum$mask_mode {
		/** Alpha values of the mask layer image should be used as the mask values. */
		alpha: 'alpha'

		/** Use alpha values if 'mask-image' is an image, luminance if a <mask> element or a CSS image. */
		auto: 'auto'

		/** Luminance values of the mask layer image should be used as the mask values. */
		luminance: 'luminance'

	}

	interface css$prop$mask_mode extends css$prop {
		/* <masking-mode># */
		set(val:css$enum$mask_mode|css$url|css$image, arg1: any, arg2: any, arg3: any): void

	}

	interface css$prop$mask_origin extends css$prop {
		/* <geometry-box># */
		set(val:css$geometry_box|css$enum$mask_origin, arg1: any, arg2: any, arg3: any): void

	}

	interface css$prop$mask_position extends css$prop {
		/* <position># */
		set(val:css$position|css$length|css$percentage, arg1: any, arg2: any, arg3: any): void

	}

	interface css$prop$mask_repeat extends css$prop {
		/* <repeat-style># */
		set(val:css$repeat, arg1: any, arg2: any, arg3: any): void

	}

	interface css$enum$mask_size {
		/** Resolved by using the image’s intrinsic ratio and the size of the other dimension, or failing that, using the image’s intrinsic size, or failing that, treating it as 100%. */
		auto: 'auto'

		/** Scale the image, while preserving its intrinsic aspect ratio (if any), to the largest size such that both its width and its height can fit inside the background positioning area. */
		contain: 'contain'

		/** Scale the image, while preserving its intrinsic aspect ratio (if any), to the smallest size such that both its width and its height can completely cover the background positioning area. */
		cover: 'cover'

	}

	interface css$prop$mask_size extends css$prop {
		/* <bg-size># */
		set(val:css$enum$mask_size|css$length|css$percentage, arg1: any, arg2: any, arg3: any): void

	}

	interface css$enum$nav_down {
		/** The user agent automatically determines which element to navigate the focus to in response to directional navigational input. */
		auto: 'auto'

		/** Indicates that the user agent should target the frame that the element is in. */
		current: 'current'

		/** Indicates that the user agent should target the full window. */
		root: 'root'

	}

	interface css$prop$nav_down extends css$prop {
		/* undefined */
		set(val:css$enum$nav_down|css$identifier|css$string): void

	}

	interface css$enum$nav_index {
		/** The element's sequential navigation order is assigned automatically by the user agent. */
		auto: 'auto'

	}

	interface css$prop$nav_index extends css$prop {
		/* undefined */
		set(val:css$enum$nav_index|css$number): void

	}

	interface css$enum$nav_left {
		/** The user agent automatically determines which element to navigate the focus to in response to directional navigational input. */
		auto: 'auto'

		/** Indicates that the user agent should target the frame that the element is in. */
		current: 'current'

		/** Indicates that the user agent should target the full window. */
		root: 'root'

	}

	interface css$prop$nav_left extends css$prop {
		/* undefined */
		set(val:css$enum$nav_left|css$identifier|css$string): void

	}

	interface css$enum$nav_right {
		/** The user agent automatically determines which element to navigate the focus to in response to directional navigational input. */
		auto: 'auto'

		/** Indicates that the user agent should target the frame that the element is in. */
		current: 'current'

		/** Indicates that the user agent should target the full window. */
		root: 'root'

	}

	interface css$prop$nav_right extends css$prop {
		/* undefined */
		set(val:css$enum$nav_right|css$identifier|css$string): void

	}

	interface css$enum$nav_up {
		/** The user agent automatically determines which element to navigate the focus to in response to directional navigational input. */
		auto: 'auto'

		/** Indicates that the user agent should target the frame that the element is in. */
		current: 'current'

		/** Indicates that the user agent should target the full window. */
		root: 'root'

	}

	interface css$prop$nav_up extends css$prop {
		/* undefined */
		set(val:css$enum$nav_up|css$identifier|css$string): void

	}

	interface css$prop$negative extends css$prop {
		/* undefined */
		set(val:css$image|css$identifier|css$string): void

	}

	interface css$enum$offset_block_end {
		/** For non-replaced elements, the effect of this value depends on which of related properties have the value 'auto' as well. */
		auto: 'auto'

	}

	interface css$prop$offset_block_end extends css$prop {
		/* undefined */
		set(val:css$enum$offset_block_end|css$length|css$percentage): void

	}

	interface css$enum$offset_block_start {
		/** For non-replaced elements, the effect of this value depends on which of related properties have the value 'auto' as well. */
		auto: 'auto'

	}

	interface css$prop$offset_block_start extends css$prop {
		/* undefined */
		set(val:css$enum$offset_block_start|css$length|css$percentage): void

	}

	interface css$enum$offset_inline_end {
		/** For non-replaced elements, the effect of this value depends on which of related properties have the value 'auto' as well. */
		auto: 'auto'

	}

	interface css$prop$offset_inline_end extends css$prop {
		/* undefined */
		set(val:css$enum$offset_inline_end|css$length|css$percentage): void

	}

	interface css$enum$offset_inline_start {
		/** For non-replaced elements, the effect of this value depends on which of related properties have the value 'auto' as well. */
		auto: 'auto'

	}

	interface css$prop$offset_inline_start extends css$prop {
		/* undefined */
		set(val:css$enum$offset_inline_start|css$length|css$percentage): void

	}

	interface css$prop$pad extends css$prop {
		/* undefined */
		set(val:css$integer|css$image|css$string|css$identifier): void

	}

	interface css$prop$prefix extends css$prop {
		/* undefined */
		set(val:css$image|css$string|css$identifier): void

	}

	interface css$enum$range {
		/** The range depends on the counter system. */
		auto: 'auto'

		/** If used as the first value in a range, it represents negative infinity; if used as the second value, it represents positive infinity. */
		infinite: 'infinite'

	}

	interface css$prop$range extends css$prop {
		/* undefined */
		set(val:css$enum$range|css$integer): void

	}

	interface css$enum$ruby_align {
		/** The user agent determines how the ruby contents are aligned. This is the initial value. */
		auto: 'auto'

		/** The ruby content is centered within its box. */
		center: 'center'

		/** If the width of the ruby text is smaller than that of the base, then the ruby text contents are evenly distributed across the width of the base, with the first and last ruby text glyphs lining up with the corresponding first and last base glyphs. If the width of the ruby text is at least the width of the base, then the letters of the base are evenly distributed across the width of the ruby text. */
		'distribute-letter': 'distribute-letter'

		/** If the width of the ruby text is smaller than that of the base, then the ruby text contents are evenly distributed across the width of the base, with a certain amount of white space preceding the first and following the last character in the ruby text. That amount of white space is normally equal to half the amount of inter-character space of the ruby text. */
		'distribute-space': 'distribute-space'

		/** The ruby text content is aligned with the start edge of the base. */
		left: 'left'

		/** If the ruby text is not adjacent to a line edge, it is aligned as in 'auto'. If it is adjacent to a line edge, then it is still aligned as in auto, but the side of the ruby text that touches the end of the line is lined up with the corresponding edge of the base. */
		'line-edge': 'line-edge'

		/** The ruby text content is aligned with the end edge of the base. */
		right: 'right'

		/** The ruby text content is aligned with the start edge of the base. */
		start: 'start'

		/** The ruby content expands as defined for normal text justification (as defined by 'text-justify'), */
		'space-between': 'space-between'

		/** As for 'space-between' except that there exists an extra justification opportunities whose space is distributed half before and half after the ruby content. */
		'space-around': 'space-around'

	}

	interface css$prop$ruby_align extends css$prop {
		/* undefined */
		set(val:css$enum$ruby_align): void

	}

	interface css$enum$ruby_overhang {
		/** The ruby text can overhang text adjacent to the base on either side. This is the initial value. */
		auto: 'auto'

		/** The ruby text can overhang the text that follows it. */
		end: 'end'

		/** The ruby text cannot overhang any text adjacent to its base, only its own base. */
		none: 'none'

		/** The ruby text can overhang the text that precedes it. */
		start: 'start'

	}

	interface css$prop$ruby_overhang extends css$prop {
		/* undefined */
		set(val:css$enum$ruby_overhang): void

	}

	interface css$enum$ruby_span {
		/** The value of attribute 'x' is a string value. The string value is evaluated as a <number> to determine the number of ruby base elements to be spanned by the annotation element. */
		attr(x): 'attr(x)'

		/** No spanning. The computed value is '1'. */
		none: 'none'

	}

	interface css$prop$ruby_span extends css$prop {
		/* undefined */
		set(val:css$enum$ruby_span): void

	}

	interface css$prop$scrollbar_3dlight_color extends css$prop {
		/* undefined */
		set(val:css$color): void

	}

	interface css$prop$scrollbar_arrow_color extends css$prop {
		/* undefined */
		set(val:css$color): void

	}

	interface css$prop$scrollbar_base_color extends css$prop {
		/* undefined */
		set(val:css$color): void

	}

	interface css$prop$scrollbar_darkshadow_color extends css$prop {
		/* undefined */
		set(val:css$color): void

	}

	interface css$prop$scrollbar_face_color extends css$prop {
		/* undefined */
		set(val:css$color): void

	}

	interface css$prop$scrollbar_highlight_color extends css$prop {
		/* undefined */
		set(val:css$color): void

	}

	interface css$prop$scrollbar_shadow_color extends css$prop {
		/* undefined */
		set(val:css$color): void

	}

	interface css$prop$scrollbar_track_color extends css$prop {
		/* undefined */
		set(val:css$color): void

	}

	interface css$prop$suffix extends css$prop {
		/* undefined */
		set(val:css$image|css$string|css$identifier): void

	}

	interface css$enum$system {
		/** Represents “sign-value” numbering systems, which, rather than using reusing digits in different positions to change their value, define additional digits with much larger values, so that the value of the number can be obtained by adding all the digits together. */
		additive: 'additive'

		/** Interprets the list of counter symbols as digits to an alphabetic numbering system, similar to the default lower-alpha counter style, which wraps from "a", "b", "c", to "aa", "ab", "ac". */
		alphabetic: 'alphabetic'

		/** Cycles repeatedly through its provided symbols, looping back to the beginning when it reaches the end of the list. */
		cyclic: 'cyclic'

		/** Use the algorithm of another counter style, but alter other aspects. */
		extends: 'extends'

		/** Runs through its list of counter symbols once, then falls back. */
		fixed: 'fixed'

		/** interprets the list of counter symbols as digits to a "place-value" numbering system, similar to the default 'decimal' counter style. */
		numeric: 'numeric'

		/** Cycles repeatedly through its provided symbols, doubling, tripling, etc. the symbols on each successive pass through the list. */
		symbolic: 'symbolic'

	}

	interface css$prop$system extends css$prop {
		/* undefined */
		set(val:css$enum$system|css$integer): void

	}

	interface css$prop$symbols extends css$prop {
		/* undefined */
		set(val:css$image|css$string|css$identifier): void

	}

	interface css$prop$aspect_ratio extends css$prop {
		/* undefined */
		set(val:any): void

	}

	interface css$prop$azimuth extends css$prop {
		/* undefined */
		set(val:any): void

	}

	interface css$prop$border_end_end_radius extends css$prop {
		/* undefined */
		set(val:any, arg1: any): void

	}

	interface css$prop$border_end_start_radius extends css$prop {
		/* undefined */
		set(val:any, arg1: any): void

	}

	interface css$prop$border_start_end_radius extends css$prop {
		/* undefined */
		set(val:any, arg1: any): void

	}

	interface css$prop$border_start_start_radius extends css$prop {
		/* undefined */
		set(val:any, arg1: any): void

	}

	interface css$prop$box_ordinal_group extends css$prop {
		/* undefined */
		set(val:any): void

	}

	interface css$prop$color_adjust extends css$prop {
		/* undefined */
		set(val:any): void

	}

	interface css$prop$counter_set extends css$prop {
		/* undefined */
		set(val:any): void

	}

	interface css$prop$hanging_punctuation extends css$prop {
		/* none | [ first || [ force-end | allow-end ] || last ] */
		set(val:any): void

	}

	interface css$prop$initial_letter extends css$prop {
		/* undefined */
		set(val:any): void

	}

	interface css$prop$initial_letter_align extends css$prop {
		/* undefined */
		set(val:any): void

	}

	interface css$prop$line_clamp extends css$prop {
		/* undefined */
		set(val:any): void

	}

	interface css$prop$line_height_step extends css$prop {
		/* undefined */
		set(val:any): void

	}

	interface css$prop$margin_trim extends css$prop {
		/* undefined */
		set(val:any): void

	}

	interface css$prop$mask_border extends css$prop {
		/* undefined */
		set(val:any): void

	}

	interface css$prop$mask_border_mode extends css$prop {
		/* undefined */
		set(val:any): void

	}

	interface css$prop$mask_border_outset extends css$prop {
		/* undefined */
		set(val:any, arg1: any, arg2: any, arg3: any): void

	}

	interface css$prop$mask_border_repeat extends css$prop {
		/* undefined */
		set(val:any, arg1: any): void

	}

	interface css$prop$mask_border_slice extends css$prop {
		/* undefined */
		set(val:any, arg1: any, arg2: any, arg3: any): void

	}

	interface css$prop$mask_border_source extends css$prop {
		/* undefined */
		set(val:any): void

	}

	interface css$prop$mask_border_width extends css$prop {
		/* undefined */
		set(val:any, arg1: any, arg2: any, arg3: any): void

	}

	interface css$prop$mask_clip extends css$prop {
		/* [ <geometry-box> | no-clip ]# */
		set(val:any, arg1: any, arg2: any, arg3: any): void

	}

	interface css$prop$mask_composite extends css$prop {
		/* <compositing-operator># */
		set(val:any, arg1: any, arg2: any, arg3: any): void

	}

	interface css$prop$max_lines extends css$prop {
		/* undefined */
		set(val:any): void

	}

	interface css$prop$overflow_clip_box extends css$prop {
		/* undefined */
		set(val:any): void

	}

	interface css$prop$overflow_inline extends css$prop {
		/* undefined */
		set(val:any): void

	}

	interface css$prop$overscroll_behavior extends css$prop {
		/* undefined */
		set(val:any, arg1: any): void

	}

	interface css$prop$overscroll_behavior_x extends css$prop {
		/* undefined */
		set(val:any): void

	}

	interface css$prop$overscroll_behavior_y extends css$prop {
		/* undefined */
		set(val:any): void

	}

	interface css$prop$ruby_merge extends css$prop {
		/* undefined */
		set(val:any): void

	}

	interface css$prop$scrollbar_color extends css$prop {
		/* auto | dark | light | <color>{2} */
		set(val:any): void

	}

	interface css$prop$scrollbar_width extends css$prop {
		/* auto | thin | none */
		set(val:any): void

	}

	interface css$prop$scroll_margin extends css$prop {
		/* <length>{1,4} */
		set(val:any, arg1: any, arg2: any, arg3: any): void

	}

	interface css$prop$scroll_margin_block extends css$prop {
		/* <length>{1,2} */
		set(val:any, arg1: any): void

	}

	interface css$prop$scroll_margin_block_start extends css$prop {
		/* <length> */
		set(val:any): void

	}

	interface css$prop$scroll_margin_block_end extends css$prop {
		/* <length> */
		set(val:any): void

	}

	interface css$prop$scroll_margin_bottom extends css$prop {
		/* <length> */
		set(val:any): void

	}

	interface css$prop$scroll_margin_inline extends css$prop {
		/* <length>{1,2} */
		set(val:any, arg1: any): void

	}

	interface css$prop$scroll_margin_inline_start extends css$prop {
		/* <length> */
		set(val:any): void

	}

	interface css$prop$scroll_margin_inline_end extends css$prop {
		/* <length> */
		set(val:any): void

	}

	interface css$prop$scroll_margin_left extends css$prop {
		/* <length> */
		set(val:any): void

	}

	interface css$prop$scroll_margin_right extends css$prop {
		/* <length> */
		set(val:any): void

	}

	interface css$prop$scroll_margin_top extends css$prop {
		/* <length> */
		set(val:any): void

	}

	interface css$prop$scroll_snap_type_x extends css$prop {
		/* undefined */
		set(val:any): void

	}

	interface css$prop$scroll_snap_type_y extends css$prop {
		/* undefined */
		set(val:any): void

	}

	interface css$prop$text_decoration_thickness extends css$prop {
		/* [object Object] */
		set(val:any): void

	}

	interface css$prop$text_emphasis extends css$prop {
		/* <'text-emphasis-style'> || <'text-emphasis-color'> */
		set(val:any): void

	}

	interface css$prop$text_emphasis_color extends css$prop {
		/* [object Object] */
		set(val:any): void

	}

	interface css$prop$text_emphasis_position extends css$prop {
		/* [ over | under ] && [ right | left ] */
		set(val:any): void

	}

	interface css$prop$text_emphasis_style extends css$prop {
		/* [object Object] */
		set(val:any): void

	}

	interface css$prop$text_underline_offset extends css$prop {
		/* undefined */
		set(val:any): void

	}

	interface css$prop$speak_as extends css$prop {
		/* undefined */
		set(val:any): void

	}

	interface css$prop$bleed extends css$prop {
		/* undefined */
		set(val:any): void

	}

	interface css$prop$marks extends css$prop {
		/* undefined */
		set(val:any): void

	}

	interface css$rule {
		/**
		Specifies the width of the content area, padding area or border area (depending on 'box-sizing') of certain boxes.
		@alias w
		*/
		width:css$prop$width;
		/** @proxy width */
		w:css$prop$width;
		/**
		Specifies the height of the content area, padding area or border area (depending on 'box-sizing') of certain boxes.
		@alias h
		*/
		height:css$prop$height;
		/** @proxy height */
		h:css$prop$height;
		/**
		In combination with 'float' and 'position', determines the type of box or boxes that are generated for an element.
		@alias d
		*/
		display:css$prop$display;
		/** @proxy display */
		d:css$prop$display;
		/**
		Shorthand property to set values the thickness of the padding area. If left is omitted, it is the same as right. If bottom is omitted it is the same as top, if right is omitted it is the same as top. The value may not be negative.
		@alias p
		*/
		padding:css$prop$padding;
		/** @proxy padding */
		p:css$prop$padding;
		/**
		The position CSS property sets how an element is positioned in a document. The top, right, bottom, and left properties determine the final location of positioned elements.
		@alias pos
		*/
		position:css$prop$position;
		/** @proxy position */
		pos:css$prop$position;
		/**
		Shorthand property for setting border width, style, and color.
		@alias bd
		*/
		border:css$prop$border;
		/** @proxy border */
		bd:css$prop$border;
		/**
		Shorthand property to set values the thickness of the margin area. If left is omitted, it is the same as right. If bottom is omitted it is the same as top, if right is omitted it is the same as top. Negative values for margin properties are allowed, but there may be implementation-specific limits.
		@alias m
		*/
		margin:css$prop$margin;
		/** @proxy margin */
		m:css$prop$margin;
		/**
		Set asset as inline background svg
		*/
		svg:css$prop$svg;
		/**
		Specifies how far an absolutely positioned box's top margin edge is offset below the top edge of the box's 'containing block'.
		@alias t
		*/
		top:css$prop$top;
		/** @proxy top */
		t:css$prop$top;
		/**
		Specifies how far an absolutely positioned box's left margin edge is offset to the right of the left edge of the box's 'containing block'.
		@alias l
		*/
		left:css$prop$left;
		/** @proxy left */
		l:css$prop$left;
		/**
		Shorthand property to set values the thickness of the margin area. If left is omitted, it is the same as right. If bottom is omitted it is the same as top, if right is omitted it is the same as top. Negative values for margin properties are allowed, but there may be implementation-specific limits..
		@alias mt
		*/
		'margin-top':css$prop$margin_top;
		/** @proxy margin-top */
		mt:css$prop$margin_top;
		/**
		Sets the color of an element's text
		@alias c
		*/
		color:css$prop$color;
		/** @proxy color */
		c:css$prop$color;
		/**
		Indicates the desired height of glyphs from the font. For scalable fonts, the font-size is a scale factor applied to the EM unit of the font. (Note that certain glyphs may bleed outside their EM box.) For non-scalable fonts, the font-size is converted into absolute units and matched against the declared font-size of the font, using the same absolute coordinate space for both of the matched values.
		@alias fs
		*/
		'font-size':css$prop$font_size;
		/** @proxy font-size */
		fs:css$prop$font_size;
		/**
		Sets the background color of an element.
		@alias bgc
		*/
		'background-color':css$prop$background_color;
		/** @proxy background-color */
		bgc:css$prop$background_color;
		/**
		Describes how inline contents of a block are horizontally aligned if the contents do not completely fill the line box.
		@alias ta
		*/
		'text-align':css$prop$text_align;
		/** @proxy text-align */
		ta:css$prop$text_align;
		/**
		Opacity of an element's text, where 1 is opaque and 0 is entirely transparent.
		@alias o
		*/
		opacity:css$prop$opacity;
		/** @proxy opacity */
		o:css$prop$opacity;
		/**
		Shorthand property for setting most background properties at the same place in the style sheet.
		@alias bg
		*/
		background:css$prop$background;
		/** @proxy background */
		bg:css$prop$background;
		/**
		Specifies weight of glyphs in the font, their degree of blackness or stroke thickness.
		@alias fw
		*/
		'font-weight':css$prop$font_weight;
		/** @proxy font-weight */
		fw:css$prop$font_weight;
		/**
		Shorthand for setting 'overflow-x' and 'overflow-y'.
		@alias of
		*/
		overflow:css$prop$overflow;
		/** @proxy overflow */
		of:css$prop$overflow;
		/**
		Specifies a prioritized list of font family names or generic family names. A user agent iterates through the list of family names until it matches an available font that contains a glyph for the character to be rendered.
		@alias ff
		*/
		'font-family':css$prop$font_family;
		/** @proxy font-family */
		ff:css$prop$font_family;
		/**
		Specifies how a box should be floated. It may be set for any element, but only applies to elements that generate boxes that are not absolutely positioned.
		*/
		float:css$prop$float;
		/**
		Determines the block-progression dimension of the text content area of an inline box.
		@alias lh
		*/
		'line-height':css$prop$line_height;
		/** @proxy line-height */
		lh:css$prop$line_height;
		/**
		Specifies the behavior of the 'width' and 'height' properties.
		*/
		'box-sizing':css$prop$box_sizing;
		/**
		Decorations applied to font used for an element's text.
		@alias td
		*/
		'text-decoration':css$prop$text_decoration;
		/** @proxy text-decoration */
		td:css$prop$text_decoration;
		/**
		For a positioned box, the 'z-index' property specifies the stack level of the box in the current stacking context and whether the box establishes a local stacking context.
		@alias zi
		*/
		'z-index':css$prop$z_index;
		/** @proxy z-index */
		zi:css$prop$z_index;
		/**
		Affects the vertical positioning of the inline boxes generated by an inline-level element inside a line box.
		@alias va
		*/
		'vertical-align':css$prop$vertical_align;
		/** @proxy vertical-align */
		va:css$prop$vertical_align;
		/**
		Allows control over cursor appearance in an element
		*/
		cursor:css$prop$cursor;
		/**
		Shorthand property to set values the thickness of the margin area. If left is omitted, it is the same as right. If bottom is omitted it is the same as top, if right is omitted it is the same as top. Negative values for margin properties are allowed, but there may be implementation-specific limits..
		@alias ml
		*/
		'margin-left':css$prop$margin_left;
		/** @proxy margin-left */
		ml:css$prop$margin_left;
		/**
		Defines the radii of the outer border edge.
		@alias rd
		*/
		'border-radius':css$prop$border_radius;
		/** @proxy border-radius */
		rd:css$prop$border_radius;
		/**
		Shorthand property to set values the thickness of the margin area. If left is omitted, it is the same as right. If bottom is omitted it is the same as top, if right is omitted it is the same as top. Negative values for margin properties are allowed, but there may be implementation-specific limits..
		@alias mb
		*/
		'margin-bottom':css$prop$margin_bottom;
		/** @proxy margin-bottom */
		mb:css$prop$margin_bottom;
		/**
		Shorthand property to set values the thickness of the margin area. If left is omitted, it is the same as right. If bottom is omitted it is the same as top, if right is omitted it is the same as top. Negative values for margin properties are allowed, but there may be implementation-specific limits..
		@alias mr
		*/
		'margin-right':css$prop$margin_right;
		/** @proxy margin-right */
		mr:css$prop$margin_right;
		/**
		Specifies how far an absolutely positioned box's right margin edge is offset to the left of the right edge of the box's 'containing block'.
		@alias r
		*/
		right:css$prop$right;
		/** @proxy right */
		r:css$prop$right;
		/**
		Shorthand property to set values the thickness of the padding area. If left is omitted, it is the same as right. If bottom is omitted it is the same as top, if right is omitted it is the same as top. The value may not be negative.
		@alias pl
		*/
		'padding-left':css$prop$padding_left;
		/** @proxy padding-left */
		pl:css$prop$padding_left;
		/**
		Shorthand property to set values the thickness of the padding area. If left is omitted, it is the same as right. If bottom is omitted it is the same as top, if right is omitted it is the same as top. The value may not be negative.
		@alias pt
		*/
		'padding-top':css$prop$padding_top;
		/** @proxy padding-top */
		pt:css$prop$padding_top;
		/**
		Allows authors to constrain content width to a certain range.
		*/
		'max-width':css$prop$max_width;
		/**
		Specifies how far an absolutely positioned box's bottom margin edge is offset above the bottom edge of the box's 'containing block'.
		@alias b
		*/
		bottom:css$prop$bottom;
		/** @proxy bottom */
		b:css$prop$bottom;
		/**
		Determines which page-based occurrence of a given element is applied to a counter or string value.
		*/
		content:css$prop$content;
		/**
		Attaches one or more drop-shadows to the box. The property is a comma-separated list of shadows, each specified by 2-4 length values, an optional color, and an optional 'inset' keyword. Omitted lengths are 0; omitted colors are a user agent chosen color.
		@alias shadow
		*/
		'box-shadow':css$prop$box_shadow;
		/** @proxy box-shadow */
		shadow:css$prop$box_shadow;
		/**
		Sets the background image(s) of an element.
		@alias bgi
		*/
		'background-image':css$prop$background_image;
		/** @proxy background-image */
		bgi:css$prop$background_image;
		/**
		Shorthand property to set values the thickness of the padding area. If left is omitted, it is the same as right. If bottom is omitted it is the same as top, if right is omitted it is the same as top. The value may not be negative.
		@alias pr
		*/
		'padding-right':css$prop$padding_right;
		/** @proxy padding-right */
		pr:css$prop$padding_right;
		/**
		Shorthand property for the 'white-space-collapsing' and 'text-wrap' properties.
		@alias ws
		*/
		'white-space':css$prop$white_space;
		/** @proxy white-space */
		ws:css$prop$white_space;
		/**
		Shorthand property to set values the thickness of the padding area. If left is omitted, it is the same as right. If bottom is omitted it is the same as top, if right is omitted it is the same as top. The value may not be negative.
		@alias pb
		*/
		'padding-bottom':css$prop$padding_bottom;
		/** @proxy padding-bottom */
		pb:css$prop$padding_bottom;
		/**
		Allows authors to constrain content height to a certain range.
		*/
		'min-height':css$prop$min_height;
		/**
		A two-dimensional transformation is applied to an element through the 'transform' property. This property contains a list of transform functions similar to those allowed by SVG.
		*/
		transform:css$prop$transform;
		/**
		Shorthand property for setting border width, style and color.
		@alias bdb
		*/
		'border-bottom':css$prop$border_bottom;
		/** @proxy border-bottom */
		bdb:css$prop$border_bottom;
		/**
		Specifies whether the boxes generated by an element are rendered. Invisible boxes still affect layout (set the ‘display’ property to ‘none’ to suppress box generation altogether).
		*/
		visibility:css$prop$visibility;
		/**
		Specifies the initial position of the background image(s) (after any resizing) within their corresponding background positioning area.
		@alias bgp
		*/
		'background-position':css$prop$background_position;
		/** @proxy background-position */
		bgp:css$prop$background_position;
		/**
		Shorthand property for setting border width, style and color
		@alias bdt
		*/
		'border-top':css$prop$border_top;
		/** @proxy border-top */
		bdt:css$prop$border_top;
		/**
		Allows authors to constrain content width to a certain range.
		*/
		'min-width':css$prop$min_width;
		/**
		Shorthand property for 'outline-style', 'outline-width', and 'outline-color'.
		*/
		outline:css$prop$outline;
		/**
		Shorthand property combines four of the transition properties into a single property.
		@alias tween
		*/
		transition:css$prop$transition;
		/** @proxy transition */
		tween:css$prop$transition;
		/**
		The color of the border around all four edges of an element.
		@alias bc
		*/
		'border-color':css$prop$border_color;
		/** @proxy border-color */
		bc:css$prop$border_color;
		/**
		Specifies how background images are tiled after they have been sized and positioned.
		@alias bgr
		*/
		'background-repeat':css$prop$background_repeat;
		/** @proxy background-repeat */
		bgr:css$prop$background_repeat;
		/**
		Controls capitalization effects of an element’s text.
		@alias tt
		*/
		'text-transform':css$prop$text_transform;
		/** @proxy text-transform */
		tt:css$prop$text_transform;
		/**
		Specifies the size of the background images.
		@alias bgs
		*/
		'background-size':css$prop$background_size;
		/** @proxy background-size */
		bgs:css$prop$background_size;
		/**
		Indicates which sides of an element's box(es) may not be adjacent to an earlier floating box. The 'clear' property does not consider floats inside the element itself or in other block formatting contexts.
		*/
		clear:css$prop$clear;
		/**
		Allows authors to constrain content height to a certain range.
		*/
		'max-height':css$prop$max_height;
		/**
		Shorthand for setting 'list-style-type', 'list-style-position' and 'list-style-image'
		*/
		'list-style':css$prop$list_style;
		/**
		Allows italic or oblique faces to be selected. Italic forms are generally cursive in nature while oblique faces are typically sloped versions of the regular face.
		*/
		'font-style':css$prop$font_style;
		/**
		Shorthand property for setting 'font-style', 'font-variant', 'font-weight', 'font-size', 'line-height', and 'font-family', at the same place in the style sheet. The syntax of this property is based on a traditional typographical shorthand notation to set multiple properties related to fonts.
		*/
		font:css$prop$font;
		/**
		Shorthand property for setting border width, style and color
		@alias bdl
		*/
		'border-left':css$prop$border_left;
		/** @proxy border-left */
		bdl:css$prop$border_left;
		/**
		Shorthand property for setting border width, style and color
		@alias bdr
		*/
		'border-right':css$prop$border_right;
		/** @proxy border-right */
		bdr:css$prop$border_right;
		/**
		Text can overflow for example when it is prevented from wrapping.
		*/
		'text-overflow':css$prop$text_overflow;
		/**
		Shorthand that sets the four 'border-*-width' properties. If it has four values, they set top, right, bottom and left in that order. If left is missing, it is the same as right; if bottom is missing, it is the same as top; if right is missing, it is the same as top.
		@alias bw
		*/
		'border-width':css$prop$border_width;
		/** @proxy border-width */
		bw:css$prop$border_width;
		/**
		Aligns flex items along the main axis of the current line of the flex container.
		@alias jc
		*/
		'justify-content':css$prop$justify_content;
		/** @proxy justify-content */
		jc:css$prop$justify_content;
		/**
		Aligns flex items along the cross axis of the current line of the flex container.
		@alias ai
		*/
		'align-items':css$prop$align_items;
		/** @proxy align-items */
		ai:css$prop$align_items;
		/**
		Specifies the handling of overflow in the vertical direction.
		@alias ofy
		*/
		'overflow-y':css$prop$overflow_y;
		/** @proxy overflow-y */
		ofy:css$prop$overflow_y;
		/**
		Specifies under what circumstances a given element can be the target element for a pointer event.
		@alias pe
		*/
		'pointer-events':css$prop$pointer_events;
		/** @proxy pointer-events */
		pe:css$prop$pointer_events;
		/**
		The style of the border around edges of an element.
		@alias bs
		*/
		'border-style':css$prop$border_style;
		/** @proxy border-style */
		bs:css$prop$border_style;
		/**
		Specifies the minimum, maximum, and optimal spacing between grapheme clusters.
		@alias ls
		*/
		'letter-spacing':css$prop$letter_spacing;
		/** @proxy letter-spacing */
		ls:css$prop$letter_spacing;
		/**
		Shorthand property combines six of the animation properties into a single property.
		*/
		animation:css$prop$animation;
		/**
		Specifies the handling of overflow in the horizontal direction.
		@alias ofx
		*/
		'overflow-x':css$prop$overflow_x;
		/** @proxy overflow-x */
		ofx:css$prop$overflow_x;
		/**
		Specifies how flex items are placed in the flex container, by setting the direction of the flex container’s main axis.
		@alias fld
		*/
		'flex-direction':css$prop$flex_direction;
		/** @proxy flex-direction */
		fld:css$prop$flex_direction;
		/**
		Specifies whether the UA may break within a word to prevent overflow when an otherwise-unbreakable string is too long to fit.
		*/
		'word-wrap':css$prop$word_wrap;
		/**
		Specifies the components of a flexible length: the flex grow factor and flex shrink factor, and the flex basis.
		@alias fl
		*/
		flex:css$prop$flex;
		/** @proxy flex */
		fl:css$prop$flex;
		/**
		Selects a table's border model.
		*/
		'border-collapse':css$prop$border_collapse;
		/**
		Non-standard. Specifies the magnification scale of the object. See 'transform: scale()' for a standards-based alternative.
		*/
		zoom:css$prop$zoom;
		/**
		Used to construct the default contents of a list item’s marker
		*/
		'list-style-type':css$prop$list_style_type;
		/**
		Defines the radii of the bottom left outer border edge.
		@alias rdbl
		*/
		'border-bottom-left-radius':css$prop$border_bottom_left_radius;
		/** @proxy border-bottom-left-radius */
		rdbl:css$prop$border_bottom_left_radius;
		/**
		Paints the interior of the given graphical element.
		*/
		fill:css$prop$fill;
		/**
		Establishes the origin of transformation for an element.
		@alias origin
		*/
		'transform-origin':css$prop$transform_origin;
		/** @proxy transform-origin */
		origin:css$prop$transform_origin;
		/**
		Controls whether the flex container is single-line or multi-line, and the direction of the cross-axis, which determines the direction new lines are stacked in.
		@alias flw
		*/
		'flex-wrap':css$prop$flex_wrap;
		/** @proxy flex-wrap */
		flw:css$prop$flex_wrap;
		/**
		Enables shadow effects to be applied to the text of the element.
		@alias ts
		*/
		'text-shadow':css$prop$text_shadow;
		/** @proxy text-shadow */
		ts:css$prop$text_shadow;
		/**
		Defines the radii of the top left outer border edge.
		@alias rdtl
		*/
		'border-top-left-radius':css$prop$border_top_left_radius;
		/** @proxy border-top-left-radius */
		rdtl:css$prop$border_top_left_radius;
		/**
		Controls the appearance of selection.
		@alias us
		*/
		'user-select':css$prop$user_select;
		/** @proxy user-select */
		us:css$prop$user_select;
		/**
		Deprecated. Use the 'clip-path' property when support allows. Defines the visible portion of an element’s box.
		*/
		clip:css$prop$clip;
		/**
		Defines the radii of the bottom right outer border edge.
		@alias rdbr
		*/
		'border-bottom-right-radius':css$prop$border_bottom_right_radius;
		/** @proxy border-bottom-right-radius */
		rdbr:css$prop$border_bottom_right_radius;
		/**
		Specifies line break opportunities for non-CJK scripts.
		*/
		'word-break':css$prop$word_break;
		/**
		Defines the radii of the top right outer border edge.
		@alias rdtr
		*/
		'border-top-right-radius':css$prop$border_top_right_radius;
		/** @proxy border-top-right-radius */
		rdtr:css$prop$border_top_right_radius;
		/**
		Sets the flex grow factor. Negative numbers are invalid.
		@alias flg
		*/
		'flex-grow':css$prop$flex_grow;
		/** @proxy flex-grow */
		flg:css$prop$flex_grow;
		/**
		Sets the color of the top border.
		@alias bct
		*/
		'border-top-color':css$prop$border_top_color;
		/** @proxy border-top-color */
		bct:css$prop$border_top_color;
		/**
		Sets the color of the bottom border.
		@alias bcb
		*/
		'border-bottom-color':css$prop$border_bottom_color;
		/** @proxy border-bottom-color */
		bcb:css$prop$border_bottom_color;
		/**
		Sets the flex shrink factor. Negative numbers are invalid.
		@alias fls
		*/
		'flex-shrink':css$prop$flex_shrink;
		/** @proxy flex-shrink */
		fls:css$prop$flex_shrink;
		/**
		The creator of SVG content might want to provide a hint to the implementation about what tradeoffs to make as it renders text. The ‘text-rendering’ property provides these hints.
		*/
		'text-rendering':css$prop$text_rendering;
		/**
		Allows the default alignment along the cross axis to be overridden for individual flex items.
		@alias as
		*/
		'align-self':css$prop$align_self;
		/** @proxy align-self */
		as:css$prop$align_self;
		/**
		Specifies the indentation applied to lines of inline content in a block. The indentation only affects the first line of inline content in the block unless the 'hanging' keyword is specified, in which case it affects all lines except the first.
		*/
		'text-indent':css$prop$text_indent;
		/**
		Describes how the animation will progress over one cycle of its duration.
		*/
		'animation-timing-function':css$prop$animation_timing_function;
		/**
		The lengths specify the distance that separates adjoining cell borders. If one length is specified, it gives both the horizontal and vertical spacing. If two are specified, the first gives the horizontal spacing and the second the vertical spacing. Lengths may not be negative.
		*/
		'border-spacing':css$prop$border_spacing;
		/**
		Specifies the inline base direction or directionality of any bidi paragraph, embedding, isolate, or override established by the box. Note: for HTML content use the 'dir' attribute and 'bdo' element rather than this property.
		*/
		direction:css$prop$direction;
		/**
		Determines the background painting area.
		@alias bgclip
		*/
		'background-clip':css$prop$background_clip;
		/** @proxy background-clip */
		bgclip:css$prop$background_clip;
		/**
		Sets the color of the left border.
		@alias bcl
		*/
		'border-left-color':css$prop$border_left_color;
		/** @proxy border-left-color */
		bcl:css$prop$border_left_color;
		/**
		@font-face descriptor. Specifies the resource containing font data. It is required, whether the font is downloadable or locally installed.
		*/
		src:css$prop$src;
		/**
		Determines whether touch input may trigger default behavior supplied by user agent.
		*/
		'touch-action':css$prop$touch_action;
		/**
		Sets the color of the right border.
		@alias bcr
		*/
		'border-right-color':css$prop$border_right_color;
		/** @proxy border-right-color */
		bcr:css$prop$border_right_color;
		/**
		Specifies the name of the CSS property to which the transition is applied.
		*/
		'transition-property':css$prop$transition_property;
		/**
		Defines a list of animations that apply. Each name is used to select the keyframe at-rule that provides the property values for the animation.
		*/
		'animation-name':css$prop$animation_name;
		/**
		Processes an element’s rendering before it is displayed in the document, by applying one or more filter effects.
		*/
		filter:css$prop$filter;
		/**
		Defines the length of time that an animation takes to complete one cycle.
		*/
		'animation-duration':css$prop$animation_duration;
		/**
		Specifies whether the UA may break within a word to prevent overflow when an otherwise-unbreakable string is too long to fit within the line box.
		*/
		'overflow-wrap':css$prop$overflow_wrap;
		/**
		Defines when the transition will start. It allows a transition to begin execution some period of time from when it is applied.
		*/
		'transition-delay':css$prop$transition_delay;
		/**
		Paints along the outline of the given graphical element.
		*/
		stroke:css$prop$stroke;
		/**
		Specifies variant representations of the font
		*/
		'font-variant':css$prop$font_variant;
		/**
		Sets the thickness of the bottom border.
		@alias bwb
		*/
		'border-bottom-width':css$prop$border_bottom_width;
		/** @proxy border-bottom-width */
		bwb:css$prop$border_bottom_width;
		/**
		Defines when the animation will start.
		*/
		'animation-delay':css$prop$animation_delay;
		/**
		Sets the thickness of the top border.
		@alias bwt
		*/
		'border-top-width':css$prop$border_top_width;
		/** @proxy border-top-width */
		bwt:css$prop$border_top_width;
		/**
		Specifies how long the transition from the old value to the new value should take.
		*/
		'transition-duration':css$prop$transition_duration;
		/**
		Sets the flex basis.
		@alias flb
		*/
		'flex-basis':css$prop$flex_basis;
		/** @proxy flex-basis */
		flb:css$prop$flex_basis;
		/**
		Provides a rendering hint to the user agent, stating what kinds of changes the author expects to perform on the element.
		*/
		'will-change':css$prop$will_change;
		/**
		Defines what values are applied by the animation outside the time it is executing.
		*/
		'animation-fill-mode':css$prop$animation_fill_mode;
		/**
		Width of the outline.
		*/
		'outline-width':css$prop$outline_width;
		/**
		Controls the algorithm used to lay out the table cells, rows, and columns.
		*/
		'table-layout':css$prop$table_layout;
		/**
		Specifies how the contents of a replaced element should be scaled relative to the box established by its used height and width.
		*/
		'object-fit':css$prop$object_fit;
		/**
		Controls the order in which children of a flex container appear within the flex container, by assigning them to ordinal groups.
		*/
		order:css$prop$order;
		/**
		Describes how the intermediate values used during a transition will be calculated.
		*/
		'transition-timing-function':css$prop$transition_timing_function;
		/**
		Specifies whether or not an element is resizable by the user, and if so, along which axis/axes.
		*/
		resize:css$prop$resize;
		/**
		Style of the outline.
		*/
		'outline-style':css$prop$outline_style;
		/**
		Sets the thickness of the right border.
		@alias bwr
		*/
		'border-right-width':css$prop$border_right_width;
		/** @proxy border-right-width */
		bwr:css$prop$border_right_width;
		/**
		Specifies the width of the stroke on the current object.
		*/
		'stroke-width':css$prop$stroke_width;
		/**
		Defines the number of times an animation cycle is played. The default value is one, meaning the animation will play from beginning to end once.
		*/
		'animation-iteration-count':css$prop$animation_iteration_count;
		/**
		Aligns a flex container’s lines within the flex container when there is extra space in the cross-axis, similar to how 'justify-content' aligns individual items within the main-axis.
		@alias ac
		*/
		'align-content':css$prop$align_content;
		/** @proxy align-content */
		ac:css$prop$align_content;
		/**
		Offset the outline and draw it beyond the border edge.
		*/
		'outline-offset':css$prop$outline_offset;
		/**
		Determines whether or not the 'back' side of a transformed element is visible when facing the viewer. With an identity transform, the front side of an element faces the viewer.
		*/
		'backface-visibility':css$prop$backface_visibility;
		/**
		Sets the thickness of the left border.
		@alias bwl
		*/
		'border-left-width':css$prop$border_left_width;
		/** @proxy border-left-width */
		bwl:css$prop$border_left_width;
		/**
		Specifies how flexbox items are placed in the flexbox.
		@alias flf
		*/
		'flex-flow':css$prop$flex_flow;
		/** @proxy flex-flow */
		flf:css$prop$flex_flow;
		/**
		Changes the appearance of buttons and other controls to resemble native controls.
		*/
		appearance:css$prop$appearance;
		/**
		The level of embedding with respect to the bidirectional algorithm.
		*/
		'unicode-bidi':css$prop$unicode_bidi;
		/**
		Controls the pattern of dashes and gaps used to stroke paths.
		*/
		'stroke-dasharray':css$prop$stroke_dasharray;
		/**
		Specifies the distance into the dash pattern to start the dash.
		*/
		'stroke-dashoffset':css$prop$stroke_dashoffset;
		/**
		@font-face descriptor. Defines the set of Unicode codepoints that may be supported by the font face for which it is declared.
		*/
		'unicode-range':css$prop$unicode_range;
		/**
		Specifies additional spacing between “words”.
		*/
		'word-spacing':css$prop$word_spacing;
		/**
		The text-size-adjust CSS property controls the text inflation algorithm used on some smartphones and tablets. Other browsers will ignore this property.
		*/
		'text-size-adjust':css$prop$text_size_adjust;
		/**
		Sets the style of the top border.
		@alias bst
		*/
		'border-top-style':css$prop$border_top_style;
		/** @proxy border-top-style */
		bst:css$prop$border_top_style;
		/**
		Sets the style of the bottom border.
		@alias bsb
		*/
		'border-bottom-style':css$prop$border_bottom_style;
		/** @proxy border-bottom-style */
		bsb:css$prop$border_bottom_style;
		/**
		Defines whether or not the animation should play in reverse on alternate cycles.
		*/
		'animation-direction':css$prop$animation_direction;
		/**
		Provides a hint to the user-agent about what aspects of an image are most important to preserve when the image is scaled, to aid the user-agent in the choice of an appropriate scaling algorithm.
		*/
		'image-rendering':css$prop$image_rendering;
		/**
		Applies the same transform as the perspective(<number>) transform function, except that it applies only to the positioned or transformed children of the element, not to the transform on the element itself.
		*/
		perspective:css$prop$perspective;
		/**
		specifies, as a space-separated track list, the line names and track sizing functions of the grid.
		@alias gtc
		*/
		'grid-template-columns':css$prop$grid_template_columns;
		/** @proxy grid-template-columns */
		gtc:css$prop$grid_template_columns;
		/**
		Specifies the position of the '::marker' pseudo-element's box in the list item.
		*/
		'list-style-position':css$prop$list_style_position;
		/**
		Provides low-level control over OpenType font features. It is intended as a way of providing access to font features that are not widely used but are needed for a particular use case.
		*/
		'font-feature-settings':css$prop$font_feature_settings;
		/**
		Indicates that an element and its contents are, as much as possible, independent of the rest of the document tree.
		*/
		contain:css$prop$contain;
		/**
		If background images have been specified, this property specifies their initial position (after any resizing) within their corresponding background positioning area.
		*/
		'background-position-x':css$prop$background_position_x;
		/**
		Defines how nested elements are rendered in 3D space.
		*/
		'transform-style':css$prop$transform_style;
		/**
		For elements rendered as a single box, specifies the background positioning area. For elements rendered as multiple boxes (e.g., inline boxes on several lines, boxes on several pages) specifies which boxes 'box-decoration-break' operates on to determine the background positioning area(s).
		@alias bgo
		*/
		'background-origin':css$prop$background_origin;
		/** @proxy background-origin */
		bgo:css$prop$background_origin;
		/**
		Sets the style of the left border.
		@alias bsl
		*/
		'border-left-style':css$prop$border_left_style;
		/** @proxy border-left-style */
		bsl:css$prop$border_left_style;
		/**
		The font-display descriptor determines how a font face is displayed based on whether and when it is downloaded and ready to use.
		*/
		'font-display':css$prop$font_display;
		/**
		Specifies a clipping path where everything inside the path is visible and everything outside is clipped out.
		*/
		'clip-path':css$prop$clip_path;
		/**
		Controls whether hyphenation is allowed to create more break opportunities within a line of text.
		*/
		hyphens:css$prop$hyphens;
		/**
		Specifies whether the background images are fixed with regard to the viewport ('fixed') or scroll along with the element ('scroll') or its contents ('local').
		@alias bga
		*/
		'background-attachment':css$prop$background_attachment;
		/** @proxy background-attachment */
		bga:css$prop$background_attachment;
		/**
		Sets the style of the right border.
		@alias bsr
		*/
		'border-right-style':css$prop$border_right_style;
		/** @proxy border-right-style */
		bsr:css$prop$border_right_style;
		/**
		The color of the outline.
		*/
		'outline-color':css$prop$outline_color;
		/**
		Logical 'margin-bottom'. Mapping depends on the parent element’s 'writing-mode', 'direction', and 'text-orientation'.
		*/
		'margin-block-end':css$prop$margin_block_end;
		/**
		Defines whether the animation is running or paused.
		*/
		'animation-play-state':css$prop$animation_play_state;
		/**
		Specifies quotation marks for any number of embedded quotations.
		*/
		quotes:css$prop$quotes;
		/**
		If background images have been specified, this property specifies their initial position (after any resizing) within their corresponding background positioning area.
		*/
		'background-position-y':css$prop$background_position_y;
		/**
		Selects a normal, condensed, or expanded face from a font family.
		*/
		'font-stretch':css$prop$font_stretch;
		/**
		Specifies the shape to be used at the end of open subpaths when they are stroked.
		*/
		'stroke-linecap':css$prop$stroke_linecap;
		/**
		Determines the alignment of the replaced element inside its box.
		*/
		'object-position':css$prop$object_position;
		/**
		Property accepts one or more names of counters (identifiers), each one optionally followed by an integer. The integer gives the value that the counter is set to on each occurrence of the element.
		*/
		'counter-reset':css$prop$counter_reset;
		/**
		Logical 'margin-top'. Mapping depends on the parent element’s 'writing-mode', 'direction', and 'text-orientation'.
		*/
		'margin-block-start':css$prop$margin_block_start;
		/**
		Manipulate the value of existing counters.
		*/
		'counter-increment':css$prop$counter_increment;
		/**
		undefined
		*/
		size:css$prop$size;
		/**
		Specifies the color of text decoration (underlines overlines, and line-throughs) set on the element with text-decoration-line.
		@alias tdc
		*/
		'text-decoration-color':css$prop$text_decoration_color;
		/** @proxy text-decoration-color */
		tdc:css$prop$text_decoration_color;
		/**
		Sets the image that will be used as the list item marker. When the image is available, it will replace the marker set with the 'list-style-type' marker.
		*/
		'list-style-image':css$prop$list_style_image;
		/**
		Describes the optimal number of columns into which the content of the element will be flowed.
		*/
		'column-count':css$prop$column_count;
		/**
		Shorthand property for setting 'border-image-source', 'border-image-slice', 'border-image-width', 'border-image-outset' and 'border-image-repeat'. Omitted values are set to their initial values.
		*/
		'border-image':css$prop$border_image;
		/**
		Sets the gap between columns. If there is a column rule between columns, it will appear in the middle of the gap.
		@alias cg
		*/
		'column-gap':css$prop$column_gap;
		/** @proxy column-gap */
		cg:css$prop$column_gap;
		/**
		Defines rules for page breaks inside an element.
		*/
		'page-break-inside':css$prop$page_break_inside;
		/**
		Specifies the opacity of the painting operation used to paint the interior the current object.
		*/
		'fill-opacity':css$prop$fill_opacity;
		/**
		Logical 'padding-left'. Mapping depends on the parent element’s 'writing-mode', 'direction', and 'text-orientation'.
		*/
		'padding-inline-start':css$prop$padding_inline_start;
		/**
		In the separated borders model, this property controls the rendering of borders and backgrounds around cells that have no visible content.
		*/
		'empty-cells':css$prop$empty_cells;
		/**
		Specifies control over which ligatures are enabled or disabled. A value of ‘normal’ implies that the defaults set by the font are used.
		*/
		'font-variant-ligatures':css$prop$font_variant_ligatures;
		/**
		The text-decoration-skip CSS property specifies what parts of the element’s content any text decoration affecting the element must skip over. It controls all text decoration lines drawn by the element and also any text decoration lines drawn by its ancestors.
		*/
		'text-decoration-skip':css$prop$text_decoration_skip;
		/**
		Defines the way of justifying a box inside its container along the appropriate axis.
		@alias js
		*/
		'justify-self':css$prop$justify_self;
		/** @proxy justify-self */
		js:css$prop$justify_self;
		/**
		Defines rules for page breaks after an element.
		*/
		'page-break-after':css$prop$page_break_after;
		/**
		specifies, as a space-separated track list, the line names and track sizing functions of the grid.
		@alias gtr
		*/
		'grid-template-rows':css$prop$grid_template_rows;
		/** @proxy grid-template-rows */
		gtr:css$prop$grid_template_rows;
		/**
		Logical 'padding-right'. Mapping depends on the parent element’s 'writing-mode', 'direction', and 'text-orientation'.
		*/
		'padding-inline-end':css$prop$padding_inline_end;
		/**
		Shorthand that specifies the gutters between grid columns and grid rows in one declaration. Replaced by 'gap' property.
		*/
		'grid-gap':css$prop$grid_gap;
		/**
		Shorthand that resets all properties except 'direction' and 'unicode-bidi'.
		*/
		all:css$prop$all;
		/**
		Shorthand for 'grid-column-start' and 'grid-column-end'.
		@alias gc
		*/
		'grid-column':css$prop$grid_column;
		/** @proxy grid-column */
		gc:css$prop$grid_column;
		/**
		Specifies the opacity of the painting operation used to stroke the current object.
		*/
		'stroke-opacity':css$prop$stroke_opacity;
		/**
		Logical 'margin-left'. Mapping depends on the parent element’s 'writing-mode', 'direction', and 'text-orientation'.
		*/
		'margin-inline-start':css$prop$margin_inline_start;
		/**
		Logical 'margin-right'. Mapping depends on the parent element’s 'writing-mode', 'direction', and 'text-orientation'.
		*/
		'margin-inline-end':css$prop$margin_inline_end;
		/**
		Controls the color of the text insertion indicator.
		*/
		'caret-color':css$prop$caret_color;
		/**
		Specifies the minimum number of line boxes in a block container that must be left in a fragment before a fragmentation break.
		*/
		orphans:css$prop$orphans;
		/**
		Specifies the position of the caption box with respect to the table box.
		*/
		'caption-side':css$prop$caption_side;
		/**
		Establishes the origin for the perspective property. It effectively sets the X and Y position at which the viewer appears to be looking at the children of the element.
		*/
		'perspective-origin':css$prop$perspective_origin;
		/**
		Indicates what color to use at that gradient stop.
		*/
		'stop-color':css$prop$stop_color;
		/**
		Specifies the minimum number of line boxes of a block container that must be left in a fragment after a break.
		*/
		widows:css$prop$widows;
		/**
		Specifies the scrolling behavior for a scrolling box, when scrolling happens due to navigation or CSSOM scrolling APIs.
		*/
		'scroll-behavior':css$prop$scroll_behavior;
		/**
		Specifies the gutters between grid columns. Replaced by 'column-gap' property.
		@alias gcg
		*/
		'grid-column-gap':css$prop$grid_column_gap;
		/** @proxy grid-column-gap */
		gcg:css$prop$grid_column_gap;
		/**
		A shorthand property which sets both 'column-width' and 'column-count'.
		*/
		columns:css$prop$columns;
		/**
		Describes the width of columns in multicol elements.
		*/
		'column-width':css$prop$column_width;
		/**
		Defines the formula that must be used to mix the colors with the backdrop.
		*/
		'mix-blend-mode':css$prop$mix_blend_mode;
		/**
		Kerning is the contextual adjustment of inter-glyph spacing. This property controls metric kerning, kerning that utilizes adjustment data contained in the font.
		*/
		'font-kerning':css$prop$font_kerning;
		/**
		Specifies inward offsets from the top, right, bottom, and left edges of the image, dividing it into nine regions: four corners, four edges and a middle.
		*/
		'border-image-slice':css$prop$border_image_slice;
		/**
		Specifies how the images for the sides and the middle part of the border image are scaled and tiled. If the second keyword is absent, it is assumed to be the same as the first.
		*/
		'border-image-repeat':css$prop$border_image_repeat;
		/**
		The four values of 'border-image-width' specify offsets that are used to divide the border image area into nine parts. They represent inward distances from the top, right, bottom, and left sides of the area, respectively.
		*/
		'border-image-width':css$prop$border_image_width;
		/**
		Shorthand for 'grid-row-start' and 'grid-row-end'.
		@alias gr
		*/
		'grid-row':css$prop$grid_row;
		/** @proxy grid-row */
		gr:css$prop$grid_row;
		/**
		Determines the width of the tab character (U+0009), in space characters (U+0020), when rendered.
		*/
		'tab-size':css$prop$tab_size;
		/**
		Specifies the gutters between grid rows. Replaced by 'row-gap' property.
		@alias grg
		*/
		'grid-row-gap':css$prop$grid_row_gap;
		/** @proxy grid-row-gap */
		grg:css$prop$grid_row_gap;
		/**
		Specifies the line style for underline, line-through and overline text decoration.
		@alias tds
		*/
		'text-decoration-style':css$prop$text_decoration_style;
		/** @proxy text-decoration-style */
		tds:css$prop$text_decoration_style;
		/**
		Specifies what set of line breaking restrictions are in effect within the element.
		*/
		'line-break':css$prop$line_break;
		/**
		The values specify the amount by which the border image area extends beyond the border box on the top, right, bottom, and left sides respectively. If the fourth value is absent, it is the same as the second. If the third one is also absent, it is the same as the first. If the second one is also absent, it is the same as the first. Numbers represent multiples of the corresponding border-width.
		*/
		'border-image-outset':css$prop$border_image_outset;
		/**
		Shorthand for setting 'column-rule-width', 'column-rule-style', and 'column-rule-color' at the same place in the style sheet. Omitted values are set to their initial values.
		*/
		'column-rule':css$prop$column_rule;
		/**
		Defines the default justify-self for all items of the box, giving them the default way of justifying each box along the appropriate axis
		@alias ji
		*/
		'justify-items':css$prop$justify_items;
		/** @proxy justify-items */
		ji:css$prop$justify_items;
		/**
		Determine a grid item’s size and location within the grid by contributing a line, a span, or nothing (automatic) to its grid placement. Shorthand for 'grid-row-start', 'grid-column-start', 'grid-row-end', and 'grid-column-end'.
		@alias ga
		*/
		'grid-area':css$prop$grid_area;
		/** @proxy grid-area */
		ga:css$prop$grid_area;
		/**
		When two line segments meet at a sharp angle and miter joins have been specified for 'stroke-linejoin', it is possible for the miter to extend far beyond the thickness of the line stroking the path.
		*/
		'stroke-miterlimit':css$prop$stroke_miterlimit;
		/**
		Describes how the last line of a block or a line right before a forced line break is aligned when 'text-align' is set to 'justify'.
		*/
		'text-align-last':css$prop$text_align_last;
		/**
		The backdrop-filter CSS property lets you apply graphical effects such as blurring or color shifting to the area behind an element. Because it applies to everything behind the element, to see the effect you must make the element or its background at least partially transparent.
		*/
		'backdrop-filter':css$prop$backdrop_filter;
		/**
		Specifies the size of implicitly created rows.
		@alias gar
		*/
		'grid-auto-rows':css$prop$grid_auto_rows;
		/** @proxy grid-auto-rows */
		gar:css$prop$grid_auto_rows;
		/**
		Specifies the shape to be used at the corners of paths or basic shapes when they are stroked.
		*/
		'stroke-linejoin':css$prop$stroke_linejoin;
		/**
		Specifies an orthogonal rotation to be applied to an image before it is laid out.
		*/
		'shape-outside':css$prop$shape_outside;
		/**
		Specifies what line decorations, if any, are added to the element.
		@alias tdl
		*/
		'text-decoration-line':css$prop$text_decoration_line;
		/** @proxy text-decoration-line */
		tdl:css$prop$text_decoration_line;
		/**
		The scroll-snap-align property specifies the box’s snap position as an alignment of its snap area (as the alignment subject) within its snap container’s snapport (as the alignment container). The two values specify the snapping alignment in the block axis and inline axis, respectively. If only one value is specified, the second value defaults to the same value.
		*/
		'scroll-snap-align':css$prop$scroll_snap_align;
		/**
		Indicates the algorithm (or winding rule) which is to be used to determine what parts of the canvas are included inside the shape.
		*/
		'fill-rule':css$prop$fill_rule;
		/**
		Controls how the auto-placement algorithm works, specifying exactly how auto-placed items get flowed into the grid.
		@alias gaf
		*/
		'grid-auto-flow':css$prop$grid_auto_flow;
		/** @proxy grid-auto-flow */
		gaf:css$prop$grid_auto_flow;
		/**
		Defines how strictly snap points are enforced on the scroll container.
		*/
		'scroll-snap-type':css$prop$scroll_snap_type;
		/**
		Defines rules for page breaks before an element.
		*/
		'page-break-before':css$prop$page_break_before;
		/**
		Determine a grid item’s size and location within the grid by contributing a line, a span, or nothing (automatic) to its grid placement.
		@alias gcs
		*/
		'grid-column-start':css$prop$grid_column_start;
		/** @proxy grid-column-start */
		gcs:css$prop$grid_column_start;
		/**
		Specifies named grid areas, which are not associated with any particular grid item, but can be referenced from the grid-placement properties.
		@alias gta
		*/
		'grid-template-areas':css$prop$grid_template_areas;
		/** @proxy grid-template-areas */
		gta:css$prop$grid_template_areas;
		/**
		Describes the page/column/region break behavior inside the principal box.
		*/
		'break-inside':css$prop$break_inside;
		/**
		In continuous media, this property will only be consulted if the length of columns has been constrained. Otherwise, columns will automatically be balanced.
		*/
		'column-fill':css$prop$column_fill;
		/**
		Determine a grid item’s size and location within the grid by contributing a line, a span, or nothing (automatic) to its grid placement.
		@alias gce
		*/
		'grid-column-end':css$prop$grid_column_end;
		/** @proxy grid-column-end */
		gce:css$prop$grid_column_end;
		/**
		Specifies an image to use instead of the border styles given by the 'border-style' properties and as an additional background layer for the element. If the value is 'none' or if the image cannot be displayed, the border styles will be used.
		*/
		'border-image-source':css$prop$border_image_source;
		/**
		The overflow-anchor CSS property provides a way to opt out browser scroll anchoring behavior which adjusts scroll position to minimize content shifts.
		@alias ofa
		*/
		'overflow-anchor':css$prop$overflow_anchor;
		/** @proxy overflow-anchor */
		ofa:css$prop$overflow_anchor;
		/**
		Determine a grid item’s size and location within the grid by contributing a line, a span, or nothing (automatic) to its grid placement.
		@alias grs
		*/
		'grid-row-start':css$prop$grid_row_start;
		/** @proxy grid-row-start */
		grs:css$prop$grid_row_start;
		/**
		Determine a grid item’s size and location within the grid by contributing a line, a span, or nothing (automatic) to its grid placement.
		@alias gre
		*/
		'grid-row-end':css$prop$grid_row_end;
		/** @proxy grid-row-end */
		gre:css$prop$grid_row_end;
		/**
		Specifies control over numerical forms.
		*/
		'font-variant-numeric':css$prop$font_variant_numeric;
		/**
		Defines the blending mode of each background layer.
		*/
		'background-blend-mode':css$prop$background_blend_mode;
		/**
		The text-decoration-skip-ink CSS property specifies how overlines and underlines are drawn when they pass over glyph ascenders and descenders.
		@alias tdsi
		*/
		'text-decoration-skip-ink':css$prop$text_decoration_skip_ink;
		/** @proxy text-decoration-skip-ink */
		tdsi:css$prop$text_decoration_skip_ink;
		/**
		Sets the color of the column rule
		*/
		'column-rule-color':css$prop$column_rule_color;
		/**
		In CSS setting to 'isolate' will turn the element into a stacking context. In SVG, it defines whether an element is isolated or not.
		*/
		isolation:css$prop$isolation;
		/**
		Provides hints about what tradeoffs to make as it renders vector graphics elements such as <path> elements and basic shapes such as circles and rectangles.
		*/
		'shape-rendering':css$prop$shape_rendering;
		/**
		Sets the style of the rule between columns of an element.
		*/
		'column-rule-style':css$prop$column_rule_style;
		/**
		Logical 'border-right-width'. Mapping depends on the parent element’s 'writing-mode', 'direction', and 'text-orientation'.
		*/
		'border-inline-end-width':css$prop$border_inline_end_width;
		/**
		Logical 'border-left-width'. Mapping depends on the parent element’s 'writing-mode', 'direction', and 'text-orientation'.
		*/
		'border-inline-start-width':css$prop$border_inline_start_width;
		/**
		Specifies the size of implicitly created columns.
		@alias gac
		*/
		'grid-auto-columns':css$prop$grid_auto_columns;
		/** @proxy grid-auto-columns */
		gac:css$prop$grid_auto_columns;
		/**
		This is a shorthand property for both 'direction' and 'block-progression'.
		*/
		'writing-mode':css$prop$writing_mode;
		/**
		Indicates the algorithm which is to be used to determine what parts of the canvas are included inside the shape.
		*/
		'clip-rule':css$prop$clip_rule;
		/**
		Specifies control over capitalized forms.
		*/
		'font-variant-caps':css$prop$font_variant_caps;
		/**
		Used to align (start-, middle- or end-alignment) a string of text relative to a given point.
		*/
		'text-anchor':css$prop$text_anchor;
		/**
		Defines the opacity of a given gradient stop.
		*/
		'stop-opacity':css$prop$stop_opacity;
		/**
		The mask CSS property alters the visibility of an element by either partially or fully hiding it. This is accomplished by either masking or clipping the image at specific points.
		*/
		mask:css$prop$mask;
		/**
		Describes the page/column break behavior after the generated box.
		*/
		'column-span':css$prop$column_span;
		/**
		Allows control of glyph substitute and positioning in East Asian text.
		*/
		'font-variant-east-asian':css$prop$font_variant_east_asian;
		/**
		Sets the position of an underline specified on the same element: it does not affect underlines specified by ancestor elements. This property is typically used in vertical writing contexts such as in Japanese documents where it often desired to have the underline appear 'over' (to the right of) the affected run of text
		*/
		'text-underline-position':css$prop$text_underline_position;
		/**
		Describes the page/column/region break behavior after the generated box.
		*/
		'break-after':css$prop$break_after;
		/**
		Describes the page/column/region break behavior before the generated box.
		*/
		'break-before':css$prop$break_before;
		/**
		Defines whether the content of the <mask> element is treated as as luminance mask or alpha mask.
		*/
		'mask-type':css$prop$mask_type;
		/**
		Sets the width of the rule between columns. Negative values are not allowed.
		*/
		'column-rule-width':css$prop$column_rule_width;
		/**
		The row-gap CSS property specifies the gutter between grid rows.
		@alias rg
		*/
		'row-gap':css$prop$row_gap;
		/** @proxy row-gap */
		rg:css$prop$row_gap;
		/**
		Specifies the orientation of text within a line.
		*/
		'text-orientation':css$prop$text_orientation;
		/**
		The scroll-padding property is a shorthand property which sets all of the scroll-padding longhands, assigning values much like the padding property does for the padding-* longhands.
		*/
		'scroll-padding':css$prop$scroll_padding;
		/**
		Shorthand for setting grid-template-columns, grid-template-rows, and grid-template-areas in a single declaration.
		@alias gt
		*/
		'grid-template':css$prop$grid_template;
		/** @proxy grid-template */
		gt:css$prop$grid_template;
		/**
		Logical 'border-right-color'. Mapping depends on the parent element’s 'writing-mode', 'direction', and 'text-orientation'.
		*/
		'border-inline-end-color':css$prop$border_inline_end_color;
		/**
		Logical 'border-left-color'. Mapping depends on the parent element’s 'writing-mode', 'direction', and 'text-orientation'.
		*/
		'border-inline-start-color':css$prop$border_inline_start_color;
		/**
		The scroll-snap-stop CSS property defines whether the scroll container is allowed to "pass over" possible snap positions.
		*/
		'scroll-snap-stop':css$prop$scroll_snap_stop;
		/**
		Adds a margin to a 'shape-outside'. This defines a new shape that is the smallest contour that includes all the points that are the 'shape-margin' distance outward in the perpendicular direction from a point on the underlying shape.
		*/
		'shape-margin':css$prop$shape_margin;
		/**
		Defines the alpha channel threshold used to extract the shape using an image. A value of 0.5 means that the shape will enclose all the pixels that are more than 50% opaque.
		*/
		'shape-image-threshold':css$prop$shape_image_threshold;
		/**
		The gap CSS property is a shorthand property for row-gap and column-gap specifying the gutters between grid rows and columns.
		@alias g
		*/
		gap:css$prop$gap;
		/** @proxy gap */
		g:css$prop$gap;
		/**
		Logical 'min-height'. Mapping depends on the element’s 'writing-mode'.
		*/
		'min-inline-size':css$prop$min_inline_size;
		/**
		Specifies an orthogonal rotation to be applied to an image before it is laid out.
		*/
		'image-orientation':css$prop$image_orientation;
		/**
		Logical 'height'. Mapping depends on the element’s 'writing-mode'.
		*/
		'inline-size':css$prop$inline_size;
		/**
		Logical 'padding-top'. Mapping depends on the parent element’s 'writing-mode', 'direction', and 'text-orientation'.
		*/
		'padding-block-start':css$prop$padding_block_start;
		/**
		Logical 'padding-bottom'. Mapping depends on the parent element’s 'writing-mode', 'direction', and 'text-orientation'.
		*/
		'padding-block-end':css$prop$padding_block_end;
		/**
		The text-combine-upright CSS property specifies the combination of multiple characters into the space of a single character. If the combined text is wider than 1em, the user agent must fit the contents within 1em. The resulting composition is treated as a single upright glyph for layout and decoration. This property only has an effect in vertical writing modes.

This is used to produce an effect that is known as tate-chū-yoko (縦中横) in Japanese, or as 直書橫向 in Chinese.
		*/
		'text-combine-upright':css$prop$text_combine_upright;
		/**
		Logical 'width'. Mapping depends on the element’s 'writing-mode'.
		*/
		'block-size':css$prop$block_size;
		/**
		Logical 'min-width'. Mapping depends on the element’s 'writing-mode'.
		*/
		'min-block-size':css$prop$min_block_size;
		/**
		The scroll-padding-top property defines offsets for the top of the optimal viewing region of the scrollport: the region used as the target region for placing things in view of the user. This allows the author to exclude regions of the scrollport that are obscured by other content (such as fixed-positioned toolbars or sidebars) or simply to put more breathing room between a targeted element and the edges of the scrollport.
		*/
		'scroll-padding-top':css$prop$scroll_padding_top;
		/**
		Logical 'border-right-style'. Mapping depends on the parent element’s 'writing-mode', 'direction', and 'text-orientation'.
		*/
		'border-inline-end-style':css$prop$border_inline_end_style;
		/**
		Logical 'border-top-width'. Mapping depends on the parent element’s 'writing-mode', 'direction', and 'text-orientation'.
		*/
		'border-block-start-width':css$prop$border_block_start_width;
		/**
		Logical 'border-bottom-width'. Mapping depends on the parent element’s 'writing-mode', 'direction', and 'text-orientation'.
		*/
		'border-block-end-width':css$prop$border_block_end_width;
		/**
		Logical 'border-bottom-color'. Mapping depends on the parent element’s 'writing-mode', 'direction', and 'text-orientation'.
		*/
		'border-block-end-color':css$prop$border_block_end_color;
		/**
		Logical 'border-left-style'. Mapping depends on the parent element’s 'writing-mode', 'direction', and 'text-orientation'.
		*/
		'border-inline-start-style':css$prop$border_inline_start_style;
		/**
		Logical 'border-top-color'. Mapping depends on the parent element’s 'writing-mode', 'direction', and 'text-orientation'.
		*/
		'border-block-start-color':css$prop$border_block_start_color;
		/**
		Logical 'border-bottom-style'. Mapping depends on the parent element’s 'writing-mode', 'direction', and 'text-orientation'.
		*/
		'border-block-end-style':css$prop$border_block_end_style;
		/**
		Logical 'border-top-style'. Mapping depends on the parent element’s 'writing-mode', 'direction', and 'text-orientation'.
		*/
		'border-block-start-style':css$prop$border_block_start_style;
		/**
		The font-variation-settings CSS property provides low-level control over OpenType or TrueType font variations, by specifying the four letter axis names of the features you want to vary, along with their variation values.
		*/
		'font-variation-settings':css$prop$font_variation_settings;
		/**
		Controls the order that the three paint operations that shapes and text are rendered with: their fill, their stroke and any markers they might have.
		*/
		'paint-order':css$prop$paint_order;
		/**
		Specifies the color space for imaging operations performed via filter effects.
		*/
		'color-interpolation-filters':css$prop$color_interpolation_filters;
		/**
		Specifies the marker that will be drawn at the last vertices of the given markable element.
		*/
		'marker-end':css$prop$marker_end;
		/**
		The scroll-padding-left property defines offsets for the left of the optimal viewing region of the scrollport: the region used as the target region for placing things in view of the user. This allows the author to exclude regions of the scrollport that are obscured by other content (such as fixed-positioned toolbars or sidebars) or simply to put more breathing room between a targeted element and the edges of the scrollport.
		*/
		'scroll-padding-left':css$prop$scroll_padding_left;
		/**
		Indicates what color to use to flood the current filter primitive subregion.
		*/
		'flood-color':css$prop$flood_color;
		/**
		Indicates what opacity to use to flood the current filter primitive subregion.
		*/
		'flood-opacity':css$prop$flood_opacity;
		/**
		Defines the color of the light source for filter primitives 'feDiffuseLighting' and 'feSpecularLighting'.
		*/
		'lighting-color':css$prop$lighting_color;
		/**
		Specifies the marker that will be drawn at the first vertices of the given markable element.
		*/
		'marker-start':css$prop$marker_start;
		/**
		Specifies the marker that will be drawn at all vertices except the first and last.
		*/
		'marker-mid':css$prop$marker_mid;
		/**
		Specifies the marker symbol that shall be used for all points on the sets the value for all vertices on the given ‘path’ element or basic shape.
		*/
		marker:css$prop$marker;
		/**
		The place-content CSS shorthand property sets both the align-content and justify-content properties.
		*/
		'place-content':css$prop$place_content;
		/**
		The offset-path CSS property specifies the offset path where the element gets positioned. The exact element’s position on the offset path is determined by the offset-distance property. An offset path is either a specified path with one or multiple sub-paths or the geometry of a not-styled basic shape. Each shape or path must define an initial position for the computed value of "0" for offset-distance and an initial direction which specifies the rotation of the object to the initial position.

In this specification, a direction (or rotation) of 0 degrees is equivalent to the direction of the positive x-axis in the object’s local coordinate system. In other words, a rotation of 0 degree points to the right side of the UA if the object and its ancestors have no transformation applied.
		*/
		'offset-path':css$prop$offset_path;
		/**
		The offset-rotate CSS property defines the direction of the element while positioning along the offset path.
		*/
		'offset-rotate':css$prop$offset_rotate;
		/**
		The offset-distance CSS property specifies a position along an offset-path.
		*/
		'offset-distance':css$prop$offset_distance;
		/**
		The transform-box CSS property defines the layout box to which the transform and transform-origin properties relate.
		*/
		'transform-box':css$prop$transform_box;
		/**
		The CSS place-items shorthand property sets both the align-items and justify-items properties. The first value is the align-items property value, the second the justify-items one. If the second value is not present, the first value is also used for it.
		*/
		'place-items':css$prop$place_items;
		/**
		Logical 'max-height'. Mapping depends on the element’s 'writing-mode'.
		*/
		'max-inline-size':css$prop$max_inline_size;
		/**
		Logical 'max-width'. Mapping depends on the element’s 'writing-mode'.
		*/
		'max-block-size':css$prop$max_block_size;
		/**
		Used by the parent of elements with display: ruby-text to control the position of the ruby text with respect to its base.
		*/
		'ruby-position':css$prop$ruby_position;
		/**
		The scroll-padding-right property defines offsets for the right of the optimal viewing region of the scrollport: the region used as the target region for placing things in view of the user. This allows the author to exclude regions of the scrollport that are obscured by other content (such as fixed-positioned toolbars or sidebars) or simply to put more breathing room between a targeted element and the edges of the scrollport.
		*/
		'scroll-padding-right':css$prop$scroll_padding_right;
		/**
		The scroll-padding-bottom property defines offsets for the bottom of the optimal viewing region of the scrollport: the region used as the target region for placing things in view of the user. This allows the author to exclude regions of the scrollport that are obscured by other content (such as fixed-positioned toolbars or sidebars) or simply to put more breathing room between a targeted element and the edges of the scrollport.
		*/
		'scroll-padding-bottom':css$prop$scroll_padding_bottom;
		/**
		The scroll-padding-inline-start property defines offsets for the start edge in the inline dimension of the optimal viewing region of the scrollport: the region used as the target region for placing things in view of the user. This allows the author to exclude regions of the scrollport that are obscured by other content (such as fixed-positioned toolbars or sidebars) or simply to put more breathing room between a targeted element and the edges of the scrollport.
		*/
		'scroll-padding-inline-start':css$prop$scroll_padding_inline_start;
		/**
		The scroll-padding-block-start property defines offsets for the start edge in the block dimension of the optimal viewing region of the scrollport: the region used as the target region for placing things in view of the user. This allows the author to exclude regions of the scrollport that are obscured by other content (such as fixed-positioned toolbars or sidebars) or simply to put more breathing room between a targeted element and the edges of the scrollport.
		*/
		'scroll-padding-block-start':css$prop$scroll_padding_block_start;
		/**
		The scroll-padding-block-end property defines offsets for the end edge in the block dimension of the optimal viewing region of the scrollport: the region used as the target region for placing things in view of the user. This allows the author to exclude regions of the scrollport that are obscured by other content (such as fixed-positioned toolbars or sidebars) or simply to put more breathing room between a targeted element and the edges of the scrollport.
		*/
		'scroll-padding-block-end':css$prop$scroll_padding_block_end;
		/**
		The scroll-padding-inline-end property defines offsets for the end edge in the inline dimension of the optimal viewing region of the scrollport: the region used as the target region for placing things in view of the user. This allows the author to exclude regions of the scrollport that are obscured by other content (such as fixed-positioned toolbars or sidebars) or simply to put more breathing room between a targeted element and the edges of the scrollport.
		*/
		'scroll-padding-inline-end':css$prop$scroll_padding_inline_end;
		/**
		The place-self CSS property is a shorthand property sets both the align-self and justify-self properties. The first value is the align-self property value, the second the justify-self one. If the second value is not present, the first value is also used for it.
		*/
		'place-self':css$prop$place_self;
		/**
		The font-optical-sizing CSS property allows developers to control whether browsers render text with slightly differing visual representations to optimize viewing at different sizes, or not. This only works for fonts that have an optical size variation axis.
		*/
		'font-optical-sizing':css$prop$font_optical_sizing;
		/**
		The grid CSS property is a shorthand property that sets all of the explicit grid properties ('grid-template-rows', 'grid-template-columns', and 'grid-template-areas'), and all the implicit grid properties ('grid-auto-rows', 'grid-auto-columns', and 'grid-auto-flow'), in a single declaration.
		*/
		grid:css$prop$grid;
		/**
		Logical 'border-left'. Mapping depends on the parent element’s 'writing-mode', 'direction', and 'text-orientation'.
		*/
		'border-inline-start':css$prop$border_inline_start;
		/**
		Logical 'border-right'. Mapping depends on the parent element’s 'writing-mode', 'direction', and 'text-orientation'.
		*/
		'border-inline-end':css$prop$border_inline_end;
		/**
		Logical 'border-bottom'. Mapping depends on the parent element’s 'writing-mode', 'direction', and 'text-orientation'.
		*/
		'border-block-end':css$prop$border_block_end;
		/**
		The offset CSS property is a shorthand property for animating an element along a defined path.
		*/
		offset:css$prop$offset;
		/**
		Logical 'border-top'. Mapping depends on the parent element’s 'writing-mode', 'direction', and 'text-orientation'.
		*/
		'border-block-start':css$prop$border_block_start;
		/**
		The scroll-padding-block property is a shorthand property which sets the scroll-padding longhands for the block dimension.
		*/
		'scroll-padding-block':css$prop$scroll_padding_block;
		/**
		The scroll-padding-inline property is a shorthand property which sets the scroll-padding longhands for the inline dimension.
		*/
		'scroll-padding-inline':css$prop$scroll_padding_inline;
		/**
		The overscroll-behavior-block CSS property sets the browser's behavior when the block direction boundary of a scrolling area is reached.
		*/
		'overscroll-behavior-block':css$prop$overscroll_behavior_block;
		/**
		The overscroll-behavior-inline CSS property sets the browser's behavior when the inline direction boundary of a scrolling area is reached.
		*/
		'overscroll-behavior-inline':css$prop$overscroll_behavior_inline;
		/**
		Shorthand property for setting 'motion-path', 'motion-offset' and 'motion-rotation'.
		*/
		motion:css$prop$motion;
		/**
		Preserves the readability of text when font fallback occurs by adjusting the font-size so that the x-height is the same regardless of the font used.
		*/
		'font-size-adjust':css$prop$font_size_adjust;
		/**
		The inset CSS property defines the logical block and inline start and end offsets of an element, which map to physical offsets depending on the element's writing mode, directionality, and text orientation. It corresponds to the top and bottom, or right and left properties depending on the values defined for writing-mode, direction, and text-orientation.
		*/
		inset:css$prop$inset;
		/**
		Selects the justification algorithm used when 'text-align' is set to 'justify'. The property applies to block containers, but the UA may (but is not required to) also support it on inline elements.
		*/
		'text-justify':css$prop$text_justify;
		/**
		Specifies the motion path the element gets positioned at.
		*/
		'motion-path':css$prop$motion_path;
		/**
		The inset-inline-start CSS property defines the logical inline start inset of an element, which maps to a physical offset depending on the element's writing mode, directionality, and text orientation. It corresponds to the top, right, bottom, or left property depending on the values defined for writing-mode, direction, and text-orientation.
		*/
		'inset-inline-start':css$prop$inset_inline_start;
		/**
		The inset-inline-end CSS property defines the logical inline end inset of an element, which maps to a physical inset depending on the element's writing mode, directionality, and text orientation. It corresponds to the top, right, bottom, or left property depending on the values defined for writing-mode, direction, and text-orientation.
		*/
		'inset-inline-end':css$prop$inset_inline_end;
		/**
		The scale CSS property allows you to specify scale transforms individually and independently of the transform property. This maps better to typical user interface usage, and saves having to remember the exact order of transform functions to specify in the transform value.
		@alias scale
		*/
		scale:css$prop$scale;
		/** @proxy scale */
		scale:css$prop$scale;
		/**
		The rotate CSS property allows you to specify rotation transforms individually and independently of the transform property. This maps better to typical user interface usage, and saves having to remember the exact order of transform functions to specify in the transform value.
		@alias rotate
		*/
		rotate:css$prop$rotate;
		/** @proxy rotate */
		rotate:css$prop$rotate;
		/**
		The translate CSS property allows you to specify translation transforms individually and independently of the transform property. This maps better to typical user interface usage, and saves having to remember the exact order of transform functions to specify in the transform value.
		*/
		translate:css$prop$translate;
		/**
		Defines an anchor point of the box positioned along the path. The anchor point specifies the point of the box which is to be considered as the point that is moved along the path.
		*/
		'offset-anchor':css$prop$offset_anchor;
		/**
		Specifies the initial position of the offset path. If position is specified with static, offset-position would be ignored.
		*/
		'offset-position':css$prop$offset_position;
		/**
		The padding-block CSS property defines the logical block start and end padding of an element, which maps to physical padding properties depending on the element's writing mode, directionality, and text orientation.
		*/
		'padding-block':css$prop$padding_block;
		/**
		The orientation CSS @media media feature can be used to apply styles based on the orientation of the viewport (or the page box, for paged media).
		*/
		orientation:css$prop$orientation;
		/**
		The user-zoom CSS descriptor controls whether or not the user can change the zoom factor of a document defined by @viewport.
		*/
		'user-zoom':css$prop$user_zoom;
		/**
		The margin-block CSS property defines the logical block start and end margins of an element, which maps to physical margins depending on the element's writing mode, directionality, and text orientation.
		*/
		'margin-block':css$prop$margin_block;
		/**
		The margin-inline CSS property defines the logical inline start and end margins of an element, which maps to physical margins depending on the element's writing mode, directionality, and text orientation.
		*/
		'margin-inline':css$prop$margin_inline;
		/**
		The padding-inline CSS property defines the logical inline start and end padding of an element, which maps to physical padding properties depending on the element's writing mode, directionality, and text orientation.
		*/
		'padding-inline':css$prop$padding_inline;
		/**
		The inset-block CSS property defines the logical block start and end offsets of an element, which maps to physical offsets depending on the element's writing mode, directionality, and text orientation. It corresponds to the top and bottom, or right and left properties depending on the values defined for writing-mode, direction, and text-orientation.
		*/
		'inset-block':css$prop$inset_block;
		/**
		The inset-inline CSS property defines the logical block start and end offsets of an element, which maps to physical offsets depending on the element's writing mode, directionality, and text orientation. It corresponds to the top and bottom, or right and left properties depending on the values defined for writing-mode, direction, and text-orientation.
		*/
		'inset-inline':css$prop$inset_inline;
		/**
		The border-block-color CSS property defines the color of the logical block borders of an element, which maps to a physical border color depending on the element's writing mode, directionality, and text orientation. It corresponds to the border-top-color and border-bottom-color, or border-right-color and border-left-color property depending on the values defined for writing-mode, direction, and text-orientation.
		*/
		'border-block-color':css$prop$border_block_color;
		/**
		The border-block CSS property is a shorthand property for setting the individual logical block border property values in a single place in the style sheet.
		*/
		'border-block':css$prop$border_block;
		/**
		The border-inline CSS property is a shorthand property for setting the individual logical inline border property values in a single place in the style sheet.
		*/
		'border-inline':css$prop$border_inline;
		/**
		The inset-block-start CSS property defines the logical block start offset of an element, which maps to a physical offset depending on the element's writing mode, directionality, and text orientation. It corresponds to the top, right, bottom, or left property depending on the values defined for writing-mode, direction, and text-orientation.
		*/
		'inset-block-start':css$prop$inset_block_start;
		/**
		The inset-block-end CSS property defines the logical block end offset of an element, which maps to a physical offset depending on the element's writing mode, directionality, and text orientation. It corresponds to the top, right, bottom, or left property depending on the values defined for writing-mode, direction, and text-orientation.
		*/
		'inset-block-end':css$prop$inset_block_end;
		/**
		Deprecated. Use 'isolation' property instead when support allows. Specifies how the accumulation of the background image is managed.
		*/
		'enable-background':css$prop$enable_background;
		/**
		Controls glyph orientation when the inline-progression-direction is horizontal.
		*/
		'glyph-orientation-horizontal':css$prop$glyph_orientation_horizontal;
		/**
		Controls glyph orientation when the inline-progression-direction is vertical.
		*/
		'glyph-orientation-vertical':css$prop$glyph_orientation_vertical;
		/**
		Indicates whether the user agent should adjust inter-glyph spacing based on kerning tables that are included in the relevant font or instead disable auto-kerning and set inter-character spacing to a specific length.
		*/
		kerning:css$prop$kerning;
		/**
		The image-resolution property specifies the intrinsic resolution of all raster images used in or on the element. It affects both content images (e.g. replaced elements and generated content) and decorative images (such as background-image). The intrinsic resolution of an image is used to determine the image’s intrinsic dimensions.
		*/
		'image-resolution':css$prop$image_resolution;
		/**
		The max-zoom CSS descriptor sets the maximum zoom factor of a document defined by the @viewport at-rule. The browser will not zoom in any further than this, whether automatically or at the user's request.

A zoom factor of 1.0 or 100% corresponds to no zooming. Larger values are zoomed in. Smaller values are zoomed out.
		*/
		'max-zoom':css$prop$max_zoom;
		/**
		The min-zoom CSS descriptor sets the minimum zoom factor of a document defined by the @viewport at-rule. The browser will not zoom out any further than this, whether automatically or at the user's request.

A zoom factor of 1.0 or 100% corresponds to no zooming. Larger values are zoomed in. Smaller values are zoomed out.
		*/
		'min-zoom':css$prop$min_zoom;
		/**
		A distance that describes the position along the specified motion path.
		*/
		'motion-offset':css$prop$motion_offset;
		/**
		Defines the direction of the element while positioning along the motion path.
		*/
		'motion-rotation':css$prop$motion_rotation;
		/**
		Defines the positioning of snap points along the x axis of the scroll container it is applied to.
		*/
		'scroll-snap-points-x':css$prop$scroll_snap_points_x;
		/**
		Defines the positioning of snap points along the y axis of the scroll container it is applied to.
		*/
		'scroll-snap-points-y':css$prop$scroll_snap_points_y;
		/**
		Defines the x and y coordinate within the element which will align with the nearest ancestor scroll container’s snap-destination for the respective axis.
		*/
		'scroll-snap-coordinate':css$prop$scroll_snap_coordinate;
		/**
		Define the x and y coordinate within the scroll container’s visual viewport which element snap points will align with.
		*/
		'scroll-snap-destination':css$prop$scroll_snap_destination;
		/**
		The border-block-style CSS property defines the style of the logical block borders of an element, which maps to a physical border style depending on the element's writing mode, directionality, and text orientation.
		*/
		'viewport-fit':css$prop$viewport_fit;
		/**
		The border-block-style CSS property defines the style of the logical block borders of an element, which maps to a physical border style depending on the element's writing mode, directionality, and text orientation. It corresponds to the border-top-style and border-bottom-style, or border-left-style and border-right-style properties depending on the values defined for writing-mode, direction, and text-orientation.
		*/
		'border-block-style':css$prop$border_block_style;
		/**
		The border-block-width CSS property defines the width of the logical block borders of an element, which maps to a physical border width depending on the element's writing mode, directionality, and text orientation. It corresponds to the border-top-width and border-bottom-width, or border-left-width, and border-right-width property depending on the values defined for writing-mode, direction, and text-orientation.
		*/
		'border-block-width':css$prop$border_block_width;
		/**
		The border-inline-color CSS property defines the color of the logical inline borders of an element, which maps to a physical border color depending on the element's writing mode, directionality, and text orientation. It corresponds to the border-top-color and border-bottom-color, or border-right-color and border-left-color property depending on the values defined for writing-mode, direction, and text-orientation.
		*/
		'border-inline-color':css$prop$border_inline_color;
		/**
		The border-inline-style CSS property defines the style of the logical inline borders of an element, which maps to a physical border style depending on the element's writing mode, directionality, and text orientation. It corresponds to the border-top-style and border-bottom-style, or border-left-style and border-right-style properties depending on the values defined for writing-mode, direction, and text-orientation.
		*/
		'border-inline-style':css$prop$border_inline_style;
		/**
		The border-inline-width CSS property defines the width of the logical inline borders of an element, which maps to a physical border width depending on the element's writing mode, directionality, and text orientation. It corresponds to the border-top-width and border-bottom-width, or border-left-width, and border-right-width property depending on the values defined for writing-mode, direction, and text-orientation.
		*/
		'border-inline-width':css$prop$border_inline_width;
		/**
		The overflow-block CSS media feature can be used to test how the output device handles content that overflows the initial containing block along the block axis.
		*/
		'overflow-block':css$prop$overflow_block;
		/**
		@counter-style descriptor. Specifies the symbols used by the marker-construction algorithm specified by the system descriptor. Needs to be specified if the counter system is 'additive'.
		*/
		'additive-symbols':css$prop$additive_symbols;
		/**
		Provides alternative text for assistive technology to replace the generated content of a ::before or ::after element.
		*/
		alt:css$prop$alt;
		/**
		IE only. Used to extend behaviors of the browser.
		*/
		behavior:css$prop$behavior;
		/**
		Specifies whether individual boxes are treated as broken pieces of one continuous box, or whether each box is individually wrapped with the border and padding.
		*/
		'box-decoration-break':css$prop$box_decoration_break;
		/**
		@counter-style descriptor. Specifies a fallback counter style to be used when the current counter style can’t create a representation for a given counter value.
		*/
		fallback:css$prop$fallback;
		/**
		The value of 'normal' implies that when rendering with OpenType fonts the language of the document is used to infer the OpenType language system, used to select language specific features when rendering.
		*/
		'font-language-override':css$prop$font_language_override;
		/**
		Controls whether user agents are allowed to synthesize bold or oblique font faces when a font family lacks bold or italic faces.
		*/
		'font-synthesis':css$prop$font_synthesis;
		/**
		For any given character, fonts can provide a variety of alternate glyphs in addition to the default glyph for that character. This property provides control over the selection of these alternate glyphs.
		*/
		'font-variant-alternates':css$prop$font_variant_alternates;
		/**
		Specifies the vertical position
		*/
		'font-variant-position':css$prop$font_variant_position;
		/**
		Controls the state of the input method editor for text fields.
		*/
		'ime-mode':css$prop$ime_mode;
		/**
		Sets the mask layer image of an element.
		*/
		'mask-image':css$prop$mask_image;
		/**
		Indicates whether the mask layer image is treated as luminance mask or alpha mask.
		*/
		'mask-mode':css$prop$mask_mode;
		/**
		Specifies the mask positioning area.
		*/
		'mask-origin':css$prop$mask_origin;
		/**
		Specifies how mask layer images are positioned.
		*/
		'mask-position':css$prop$mask_position;
		/**
		Specifies how mask layer images are tiled after they have been sized and positioned.
		*/
		'mask-repeat':css$prop$mask_repeat;
		/**
		Specifies the size of the mask layer images.
		*/
		'mask-size':css$prop$mask_size;
		/**
		Provides an way to control directional focus navigation.
		*/
		'nav-down':css$prop$nav_down;
		/**
		Provides an input-method-neutral way of specifying the sequential navigation order (also known as 'tabbing order').
		*/
		'nav-index':css$prop$nav_index;
		/**
		Provides an way to control directional focus navigation.
		*/
		'nav-left':css$prop$nav_left;
		/**
		Provides an way to control directional focus navigation.
		*/
		'nav-right':css$prop$nav_right;
		/**
		Provides an way to control directional focus navigation.
		*/
		'nav-up':css$prop$nav_up;
		/**
		@counter-style descriptor. Defines how to alter the representation when the counter value is negative.
		*/
		negative:css$prop$negative;
		/**
		Logical 'bottom'. Mapping depends on the parent element’s 'writing-mode', 'direction', and 'text-orientation'.
		*/
		'offset-block-end':css$prop$offset_block_end;
		/**
		Logical 'top'. Mapping depends on the parent element’s 'writing-mode', 'direction', and 'text-orientation'.
		*/
		'offset-block-start':css$prop$offset_block_start;
		/**
		Logical 'right'. Mapping depends on the parent element’s 'writing-mode', 'direction', and 'text-orientation'.
		*/
		'offset-inline-end':css$prop$offset_inline_end;
		/**
		Logical 'left'. Mapping depends on the parent element’s 'writing-mode', 'direction', and 'text-orientation'.
		*/
		'offset-inline-start':css$prop$offset_inline_start;
		/**
		@counter-style descriptor. Specifies a “fixed-width” counter style, where representations shorter than the pad value are padded with a particular <symbol>
		*/
		pad:css$prop$pad;
		/**
		@counter-style descriptor. Specifies a <symbol> that is prepended to the marker representation.
		*/
		prefix:css$prop$prefix;
		/**
		@counter-style descriptor. Defines the ranges over which the counter style is defined.
		*/
		range:css$prop$range;
		/**
		Specifies how text is distributed within the various ruby boxes when their contents do not exactly fill their respective boxes.
		*/
		'ruby-align':css$prop$ruby_align;
		/**
		Determines whether, and on which side, ruby text is allowed to partially overhang any adjacent text in addition to its own base, when the ruby text is wider than the ruby base.
		*/
		'ruby-overhang':css$prop$ruby_overhang;
		/**
		Determines whether, and on which side, ruby text is allowed to partially overhang any adjacent text in addition to its own base, when the ruby text is wider than the ruby base.
		*/
		'ruby-span':css$prop$ruby_span;
		/**
		Determines the color of the top and left edges of the scroll box and scroll arrows of a scroll bar.
		*/
		'scrollbar-3dlight-color':css$prop$scrollbar_3dlight_color;
		/**
		Determines the color of the arrow elements of a scroll arrow.
		*/
		'scrollbar-arrow-color':css$prop$scrollbar_arrow_color;
		/**
		Determines the color of the main elements of a scroll bar, which include the scroll box, track, and scroll arrows.
		*/
		'scrollbar-base-color':css$prop$scrollbar_base_color;
		/**
		Determines the color of the gutter of a scroll bar.
		*/
		'scrollbar-darkshadow-color':css$prop$scrollbar_darkshadow_color;
		/**
		Determines the color of the scroll box and scroll arrows of a scroll bar.
		*/
		'scrollbar-face-color':css$prop$scrollbar_face_color;
		/**
		Determines the color of the top and left edges of the scroll box and scroll arrows of a scroll bar.
		*/
		'scrollbar-highlight-color':css$prop$scrollbar_highlight_color;
		/**
		Determines the color of the bottom and right edges of the scroll box and scroll arrows of a scroll bar.
		*/
		'scrollbar-shadow-color':css$prop$scrollbar_shadow_color;
		/**
		Determines the color of the track element of a scroll bar.
		*/
		'scrollbar-track-color':css$prop$scrollbar_track_color;
		/**
		@counter-style descriptor. Specifies a <symbol> that is appended to the marker representation.
		*/
		suffix:css$prop$suffix;
		/**
		@counter-style descriptor. Specifies which algorithm will be used to construct the counter’s representation based on the counter value.
		*/
		system:css$prop$system;
		/**
		@counter-style descriptor. Specifies the symbols used by the marker-construction algorithm specified by the system descriptor.
		*/
		symbols:css$prop$symbols;
		/**
		The aspect-ratio   CSS property sets a preferred aspect ratio for the box, which will be used in the calculation of auto sizes and some other layout functions.
		*/
		'aspect-ratio':css$prop$aspect_ratio;
		/**
		In combination with elevation, the azimuth CSS property enables different audio sources to be positioned spatially for aural presentation. This is important in that it provides a natural way to tell several voices apart, as each can be positioned to originate at a different location on the sound stage. Stereo output produce a lateral sound stage, while binaural headphones and multi-speaker setups allow for a fully three-dimensional stage.
		*/
		azimuth:css$prop$azimuth;
		/**
		The border-end-end-radius CSS property defines a logical border radius on an element, which maps to a physical border radius that depends on on the element's writing-mode, direction, and text-orientation.
		*/
		'border-end-end-radius':css$prop$border_end_end_radius;
		/**
		The border-end-start-radius CSS property defines a logical border radius on an element, which maps to a physical border radius depending on the element's writing-mode, direction, and text-orientation.
		*/
		'border-end-start-radius':css$prop$border_end_start_radius;
		/**
		The border-start-end-radius CSS property defines a logical border radius on an element, which maps to a physical border radius depending on the element's writing-mode, direction, and text-orientation.
		*/
		'border-start-end-radius':css$prop$border_start_end_radius;
		/**
		The border-start-start-radius CSS property defines a logical border radius on an element, which maps to a physical border radius that depends on the element's writing-mode, direction, and text-orientation.
		*/
		'border-start-start-radius':css$prop$border_start_start_radius;
		/**
		The box-ordinal-group CSS property assigns the flexbox's child elements to an ordinal group.
		*/
		'box-ordinal-group':css$prop$box_ordinal_group;
		/**
		The color-adjust property is a non-standard CSS extension that can be used to force printing of background colors and images in browsers based on the WebKit engine.
		*/
		'color-adjust':css$prop$color_adjust;
		/**
		The counter-set CSS property sets a CSS counter to a given value. It manipulates the value of existing counters, and will only create new counters if there isn't already a counter of the given name on the element.
		*/
		'counter-set':css$prop$counter_set;
		/**
		The hanging-punctuation CSS property specifies whether a punctuation mark should hang at the start or end of a line of text. Hanging punctuation may be placed outside the line box.
		*/
		'hanging-punctuation':css$prop$hanging_punctuation;
		/**
		The initial-letter CSS property specifies styling for dropped, raised, and sunken initial letters.
		*/
		'initial-letter':css$prop$initial_letter;
		/**
		The initial-letter-align CSS property specifies the alignment of initial letters within a paragraph.
		*/
		'initial-letter-align':css$prop$initial_letter_align;
		/**
		The line-clamp property allows limiting the contents of a block container to the specified number of lines; remaining content is fragmented away and neither rendered nor measured. Optionally, it also allows inserting content into the last line box to indicate the continuity of truncated/interrupted content.
		*/
		'line-clamp':css$prop$line_clamp;
		/**
		The line-height-step CSS property defines the step units for line box heights. When the step unit is positive, line box heights are rounded up to the closest multiple of the unit. Negative values are invalid.
		*/
		'line-height-step':css$prop$line_height_step;
		/**
		The margin-trim property allows the container to trim the margins of its children where they adjoin the container’s edges.
		*/
		'margin-trim':css$prop$margin_trim;
		/**
		The mask-border CSS property lets you create a mask along the edge of an element's border.

This property is a shorthand for mask-border-source, mask-border-slice, mask-border-width, mask-border-outset, mask-border-repeat, and mask-border-mode. As with all shorthand properties, any omitted sub-values will be set to their initial value.
		*/
		'mask-border':css$prop$mask_border;
		/**
		The mask-border-mode CSS property specifies the blending mode used in a mask border.
		*/
		'mask-border-mode':css$prop$mask_border_mode;
		/**
		The mask-border-outset CSS property specifies the distance by which an element's mask border is set out from its border box.
		*/
		'mask-border-outset':css$prop$mask_border_outset;
		/**
		The mask-border-repeat CSS property defines how the edge regions of a source image are adjusted to fit the dimensions of an element's mask border.
		*/
		'mask-border-repeat':css$prop$mask_border_repeat;
		/**
		The mask-border-slice CSS property divides the image specified by mask-border-source into regions. These regions are used to form the components of an element's mask border.
		*/
		'mask-border-slice':css$prop$mask_border_slice;
		/**
		The mask-border-source CSS property specifies the source image used to create an element's mask border.

The mask-border-slice property is used to divide the source image into regions, which are then dynamically applied to the final mask border.
		*/
		'mask-border-source':css$prop$mask_border_source;
		/**
		The mask-border-width CSS property specifies the width of an element's mask border.
		*/
		'mask-border-width':css$prop$mask_border_width;
		/**
		The mask-clip CSS property determines the area, which is affected by a mask. The painted content of an element must be restricted to this area.
		*/
		'mask-clip':css$prop$mask_clip;
		/**
		The mask-composite CSS property represents a compositing operation used on the current mask layer with the mask layers below it.
		*/
		'mask-composite':css$prop$mask_composite;
		/**
		The max-liens property forces a break after a set number of lines
		*/
		'max-lines':css$prop$max_lines;
		/**
		The overflow-clip-box CSS property specifies relative to which box the clipping happens when there is an overflow. It is short hand for the overflow-clip-box-inline and overflow-clip-box-block properties.
		*/
		'overflow-clip-box':css$prop$overflow_clip_box;
		/**
		The overflow-inline CSS media feature can be used to test how the output device handles content that overflows the initial containing block along the inline axis.
		*/
		'overflow-inline':css$prop$overflow_inline;
		/**
		The overscroll-behavior CSS property is shorthand for the overscroll-behavior-x and overscroll-behavior-y properties, which allow you to control the browser's scroll overflow behavior — what happens when the boundary of a scrolling area is reached.
		*/
		'overscroll-behavior':css$prop$overscroll_behavior;
		/**
		The overscroll-behavior-x CSS property is allows you to control the browser's scroll overflow behavior — what happens when the boundary of a scrolling area is reached — in the x axis direction.
		*/
		'overscroll-behavior-x':css$prop$overscroll_behavior_x;
		/**
		The overscroll-behavior-y CSS property is allows you to control the browser's scroll overflow behavior — what happens when the boundary of a scrolling area is reached — in the y axis direction.
		*/
		'overscroll-behavior-y':css$prop$overscroll_behavior_y;
		/**
		This property controls how ruby annotation boxes should be rendered when there are more than one in a ruby container box: whether each pair should be kept separate, the annotations should be collapsed and rendered as a group, or the separation should be determined based on the space available.
		*/
		'ruby-merge':css$prop$ruby_merge;
		/**
		The scrollbar-color CSS property sets the color of the scrollbar track and thumb.
		*/
		'scrollbar-color':css$prop$scrollbar_color;
		/**
		The scrollbar-width property allows the author to set the maximum thickness of an element’s scrollbars when they are shown. 
		*/
		'scrollbar-width':css$prop$scrollbar_width;
		/**
		The scroll-margin property is a shorthand property which sets all of the scroll-margin longhands, assigning values much like the margin property does for the margin-* longhands.
		*/
		'scroll-margin':css$prop$scroll_margin;
		/**
		The scroll-margin-block property is a shorthand property which sets the scroll-margin longhands in the block dimension.
		*/
		'scroll-margin-block':css$prop$scroll_margin_block;
		/**
		The scroll-margin-block-start property defines the margin of the scroll snap area at the start of the block dimension that is used for snapping this box to the snapport. The scroll snap area is determined by taking the transformed border box, finding its rectangular bounding box (axis-aligned in the scroll container’s coordinate space), then adding the specified outsets.
		*/
		'scroll-margin-block-start':css$prop$scroll_margin_block_start;
		/**
		The scroll-margin-block-end property defines the margin of the scroll snap area at the end of the block dimension that is used for snapping this box to the snapport. The scroll snap area is determined by taking the transformed border box, finding its rectangular bounding box (axis-aligned in the scroll container’s coordinate space), then adding the specified outsets.
		*/
		'scroll-margin-block-end':css$prop$scroll_margin_block_end;
		/**
		The scroll-margin-bottom property defines the bottom margin of the scroll snap area that is used for snapping this box to the snapport. The scroll snap area is determined by taking the transformed border box, finding its rectangular bounding box (axis-aligned in the scroll container’s coordinate space), then adding the specified outsets.
		*/
		'scroll-margin-bottom':css$prop$scroll_margin_bottom;
		/**
		The scroll-margin-inline property is a shorthand property which sets the scroll-margin longhands in the inline dimension.
		*/
		'scroll-margin-inline':css$prop$scroll_margin_inline;
		/**
		The scroll-margin-inline-start property defines the margin of the scroll snap area at the start of the inline dimension that is used for snapping this box to the snapport. The scroll snap area is determined by taking the transformed border box, finding its rectangular bounding box (axis-aligned in the scroll container’s coordinate space), then adding the specified outsets.
		*/
		'scroll-margin-inline-start':css$prop$scroll_margin_inline_start;
		/**
		The scroll-margin-inline-end property defines the margin of the scroll snap area at the end of the inline dimension that is used for snapping this box to the snapport. The scroll snap area is determined by taking the transformed border box, finding its rectangular bounding box (axis-aligned in the scroll container’s coordinate space), then adding the specified outsets.
		*/
		'scroll-margin-inline-end':css$prop$scroll_margin_inline_end;
		/**
		The scroll-margin-left property defines the left margin of the scroll snap area that is used for snapping this box to the snapport. The scroll snap area is determined by taking the transformed border box, finding its rectangular bounding box (axis-aligned in the scroll container’s coordinate space), then adding the specified outsets.
		*/
		'scroll-margin-left':css$prop$scroll_margin_left;
		/**
		The scroll-margin-right property defines the right margin of the scroll snap area that is used for snapping this box to the snapport. The scroll snap area is determined by taking the transformed border box, finding its rectangular bounding box (axis-aligned in the scroll container’s coordinate space), then adding the specified outsets.
		*/
		'scroll-margin-right':css$prop$scroll_margin_right;
		/**
		The scroll-margin-top property defines the top margin of the scroll snap area that is used for snapping this box to the snapport. The scroll snap area is determined by taking the transformed border box, finding its rectangular bounding box (axis-aligned in the scroll container’s coordinate space), then adding the specified outsets.
		*/
		'scroll-margin-top':css$prop$scroll_margin_top;
		/**
		The scroll-snap-type-x CSS property defines how strictly snap points are enforced on the horizontal axis of the scroll container in case there is one.

Specifying any precise animations or physics used to enforce those snap points is not covered by this property but instead left up to the user agent.
		*/
		'scroll-snap-type-x':css$prop$scroll_snap_type_x;
		/**
		The scroll-snap-type-y CSS property defines how strictly snap points are enforced on the vertical axis of the scroll container in case there is one.

Specifying any precise animations or physics used to enforce those snap points is not covered by this property but instead left up to the user agent.
		*/
		'scroll-snap-type-y':css$prop$scroll_snap_type_y;
		/**
		The text-decoration-thickness CSS property sets the thickness, or width, of the decoration line that is used on text in an element, such as a line-through, underline, or overline.
		@alias tdt
		*/
		'text-decoration-thickness':css$prop$text_decoration_thickness;
		/** @proxy text-decoration-thickness */
		tdt:css$prop$text_decoration_thickness;
		/**
		The text-emphasis CSS property is a shorthand property for setting text-emphasis-style and text-emphasis-color in one declaration. This property will apply the specified emphasis mark to each character of the element's text, except separator characters, like spaces,  and control characters.
		@alias te
		*/
		'text-emphasis':css$prop$text_emphasis;
		/** @proxy text-emphasis */
		te:css$prop$text_emphasis;
		/**
		The text-emphasis-color CSS property defines the color used to draw emphasis marks on text being rendered in the HTML document. This value can also be set and reset using the text-emphasis shorthand.
		@alias tec
		*/
		'text-emphasis-color':css$prop$text_emphasis_color;
		/** @proxy text-emphasis-color */
		tec:css$prop$text_emphasis_color;
		/**
		The text-emphasis-position CSS property describes where emphasis marks are drawn at. The effect of emphasis marks on the line height is the same as for ruby text: if there isn't enough place, the line height is increased.
		@alias tep
		*/
		'text-emphasis-position':css$prop$text_emphasis_position;
		/** @proxy text-emphasis-position */
		tep:css$prop$text_emphasis_position;
		/**
		The text-emphasis-style CSS property defines the type of emphasis used. It can also be set, and reset, using the text-emphasis shorthand.
		@alias tes
		*/
		'text-emphasis-style':css$prop$text_emphasis_style;
		/** @proxy text-emphasis-style */
		tes:css$prop$text_emphasis_style;
		/**
		The text-underline-offset CSS property sets the offset distance of an underline text decoration line (applied using text-decoration) from its original position.
		*/
		'text-underline-offset':css$prop$text_underline_offset;
		/**
		The speak-as descriptor specifies how a counter symbol constructed with a given @counter-style will be represented in the spoken form. For example, an author can specify a counter symbol to be either spoken as its numerical value or just represented with an audio cue.
		*/
		'speak-as':css$prop$speak_as;
		/**
		The bleed CSS at-rule descriptor, used with the @page at-rule, specifies the extent of the page bleed area outside the page box. This property only has effect if crop marks are enabled using the marks property.
		*/
		bleed:css$prop$bleed;
		/**
		The marks CSS at-rule descriptor, used with the @page at-rule, adds crop and/or cross marks to the presentation of the document. Crop marks indicate where the page should be cut. Cross marks are used to align sheets.
		*/
		marks:css$prop$marks;
	}

}

