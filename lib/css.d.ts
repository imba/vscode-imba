declare module "imba_css" {
	interface width {
		/** The width depends on the values of other properties. */
		'auto': width

		/** Use the fit-content inline size or fit-content block size, as appropriate to the writing mode. */
		'fit-content': width

		/** Use the max-content inline size or max-content block size, as appropriate to the writing mode. */
		'max-content': width

		/** Use the min-content inline size or min-content block size, as appropriate to the writing mode. */
		'min-content': width

	}

	interface height {
		/** The height depends on the values of other properties. */
		'auto': height

		/** Use the fit-content inline size or fit-content block size, as appropriate to the writing mode. */
		'fit-content': height

		/** Use the max-content inline size or max-content block size, as appropriate to the writing mode. */
		'max-content': height

		/** Use the min-content inline size or min-content block size, as appropriate to the writing mode. */
		'min-content': height

	}

	interface display {
		/** The element generates a block-level box */
		'block': display

		/** The element itself does not generate any boxes, but its children and pseudo-elements still generate boxes as normal. */
		'contents': display

		/** The element generates a principal flex container box and establishes a flex formatting context. */
		'flex': display

		/** Flex with flex-direction set to row */
		'hflex': display

		/** Flex with flex-direction set to column */
		'vflex': display

		/** The element generates a block container box, and lays out its contents using flow layout. */
		'flow-root': display

		/** The element generates a principal grid container box, and establishes a grid formatting context. */
		'grid': display

		/** Grid with grid-auto-flow set to column */
		'hgrid': display

		/** Grid with grid-auto-flow set to row */
		'vgrid': display

		/** The element generates an inline-level box. */
		'inline': display

		/** A block box, which itself is flowed as a single inline box, similar to a replaced element. The inside of an inline-block is formatted as a block box, and the box itself is formatted as an inline box. */
		'inline-block': display

		/** Inline-level flex container. */
		'inline-flex': display

		/** Inline-level table wrapper box containing table box. */
		'inline-table': display

		/** One or more block boxes and one marker box. */
		'list-item': display

		/** The element lays out its contents using flow layout (block-and-inline layout). Standardized as 'flex'. */
		'-moz-box': display

		'-moz-deck': display

		'-moz-grid': display

		'-moz-grid-group': display

		'-moz-grid-line': display

		'-moz-groupbox': display

		/** Inline-level flex container. Standardized as 'inline-flex' */
		'-moz-inline-box': display

		'-moz-inline-grid': display

		'-moz-inline-stack': display

		'-moz-marker': display

		'-moz-popup': display

		'-moz-stack': display

		/** The element lays out its contents using flow layout (block-and-inline layout). Standardized as 'flex'. */
		'-ms-flexbox': display

		/** The element generates a principal grid container box, and establishes a grid formatting context. */
		'-ms-grid': display

		/** Inline-level flex container. Standardized as 'inline-flex' */
		'-ms-inline-flexbox': display

		/** Inline-level grid container. */
		'-ms-inline-grid': display

		/** The element and its descendants generates no boxes. */
		'none': display

		/** The element generates a principal ruby container box, and establishes a ruby formatting context. */
		'ruby': display

		'ruby-base': display

		'ruby-base-container': display

		'ruby-text': display

		'ruby-text-container': display

		/** The element generates a run-in box. Run-in elements act like inlines or blocks, depending on the surrounding elements. */
		'run-in': display

		/** The element generates a principal table wrapper box containing an additionally-generated table box, and establishes a table formatting context. */
		'table': display

		'table-caption': display

		'table-cell': display

		'table-column': display

		'table-column-group': display

		'table-footer-group': display

		'table-header-group': display

		'table-row': display

		'table-row-group': display

		/** The element lays out its contents using flow layout (block-and-inline layout). Standardized as 'flex'. */
		'-webkit-box': display

		/** The element lays out its contents using flow layout (block-and-inline layout). */
		'-webkit-flex': display

		/** Inline-level flex container. Standardized as 'inline-flex' */
		'-webkit-inline-box': display

		/** Inline-level flex container. */
		'-webkit-inline-flex': display

	}

	interface padding {
	}

	interface position {
		/** The box's position (and possibly size) is specified with the 'top', 'right', 'bottom', and 'left' properties. These properties specify offsets with respect to the box's 'containing block'. */
		'absolute': position

		/** The box's position is calculated according to the 'absolute' model, but in addition, the box is fixed with respect to some reference. As with the 'absolute' model, the box's margins do not collapse with any other margins. */
		'fixed': position

		/** The box's position is calculated according to the 'absolute' model. */
		'-ms-page': position

		/** The box's position is calculated according to the normal flow (this is called the position in normal flow). Then the box is offset relative to its normal position. */
		'relative': position

		/** The box is a normal box, laid out according to the normal flow. The 'top', 'right', 'bottom', and 'left' properties do not apply. */
		'static': position

		/** The box's position is calculated according to the normal flow. Then the box is offset relative to its flow root and containing block and in all cases, including table elements, does not affect the position of any following boxes. */
		'sticky': position

		/** The box's position is calculated according to the normal flow. Then the box is offset relative to its flow root and containing block and in all cases, including table elements, does not affect the position of any following boxes. */
		'-webkit-sticky': position

	}

	interface border {
	}

	interface margin {
		'auto': margin

	}

	interface svg {
	}

	interface top {
		/** For non-replaced elements, the effect of this value depends on which of related properties have the value 'auto' as well */
		'auto': top

	}

	interface left {
		/** For non-replaced elements, the effect of this value depends on which of related properties have the value 'auto' as well */
		'auto': left

	}

	interface margin_top {
		'auto': margin_top

	}

	interface color {
	}

	interface font_size {
		'large': font_size

		'larger': font_size

		'medium': font_size

		'small': font_size

		'smaller': font_size

		'x-large': font_size

		'x-small': font_size

		'xx-large': font_size

		'xx-small': font_size

	}

	interface background_color {
	}

	interface text_align {
		/** The inline contents are centered within the line box. */
		'center': text_align

		/** The inline contents are aligned to the end edge of the line box. */
		'end': text_align

		/** The text is justified according to the method specified by the 'text-justify' property. */
		'justify': text_align

		/** The inline contents are aligned to the left edge of the line box. In vertical text, 'left' aligns to the edge of the line box that would be the start edge for left-to-right text. */
		'left': text_align

		/** The inline contents are aligned to the right edge of the line box. In vertical text, 'right' aligns to the edge of the line box that would be the end edge for left-to-right text. */
		'right': text_align

		/** The inline contents are aligned to the start edge of the line box. */
		'start': text_align

	}

	interface opacity {
	}

	interface background {
		/** The background is fixed with regard to the viewport. In paged media where there is no viewport, a 'fixed' background is fixed with respect to the page box and therefore replicated on every page. */
		'fixed': background

		/** The background is fixed with regard to the element's contents: if the element has a scrolling mechanism, the background scrolls with the element's contents. */
		'local': background

		/** A value of 'none' counts as an image layer but draws nothing. */
		'none': background

		/** The background is fixed with regard to the element itself and does not scroll with its contents. (It is effectively attached to the element's border.) */
		'scroll': background

	}

	interface font_weight {
		/** Thin */
		'100': font_weight

		/** Extra Light (Ultra Light) */
		'200': font_weight

		/** Light */
		'300': font_weight

		/** Normal */
		'400': font_weight

		/** Medium */
		'500': font_weight

		/** Semi Bold (Demi Bold) */
		'600': font_weight

		/** Bold */
		'700': font_weight

		/** Extra Bold (Ultra Bold) */
		'800': font_weight

		/** Black (Heavy) */
		'900': font_weight

		/** Same as 700 */
		'bold': font_weight

		/** Specifies the weight of the face bolder than the inherited value. */
		'bolder': font_weight

		/** Specifies the weight of the face lighter than the inherited value. */
		'lighter': font_weight

		/** Same as 400 */
		'normal': font_weight

	}

	interface overflow {
		/** The behavior of the 'auto' value is UA-dependent, but should cause a scrolling mechanism to be provided for overflowing boxes. */
		'auto': overflow

		/** Content is clipped and no scrolling mechanism should be provided to view the content outside the clipping region. */
		'hidden': overflow

		/** Same as the standardized 'clip', except doesn’t establish a block formatting context. */
		'-moz-hidden-unscrollable': overflow

		/** Content is clipped and if the user agent uses a scrolling mechanism that is visible on the screen (such as a scroll bar or a panner), that mechanism should be displayed for a box whether or not any of its content is clipped. */
		'scroll': overflow

		/** Content is not clipped, i.e., it may be rendered outside the content box. */
		'visible': overflow

	}

	interface font_family {
		'cursive': font_family

		'fantasy': font_family

		'monospace': font_family

		'sans-serif': font_family

		'serif': font_family

	}

	interface float {
		/** A keyword indicating that the element must float on the end side of its containing block. That is the right side with ltr scripts, and the left side with rtl scripts. */
		'inline-end': float

		/** A keyword indicating that the element must float on the start side of its containing block. That is the left side with ltr scripts, and the right side with rtl scripts. */
		'inline-start': float

		/** The element generates a block box that is floated to the left. Content flows on the right side of the box, starting at the top (subject to the 'clear' property). */
		'left': float

		/** The box is not floated. */
		'none': float

		/** Similar to 'left', except the box is floated to the right, and content flows on the left side of the box, starting at the top. */
		'right': float

	}

	interface line_height {
		/** Tells user agents to set the computed value to a 'reasonable' value based on the font size of the element. */
		'normal': line_height

	}

	interface box_sizing {
		/** The specified width and height (and respective min/max properties) on this element determine the border box of the element. */
		'border-box': box_sizing

		/** Behavior of width and height as specified by CSS2.1. The specified width and height (and respective min/max properties) apply to the width and height respectively of the content box of the element. */
		'content-box': box_sizing

	}

	interface text_decoration {
		/** Produces a dashed line style. */
		'dashed': text_decoration

		/** Produces a dotted line. */
		'dotted': text_decoration

		/** Produces a double line. */
		'double': text_decoration

		/** Each line of text has a line through the middle. */
		'line-through': text_decoration

		/** Produces no line. */
		'none': text_decoration

		/** Each line of text has a line above it. */
		'overline': text_decoration

		/** Produces a solid line. */
		'solid': text_decoration

		/** Each line of text is underlined. */
		'underline': text_decoration

		/** Produces a wavy line. */
		'wavy': text_decoration

	}

	interface z_index {
		/** The stack level of the generated box in the current stacking context is 0. The box does not establish a new stacking context unless it is the root element. */
		'auto': z_index

	}

	interface vertical_align {
		/** Align the dominant baseline of the parent box with the equivalent, or heuristically reconstructed, baseline of the element inline box. */
		'auto': vertical_align

		/** Align the 'alphabetic' baseline of the element with the 'alphabetic' baseline of the parent element. */
		'baseline': vertical_align

		/** Align the after edge of the extended inline box with the after-edge of the line box. */
		'bottom': vertical_align

		/** Align the 'middle' baseline of the inline element with the middle baseline of the parent. */
		'middle': vertical_align

		/** Lower the baseline of the box to the proper position for subscripts of the parent's box. (This value has no effect on the font size of the element's text.) */
		'sub': vertical_align

		/** Raise the baseline of the box to the proper position for superscripts of the parent's box. (This value has no effect on the font size of the element's text.) */
		'super': vertical_align

		/** Align the bottom of the box with the after-edge of the parent element's font. */
		'text-bottom': vertical_align

		/** Align the top of the box with the before-edge of the parent element's font. */
		'text-top': vertical_align

		/** Align the before edge of the extended inline box with the before-edge of the line box. */
		'top': vertical_align

		'-webkit-baseline-middle': vertical_align

	}

	interface cursor {
		/** Indicates an alias of/shortcut to something is to be created. Often rendered as an arrow with a small curved arrow next to it. */
		'alias': cursor

		/** Indicates that the something can be scrolled in any direction. Often rendered as arrows pointing up, down, left, and right with a dot in the middle. */
		'all-scroll': cursor

		/** The UA determines the cursor to display based on the current context. */
		'auto': cursor

		/** Indicates that a cell or set of cells may be selected. Often rendered as a thick plus-sign with a dot in the middle. */
		'cell': cursor

		/** Indicates that the item/column can be resized horizontally. Often rendered as arrows pointing left and right with a vertical bar separating them. */
		'col-resize': cursor

		/** A context menu is available for the object under the cursor. Often rendered as an arrow with a small menu-like graphic next to it. */
		'context-menu': cursor

		/** Indicates something is to be copied. Often rendered as an arrow with a small plus sign next to it. */
		'copy': cursor

		/** A simple crosshair (e.g., short line segments resembling a '+' sign). Often used to indicate a two dimensional bitmap selection mode. */
		'crosshair': cursor

		/** The platform-dependent default cursor. Often rendered as an arrow. */
		'default': cursor

		/** Indicates that east edge is to be moved. */
		'e-resize': cursor

		/** Indicates a bidirectional east-west resize cursor. */
		'ew-resize': cursor

		/** Indicates that something can be grabbed. */
		'grab': cursor

		/** Indicates that something is being grabbed. */
		'grabbing': cursor

		/** Help is available for the object under the cursor. Often rendered as a question mark or a balloon. */
		'help': cursor

		/** Indicates something is to be moved. */
		'move': cursor

		/** Indicates that something can be grabbed. */
		'-moz-grab': cursor

		/** Indicates that something is being grabbed. */
		'-moz-grabbing': cursor

		/** Indicates that something can be zoomed (magnified) in. */
		'-moz-zoom-in': cursor

		/** Indicates that something can be zoomed (magnified) out. */
		'-moz-zoom-out': cursor

		/** Indicates that movement starts from north-east corner. */
		'ne-resize': cursor

		/** Indicates a bidirectional north-east/south-west cursor. */
		'nesw-resize': cursor

		/** Indicates that the dragged item cannot be dropped at the current cursor location. Often rendered as a hand or pointer with a small circle with a line through it. */
		'no-drop': cursor

		/** No cursor is rendered for the element. */
		'none': cursor

		/** Indicates that the requested action will not be carried out. Often rendered as a circle with a line through it. */
		'not-allowed': cursor

		/** Indicates that north edge is to be moved. */
		'n-resize': cursor

		/** Indicates a bidirectional north-south cursor. */
		'ns-resize': cursor

		/** Indicates that movement starts from north-west corner. */
		'nw-resize': cursor

		/** Indicates a bidirectional north-west/south-east cursor. */
		'nwse-resize': cursor

		/** The cursor is a pointer that indicates a link. */
		'pointer': cursor

		/** A progress indicator. The program is performing some processing, but is different from 'wait' in that the user may still interact with the program. Often rendered as a spinning beach ball, or an arrow with a watch or hourglass. */
		'progress': cursor

		/** Indicates that the item/row can be resized vertically. Often rendered as arrows pointing up and down with a horizontal bar separating them. */
		'row-resize': cursor

		/** Indicates that movement starts from south-east corner. */
		'se-resize': cursor

		/** Indicates that south edge is to be moved. */
		's-resize': cursor

		/** Indicates that movement starts from south-west corner. */
		'sw-resize': cursor

		/** Indicates text that may be selected. Often rendered as a vertical I-beam. */
		'text': cursor

		/** Indicates vertical-text that may be selected. Often rendered as a horizontal I-beam. */
		'vertical-text': cursor

		/** Indicates that the program is busy and the user should wait. Often rendered as a watch or hourglass. */
		'wait': cursor

		/** Indicates that something can be grabbed. */
		'-webkit-grab': cursor

		/** Indicates that something is being grabbed. */
		'-webkit-grabbing': cursor

		/** Indicates that something can be zoomed (magnified) in. */
		'-webkit-zoom-in': cursor

		/** Indicates that something can be zoomed (magnified) out. */
		'-webkit-zoom-out': cursor

		/** Indicates that west edge is to be moved. */
		'w-resize': cursor

		/** Indicates that something can be zoomed (magnified) in. */
		'zoom-in': cursor

		/** Indicates that something can be zoomed (magnified) out. */
		'zoom-out': cursor

	}

	interface margin_left {
		'auto': margin_left

	}

	interface border_radius {
	}

	interface margin_bottom {
		'auto': margin_bottom

	}

	interface margin_right {
		'auto': margin_right

	}

	interface right {
		/** For non-replaced elements, the effect of this value depends on which of related properties have the value 'auto' as well */
		'auto': right

	}

	interface padding_left {
	}

	interface padding_top {
	}

	interface max_width {
		/** No limit on the width of the box. */
		'none': max_width

		/** Use the fit-content inline size or fit-content block size, as appropriate to the writing mode. */
		'fit-content': max_width

		/** Use the max-content inline size or max-content block size, as appropriate to the writing mode. */
		'max-content': max_width

		/** Use the min-content inline size or min-content block size, as appropriate to the writing mode. */
		'min-content': max_width

	}

	interface bottom {
		/** For non-replaced elements, the effect of this value depends on which of related properties have the value 'auto' as well */
		'auto': bottom

	}

	interface content {
		/** The attr(n) function returns as a string the value of attribute n for the subject of the selector. */
		'attr()': content

		/** Counters are denoted by identifiers (see the 'counter-increment' and 'counter-reset' properties). */
		'counter(name)': content

		/** The (pseudo-)element is replaced in its entirety by the resource referenced by its 'icon' property, and treated as a replaced element. */
		'icon': content

		/** On elements, this inhibits the children of the element from being rendered as children of this element, as if the element was empty. On pseudo-elements it causes the pseudo-element to have no content. */
		'none': content

		/** See http://www.w3.org/TR/css3-content/#content for computation rules. */
		'normal': content

		'url()': content

	}

	interface box_shadow {
		/** Changes the drop shadow from an outer shadow (one that shadows the box onto the canvas, as if it were lifted above the canvas) to an inner shadow (one that shadows the canvas onto the box, as if the box were cut out of the canvas and shifted behind it). */
		'inset': box_shadow

		/** No shadow. */
		'none': box_shadow

	}

	interface background_image {
		/** Counts as an image layer but draws nothing. */
		'none': background_image

	}

	interface padding_right {
	}

	interface white_space {
		/** Sets 'white-space-collapsing' to 'collapse' and 'text-wrap' to 'normal'. */
		'normal': white_space

		/** Sets 'white-space-collapsing' to 'collapse' and 'text-wrap' to 'none'. */
		'nowrap': white_space

		/** Sets 'white-space-collapsing' to 'preserve' and 'text-wrap' to 'none'. */
		'pre': white_space

		/** Sets 'white-space-collapsing' to 'preserve-breaks' and 'text-wrap' to 'normal'. */
		'pre-line': white_space

		/** Sets 'white-space-collapsing' to 'preserve' and 'text-wrap' to 'normal'. */
		'pre-wrap': white_space

	}

	interface padding_bottom {
	}

	interface min_height {
		'auto': min_height

		/** Use the fit-content inline size or fit-content block size, as appropriate to the writing mode. */
		'fit-content': min_height

		/** Use the max-content inline size or max-content block size, as appropriate to the writing mode. */
		'max-content': min_height

		/** Use the min-content inline size or min-content block size, as appropriate to the writing mode. */
		'min-content': min_height

	}

	interface transform {
		/** Specifies a 2D transformation in the form of a transformation matrix of six values. matrix(a,b,c,d,e,f) is equivalent to applying the transformation matrix [a b c d e f] */
		'matrix()': transform

		/** Specifies a 3D transformation as a 4x4 homogeneous matrix of 16 values in column-major order. */
		'matrix3d()': transform

		'none': transform

		/** Specifies a perspective projection matrix. */
		'perspective()': transform

		/** Specifies a 2D rotation by the angle specified in the parameter about the origin of the element, as defined by the transform-origin property. */
		'rotate()': transform

		/** Specifies a clockwise 3D rotation by the angle specified in last parameter about the [x,y,z] direction vector described by the first 3 parameters. */
		'rotate3d()': transform

		/** Specifies a 2D scale operation by the [sx,sy] scaling vector described by the 2 parameters. If the second parameter is not provided, it is takes a value equal to the first. */
		'scale()': transform

		/** Specifies a 3D scale operation by the [sx,sy,sz] scaling vector described by the 3 parameters. */
		'scale3d()': transform

		/** Specifies a scale operation using the [sx,1] scaling vector, where sx is given as the parameter. */
		'scaleX()': transform

		/** Specifies a scale operation using the [sy,1] scaling vector, where sy is given as the parameter. */
		'scaleY()': transform

		/** Specifies a scale operation using the [1,1,sz] scaling vector, where sz is given as the parameter. */
		'scaleZ()': transform

		/** Specifies a skew transformation along the X and Y axes. The first angle parameter specifies the skew on the X axis. The second angle parameter specifies the skew on the Y axis. If the second parameter is not given then a value of 0 is used for the Y angle (ie: no skew on the Y axis). */
		'skew()': transform

		/** Specifies a skew transformation along the X axis by the given angle. */
		'skewX()': transform

		/** Specifies a skew transformation along the Y axis by the given angle. */
		'skewY()': transform

		/** Specifies a 2D translation by the vector [tx, ty], where tx is the first translation-value parameter and ty is the optional second translation-value parameter. */
		'translate()': transform

		/** Specifies a 3D translation by the vector [tx,ty,tz], with tx, ty and tz being the first, second and third translation-value parameters respectively. */
		'translate3d()': transform

		/** Specifies a translation by the given amount in the X direction. */
		'translateX()': transform

		/** Specifies a translation by the given amount in the Y direction. */
		'translateY()': transform

		/** Specifies a translation by the given amount in the Z direction. Note that percentage values are not allowed in the translateZ translation-value, and if present are evaluated as 0. */
		'translateZ()': transform

	}

	interface border_bottom {
	}

	interface visibility {
		/** Table-specific. If used on elements other than rows, row groups, columns, or column groups, 'collapse' has the same meaning as 'hidden'. */
		'collapse': visibility

		/** The generated box is invisible (fully transparent, nothing is drawn), but still affects layout. */
		'hidden': visibility

		/** The generated box is visible. */
		'visible': visibility

	}

	interface background_position {
	}

	interface border_top {
	}

	interface min_width {
		'auto': min_width

		/** Use the fit-content inline size or fit-content block size, as appropriate to the writing mode. */
		'fit-content': min_width

		/** Use the max-content inline size or max-content block size, as appropriate to the writing mode. */
		'max-content': min_width

		/** Use the min-content inline size or min-content block size, as appropriate to the writing mode. */
		'min-content': min_width

	}

	interface outline {
		/** Permits the user agent to render a custom outline style, typically the default platform style. */
		'auto': outline

		/** Performs a color inversion on the pixels on the screen. */
		'invert': outline

	}

	interface transition {
		/** Every property that is able to undergo a transition will do so. */
		'all': transition

		/** background-color, border-color, color, fill, stroke, opacity, box-shadow, transform */
		'styles': transition

		/** width, height, left, top, right, bottom, margin, padding */
		'sizes': transition

		/** background-color, border-color, color, fill, stroke */
		'colors': transition

		/** No property will transition. */
		'none': transition

	}

	interface border_color {
	}

	interface background_repeat {
	}

	interface text_transform {
		/** Puts the first typographic letter unit of each word in titlecase. */
		'capitalize': text_transform

		/** Puts all letters in lowercase. */
		'lowercase': text_transform

		/** No effects. */
		'none': text_transform

		/** Puts all letters in uppercase. */
		'uppercase': text_transform

	}

	interface background_size {
		/** Resolved by using the image’s intrinsic ratio and the size of the other dimension, or failing that, using the image’s intrinsic size, or failing that, treating it as 100%. */
		'auto': background_size

		/** Scale the image, while preserving its intrinsic aspect ratio (if any), to the largest size such that both its width and its height can fit inside the background positioning area. */
		'contain': background_size

		/** Scale the image, while preserving its intrinsic aspect ratio (if any), to the smallest size such that both its width and its height can completely cover the background positioning area. */
		'cover': background_size

	}

	interface clear {
		/** The clearance of the generated box is set to the amount necessary to place the top border edge below the bottom outer edge of any right-floating and left-floating boxes that resulted from elements earlier in the source document. */
		'both': clear

		/** The clearance of the generated box is set to the amount necessary to place the top border edge below the bottom outer edge of any left-floating boxes that resulted from elements earlier in the source document. */
		'left': clear

		/** No constraint on the box's position with respect to floats. */
		'none': clear

		/** The clearance of the generated box is set to the amount necessary to place the top border edge below the bottom outer edge of any right-floating boxes that resulted from elements earlier in the source document. */
		'right': clear

	}

	interface max_height {
		/** No limit on the height of the box. */
		'none': max_height

		/** Use the fit-content inline size or fit-content block size, as appropriate to the writing mode. */
		'fit-content': max_height

		/** Use the max-content inline size or max-content block size, as appropriate to the writing mode. */
		'max-content': max_height

		/** Use the min-content inline size or min-content block size, as appropriate to the writing mode. */
		'min-content': max_height

	}

	interface list_style {
		'armenian': list_style

		/** A hollow circle. */
		'circle': list_style

		'decimal': list_style

		'decimal-leading-zero': list_style

		/** A filled circle. */
		'disc': list_style

		'georgian': list_style

		/** The marker box is outside the principal block box, as described in the section on the ::marker pseudo-element below. */
		'inside': list_style

		'lower-alpha': list_style

		'lower-greek': list_style

		'lower-latin': list_style

		'lower-roman': list_style

		'none': list_style

		/** The ::marker pseudo-element is an inline element placed immediately before all ::before pseudo-elements in the principal block box, after which the element's content flows. */
		'outside': list_style

		/** A filled square. */
		'square': list_style

		/** Allows a counter style to be defined inline. */
		'symbols()': list_style

		'upper-alpha': list_style

		'upper-latin': list_style

		'upper-roman': list_style

		'url()': list_style

	}

	interface font_style {
		/** Selects a font that is labeled as an 'italic' face, or an 'oblique' face if one is not */
		'italic': font_style

		/** Selects a face that is classified as 'normal'. */
		'normal': font_style

		/** Selects a font that is labeled as an 'oblique' face, or an 'italic' face if one is not. */
		'oblique': font_style

	}

	interface font {
		/** Thin */
		'100': font

		/** Extra Light (Ultra Light) */
		'200': font

		/** Light */
		'300': font

		/** Normal */
		'400': font

		/** Medium */
		'500': font

		/** Semi Bold (Demi Bold) */
		'600': font

		/** Bold */
		'700': font

		/** Extra Bold (Ultra Bold) */
		'800': font

		/** Black (Heavy) */
		'900': font

		/** Same as 700 */
		'bold': font

		/** Specifies the weight of the face bolder than the inherited value. */
		'bolder': font

		/** The font used for captioned controls (e.g., buttons, drop-downs, etc.). */
		'caption': font

		/** The font used to label icons. */
		'icon': font

		/** Selects a font that is labeled 'italic', or, if that is not available, one labeled 'oblique'. */
		'italic': font

		'large': font

		'larger': font

		/** Specifies the weight of the face lighter than the inherited value. */
		'lighter': font

		'medium': font

		/** The font used in menus (e.g., dropdown menus and menu lists). */
		'menu': font

		/** The font used in dialog boxes. */
		'message-box': font

		/** Specifies a face that is not labeled as a small-caps font. */
		'normal': font

		/** Selects a font that is labeled 'oblique'. */
		'oblique': font

		'small': font

		/** Specifies a font that is labeled as a small-caps font. If a genuine small-caps font is not available, user agents should simulate a small-caps font. */
		'small-caps': font

		/** The font used for labeling small controls. */
		'small-caption': font

		'smaller': font

		/** The font used in window status bars. */
		'status-bar': font

		'x-large': font

		'x-small': font

		'xx-large': font

		'xx-small': font

	}

	interface border_left {
	}

	interface border_right {
	}

	interface text_overflow {
		/** Clip inline content that overflows. Characters may be only partially rendered. */
		'clip': text_overflow

		/** Render an ellipsis character (U+2026) to represent clipped inline content. */
		'ellipsis': text_overflow

	}

	interface border_width {
	}

	interface justify_content {
		/** Flex items are packed toward the center of the line. */
		'center': justify_content

		/** The items are packed flush to each other toward the start edge of the alignment container in the main axis. */
		'start': justify_content

		/** The items are packed flush to each other toward the end edge of the alignment container in the main axis. */
		'end': justify_content

		/** The items are packed flush to each other toward the left edge of the alignment container in the main axis. */
		'left': justify_content

		/** The items are packed flush to each other toward the right edge of the alignment container in the main axis. */
		'right': justify_content

		/** If the size of the item overflows the alignment container, the item is instead aligned as if the alignment mode were start. */
		'safe': justify_content

		/** Regardless of the relative sizes of the item and alignment container, the given alignment value is honored. */
		'unsafe': justify_content

		/** If the combined size of the alignment subjects is less than the size of the alignment container, any auto-sized alignment subjects have their size increased equally (not proportionally), while still respecting the constraints imposed by max-height/max-width (or equivalent functionality), so that the combined size exactly fills the alignment container. */
		'stretch': justify_content

		/** The items are evenly distributed within the alignment container along the main axis. */
		'space-evenly': justify_content

		/** Flex items are packed toward the end of the line. */
		'flex-end': justify_content

		/** Flex items are packed toward the start of the line. */
		'flex-start': justify_content

		/** Flex items are evenly distributed in the line, with half-size spaces on either end. */
		'space-around': justify_content

		/** Flex items are evenly distributed in the line. */
		'space-between': justify_content

		/** Specifies participation in first-baseline alignment. */
		'baseline': justify_content

		/** Specifies participation in first-baseline alignment. */
		'first baseline': justify_content

		/** Specifies participation in last-baseline alignment. */
		'last baseline': justify_content

	}

	interface align_items {
		/** If the flex item’s inline axis is the same as the cross axis, this value is identical to 'flex-start'. Otherwise, it participates in baseline alignment. */
		'baseline': align_items

		/** The flex item’s margin box is centered in the cross axis within the line. */
		'center': align_items

		/** The cross-end margin edge of the flex item is placed flush with the cross-end edge of the line. */
		'flex-end': align_items

		/** The cross-start margin edge of the flex item is placed flush with the cross-start edge of the line. */
		'flex-start': align_items

		/** If the cross size property of the flex item computes to auto, and neither of the cross-axis margins are auto, the flex item is stretched. */
		'stretch': align_items

	}

	interface overflow_y {
		/** The behavior of the 'auto' value is UA-dependent, but should cause a scrolling mechanism to be provided for overflowing boxes. */
		'auto': overflow_y

		/** Content is clipped and no scrolling mechanism should be provided to view the content outside the clipping region. */
		'hidden': overflow_y

		/** Content is clipped and if the user agent uses a scrolling mechanism that is visible on the screen (such as a scroll bar or a panner), that mechanism should be displayed for a box whether or not any of its content is clipped. */
		'scroll': overflow_y

		/** Content is not clipped, i.e., it may be rendered outside the content box. */
		'visible': overflow_y

	}

	interface pointer_events {
		/** The given element can be the target element for pointer events whenever the pointer is over either the interior or the perimeter of the element. */
		'all': pointer_events

		/** The given element can be the target element for pointer events whenever the pointer is over the interior of the element. */
		'fill': pointer_events

		/** The given element does not receive pointer events. */
		'none': pointer_events

		/** The given element can be the target element for pointer events when the pointer is over a "painted" area.  */
		'painted': pointer_events

		/** The given element can be the target element for pointer events whenever the pointer is over the perimeter of the element. */
		'stroke': pointer_events

		/** The given element can be the target element for pointer events when the ‘visibility’ property is set to visible and the pointer is over either the interior or the perimete of the element. */
		'visible': pointer_events

		/** The given element can be the target element for pointer events when the ‘visibility’ property is set to visible and when the pointer is over the interior of the element. */
		'visibleFill': pointer_events

		/** The given element can be the target element for pointer events when the ‘visibility’ property is set to visible and when the pointer is over a ‘painted’ area. */
		'visiblePainted': pointer_events

		/** The given element can be the target element for pointer events when the ‘visibility’ property is set to visible and when the pointer is over the perimeter of the element. */
		'visibleStroke': pointer_events

	}

	interface border_style {
	}

	interface letter_spacing {
		/** The spacing is the normal spacing for the current font. It is typically zero-length. */
		'normal': letter_spacing

	}

	interface animation {
		/** The animation cycle iterations that are odd counts are played in the normal direction, and the animation cycle iterations that are even counts are played in a reverse direction. */
		'alternate': animation

		/** The animation cycle iterations that are odd counts are played in the reverse direction, and the animation cycle iterations that are even counts are played in a normal direction. */
		'alternate-reverse': animation

		/** The beginning property value (as defined in the first @keyframes at-rule) is applied before the animation is displayed, during the period defined by 'animation-delay'. */
		'backwards': animation

		/** Both forwards and backwards fill modes are applied. */
		'both': animation

		/** The final property value (as defined in the last @keyframes at-rule) is maintained after the animation completes. */
		'forwards': animation

		/** Causes the animation to repeat forever. */
		'infinite': animation

		/** No animation is performed */
		'none': animation

		/** Normal playback. */
		'normal': animation

		/** All iterations of the animation are played in the reverse direction from the way they were specified. */
		'reverse': animation

	}

	interface overflow_x {
		/** The behavior of the 'auto' value is UA-dependent, but should cause a scrolling mechanism to be provided for overflowing boxes. */
		'auto': overflow_x

		/** Content is clipped and no scrolling mechanism should be provided to view the content outside the clipping region. */
		'hidden': overflow_x

		/** Content is clipped and if the user agent uses a scrolling mechanism that is visible on the screen (such as a scroll bar or a panner), that mechanism should be displayed for a box whether or not any of its content is clipped. */
		'scroll': overflow_x

		/** Content is not clipped, i.e., it may be rendered outside the content box. */
		'visible': overflow_x

	}

	interface flex_direction {
		/** The flex container’s main axis has the same orientation as the block axis of the current writing mode. */
		'column': flex_direction

		/** Same as 'column', except the main-start and main-end directions are swapped. */
		'column-reverse': flex_direction

		/** The flex container’s main axis has the same orientation as the inline axis of the current writing mode. */
		'row': flex_direction

		/** Same as 'row', except the main-start and main-end directions are swapped. */
		'row-reverse': flex_direction

	}

	interface word_wrap {
		/** An otherwise unbreakable sequence of characters may be broken at an arbitrary point if there are no otherwise-acceptable break points in the line. */
		'break-word': word_wrap

		/** Lines may break only at allowed break points. */
		'normal': word_wrap

	}

	interface flex {
		/** Retrieves the value of the main size property as the used 'flex-basis'. */
		'auto': flex

		/** Indicates automatic sizing, based on the flex item’s content. */
		'content': flex

		/** Expands to '0 0 auto'. */
		'none': flex

	}

	interface border_collapse {
		/** Selects the collapsing borders model. */
		'collapse': border_collapse

		/** Selects the separated borders border model. */
		'separate': border_collapse

	}

	interface zoom {
		'normal': zoom

	}

	interface list_style_type {
		/** Traditional uppercase Armenian numbering. */
		'armenian': list_style_type

		/** A hollow circle. */
		'circle': list_style_type

		/** Western decimal numbers. */
		'decimal': list_style_type

		/** Decimal numbers padded by initial zeros. */
		'decimal-leading-zero': list_style_type

		/** A filled circle. */
		'disc': list_style_type

		/** Traditional Georgian numbering. */
		'georgian': list_style_type

		/** Lowercase ASCII letters. */
		'lower-alpha': list_style_type

		/** Lowercase classical Greek. */
		'lower-greek': list_style_type

		/** Lowercase ASCII letters. */
		'lower-latin': list_style_type

		/** Lowercase ASCII Roman numerals. */
		'lower-roman': list_style_type

		/** No marker */
		'none': list_style_type

		/** A filled square. */
		'square': list_style_type

		/** Allows a counter style to be defined inline. */
		'symbols()': list_style_type

		/** Uppercase ASCII letters. */
		'upper-alpha': list_style_type

		/** Uppercase ASCII letters. */
		'upper-latin': list_style_type

		/** Uppercase ASCII Roman numerals. */
		'upper-roman': list_style_type

	}

	interface border_bottom_left_radius {
	}

	interface fill {
		/** A URL reference to a paint server element, which is an element that defines a paint server: ‘hatch’, ‘linearGradient’, ‘mesh’, ‘pattern’, ‘radialGradient’ and ‘solidcolor’. */
		'url()': fill

		/** No paint is applied in this layer. */
		'none': fill

	}

	interface transform_origin {
	}

	interface flex_wrap {
		/** The flex container is single-line. */
		'nowrap': flex_wrap

		/** The flexbox is multi-line. */
		'wrap': flex_wrap

		/** Same as 'wrap', except the cross-start and cross-end directions are swapped. */
		'wrap-reverse': flex_wrap

	}

	interface text_shadow {
		/** No shadow. */
		'none': text_shadow

	}

	interface border_top_left_radius {
	}

	interface user_select {
		/** The content of the element must be selected atomically */
		'all': user_select

		'auto': user_select

		/** UAs must not allow a selection which is started in this element to be extended outside of this element. */
		'contain': user_select

		/** The UA must not allow selections to be started in this element. */
		'none': user_select

		/** The element imposes no constraint on the selection. */
		'text': user_select

	}

	interface clip {
		/** The element does not clip. */
		'auto': clip

		/** Specifies offsets from the edges of the border box. */
		'rect()': clip

	}

	interface border_bottom_right_radius {
	}

	interface word_break {
		/** Lines may break between any two grapheme clusters for non-CJK scripts. */
		'break-all': word_break

		/** Block characters can no longer create implied break points. */
		'keep-all': word_break

		/** Breaks non-CJK scripts according to their own rules. */
		'normal': word_break

	}

	interface border_top_right_radius {
	}

	interface flex_grow {
	}

	interface border_top_color {
	}

	interface border_bottom_color {
	}

	interface flex_shrink {
	}

	interface text_rendering {
		'auto': text_rendering

		/** Indicates that the user agent shall emphasize geometric precision over legibility and rendering speed. */
		'geometricPrecision': text_rendering

		/** Indicates that the user agent shall emphasize legibility over rendering speed and geometric precision. */
		'optimizeLegibility': text_rendering

		/** Indicates that the user agent shall emphasize rendering speed over legibility and geometric precision. */
		'optimizeSpeed': text_rendering

	}

	interface align_self {
		/** Computes to the value of 'align-items' on the element’s parent, or 'stretch' if the element has no parent. On absolutely positioned elements, it computes to itself. */
		'auto': align_self

		/** If the flex item’s inline axis is the same as the cross axis, this value is identical to 'flex-start'. Otherwise, it participates in baseline alignment. */
		'baseline': align_self

		/** The flex item’s margin box is centered in the cross axis within the line. */
		'center': align_self

		/** The cross-end margin edge of the flex item is placed flush with the cross-end edge of the line. */
		'flex-end': align_self

		/** The cross-start margin edge of the flex item is placed flush with the cross-start edge of the line. */
		'flex-start': align_self

		/** If the cross size property of the flex item computes to auto, and neither of the cross-axis margins are auto, the flex item is stretched. */
		'stretch': align_self

	}

	interface text_indent {
	}

	interface animation_timing_function {
	}

	interface border_spacing {
	}

	interface direction {
		/** Left-to-right direction. */
		'ltr': direction

		/** Right-to-left direction. */
		'rtl': direction

	}

	interface background_clip {
	}

	interface border_left_color {
	}

	interface src {
		/** Reference font by URL */
		'url()': src

		/** Optional hint describing the format of the font resource. */
		'format()': src

		/** Format-specific string that identifies a locally available copy of a given font. */
		'local()': src

	}

	interface touch_action {
		/** The user agent may determine any permitted touch behaviors for touches that begin on the element. */
		'auto': touch_action

		'cross-slide-x': touch_action

		'cross-slide-y': touch_action

		'double-tap-zoom': touch_action

		/** The user agent may consider touches that begin on the element only for the purposes of scrolling and continuous zooming. */
		'manipulation': touch_action

		/** Touches that begin on the element must not trigger default touch behaviors. */
		'none': touch_action

		/** The user agent may consider touches that begin on the element only for the purposes of horizontally scrolling the element’s nearest ancestor with horizontally scrollable content. */
		'pan-x': touch_action

		/** The user agent may consider touches that begin on the element only for the purposes of vertically scrolling the element’s nearest ancestor with vertically scrollable content. */
		'pan-y': touch_action

		'pinch-zoom': touch_action

	}

	interface border_right_color {
	}

	interface transition_property {
		/** Every property that is able to undergo a transition will do so. */
		'all': transition_property

		/** No property will transition. */
		'none': transition_property

	}

	interface animation_name {
		/** No animation is performed */
		'none': animation_name

	}

	interface filter {
		/** No filter effects are applied. */
		'none': filter

		/** Applies a Gaussian blur to the input image. */
		'blur()': filter

		/** Applies a linear multiplier to input image, making it appear more or less bright. */
		'brightness()': filter

		/** Adjusts the contrast of the input. */
		'contrast()': filter

		/** Applies a drop shadow effect to the input image. */
		'drop-shadow()': filter

		/** Converts the input image to grayscale. */
		'grayscale()': filter

		/** Applies a hue rotation on the input image.  */
		'hue-rotate()': filter

		/** Inverts the samples in the input image. */
		'invert()': filter

		/** Applies transparency to the samples in the input image. */
		'opacity()': filter

		/** Saturates the input image. */
		'saturate()': filter

		/** Converts the input image to sepia. */
		'sepia()': filter

		/** A filter reference to a <filter> element. */
		'url()': filter

	}

	interface animation_duration {
	}

	interface overflow_wrap {
		/** An otherwise unbreakable sequence of characters may be broken at an arbitrary point if there are no otherwise-acceptable break points in the line. */
		'break-word': overflow_wrap

		/** Lines may break only at allowed break points. */
		'normal': overflow_wrap

	}

	interface transition_delay {
	}

	interface stroke {
		/** A URL reference to a paint server element, which is an element that defines a paint server: ‘hatch’, ‘linearGradient’, ‘mesh’, ‘pattern’, ‘radialGradient’ and ‘solidcolor’. */
		'url()': stroke

		/** No paint is applied in this layer. */
		'none': stroke

	}

	interface font_variant {
		/** Specifies a face that is not labeled as a small-caps font. */
		'normal': font_variant

		/** Specifies a font that is labeled as a small-caps font. If a genuine small-caps font is not available, user agents should simulate a small-caps font. */
		'small-caps': font_variant

	}

	interface border_bottom_width {
	}

	interface animation_delay {
	}

	interface border_top_width {
	}

	interface transition_duration {
	}

	interface flex_basis {
		/** Retrieves the value of the main size property as the used 'flex-basis'. */
		'auto': flex_basis

		/** Indicates automatic sizing, based on the flex item’s content. */
		'content': flex_basis

	}

	interface will_change {
		/** Expresses no particular intent. */
		'auto': will_change

		/** Indicates that the author expects to animate or change something about the element’s contents in the near future. */
		'contents': will_change

		/** Indicates that the author expects to animate or change the scroll position of the element in the near future. */
		'scroll-position': will_change

	}

	interface animation_fill_mode {
		/** The beginning property value (as defined in the first @keyframes at-rule) is applied before the animation is displayed, during the period defined by 'animation-delay'. */
		'backwards': animation_fill_mode

		/** Both forwards and backwards fill modes are applied. */
		'both': animation_fill_mode

		/** The final property value (as defined in the last @keyframes at-rule) is maintained after the animation completes. */
		'forwards': animation_fill_mode

		/** There is no change to the property value between the time the animation is applied and the time the animation begins playing or after the animation completes. */
		'none': animation_fill_mode

	}

	interface outline_width {
	}

	interface table_layout {
		/** Use any automatic table layout algorithm. */
		'auto': table_layout

		/** Use the fixed table layout algorithm. */
		'fixed': table_layout

	}

	interface object_fit {
		/** The replaced content is sized to maintain its aspect ratio while fitting within the element’s content box: its concrete object size is resolved as a contain constraint against the element's used width and height. */
		'contain': object_fit

		/** The replaced content is sized to maintain its aspect ratio while filling the element's entire content box: its concrete object size is resolved as a cover constraint against the element’s used width and height. */
		'cover': object_fit

		/** The replaced content is sized to fill the element’s content box: the object's concrete object size is the element's used width and height. */
		'fill': object_fit

		/** The replaced content is not resized to fit inside the element's content box */
		'none': object_fit

		/** Size the content as if ‘none’ or ‘contain’ were specified, whichever would result in a smaller concrete object size. */
		'scale-down': object_fit

	}

	interface order {
	}

	interface transition_timing_function {
	}

	interface resize {
		/** The UA presents a bidirectional resizing mechanism to allow the user to adjust both the height and the width of the element. */
		'both': resize

		/** The UA presents a unidirectional horizontal resizing mechanism to allow the user to adjust only the width of the element. */
		'horizontal': resize

		/** The UA does not present a resizing mechanism on the element, and the user is given no direct manipulation mechanism to resize the element. */
		'none': resize

		/** The UA presents a unidirectional vertical resizing mechanism to allow the user to adjust only the height of the element. */
		'vertical': resize

	}

	interface outline_style {
		/** Permits the user agent to render a custom outline style, typically the default platform style. */
		'auto': outline_style

	}

	interface border_right_width {
	}

	interface stroke_width {
	}

	interface animation_iteration_count {
		/** Causes the animation to repeat forever. */
		'infinite': animation_iteration_count

	}

	interface align_content {
		/** Lines are packed toward the center of the flex container. */
		'center': align_content

		/** Lines are packed toward the end of the flex container. */
		'flex-end': align_content

		/** Lines are packed toward the start of the flex container. */
		'flex-start': align_content

		/** Lines are evenly distributed in the flex container, with half-size spaces on either end. */
		'space-around': align_content

		/** Lines are evenly distributed in the flex container. */
		'space-between': align_content

		/** Lines stretch to take up the remaining space. */
		'stretch': align_content

	}

	interface outline_offset {
	}

	interface backface_visibility {
		/** Back side is hidden. */
		'hidden': backface_visibility

		/** Back side is visible. */
		'visible': backface_visibility

	}

	interface border_left_width {
	}

	interface flex_flow {
		/** The flex container’s main axis has the same orientation as the block axis of the current writing mode. */
		'column': flex_flow

		/** Same as 'column', except the main-start and main-end directions are swapped. */
		'column-reverse': flex_flow

		/** The flex container is single-line. */
		'nowrap': flex_flow

		/** The flex container’s main axis has the same orientation as the inline axis of the current writing mode. */
		'row': flex_flow

		/** Same as 'row', except the main-start and main-end directions are swapped. */
		'row-reverse': flex_flow

		/** The flexbox is multi-line. */
		'wrap': flex_flow

		/** Same as 'wrap', except the cross-start and cross-end directions are swapped. */
		'wrap-reverse': flex_flow

	}

	interface appearance {
	}

	interface unicode_bidi {
		/** Inside the element, reordering is strictly in sequence according to the 'direction' property; the implicit part of the bidirectional algorithm is ignored. */
		'bidi-override': unicode_bidi

		/** If the element is inline-level, this value opens an additional level of embedding with respect to the bidirectional algorithm. The direction of this embedding level is given by the 'direction' property. */
		'embed': unicode_bidi

		/** The contents of the element are considered to be inside a separate, independent paragraph. */
		'isolate': unicode_bidi

		/** This combines the isolation behavior of 'isolate' with the directional override behavior of 'bidi-override' */
		'isolate-override': unicode_bidi

		/** The element does not open an additional level of embedding with respect to the bidirectional algorithm. For inline-level elements, implicit reordering works across element boundaries. */
		'normal': unicode_bidi

		/** For the purposes of the Unicode bidirectional algorithm, the base directionality of each bidi paragraph for which the element forms the containing block is determined not by the element's computed 'direction'. */
		'plaintext': unicode_bidi

	}

	interface stroke_dasharray {
		/** Indicates that no dashing is used. */
		'none': stroke_dasharray

	}

	interface stroke_dashoffset {
	}

	interface unicode_range {
		/** Ampersand. */
		'U+26': unicode_range

		/** Basic Latin (ASCII). */
		'U+00-7F': unicode_range

		/** Latin-1 Supplement. Accented characters for Western European languages, common punctuation characters, multiplication and division signs. */
		'U+80-FF': unicode_range

		/** Latin Extended-A. Accented characters for for Czech, Dutch, Polish, and Turkish. */
		'U+100-17F': unicode_range

		/** Latin Extended-B. Croatian, Slovenian, Romanian, Non-European and historic latin, Khoisan, Pinyin, Livonian, Sinology. */
		'U+180-24F': unicode_range

		/** Latin Extended Additional. Vietnamese, German captial sharp s, Medievalist, Latin general use. */
		'U+1E00-1EFF': unicode_range

		/** International Phonetic Alphabet Extensions. */
		'U+250-2AF': unicode_range

		/** Greek and Coptic. */
		'U+370-3FF': unicode_range

		/** Greek Extended. Accented characters for polytonic Greek. */
		'U+1F00-1FFF': unicode_range

		/** Cyrillic. */
		'U+400-4FF': unicode_range

		/** Cyrillic Supplement. Extra letters for Komi, Khanty, Chukchi, Mordvin, Kurdish, Aleut, Chuvash, Abkhaz, Azerbaijani, and Orok. */
		'U+500-52F': unicode_range

		/** Armenian. */
		'U+530–58F': unicode_range

		/** Hebrew. */
		'U+590–5FF': unicode_range

		/** Arabic. */
		'U+600–6FF': unicode_range

		/** Arabic Supplement. Additional letters for African languages, Khowar, Torwali, Burushaski, and early Persian. */
		'U+750–77F': unicode_range

		/** Arabic Extended-A. Additional letters for African languages, European and Central Asian languages, Rohingya, Tamazight, Arwi, and Koranic annotation signs. */
		'U+8A0–8FF': unicode_range

		/** Syriac. */
		'U+700–74F': unicode_range

		/** Devanagari. */
		'U+900–97F': unicode_range

		/** Bengali. */
		'U+980–9FF': unicode_range

		/** Gurmukhi. */
		'U+A00–A7F': unicode_range

		/** Gujarati. */
		'U+A80–AFF': unicode_range

		/** Oriya. */
		'U+B00–B7F': unicode_range

		/** Tamil. */
		'U+B80–BFF': unicode_range

		/** Telugu. */
		'U+C00–C7F': unicode_range

		/** Kannada. */
		'U+C80–CFF': unicode_range

		/** Malayalam. */
		'U+D00–D7F': unicode_range

		/** Sinhala. */
		'U+D80–DFF': unicode_range

		/** Warang Citi. */
		'U+118A0–118FF': unicode_range

		/** Thai. */
		'U+E00–E7F': unicode_range

		/** Tai Tham. */
		'U+1A20–1AAF': unicode_range

		/** Tai Viet. */
		'U+AA80–AADF': unicode_range

		/** Lao. */
		'U+E80–EFF': unicode_range

		/** Tibetan. */
		'U+F00–FFF': unicode_range

		/** Myanmar (Burmese). */
		'U+1000–109F': unicode_range

		/** Georgian. */
		'U+10A0–10FF': unicode_range

		/** Ethiopic. */
		'U+1200–137F': unicode_range

		/** Ethiopic Supplement. Extra Syllables for Sebatbeit, and Tonal marks */
		'U+1380–139F': unicode_range

		/** Ethiopic Extended. Extra Syllables for Me'en, Blin, and Sebatbeit. */
		'U+2D80–2DDF': unicode_range

		/** Ethiopic Extended-A. Extra characters for Gamo-Gofa-Dawro, Basketo, and Gumuz. */
		'U+AB00–AB2F': unicode_range

		/** Khmer. */
		'U+1780–17FF': unicode_range

		/** Mongolian. */
		'U+1800–18AF': unicode_range

		/** Sundanese. */
		'U+1B80–1BBF': unicode_range

		/** Sundanese Supplement. Punctuation. */
		'U+1CC0–1CCF': unicode_range

		/** CJK (Chinese, Japanese, Korean) Unified Ideographs. Most common ideographs for modern Chinese and Japanese. */
		'U+4E00–9FD5': unicode_range

		/** CJK Unified Ideographs Extension A. Rare ideographs. */
		'U+3400–4DB5': unicode_range

		/** Kangxi Radicals. */
		'U+2F00–2FDF': unicode_range

		/** CJK Radicals Supplement. Alternative forms of Kangxi Radicals. */
		'U+2E80–2EFF': unicode_range

		/** Hangul Jamo. */
		'U+1100–11FF': unicode_range

		/** Hangul Syllables. */
		'U+AC00–D7AF': unicode_range

		/** Hiragana. */
		'U+3040–309F': unicode_range

		/** Katakana. */
		'U+30A0–30FF': unicode_range

		/** Lisu. */
		'U+A4D0–A4FF': unicode_range

		/** Yi Syllables. */
		'U+A000–A48F': unicode_range

		/** Yi Radicals. */
		'U+A490–A4CF': unicode_range

		/** General Punctuation. */
		'U+2000-206F': unicode_range

		/** CJK Symbols and Punctuation. */
		'U+3000–303F': unicode_range

		/** Superscripts and Subscripts. */
		'U+2070–209F': unicode_range

		/** Currency Symbols. */
		'U+20A0–20CF': unicode_range

		/** Letterlike Symbols. */
		'U+2100–214F': unicode_range

		/** Number Forms. */
		'U+2150–218F': unicode_range

		/** Arrows. */
		'U+2190–21FF': unicode_range

		/** Mathematical Operators. */
		'U+2200–22FF': unicode_range

		/** Miscellaneous Technical. */
		'U+2300–23FF': unicode_range

		/** Private Use Area. */
		'U+E000-F8FF': unicode_range

		/** Alphabetic Presentation Forms. Ligatures for latin, Armenian, and Hebrew. */
		'U+FB00–FB4F': unicode_range

		/** Arabic Presentation Forms-A. Contextual forms / ligatures for Persian, Urdu, Sindhi, Central Asian languages, etc, Arabic pedagogical symbols, word ligatures. */
		'U+FB50–FDFF': unicode_range

		/** Emoji: Emoticons. */
		'U+1F600–1F64F': unicode_range

		/** Emoji: Miscellaneous Symbols. */
		'U+2600–26FF': unicode_range

		/** Emoji: Miscellaneous Symbols and Pictographs. */
		'U+1F300–1F5FF': unicode_range

		/** Emoji: Supplemental Symbols and Pictographs. */
		'U+1F900–1F9FF': unicode_range

		/** Emoji: Transport and Map Symbols. */
		'U+1F680–1F6FF': unicode_range

	}

	interface word_spacing {
		/** No additional spacing is applied. Computes to zero. */
		'normal': word_spacing

	}

	interface text_size_adjust {
	}

	interface border_top_style {
	}

	interface border_bottom_style {
	}

	interface animation_direction {
		/** The animation cycle iterations that are odd counts are played in the normal direction, and the animation cycle iterations that are even counts are played in a reverse direction. */
		'alternate': animation_direction

		/** The animation cycle iterations that are odd counts are played in the reverse direction, and the animation cycle iterations that are even counts are played in a normal direction. */
		'alternate-reverse': animation_direction

		/** Normal playback. */
		'normal': animation_direction

		/** All iterations of the animation are played in the reverse direction from the way they were specified. */
		'reverse': animation_direction

	}

	interface image_rendering {
		/** The image should be scaled with an algorithm that maximizes the appearance of the image. */
		'auto': image_rendering

		/** The image must be scaled with an algorithm that preserves contrast and edges in the image, and which does not smooth colors or introduce blur to the image in the process. */
		'crisp-edges': image_rendering

		'-moz-crisp-edges': image_rendering

		/** Deprecated. */
		'optimizeQuality': image_rendering

		/** Deprecated. */
		'optimizeSpeed': image_rendering

		/** When scaling the image up, the 'nearest neighbor' or similar algorithm must be used, so that the image appears to be simply composed of very large pixels. */
		'pixelated': image_rendering

	}

	interface perspective {
		/** No perspective transform is applied. */
		'none': perspective

	}

	interface grid_template_columns {
		/** There is no explicit grid; any rows/columns will be implicitly generated. */
		'none': grid_template_columns

		/** Represents the largest min-content contribution of the grid items occupying the grid track. */
		'min-content': grid_template_columns

		/** Represents the largest max-content contribution of the grid items occupying the grid track. */
		'max-content': grid_template_columns

		/** As a maximum, identical to 'max-content'. As a minimum, represents the largest minimum size (as specified by min-width/min-height) of the grid items occupying the grid track. */
		'auto': grid_template_columns

		/** Indicates that the grid will align to its parent grid in that axis. */
		'subgrid': grid_template_columns

		/** Defines a size range greater than or equal to min and less than or equal to max. */
		'minmax()': grid_template_columns

		/** Represents a repeated fragment of the track list, allowing a large number of columns or rows that exhibit a recurring pattern to be written in a more compact form. */
		'repeat()': grid_template_columns

	}

	interface list_style_position {
		/** The marker box is outside the principal block box, as described in the section on the ::marker pseudo-element below. */
		'inside': list_style_position

		/** The ::marker pseudo-element is an inline element placed immediately before all ::before pseudo-elements in the principal block box, after which the element's content flows. */
		'outside': list_style_position

	}

	interface font_feature_settings {
		/** No change in glyph substitution or positioning occurs. */
		'normal': font_feature_settings

		/** Disable feature. */
		'off': font_feature_settings

		/** Enable feature. */
		'on': font_feature_settings

	}

	interface contain {
		/** Indicates that the property has no effect. */
		'none': contain

		/** Turns on all forms of containment for the element. */
		'strict': contain

		/** All containment rules except size are applied to the element. */
		'content': contain

		/** For properties that can have effects on more than just an element and its descendants, those effects don't escape the containing element. */
		'size': contain

		/** Turns on layout containment for the element. */
		'layout': contain

		/** Turns on style containment for the element. */
		'style': contain

		/** Turns on paint containment for the element. */
		'paint': contain

	}

	interface background_position_x {
		/** Equivalent to '50%' ('left 50%') for the horizontal position if the horizontal position is not otherwise specified, or '50%' ('top 50%') for the vertical position if it is. */
		'center': background_position_x

		/** Equivalent to '0%' for the horizontal position if one or two values are given, otherwise specifies the left edge as the origin for the next offset. */
		'left': background_position_x

		/** Equivalent to '100%' for the horizontal position if one or two values are given, otherwise specifies the right edge as the origin for the next offset. */
		'right': background_position_x

	}

	interface transform_style {
		/** All children of this element are rendered flattened into the 2D plane of the element. */
		'flat': transform_style

		/** Flattening is not performed, so children maintain their position in 3D space. */
		'preserve-3d': transform_style

	}

	interface background_origin {
	}

	interface border_left_style {
	}

	interface font_display {
	}

	interface clip_path {
		/** No clipping path gets created. */
		'none': clip_path

		/** References a <clipPath> element to create a clipping path. */
		'url()': clip_path

	}

	interface hyphens {
		/** Conditional hyphenation characters inside a word, if present, take priority over automatic resources when determining hyphenation points within the word. */
		'auto': hyphens

		/** Words are only broken at line breaks where there are characters inside the word that suggest line break opportunities */
		'manual': hyphens

		/** Words are not broken at line breaks, even if characters inside the word suggest line break points. */
		'none': hyphens

	}

	interface background_attachment {
		/** The background is fixed with regard to the viewport. In paged media where there is no viewport, a 'fixed' background is fixed with respect to the page box and therefore replicated on every page. */
		'fixed': background_attachment

		/** The background is fixed with regard to the element’s contents: if the element has a scrolling mechanism, the background scrolls with the element’s contents. */
		'local': background_attachment

		/** The background is fixed with regard to the element itself and does not scroll with its contents. (It is effectively attached to the element’s border.) */
		'scroll': background_attachment

	}

	interface border_right_style {
	}

	interface outline_color {
		/** Performs a color inversion on the pixels on the screen. */
		'invert': outline_color

	}

	interface margin_block_end {
		'auto': margin_block_end

	}

	interface animation_play_state {
		/** A running animation will be paused. */
		'paused': animation_play_state

		/** Resume playback of a paused animation. */
		'running': animation_play_state

	}

	interface quotes {
		/** The 'open-quote' and 'close-quote' values of the 'content' property produce no quotations marks, as if they were 'no-open-quote' and 'no-close-quote' respectively. */
		'none': quotes

	}

	interface background_position_y {
		/** Equivalent to '100%' for the vertical position if one or two values are given, otherwise specifies the bottom edge as the origin for the next offset. */
		'bottom': background_position_y

		/** Equivalent to '50%' ('left 50%') for the horizontal position if the horizontal position is not otherwise specified, or '50%' ('top 50%') for the vertical position if it is. */
		'center': background_position_y

		/** Equivalent to '0%' for the vertical position if one or two values are given, otherwise specifies the top edge as the origin for the next offset. */
		'top': background_position_y

	}

	interface font_stretch {
		'condensed': font_stretch

		'expanded': font_stretch

		'extra-condensed': font_stretch

		'extra-expanded': font_stretch

		/** Indicates a narrower value relative to the width of the parent element. */
		'narrower': font_stretch

		'normal': font_stretch

		'semi-condensed': font_stretch

		'semi-expanded': font_stretch

		'ultra-condensed': font_stretch

		'ultra-expanded': font_stretch

		/** Indicates a wider value relative to the width of the parent element. */
		'wider': font_stretch

	}

	interface stroke_linecap {
		/** Indicates that the stroke for each subpath does not extend beyond its two endpoints. */
		'butt': stroke_linecap

		/** Indicates that at each end of each subpath, the shape representing the stroke will be extended by a half circle with a radius equal to the stroke width. */
		'round': stroke_linecap

		/** Indicates that at the end of each subpath, the shape representing the stroke will be extended by a rectangle with the same width as the stroke width and whose length is half of the stroke width. */
		'square': stroke_linecap

	}

	interface object_position {
	}

	interface counter_reset {
		/** The counter is not modified. */
		'none': counter_reset

	}

	interface margin_block_start {
		'auto': margin_block_start

	}

	interface counter_increment {
		/** This element does not alter the value of any counters. */
		'none': counter_increment

	}

	interface size {
	}

	interface text_decoration_color {
	}

	interface list_style_image {
		/** The default contents of the of the list item’s marker are given by 'list-style-type' instead. */
		'none': list_style_image

	}

	interface column_count {
		/** Determines the number of columns by the 'column-width' property and the element width. */
		'auto': column_count

	}

	interface border_image {
		/** If 'auto' is specified then the border image width is the intrinsic width or height (whichever is applicable) of the corresponding image slice. If the image does not have the required intrinsic dimension then the corresponding border-width is used instead. */
		'auto': border_image

		/** Causes the middle part of the border-image to be preserved. */
		'fill': border_image

		/** Use the border styles. */
		'none': border_image

		/** The image is tiled (repeated) to fill the area. */
		'repeat': border_image

		/** The image is tiled (repeated) to fill the area. If it does not fill the area with a whole number of tiles, the image is rescaled so that it does. */
		'round': border_image

		/** The image is tiled (repeated) to fill the area. If it does not fill the area with a whole number of tiles, the extra space is distributed around the tiles. */
		'space': border_image

		/** The image is stretched to fill the area. */
		'stretch': border_image

		'url()': border_image

	}

	interface column_gap {
		/** User agent specific and typically equivalent to 1em. */
		'normal': column_gap

	}

	interface page_break_inside {
		/** Neither force nor forbid a page break inside the generated box. */
		'auto': page_break_inside

		/** Avoid a page break inside the generated box. */
		'avoid': page_break_inside

	}

	interface fill_opacity {
	}

	interface padding_inline_start {
	}

	interface empty_cells {
		/** No borders or backgrounds are drawn around/behind empty cells. */
		'hide': empty_cells

		'-moz-show-background': empty_cells

		/** Borders and backgrounds are drawn around/behind empty cells (like normal cells). */
		'show': empty_cells

	}

	interface font_variant_ligatures {
		/** Enables display of additional ligatures. */
		'additional-ligatures': font_variant_ligatures

		/** Enables display of common ligatures. */
		'common-ligatures': font_variant_ligatures

		/** Enables display of contextual alternates. */
		'contextual': font_variant_ligatures

		/** Enables display of discretionary ligatures. */
		'discretionary-ligatures': font_variant_ligatures

		/** Enables display of historical ligatures. */
		'historical-ligatures': font_variant_ligatures

		/** Disables display of additional ligatures. */
		'no-additional-ligatures': font_variant_ligatures

		/** Disables display of common ligatures. */
		'no-common-ligatures': font_variant_ligatures

		/** Disables display of contextual alternates. */
		'no-contextual': font_variant_ligatures

		/** Disables display of discretionary ligatures. */
		'no-discretionary-ligatures': font_variant_ligatures

		/** Disables display of historical ligatures. */
		'no-historical-ligatures': font_variant_ligatures

		/** Disables all ligatures. */
		'none': font_variant_ligatures

		/** Implies that the defaults set by the font are used. */
		'normal': font_variant_ligatures

	}

	interface text_decoration_skip {
	}

	interface justify_self {
		'auto': justify_self

		'normal': justify_self

		'end': justify_self

		'start': justify_self

		/** "Flex items are packed toward the end of the line." */
		'flex-end': justify_self

		/** "Flex items are packed toward the start of the line." */
		'flex-start': justify_self

		/** The item is packed flush to the edge of the alignment container of the end side of the item, in the appropriate axis. */
		'self-end': justify_self

		/** The item is packed flush to the edge of the alignment container of the start side of the item, in the appropriate axis.. */
		'self-start': justify_self

		/** The items are packed flush to each other toward the center of the of the alignment container. */
		'center': justify_self

		'left': justify_self

		'right': justify_self

		'baseline': justify_self

		'first baseline': justify_self

		'last baseline': justify_self

		/** If the cross size property of the flex item computes to auto, and neither of the cross-axis margins are auto, the flex item is stretched. */
		'stretch': justify_self

		'save': justify_self

		'unsave': justify_self

	}

	interface page_break_after {
		/** Always force a page break after the generated box. */
		'always': page_break_after

		/** Neither force nor forbid a page break after generated box. */
		'auto': page_break_after

		/** Avoid a page break after the generated box. */
		'avoid': page_break_after

		/** Force one or two page breaks after the generated box so that the next page is formatted as a left page. */
		'left': page_break_after

		/** Force one or two page breaks after the generated box so that the next page is formatted as a right page. */
		'right': page_break_after

	}

	interface grid_template_rows {
		/** There is no explicit grid; any rows/columns will be implicitly generated. */
		'none': grid_template_rows

		/** Represents the largest min-content contribution of the grid items occupying the grid track. */
		'min-content': grid_template_rows

		/** Represents the largest max-content contribution of the grid items occupying the grid track. */
		'max-content': grid_template_rows

		/** As a maximum, identical to 'max-content'. As a minimum, represents the largest minimum size (as specified by min-width/min-height) of the grid items occupying the grid track. */
		'auto': grid_template_rows

		/** Indicates that the grid will align to its parent grid in that axis. */
		'subgrid': grid_template_rows

		/** Defines a size range greater than or equal to min and less than or equal to max. */
		'minmax()': grid_template_rows

		/** Represents a repeated fragment of the track list, allowing a large number of columns or rows that exhibit a recurring pattern to be written in a more compact form. */
		'repeat()': grid_template_rows

	}

	interface padding_inline_end {
	}

	interface grid_gap {
	}

	interface all {
	}

	interface grid_column {
		/** The property contributes nothing to the grid item’s placement, indicating auto-placement, an automatic span, or a default span of one. */
		'auto': grid_column

		/** Contributes a grid span to the grid item’s placement such that the corresponding edge of the grid item’s grid area is N lines from its opposite edge. */
		'span': grid_column

	}

	interface stroke_opacity {
	}

	interface margin_inline_start {
		'auto': margin_inline_start

	}

	interface margin_inline_end {
		'auto': margin_inline_end

	}

	interface caret_color {
		/** The user agent selects an appropriate color for the caret. This is generally currentcolor, but the user agent may choose a different color to ensure good visibility and contrast with the surrounding content, taking into account the value of currentcolor, the background, shadows, and other factors. */
		'auto': caret_color

	}

	interface orphans {
	}

	interface caption_side {
		/** Positions the caption box below the table box. */
		'bottom': caption_side

		/** Positions the caption box above the table box. */
		'top': caption_side

	}

	interface perspective_origin {
	}

	interface stop_color {
	}

	interface widows {
	}

	interface scroll_behavior {
		/** Scrolls in an instant fashion. */
		'auto': scroll_behavior

		/** Scrolls in a smooth fashion using a user-agent-defined timing function and time period. */
		'smooth': scroll_behavior

	}

	interface grid_column_gap {
	}

	interface columns {
		/** The width depends on the values of other properties. */
		'auto': columns

	}

	interface column_width {
		/** The width depends on the values of other properties. */
		'auto': column_width

	}

	interface mix_blend_mode {
		/** Default attribute which specifies no blending */
		'normal': mix_blend_mode

		/** The source color is multiplied by the destination color and replaces the destination. */
		'multiply': mix_blend_mode

		/** Multiplies the complements of the backdrop and source color values, then complements the result. */
		'screen': mix_blend_mode

		/** Multiplies or screens the colors, depending on the backdrop color value. */
		'overlay': mix_blend_mode

		/** Selects the darker of the backdrop and source colors. */
		'darken': mix_blend_mode

		/** Selects the lighter of the backdrop and source colors. */
		'lighten': mix_blend_mode

		/** Brightens the backdrop color to reflect the source color. */
		'color-dodge': mix_blend_mode

		/** Darkens the backdrop color to reflect the source color. */
		'color-burn': mix_blend_mode

		/** Multiplies or screens the colors, depending on the source color value. */
		'hard-light': mix_blend_mode

		/** Darkens or lightens the colors, depending on the source color value. */
		'soft-light': mix_blend_mode

		/** Subtracts the darker of the two constituent colors from the lighter color.. */
		'difference': mix_blend_mode

		/** Produces an effect similar to that of the Difference mode but lower in contrast. */
		'exclusion': mix_blend_mode

		/** Creates a color with the hue of the source color and the saturation and luminosity of the backdrop color. */
		'hue': mix_blend_mode

		/** Creates a color with the saturation of the source color and the hue and luminosity of the backdrop color. */
		'saturation': mix_blend_mode

		/** Creates a color with the hue and saturation of the source color and the luminosity of the backdrop color. */
		'color': mix_blend_mode

		/** Creates a color with the luminosity of the source color and the hue and saturation of the backdrop color. */
		'luminosity': mix_blend_mode

	}

	interface font_kerning {
		/** Specifies that kerning is applied at the discretion of the user agent. */
		'auto': font_kerning

		/** Specifies that kerning is not applied. */
		'none': font_kerning

		/** Specifies that kerning is applied. */
		'normal': font_kerning

	}

	interface border_image_slice {
		/** Causes the middle part of the border-image to be preserved. */
		'fill': border_image_slice

	}

	interface border_image_repeat {
		/** The image is tiled (repeated) to fill the area. */
		'repeat': border_image_repeat

		/** The image is tiled (repeated) to fill the area. If it does not fill the area with a whole number of tiles, the image is rescaled so that it does. */
		'round': border_image_repeat

		/** The image is tiled (repeated) to fill the area. If it does not fill the area with a whole number of tiles, the extra space is distributed around the tiles. */
		'space': border_image_repeat

		/** The image is stretched to fill the area. */
		'stretch': border_image_repeat

	}

	interface border_image_width {
		/** The border image width is the intrinsic width or height (whichever is applicable) of the corresponding image slice. If the image does not have the required intrinsic dimension then the corresponding border-width is used instead. */
		'auto': border_image_width

	}

	interface grid_row {
		/** The property contributes nothing to the grid item’s placement, indicating auto-placement, an automatic span, or a default span of one. */
		'auto': grid_row

		/** Contributes a grid span to the grid item’s placement such that the corresponding edge of the grid item’s grid area is N lines from its opposite edge. */
		'span': grid_row

	}

	interface tab_size {
	}

	interface grid_row_gap {
	}

	interface text_decoration_style {
		/** Produces a dashed line style. */
		'dashed': text_decoration_style

		/** Produces a dotted line. */
		'dotted': text_decoration_style

		/** Produces a double line. */
		'double': text_decoration_style

		/** Produces no line. */
		'none': text_decoration_style

		/** Produces a solid line. */
		'solid': text_decoration_style

		/** Produces a wavy line. */
		'wavy': text_decoration_style

	}

	interface line_break {
		/** The UA determines the set of line-breaking restrictions to use for CJK scripts, and it may vary the restrictions based on the length of the line; e.g., use a less restrictive set of line-break rules for short lines. */
		'auto': line_break

		/** Breaks text using the least restrictive set of line-breaking rules. Typically used for short lines, such as in newspapers. */
		'loose': line_break

		/** Breaks text using the most common set of line-breaking rules. */
		'normal': line_break

		/** Breaks CJK scripts using a more restrictive set of line-breaking rules than 'normal'. */
		'strict': line_break

	}

	interface border_image_outset {
	}

	interface column_rule {
	}

	interface justify_items {
		'auto': justify_items

		'normal': justify_items

		'end': justify_items

		'start': justify_items

		/** "Flex items are packed toward the end of the line." */
		'flex-end': justify_items

		/** "Flex items are packed toward the start of the line." */
		'flex-start': justify_items

		/** The item is packed flush to the edge of the alignment container of the end side of the item, in the appropriate axis. */
		'self-end': justify_items

		/** The item is packed flush to the edge of the alignment container of the start side of the item, in the appropriate axis.. */
		'self-start': justify_items

		/** The items are packed flush to each other toward the center of the of the alignment container. */
		'center': justify_items

		'left': justify_items

		'right': justify_items

		'baseline': justify_items

		'first baseline': justify_items

		'last baseline': justify_items

		/** If the cross size property of the flex item computes to auto, and neither of the cross-axis margins are auto, the flex item is stretched. */
		'stretch': justify_items

		'save': justify_items

		'unsave': justify_items

		'legacy': justify_items

	}

	interface grid_area {
		/** The property contributes nothing to the grid item’s placement, indicating auto-placement, an automatic span, or a default span of one. */
		'auto': grid_area

		/** Contributes a grid span to the grid item’s placement such that the corresponding edge of the grid item’s grid area is N lines from its opposite edge. */
		'span': grid_area

	}

	interface stroke_miterlimit {
	}

	interface text_align_last {
		/** Content on the affected line is aligned per 'text-align' unless 'text-align' is set to 'justify', in which case it is 'start-aligned'. */
		'auto': text_align_last

		/** The inline contents are centered within the line box. */
		'center': text_align_last

		/** The text is justified according to the method specified by the 'text-justify' property. */
		'justify': text_align_last

		/** The inline contents are aligned to the left edge of the line box. In vertical text, 'left' aligns to the edge of the line box that would be the start edge for left-to-right text. */
		'left': text_align_last

		/** The inline contents are aligned to the right edge of the line box. In vertical text, 'right' aligns to the edge of the line box that would be the end edge for left-to-right text. */
		'right': text_align_last

	}

	interface backdrop_filter {
	}

	interface grid_auto_rows {
		/** Represents the largest min-content contribution of the grid items occupying the grid track. */
		'min-content': grid_auto_rows

		/** Represents the largest max-content contribution of the grid items occupying the grid track. */
		'max-content': grid_auto_rows

		/** As a maximum, identical to 'max-content'. As a minimum, represents the largest minimum size (as specified by min-width/min-height) of the grid items occupying the grid track. */
		'auto': grid_auto_rows

		/** Defines a size range greater than or equal to min and less than or equal to max. */
		'minmax()': grid_auto_rows

	}

	interface stroke_linejoin {
		/** Indicates that a bevelled corner is to be used to join path segments. */
		'bevel': stroke_linejoin

		/** Indicates that a sharp corner is to be used to join path segments. */
		'miter': stroke_linejoin

		/** Indicates that a round corner is to be used to join path segments. */
		'round': stroke_linejoin

	}

	interface shape_outside {
		/** The background is painted within (clipped to) the margin box. */
		'margin-box': shape_outside

		/** The float area is unaffected. */
		'none': shape_outside

	}

	interface text_decoration_line {
		/** Each line of text has a line through the middle. */
		'line-through': text_decoration_line

		/** Neither produces nor inhibits text decoration. */
		'none': text_decoration_line

		/** Each line of text has a line above it. */
		'overline': text_decoration_line

		/** Each line of text is underlined. */
		'underline': text_decoration_line

	}

	interface scroll_snap_align {
	}

	interface fill_rule {
		/** Determines the ‘insideness’ of a point on the canvas by drawing a ray from that point to infinity in any direction and counting the number of path segments from the given shape that the ray crosses. */
		'evenodd': fill_rule

		/** Determines the ‘insideness’ of a point on the canvas by drawing a ray from that point to infinity in any direction and then examining the places where a segment of the shape crosses the ray. */
		'nonzero': fill_rule

	}

	interface grid_auto_flow {
		/** The auto-placement algorithm places items by filling each row in turn, adding new rows as necessary. */
		'row': grid_auto_flow

		/** The auto-placement algorithm places items by filling each column in turn, adding new columns as necessary. */
		'column': grid_auto_flow

		/** If specified, the auto-placement algorithm uses a “dense” packing algorithm, which attempts to fill in holes earlier in the grid if smaller items come up later. */
		'dense': grid_auto_flow

	}

	interface scroll_snap_type {
		/** The visual viewport of this scroll container must ignore snap points, if any, when scrolled. */
		'none': scroll_snap_type

		/** The visual viewport of this scroll container is guaranteed to rest on a snap point when there are no active scrolling operations. */
		'mandatory': scroll_snap_type

		/** The visual viewport of this scroll container may come to rest on a snap point at the termination of a scroll at the discretion of the UA given the parameters of the scroll. */
		'proximity': scroll_snap_type

	}

	interface page_break_before {
		/** Always force a page break before the generated box. */
		'always': page_break_before

		/** Neither force nor forbid a page break before the generated box. */
		'auto': page_break_before

		/** Avoid a page break before the generated box. */
		'avoid': page_break_before

		/** Force one or two page breaks before the generated box so that the next page is formatted as a left page. */
		'left': page_break_before

		/** Force one or two page breaks before the generated box so that the next page is formatted as a right page. */
		'right': page_break_before

	}

	interface grid_column_start {
		/** The property contributes nothing to the grid item’s placement, indicating auto-placement, an automatic span, or a default span of one. */
		'auto': grid_column_start

		/** Contributes a grid span to the grid item’s placement such that the corresponding edge of the grid item’s grid area is N lines from its opposite edge. */
		'span': grid_column_start

	}

	interface grid_template_areas {
		/** The grid container doesn’t define any named grid areas. */
		'none': grid_template_areas

	}

	interface break_inside {
		/** Impose no additional breaking constraints within the box. */
		'auto': break_inside

		/** Avoid breaks within the box. */
		'avoid': break_inside

		/** Avoid a column break within the box. */
		'avoid-column': break_inside

		/** Avoid a page break within the box. */
		'avoid-page': break_inside

	}

	interface column_fill {
		/** Fills columns sequentially. */
		'auto': column_fill

		/** Balance content equally between columns, if possible. */
		'balance': column_fill

	}

	interface grid_column_end {
		/** The property contributes nothing to the grid item’s placement, indicating auto-placement, an automatic span, or a default span of one. */
		'auto': grid_column_end

		/** Contributes a grid span to the grid item’s placement such that the corresponding edge of the grid item’s grid area is N lines from its opposite edge. */
		'span': grid_column_end

	}

	interface border_image_source {
		/** Use the border styles. */
		'none': border_image_source

	}

	interface overflow_anchor {
	}

	interface grid_row_start {
		/** The property contributes nothing to the grid item’s placement, indicating auto-placement, an automatic span, or a default span of one. */
		'auto': grid_row_start

		/** Contributes a grid span to the grid item’s placement such that the corresponding edge of the grid item’s grid area is N lines from its opposite edge. */
		'span': grid_row_start

	}

	interface grid_row_end {
		/** The property contributes nothing to the grid item’s placement, indicating auto-placement, an automatic span, or a default span of one. */
		'auto': grid_row_end

		/** Contributes a grid span to the grid item’s placement such that the corresponding edge of the grid item’s grid area is N lines from its opposite edge. */
		'span': grid_row_end

	}

	interface font_variant_numeric {
		/** Enables display of lining diagonal fractions. */
		'diagonal-fractions': font_variant_numeric

		/** Enables display of lining numerals. */
		'lining-nums': font_variant_numeric

		/** None of the features are enabled. */
		'normal': font_variant_numeric

		/** Enables display of old-style numerals. */
		'oldstyle-nums': font_variant_numeric

		/** Enables display of letter forms used with ordinal numbers. */
		'ordinal': font_variant_numeric

		/** Enables display of proportional numerals. */
		'proportional-nums': font_variant_numeric

		/** Enables display of slashed zeros. */
		'slashed-zero': font_variant_numeric

		/** Enables display of lining stacked fractions. */
		'stacked-fractions': font_variant_numeric

		/** Enables display of tabular numerals. */
		'tabular-nums': font_variant_numeric

	}

	interface background_blend_mode {
		/** Default attribute which specifies no blending */
		'normal': background_blend_mode

		/** The source color is multiplied by the destination color and replaces the destination. */
		'multiply': background_blend_mode

		/** Multiplies the complements of the backdrop and source color values, then complements the result. */
		'screen': background_blend_mode

		/** Multiplies or screens the colors, depending on the backdrop color value. */
		'overlay': background_blend_mode

		/** Selects the darker of the backdrop and source colors. */
		'darken': background_blend_mode

		/** Selects the lighter of the backdrop and source colors. */
		'lighten': background_blend_mode

		/** Brightens the backdrop color to reflect the source color. */
		'color-dodge': background_blend_mode

		/** Darkens the backdrop color to reflect the source color. */
		'color-burn': background_blend_mode

		/** Multiplies or screens the colors, depending on the source color value. */
		'hard-light': background_blend_mode

		/** Darkens or lightens the colors, depending on the source color value. */
		'soft-light': background_blend_mode

		/** Subtracts the darker of the two constituent colors from the lighter color.. */
		'difference': background_blend_mode

		/** Produces an effect similar to that of the Difference mode but lower in contrast. */
		'exclusion': background_blend_mode

		/** Creates a color with the hue of the source color and the saturation and luminosity of the backdrop color. */
		'hue': background_blend_mode

		/** Creates a color with the saturation of the source color and the hue and luminosity of the backdrop color. */
		'saturation': background_blend_mode

		/** Creates a color with the hue and saturation of the source color and the luminosity of the backdrop color. */
		'color': background_blend_mode

		/** Creates a color with the luminosity of the source color and the hue and saturation of the backdrop color. */
		'luminosity': background_blend_mode

	}

	interface text_decoration_skip_ink {
	}

	interface column_rule_color {
	}

	interface isolation {
		/** Elements are not isolated unless an operation is applied that causes the creation of a stacking context. */
		'auto': isolation

		/** In CSS will turn the element into a stacking context. */
		'isolate': isolation

	}

	interface shape_rendering {
		/** Suppresses aural rendering. */
		'auto': shape_rendering

		/** Emphasize the contrast between clean edges of artwork over rendering speed and geometric precision. */
		'crispEdges': shape_rendering

		/** Emphasize geometric precision over speed and crisp edges. */
		'geometricPrecision': shape_rendering

		/** Emphasize rendering speed over geometric precision and crisp edges. */
		'optimizeSpeed': shape_rendering

	}

	interface column_rule_style {
	}

	interface border_inline_end_width {
	}

	interface border_inline_start_width {
	}

	interface grid_auto_columns {
		/** Represents the largest min-content contribution of the grid items occupying the grid track. */
		'min-content': grid_auto_columns

		/** Represents the largest max-content contribution of the grid items occupying the grid track. */
		'max-content': grid_auto_columns

		/** As a maximum, identical to 'max-content'. As a minimum, represents the largest minimum size (as specified by min-width/min-height) of the grid items occupying the grid track. */
		'auto': grid_auto_columns

		/** Defines a size range greater than or equal to min and less than or equal to max. */
		'minmax()': grid_auto_columns

	}

	interface writing_mode {
		/** Top-to-bottom block flow direction. The writing mode is horizontal. */
		'horizontal-tb': writing_mode

		/** Left-to-right block flow direction. The writing mode is vertical, while the typographic mode is horizontal. */
		'sideways-lr': writing_mode

		/** Right-to-left block flow direction. The writing mode is vertical, while the typographic mode is horizontal. */
		'sideways-rl': writing_mode

		/** Left-to-right block flow direction. The writing mode is vertical. */
		'vertical-lr': writing_mode

		/** Right-to-left block flow direction. The writing mode is vertical. */
		'vertical-rl': writing_mode

	}

	interface clip_rule {
		/** Determines the ‘insideness’ of a point on the canvas by drawing a ray from that point to infinity in any direction and counting the number of path segments from the given shape that the ray crosses. */
		'evenodd': clip_rule

		/** Determines the ‘insideness’ of a point on the canvas by drawing a ray from that point to infinity in any direction and then examining the places where a segment of the shape crosses the ray. */
		'nonzero': clip_rule

	}

	interface font_variant_caps {
		/** Enables display of petite capitals for both upper and lowercase letters. */
		'all-petite-caps': font_variant_caps

		/** Enables display of small capitals for both upper and lowercase letters. */
		'all-small-caps': font_variant_caps

		/** None of the features are enabled. */
		'normal': font_variant_caps

		/** Enables display of petite capitals. */
		'petite-caps': font_variant_caps

		/** Enables display of small capitals. Small-caps glyphs typically use the form of uppercase letters but are reduced to the size of lowercase letters. */
		'small-caps': font_variant_caps

		/** Enables display of titling capitals. */
		'titling-caps': font_variant_caps

		/** Enables display of mixture of small capitals for uppercase letters with normal lowercase letters. */
		'unicase': font_variant_caps

	}

	interface text_anchor {
		/** The rendered characters are aligned such that the end of the resulting rendered text is at the initial current text position. */
		'end': text_anchor

		/** The rendered characters are aligned such that the geometric middle of the resulting rendered text is at the initial current text position. */
		'middle': text_anchor

		/** The rendered characters are aligned such that the start of the resulting rendered text is at the initial current text position. */
		'start': text_anchor

	}

	interface stop_opacity {
	}

	interface mask {
	}

	interface column_span {
		/** The element spans across all columns. Content in the normal flow that appears before the element is automatically balanced across all columns before the element appear. */
		'all': column_span

		/** The element does not span multiple columns. */
		'none': column_span

	}

	interface font_variant_east_asian {
		/** Enables rendering of full-width variants. */
		'full-width': font_variant_east_asian

		/** Enables rendering of JIS04 forms. */
		'jis04': font_variant_east_asian

		/** Enables rendering of JIS78 forms. */
		'jis78': font_variant_east_asian

		/** Enables rendering of JIS83 forms. */
		'jis83': font_variant_east_asian

		/** Enables rendering of JIS90 forms. */
		'jis90': font_variant_east_asian

		/** None of the features are enabled. */
		'normal': font_variant_east_asian

		/** Enables rendering of proportionally-spaced variants. */
		'proportional-width': font_variant_east_asian

		/** Enables display of ruby variant glyphs. */
		'ruby': font_variant_east_asian

		/** Enables rendering of simplified forms. */
		'simplified': font_variant_east_asian

		/** Enables rendering of traditional forms. */
		'traditional': font_variant_east_asian

	}

	interface text_underline_position {
		'above': text_underline_position

		/** The user agent may use any algorithm to determine the underline’s position. In horizontal line layout, the underline should be aligned as for alphabetic. In vertical line layout, if the language is set to Japanese or Korean, the underline should be aligned as for over. */
		'auto': text_underline_position

		/** The underline is aligned with the under edge of the element’s content box. */
		'below': text_underline_position

	}

	interface break_after {
		/** Always force a page break before/after the generated box. */
		'always': break_after

		/** Neither force nor forbid a page/column break before/after the principal box. */
		'auto': break_after

		/** Avoid a break before/after the principal box. */
		'avoid': break_after

		/** Avoid a column break before/after the principal box. */
		'avoid-column': break_after

		/** Avoid a page break before/after the principal box. */
		'avoid-page': break_after

		/** Always force a column break before/after the principal box. */
		'column': break_after

		/** Force one or two page breaks before/after the generated box so that the next page is formatted as a left page. */
		'left': break_after

		/** Always force a page break before/after the principal box. */
		'page': break_after

		/** Force one or two page breaks before/after the generated box so that the next page is formatted as a right page. */
		'right': break_after

	}

	interface break_before {
		/** Always force a page break before/after the generated box. */
		'always': break_before

		/** Neither force nor forbid a page/column break before/after the principal box. */
		'auto': break_before

		/** Avoid a break before/after the principal box. */
		'avoid': break_before

		/** Avoid a column break before/after the principal box. */
		'avoid-column': break_before

		/** Avoid a page break before/after the principal box. */
		'avoid-page': break_before

		/** Always force a column break before/after the principal box. */
		'column': break_before

		/** Force one or two page breaks before/after the generated box so that the next page is formatted as a left page. */
		'left': break_before

		/** Always force a page break before/after the principal box. */
		'page': break_before

		/** Force one or two page breaks before/after the generated box so that the next page is formatted as a right page. */
		'right': break_before

	}

	interface mask_type {
		/** Indicates that the alpha values of the mask should be used. */
		'alpha': mask_type

		/** Indicates that the luminance values of the mask should be used. */
		'luminance': mask_type

	}

	interface column_rule_width {
	}

	interface row_gap {
	}

	interface text_orientation {
		/** This value is equivalent to 'sideways-right' in 'vertical-rl' writing mode and equivalent to 'sideways-left' in 'vertical-lr' writing mode. */
		'sideways': text_orientation

		/** In vertical writing modes, this causes text to be set as if in a horizontal layout, but rotated 90° clockwise. */
		'sideways-right': text_orientation

		/** In vertical writing modes, characters from horizontal-only scripts are rendered upright, i.e. in their standard horizontal orientation. */
		'upright': text_orientation

	}

	interface scroll_padding {
	}

	interface grid_template {
		/** Sets all three properties to their initial values. */
		'none': grid_template

		/** Represents the largest min-content contribution of the grid items occupying the grid track. */
		'min-content': grid_template

		/** Represents the largest max-content contribution of the grid items occupying the grid track. */
		'max-content': grid_template

		/** As a maximum, identical to 'max-content'. As a minimum, represents the largest minimum size (as specified by min-width/min-height) of the grid items occupying the grid track. */
		'auto': grid_template

		/** Sets 'grid-template-rows' and 'grid-template-columns' to 'subgrid', and 'grid-template-areas' to its initial value. */
		'subgrid': grid_template

		/** Defines a size range greater than or equal to min and less than or equal to max. */
		'minmax()': grid_template

		/** Represents a repeated fragment of the track list, allowing a large number of columns or rows that exhibit a recurring pattern to be written in a more compact form. */
		'repeat()': grid_template

	}

	interface border_inline_end_color {
	}

	interface border_inline_start_color {
	}

	interface scroll_snap_stop {
	}

	interface shape_margin {
	}

	interface shape_image_threshold {
	}

	interface gap {
	}

	interface min_inline_size {
	}

	interface image_orientation {
		/** After rotating by the precededing angle, the image is flipped horizontally. Defaults to 0deg if the angle is ommitted. */
		'flip': image_orientation

		/** If the image has an orientation specified in its metadata, such as EXIF, this value computes to the angle that the metadata specifies is necessary to correctly orient the image. */
		'from-image': image_orientation

	}

	interface inline_size {
		/** Depends on the values of other properties. */
		'auto': inline_size

	}

	interface padding_block_start {
	}

	interface padding_block_end {
	}

	interface text_combine_upright {
	}

	interface block_size {
		/** Depends on the values of other properties. */
		'auto': block_size

	}

	interface min_block_size {
	}

	interface scroll_padding_top {
	}

	interface border_inline_end_style {
	}

	interface border_block_start_width {
	}

	interface border_block_end_width {
	}

	interface border_block_end_color {
	}

	interface border_inline_start_style {
	}

	interface border_block_start_color {
	}

	interface border_block_end_style {
	}

	interface border_block_start_style {
	}

	interface font_variation_settings {
	}

	interface paint_order {
		'fill': paint_order

		'markers': paint_order

		/** The element is painted with the standard order of painting operations: the 'fill' is painted first, then its 'stroke' and finally its markers. */
		'normal': paint_order

		'stroke': paint_order

	}

	interface color_interpolation_filters {
		/** Color operations are not required to occur in a particular color space. */
		'auto': color_interpolation_filters

		/** Color operations should occur in the linearized RGB color space. */
		'linearRGB': color_interpolation_filters

		/** Color operations should occur in the sRGB color space. */
		'sRGB': color_interpolation_filters

	}

	interface marker_end {
		/** Indicates that no marker symbol will be drawn at the given vertex or vertices. */
		'none': marker_end

		/** Indicates that the <marker> element referenced will be used. */
		'url()': marker_end

	}

	interface scroll_padding_left {
	}

	interface flood_color {
	}

	interface flood_opacity {
	}

	interface lighting_color {
	}

	interface marker_start {
		/** Indicates that no marker symbol will be drawn at the given vertex or vertices. */
		'none': marker_start

		/** Indicates that the <marker> element referenced will be used. */
		'url()': marker_start

	}

	interface marker_mid {
		/** Indicates that no marker symbol will be drawn at the given vertex or vertices. */
		'none': marker_mid

		/** Indicates that the <marker> element referenced will be used. */
		'url()': marker_mid

	}

	interface marker {
		/** Indicates that no marker symbol will be drawn at the given vertex or vertices. */
		'none': marker

		/** Indicates that the <marker> element referenced will be used. */
		'url()': marker

	}

	interface place_content {
	}

	interface offset_path {
	}

	interface offset_rotate {
	}

	interface offset_distance {
	}

	interface transform_box {
	}

	interface place_items {
	}

	interface max_inline_size {
		/** No limit on the height of the box. */
		'none': max_inline_size

	}

	interface max_block_size {
		/** No limit on the width of the box. */
		'none': max_block_size

	}

	interface ruby_position {
		/** The ruby text appears after the base. This is a relatively rare setting used in ideographic East Asian writing systems, most easily found in educational text. */
		'after': ruby_position

		/** The ruby text appears before the base. This is the most common setting used in ideographic East Asian writing systems. */
		'before': ruby_position

		'inline': ruby_position

		/** The ruby text appears on the right of the base. Unlike 'before' and 'after', this value is not relative to the text flow direction. */
		'right': ruby_position

	}

	interface scroll_padding_right {
	}

	interface scroll_padding_bottom {
	}

	interface scroll_padding_inline_start {
	}

	interface scroll_padding_block_start {
	}

	interface scroll_padding_block_end {
	}

	interface scroll_padding_inline_end {
	}

	interface place_self {
	}

	interface font_optical_sizing {
	}

	interface grid {
	}

	interface border_inline_start {
	}

	interface border_inline_end {
	}

	interface border_block_end {
	}

	interface offset {
	}

	interface border_block_start {
	}

	interface scroll_padding_block {
	}

	interface scroll_padding_inline {
	}

	interface overscroll_behavior_block {
	}

	interface overscroll_behavior_inline {
	}

	interface motion {
		/** No motion path gets created. */
		'none': motion

		/** Defines an SVG path as a string, with optional 'fill-rule' as the first argument. */
		'path()': motion

		/** Indicates that the object is rotated by the angle of the direction of the motion path. */
		'auto': motion

		/** Indicates that the object is rotated by the angle of the direction of the motion path plus 180 degrees. */
		'reverse': motion

	}

	interface font_size_adjust {
		/** Do not preserve the font’s x-height. */
		'none': font_size_adjust

	}

	interface inset {
	}

	interface text_justify {
		/** The UA determines the justification algorithm to follow, based on a balance between performance and adequate presentation quality. */
		'auto': text_justify

		/** Justification primarily changes spacing both at word separators and at grapheme cluster boundaries in all scripts except those in the connected and cursive groups. This value is sometimes used in e.g. Japanese, often with the 'text-align-last' property. */
		'distribute': text_justify

		'distribute-all-lines': text_justify

		/** Justification primarily changes spacing at word separators and at grapheme cluster boundaries in clustered scripts. This value is typically used for Southeast Asian scripts such as Thai. */
		'inter-cluster': text_justify

		/** Justification primarily changes spacing at word separators and at inter-graphemic boundaries in scripts that use no word spaces. This value is typically used for CJK languages. */
		'inter-ideograph': text_justify

		/** Justification primarily changes spacing at word separators. This value is typically used for languages that separate words using spaces, like English or (sometimes) Korean. */
		'inter-word': text_justify

		/** Justification primarily stretches Arabic and related scripts through the use of kashida or other calligraphic elongation. */
		'kashida': text_justify

		'newspaper': text_justify

	}

	interface motion_path {
		/** No motion path gets created. */
		'none': motion_path

		/** Defines an SVG path as a string, with optional 'fill-rule' as the first argument. */
		'path()': motion_path

	}

	interface inset_inline_start {
	}

	interface inset_inline_end {
	}

	interface scale {
	}

	interface rotate {
	}

	interface translate {
	}

	interface offset_anchor {
	}

	interface offset_position {
	}

	interface padding_block {
	}

	interface orientation {
	}

	interface user_zoom {
	}

	interface margin_block {
	}

	interface margin_inline {
	}

	interface padding_inline {
	}

	interface inset_block {
	}

	interface inset_inline {
	}

	interface border_block_color {
	}

	interface border_block {
	}

	interface border_inline {
	}

	interface inset_block_start {
	}

	interface inset_block_end {
	}

	interface enable_background {
		/** If the ancestor container element has a property of new, then all graphics elements within the current container are rendered both on the parent's background image and onto the target. */
		'accumulate': enable_background

		/** Create a new background image canvas. All children of the current container element can access the background, and they will be rendered onto both the parent's background image canvas in addition to the target device. */
		'new': enable_background

	}

	interface glyph_orientation_horizontal {
	}

	interface glyph_orientation_vertical {
		/** Sets the orientation based on the fullwidth or non-fullwidth characters and the most common orientation. */
		'auto': glyph_orientation_vertical

	}

	interface kerning {
		/** Indicates that the user agent should adjust inter-glyph spacing based on kerning tables that are included in the font that will be used. */
		'auto': kerning

	}

	interface image_resolution {
	}

	interface max_zoom {
	}

	interface min_zoom {
	}

	interface motion_offset {
	}

	interface motion_rotation {
		/** Indicates that the object is rotated by the angle of the direction of the motion path. */
		'auto': motion_rotation

		/** Indicates that the object is rotated by the angle of the direction of the motion path plus 180 degrees. */
		'reverse': motion_rotation

	}

	interface scroll_snap_points_x {
		/** No snap points are defined by this scroll container. */
		'none': scroll_snap_points_x

		/** Defines an interval at which snap points are defined, starting from the container’s relevant start edge. */
		'repeat()': scroll_snap_points_x

	}

	interface scroll_snap_points_y {
		/** No snap points are defined by this scroll container. */
		'none': scroll_snap_points_y

		/** Defines an interval at which snap points are defined, starting from the container’s relevant start edge. */
		'repeat()': scroll_snap_points_y

	}

	interface scroll_snap_coordinate {
		/** Specifies that this element does not contribute a snap point. */
		'none': scroll_snap_coordinate

	}

	interface scroll_snap_destination {
	}

	interface viewport_fit {
	}

	interface border_block_style {
	}

	interface border_block_width {
	}

	interface border_inline_color {
	}

	interface border_inline_style {
	}

	interface border_inline_width {
	}

	interface overflow_block {
	}

	interface additive_symbols {
	}

	interface alt {
	}

	interface behavior {
	}

	interface box_decoration_break {
		/** Each box is independently wrapped with the border and padding. */
		'clone': box_decoration_break

		/** The effect is as though the element were rendered with no breaks present, and then sliced by the breaks afterward. */
		'slice': box_decoration_break

	}

	interface fallback {
	}

	interface font_language_override {
		/** Implies that when rendering with OpenType fonts the language of the document is used to infer the OpenType language system, used to select language specific features when rendering. */
		'normal': font_language_override

	}

	interface font_synthesis {
		/** Disallow all synthetic faces. */
		'none': font_synthesis

		/** Allow synthetic italic faces. */
		'style': font_synthesis

		/** Allow synthetic bold faces. */
		'weight': font_synthesis

	}

	interface font_variant_alternates {
		/** Enables display of alternate annotation forms. */
		'annotation()': font_variant_alternates

		/** Enables display of specific character variants. */
		'character-variant()': font_variant_alternates

		/** Enables display of historical forms. */
		'historical-forms': font_variant_alternates

		/** None of the features are enabled. */
		'normal': font_variant_alternates

		/** Enables replacement of default glyphs with ornaments, if provided in the font. */
		'ornaments()': font_variant_alternates

		/** Enables display with stylistic sets. */
		'styleset()': font_variant_alternates

		/** Enables display of stylistic alternates. */
		'stylistic()': font_variant_alternates

		/** Enables display of swash glyphs. */
		'swash()': font_variant_alternates

	}

	interface font_variant_position {
		/** None of the features are enabled. */
		'normal': font_variant_position

		/** Enables display of subscript variants (OpenType feature: subs). */
		'sub': font_variant_position

		/** Enables display of superscript variants (OpenType feature: sups). */
		'super': font_variant_position

	}

	interface ime_mode {
		/** The input method editor is initially active; text entry is performed using it unless the user specifically dismisses it. */
		'active': ime_mode

		/** No change is made to the current input method editor state. This is the default. */
		'auto': ime_mode

		/** The input method editor is disabled and may not be activated by the user. */
		'disabled': ime_mode

		/** The input method editor is initially inactive, but the user may activate it if they wish. */
		'inactive': ime_mode

		/** The IME state should be normal; this value can be used in a user style sheet to override the page setting. */
		'normal': ime_mode

	}

	interface mask_image {
		/** Counts as a transparent black image layer. */
		'none': mask_image

		/** Reference to a <mask element or to a CSS image. */
		'url()': mask_image

	}

	interface mask_mode {
		/** Alpha values of the mask layer image should be used as the mask values. */
		'alpha': mask_mode

		/** Use alpha values if 'mask-image' is an image, luminance if a <mask> element or a CSS image. */
		'auto': mask_mode

		/** Luminance values of the mask layer image should be used as the mask values. */
		'luminance': mask_mode

	}

	interface mask_origin {
	}

	interface mask_position {
	}

	interface mask_repeat {
	}

	interface mask_size {
		/** Resolved by using the image’s intrinsic ratio and the size of the other dimension, or failing that, using the image’s intrinsic size, or failing that, treating it as 100%. */
		'auto': mask_size

		/** Scale the image, while preserving its intrinsic aspect ratio (if any), to the largest size such that both its width and its height can fit inside the background positioning area. */
		'contain': mask_size

		/** Scale the image, while preserving its intrinsic aspect ratio (if any), to the smallest size such that both its width and its height can completely cover the background positioning area. */
		'cover': mask_size

	}

	interface nav_down {
		/** The user agent automatically determines which element to navigate the focus to in response to directional navigational input. */
		'auto': nav_down

		/** Indicates that the user agent should target the frame that the element is in. */
		'current': nav_down

		/** Indicates that the user agent should target the full window. */
		'root': nav_down

	}

	interface nav_index {
		/** The element's sequential navigation order is assigned automatically by the user agent. */
		'auto': nav_index

	}

	interface nav_left {
		/** The user agent automatically determines which element to navigate the focus to in response to directional navigational input. */
		'auto': nav_left

		/** Indicates that the user agent should target the frame that the element is in. */
		'current': nav_left

		/** Indicates that the user agent should target the full window. */
		'root': nav_left

	}

	interface nav_right {
		/** The user agent automatically determines which element to navigate the focus to in response to directional navigational input. */
		'auto': nav_right

		/** Indicates that the user agent should target the frame that the element is in. */
		'current': nav_right

		/** Indicates that the user agent should target the full window. */
		'root': nav_right

	}

	interface nav_up {
		/** The user agent automatically determines which element to navigate the focus to in response to directional navigational input. */
		'auto': nav_up

		/** Indicates that the user agent should target the frame that the element is in. */
		'current': nav_up

		/** Indicates that the user agent should target the full window. */
		'root': nav_up

	}

	interface negative {
	}

	interface offset_block_end {
		/** For non-replaced elements, the effect of this value depends on which of related properties have the value 'auto' as well. */
		'auto': offset_block_end

	}

	interface offset_block_start {
		/** For non-replaced elements, the effect of this value depends on which of related properties have the value 'auto' as well. */
		'auto': offset_block_start

	}

	interface offset_inline_end {
		/** For non-replaced elements, the effect of this value depends on which of related properties have the value 'auto' as well. */
		'auto': offset_inline_end

	}

	interface offset_inline_start {
		/** For non-replaced elements, the effect of this value depends on which of related properties have the value 'auto' as well. */
		'auto': offset_inline_start

	}

	interface pad {
	}

	interface prefix {
	}

	interface range {
		/** The range depends on the counter system. */
		'auto': range

		/** If used as the first value in a range, it represents negative infinity; if used as the second value, it represents positive infinity. */
		'infinite': range

	}

	interface ruby_align {
		/** The user agent determines how the ruby contents are aligned. This is the initial value. */
		'auto': ruby_align

		/** The ruby content is centered within its box. */
		'center': ruby_align

		/** If the width of the ruby text is smaller than that of the base, then the ruby text contents are evenly distributed across the width of the base, with the first and last ruby text glyphs lining up with the corresponding first and last base glyphs. If the width of the ruby text is at least the width of the base, then the letters of the base are evenly distributed across the width of the ruby text. */
		'distribute-letter': ruby_align

		/** If the width of the ruby text is smaller than that of the base, then the ruby text contents are evenly distributed across the width of the base, with a certain amount of white space preceding the first and following the last character in the ruby text. That amount of white space is normally equal to half the amount of inter-character space of the ruby text. */
		'distribute-space': ruby_align

		/** The ruby text content is aligned with the start edge of the base. */
		'left': ruby_align

		/** If the ruby text is not adjacent to a line edge, it is aligned as in 'auto'. If it is adjacent to a line edge, then it is still aligned as in auto, but the side of the ruby text that touches the end of the line is lined up with the corresponding edge of the base. */
		'line-edge': ruby_align

		/** The ruby text content is aligned with the end edge of the base. */
		'right': ruby_align

		/** The ruby text content is aligned with the start edge of the base. */
		'start': ruby_align

		/** The ruby content expands as defined for normal text justification (as defined by 'text-justify'), */
		'space-between': ruby_align

		/** As for 'space-between' except that there exists an extra justification opportunities whose space is distributed half before and half after the ruby content. */
		'space-around': ruby_align

	}

	interface ruby_overhang {
		/** The ruby text can overhang text adjacent to the base on either side. This is the initial value. */
		'auto': ruby_overhang

		/** The ruby text can overhang the text that follows it. */
		'end': ruby_overhang

		/** The ruby text cannot overhang any text adjacent to its base, only its own base. */
		'none': ruby_overhang

		/** The ruby text can overhang the text that precedes it. */
		'start': ruby_overhang

	}

	interface ruby_span {
		/** The value of attribute 'x' is a string value. The string value is evaluated as a <number> to determine the number of ruby base elements to be spanned by the annotation element. */
		'attr(x)': ruby_span

		/** No spanning. The computed value is '1'. */
		'none': ruby_span

	}

	interface scrollbar_3dlight_color {
	}

	interface scrollbar_arrow_color {
	}

	interface scrollbar_base_color {
	}

	interface scrollbar_darkshadow_color {
	}

	interface scrollbar_face_color {
	}

	interface scrollbar_highlight_color {
	}

	interface scrollbar_shadow_color {
	}

	interface scrollbar_track_color {
	}

	interface suffix {
	}

	interface system {
		/** Represents “sign-value” numbering systems, which, rather than using reusing digits in different positions to change their value, define additional digits with much larger values, so that the value of the number can be obtained by adding all the digits together. */
		'additive': system

		/** Interprets the list of counter symbols as digits to an alphabetic numbering system, similar to the default lower-alpha counter style, which wraps from "a", "b", "c", to "aa", "ab", "ac". */
		'alphabetic': system

		/** Cycles repeatedly through its provided symbols, looping back to the beginning when it reaches the end of the list. */
		'cyclic': system

		/** Use the algorithm of another counter style, but alter other aspects. */
		'extends': system

		/** Runs through its list of counter symbols once, then falls back. */
		'fixed': system

		/** interprets the list of counter symbols as digits to a "place-value" numbering system, similar to the default 'decimal' counter style. */
		'numeric': system

		/** Cycles repeatedly through its provided symbols, doubling, tripling, etc. the symbols on each successive pass through the list. */
		'symbolic': system

	}

	interface symbols {
	}

	interface aspect_ratio {
	}

	interface azimuth {
	}

	interface border_end_end_radius {
	}

	interface border_end_start_radius {
	}

	interface border_start_end_radius {
	}

	interface border_start_start_radius {
	}

	interface box_align {
	}

	interface box_direction {
	}

	interface box_flex {
	}

	interface box_flex_group {
	}

	interface box_lines {
	}

	interface box_ordinal_group {
	}

	interface box_orient {
	}

	interface box_pack {
	}

	interface color_adjust {
	}

	interface counter_set {
	}

	interface hanging_punctuation {
	}

	interface initial_letter {
	}

	interface initial_letter_align {
	}

	interface line_clamp {
	}

	interface line_height_step {
	}

	interface margin_trim {
	}

	interface mask_border {
	}

	interface mask_border_mode {
	}

	interface mask_border_outset {
	}

	interface mask_border_repeat {
	}

	interface mask_border_slice {
	}

	interface mask_border_source {
	}

	interface mask_border_width {
	}

	interface mask_clip {
	}

	interface mask_composite {
	}

	interface max_lines {
	}

	interface overflow_clip_box {
	}

	interface overflow_inline {
	}

	interface overscroll_behavior {
	}

	interface overscroll_behavior_x {
	}

	interface overscroll_behavior_y {
	}

	interface ruby_merge {
	}

	interface scrollbar_color {
	}

	interface scrollbar_width {
	}

	interface scroll_margin {
	}

	interface scroll_margin_block {
	}

	interface scroll_margin_block_start {
	}

	interface scroll_margin_block_end {
	}

	interface scroll_margin_bottom {
	}

	interface scroll_margin_inline {
	}

	interface scroll_margin_inline_start {
	}

	interface scroll_margin_inline_end {
	}

	interface scroll_margin_left {
	}

	interface scroll_margin_right {
	}

	interface scroll_margin_top {
	}

	interface scroll_snap_type_x {
	}

	interface scroll_snap_type_y {
	}

	interface text_decoration_thickness {
	}

	interface text_emphasis {
	}

	interface text_emphasis_color {
	}

	interface text_emphasis_position {
	}

	interface text_emphasis_style {
	}

	interface text_underline_offset {
	}

	interface speak_as {
	}

	interface bleed {
	}

	interface marks {
	}

	interface css$rule {
		/**
		Specifies the width of the content area, padding area or border area (depending on 'box-sizing') of certain boxes.
		@alias w
		*/
		'width'():void;
		/** @alias width */
		'w'():void;
		/**
		Specifies the height of the content area, padding area or border area (depending on 'box-sizing') of certain boxes.
		@alias h
		*/
		'height'():void;
		/** @alias height */
		'h'():void;
		/**
		In combination with 'float' and 'position', determines the type of box or boxes that are generated for an element.
		@alias d
		*/
		'display'():void;
		/** @alias display */
		'd'():void;
		/**
		Shorthand property to set values the thickness of the padding area. If left is omitted, it is the same as right. If bottom is omitted it is the same as top, if right is omitted it is the same as top. The value may not be negative.
		@alias p
		*/
		'padding'():void;
		/** @alias padding */
		'p'():void;
		/**
		The position CSS property sets how an element is positioned in a document. The top, right, bottom, and left properties determine the final location of positioned elements.
		@alias pos
		*/
		'position'():void;
		/** @alias position */
		'pos'():void;
		/**
		Shorthand property for setting border width, style, and color.
		@alias bd
		*/
		'border'():void;
		/** @alias border */
		'bd'():void;
		/**
		Shorthand property to set values the thickness of the margin area. If left is omitted, it is the same as right. If bottom is omitted it is the same as top, if right is omitted it is the same as top. Negative values for margin properties are allowed, but there may be implementation-specific limits.
		@alias m
		*/
		'margin'():void;
		/** @alias margin */
		'm'():void;
		/**
		Set asset as inline background svg
		*/
		'svg'():void;
		/**
		Specifies how far an absolutely positioned box's top margin edge is offset below the top edge of the box's 'containing block'.
		@alias t
		*/
		'top'():void;
		/** @alias top */
		't'():void;
		/**
		Specifies how far an absolutely positioned box's left margin edge is offset to the right of the left edge of the box's 'containing block'.
		@alias l
		*/
		'left'():void;
		/** @alias left */
		'l'():void;
		/**
		Shorthand property to set values the thickness of the margin area. If left is omitted, it is the same as right. If bottom is omitted it is the same as top, if right is omitted it is the same as top. Negative values for margin properties are allowed, but there may be implementation-specific limits..
		@alias mt
		*/
		'margin-top'():void;
		/** @alias margin-top */
		'mt'():void;
		/**
		Sets the color of an element's text
		@alias c
		*/
		'color'():void;
		/** @alias color */
		'c'():void;
		/**
		Indicates the desired height of glyphs from the font. For scalable fonts, the font-size is a scale factor applied to the EM unit of the font. (Note that certain glyphs may bleed outside their EM box.) For non-scalable fonts, the font-size is converted into absolute units and matched against the declared font-size of the font, using the same absolute coordinate space for both of the matched values.
		@alias fs
		*/
		'font-size'():void;
		/** @alias font-size */
		'fs'():void;
		/**
		Sets the background color of an element.
		@alias bgc
		*/
		'background-color'():void;
		/** @alias background-color */
		'bgc'():void;
		/**
		Describes how inline contents of a block are horizontally aligned if the contents do not completely fill the line box.
		@alias ta
		*/
		'text-align'():void;
		/** @alias text-align */
		'ta'():void;
		/**
		Opacity of an element's text, where 1 is opaque and 0 is entirely transparent.
		@alias o
		*/
		'opacity'():void;
		/** @alias opacity */
		'o'():void;
		/**
		Shorthand property for setting most background properties at the same place in the style sheet.
		@alias bg
		*/
		'background'():void;
		/** @alias background */
		'bg'():void;
		/**
		Specifies weight of glyphs in the font, their degree of blackness or stroke thickness.
		@alias fw
		*/
		'font-weight'():void;
		/** @alias font-weight */
		'fw'():void;
		/**
		Shorthand for setting 'overflow-x' and 'overflow-y'.
		@alias of
		*/
		'overflow'():void;
		/** @alias overflow */
		'of'():void;
		/**
		Specifies a prioritized list of font family names or generic family names. A user agent iterates through the list of family names until it matches an available font that contains a glyph for the character to be rendered.
		@alias ff
		*/
		'font-family'():void;
		/** @alias font-family */
		'ff'():void;
		/**
		Specifies how a box should be floated. It may be set for any element, but only applies to elements that generate boxes that are not absolutely positioned.
		*/
		'float'():void;
		/**
		Determines the block-progression dimension of the text content area of an inline box.
		@alias lh
		*/
		'line-height'():void;
		/** @alias line-height */
		'lh'():void;
		/**
		Specifies the behavior of the 'width' and 'height' properties.
		*/
		'box-sizing'():void;
		/**
		Decorations applied to font used for an element's text.
		@alias td
		*/
		'text-decoration'():void;
		/** @alias text-decoration */
		'td'():void;
		/**
		For a positioned box, the 'z-index' property specifies the stack level of the box in the current stacking context and whether the box establishes a local stacking context.
		@alias zi
		*/
		'z-index'():void;
		/** @alias z-index */
		'zi'():void;
		/**
		Affects the vertical positioning of the inline boxes generated by an inline-level element inside a line box.
		@alias va
		*/
		'vertical-align'():void;
		/** @alias vertical-align */
		'va'():void;
		/**
		Allows control over cursor appearance in an element
		*/
		'cursor'():void;
		/**
		Shorthand property to set values the thickness of the margin area. If left is omitted, it is the same as right. If bottom is omitted it is the same as top, if right is omitted it is the same as top. Negative values for margin properties are allowed, but there may be implementation-specific limits..
		@alias ml
		*/
		'margin-left'():void;
		/** @alias margin-left */
		'ml'():void;
		/**
		Defines the radii of the outer border edge.
		@alias rd
		*/
		'border-radius'():void;
		/** @alias border-radius */
		'rd'():void;
		/**
		Shorthand property to set values the thickness of the margin area. If left is omitted, it is the same as right. If bottom is omitted it is the same as top, if right is omitted it is the same as top. Negative values for margin properties are allowed, but there may be implementation-specific limits..
		@alias mb
		*/
		'margin-bottom'():void;
		/** @alias margin-bottom */
		'mb'():void;
		/**
		Shorthand property to set values the thickness of the margin area. If left is omitted, it is the same as right. If bottom is omitted it is the same as top, if right is omitted it is the same as top. Negative values for margin properties are allowed, but there may be implementation-specific limits..
		@alias mr
		*/
		'margin-right'():void;
		/** @alias margin-right */
		'mr'():void;
		/**
		Specifies how far an absolutely positioned box's right margin edge is offset to the left of the right edge of the box's 'containing block'.
		@alias r
		*/
		'right'():void;
		/** @alias right */
		'r'():void;
		/**
		Shorthand property to set values the thickness of the padding area. If left is omitted, it is the same as right. If bottom is omitted it is the same as top, if right is omitted it is the same as top. The value may not be negative.
		@alias pl
		*/
		'padding-left'():void;
		/** @alias padding-left */
		'pl'():void;
		/**
		Shorthand property to set values the thickness of the padding area. If left is omitted, it is the same as right. If bottom is omitted it is the same as top, if right is omitted it is the same as top. The value may not be negative.
		@alias pt
		*/
		'padding-top'():void;
		/** @alias padding-top */
		'pt'():void;
		/**
		Allows authors to constrain content width to a certain range.
		*/
		'max-width'():void;
		/**
		Specifies how far an absolutely positioned box's bottom margin edge is offset above the bottom edge of the box's 'containing block'.
		@alias b
		*/
		'bottom'():void;
		/** @alias bottom */
		'b'():void;
		/**
		Determines which page-based occurrence of a given element is applied to a counter or string value.
		*/
		'content'():void;
		/**
		Attaches one or more drop-shadows to the box. The property is a comma-separated list of shadows, each specified by 2-4 length values, an optional color, and an optional 'inset' keyword. Omitted lengths are 0; omitted colors are a user agent chosen color.
		@alias shadow
		*/
		'box-shadow'():void;
		/** @alias box-shadow */
		'shadow'():void;
		/**
		Sets the background image(s) of an element.
		@alias bgi
		*/
		'background-image'():void;
		/** @alias background-image */
		'bgi'():void;
		/**
		Shorthand property to set values the thickness of the padding area. If left is omitted, it is the same as right. If bottom is omitted it is the same as top, if right is omitted it is the same as top. The value may not be negative.
		@alias pr
		*/
		'padding-right'():void;
		/** @alias padding-right */
		'pr'():void;
		/**
		Shorthand property for the 'white-space-collapsing' and 'text-wrap' properties.
		@alias ws
		*/
		'white-space'():void;
		/** @alias white-space */
		'ws'():void;
		/**
		Shorthand property to set values the thickness of the padding area. If left is omitted, it is the same as right. If bottom is omitted it is the same as top, if right is omitted it is the same as top. The value may not be negative.
		@alias pb
		*/
		'padding-bottom'():void;
		/** @alias padding-bottom */
		'pb'():void;
		/**
		Allows authors to constrain content height to a certain range.
		*/
		'min-height'():void;
		/**
		A two-dimensional transformation is applied to an element through the 'transform' property. This property contains a list of transform functions similar to those allowed by SVG.
		*/
		'transform'():void;
		/**
		Shorthand property for setting border width, style and color.
		@alias bdb
		*/
		'border-bottom'():void;
		/** @alias border-bottom */
		'bdb'():void;
		/**
		Specifies whether the boxes generated by an element are rendered. Invisible boxes still affect layout (set the ‘display’ property to ‘none’ to suppress box generation altogether).
		*/
		'visibility'():void;
		/**
		Specifies the initial position of the background image(s) (after any resizing) within their corresponding background positioning area.
		@alias bgp
		*/
		'background-position'():void;
		/** @alias background-position */
		'bgp'():void;
		/**
		Shorthand property for setting border width, style and color
		@alias bdt
		*/
		'border-top'():void;
		/** @alias border-top */
		'bdt'():void;
		/**
		Allows authors to constrain content width to a certain range.
		*/
		'min-width'():void;
		/**
		Shorthand property for 'outline-style', 'outline-width', and 'outline-color'.
		*/
		'outline'():void;
		/**
		Shorthand property combines four of the transition properties into a single property.
		@alias tween
		*/
		'transition'():void;
		/** @alias transition */
		'tween'():void;
		/**
		The color of the border around all four edges of an element.
		@alias bc
		*/
		'border-color'():void;
		/** @alias border-color */
		'bc'():void;
		/**
		Specifies how background images are tiled after they have been sized and positioned.
		@alias bgr
		*/
		'background-repeat'():void;
		/** @alias background-repeat */
		'bgr'():void;
		/**
		Controls capitalization effects of an element’s text.
		@alias tt
		*/
		'text-transform'():void;
		/** @alias text-transform */
		'tt'():void;
		/**
		Specifies the size of the background images.
		@alias bgs
		*/
		'background-size'():void;
		/** @alias background-size */
		'bgs'():void;
		/**
		Indicates which sides of an element's box(es) may not be adjacent to an earlier floating box. The 'clear' property does not consider floats inside the element itself or in other block formatting contexts.
		*/
		'clear'():void;
		/**
		Allows authors to constrain content height to a certain range.
		*/
		'max-height'():void;
		/**
		Shorthand for setting 'list-style-type', 'list-style-position' and 'list-style-image'
		*/
		'list-style'():void;
		/**
		Allows italic or oblique faces to be selected. Italic forms are generally cursive in nature while oblique faces are typically sloped versions of the regular face.
		*/
		'font-style'():void;
		/**
		Shorthand property for setting 'font-style', 'font-variant', 'font-weight', 'font-size', 'line-height', and 'font-family', at the same place in the style sheet. The syntax of this property is based on a traditional typographical shorthand notation to set multiple properties related to fonts.
		*/
		'font'():void;
		/**
		Shorthand property for setting border width, style and color
		@alias bdl
		*/
		'border-left'():void;
		/** @alias border-left */
		'bdl'():void;
		/**
		Shorthand property for setting border width, style and color
		@alias bdr
		*/
		'border-right'():void;
		/** @alias border-right */
		'bdr'():void;
		/**
		Text can overflow for example when it is prevented from wrapping.
		*/
		'text-overflow'():void;
		/**
		Shorthand that sets the four 'border-*-width' properties. If it has four values, they set top, right, bottom and left in that order. If left is missing, it is the same as right; if bottom is missing, it is the same as top; if right is missing, it is the same as top.
		@alias bw
		*/
		'border-width'():void;
		/** @alias border-width */
		'bw'():void;
		/**
		Aligns flex items along the main axis of the current line of the flex container.
		@alias jc
		*/
		'justify-content'():void;
		/** @alias justify-content */
		'jc'():void;
		/**
		Aligns flex items along the cross axis of the current line of the flex container.
		@alias ai
		*/
		'align-items'():void;
		/** @alias align-items */
		'ai'():void;
		/**
		Specifies the handling of overflow in the vertical direction.
		@alias ofy
		*/
		'overflow-y'():void;
		/** @alias overflow-y */
		'ofy'():void;
		/**
		Specifies under what circumstances a given element can be the target element for a pointer event.
		@alias pe
		*/
		'pointer-events'():void;
		/** @alias pointer-events */
		'pe'():void;
		/**
		The style of the border around edges of an element.
		@alias bs
		*/
		'border-style'():void;
		/** @alias border-style */
		'bs'():void;
		/**
		Specifies the minimum, maximum, and optimal spacing between grapheme clusters.
		@alias ls
		*/
		'letter-spacing'():void;
		/** @alias letter-spacing */
		'ls'():void;
		/**
		Shorthand property combines six of the animation properties into a single property.
		*/
		'animation'():void;
		/**
		Specifies the handling of overflow in the horizontal direction.
		@alias ofx
		*/
		'overflow-x'():void;
		/** @alias overflow-x */
		'ofx'():void;
		/**
		Specifies how flex items are placed in the flex container, by setting the direction of the flex container’s main axis.
		@alias fld
		*/
		'flex-direction'():void;
		/** @alias flex-direction */
		'fld'():void;
		/**
		Specifies whether the UA may break within a word to prevent overflow when an otherwise-unbreakable string is too long to fit.
		*/
		'word-wrap'():void;
		/**
		Specifies the components of a flexible length: the flex grow factor and flex shrink factor, and the flex basis.
		@alias fl
		*/
		'flex'():void;
		/** @alias flex */
		'fl'():void;
		/**
		Selects a table's border model.
		*/
		'border-collapse'():void;
		/**
		Non-standard. Specifies the magnification scale of the object. See 'transform: scale()' for a standards-based alternative.
		*/
		'zoom'():void;
		/**
		Used to construct the default contents of a list item’s marker
		*/
		'list-style-type'():void;
		/**
		Defines the radii of the bottom left outer border edge.
		@alias rdbl
		*/
		'border-bottom-left-radius'():void;
		/** @alias border-bottom-left-radius */
		'rdbl'():void;
		/**
		Paints the interior of the given graphical element.
		*/
		'fill'():void;
		/**
		Establishes the origin of transformation for an element.
		@alias origin
		*/
		'transform-origin'():void;
		/** @alias transform-origin */
		'origin'():void;
		/**
		Controls whether the flex container is single-line or multi-line, and the direction of the cross-axis, which determines the direction new lines are stacked in.
		@alias flw
		*/
		'flex-wrap'():void;
		/** @alias flex-wrap */
		'flw'():void;
		/**
		Enables shadow effects to be applied to the text of the element.
		@alias ts
		*/
		'text-shadow'():void;
		/** @alias text-shadow */
		'ts'():void;
		/**
		Defines the radii of the top left outer border edge.
		@alias rdtl
		*/
		'border-top-left-radius'():void;
		/** @alias border-top-left-radius */
		'rdtl'():void;
		/**
		Controls the appearance of selection.
		@alias us
		*/
		'user-select'():void;
		/** @alias user-select */
		'us'():void;
		/**
		Deprecated. Use the 'clip-path' property when support allows. Defines the visible portion of an element’s box.
		*/
		'clip'():void;
		/**
		Defines the radii of the bottom right outer border edge.
		@alias rdbr
		*/
		'border-bottom-right-radius'():void;
		/** @alias border-bottom-right-radius */
		'rdbr'():void;
		/**
		Specifies line break opportunities for non-CJK scripts.
		*/
		'word-break'():void;
		/**
		Defines the radii of the top right outer border edge.
		@alias rdtr
		*/
		'border-top-right-radius'():void;
		/** @alias border-top-right-radius */
		'rdtr'():void;
		/**
		Sets the flex grow factor. Negative numbers are invalid.
		@alias flg
		*/
		'flex-grow'():void;
		/** @alias flex-grow */
		'flg'():void;
		/**
		Sets the color of the top border.
		@alias bct
		*/
		'border-top-color'():void;
		/** @alias border-top-color */
		'bct'():void;
		/**
		Sets the color of the bottom border.
		@alias bcb
		*/
		'border-bottom-color'():void;
		/** @alias border-bottom-color */
		'bcb'():void;
		/**
		Sets the flex shrink factor. Negative numbers are invalid.
		@alias fls
		*/
		'flex-shrink'():void;
		/** @alias flex-shrink */
		'fls'():void;
		/**
		The creator of SVG content might want to provide a hint to the implementation about what tradeoffs to make as it renders text. The ‘text-rendering’ property provides these hints.
		*/
		'text-rendering'():void;
		/**
		Allows the default alignment along the cross axis to be overridden for individual flex items.
		@alias as
		*/
		'align-self'():void;
		/** @alias align-self */
		'as'():void;
		/**
		Specifies the indentation applied to lines of inline content in a block. The indentation only affects the first line of inline content in the block unless the 'hanging' keyword is specified, in which case it affects all lines except the first.
		*/
		'text-indent'():void;
		/**
		Describes how the animation will progress over one cycle of its duration.
		*/
		'animation-timing-function'():void;
		/**
		The lengths specify the distance that separates adjoining cell borders. If one length is specified, it gives both the horizontal and vertical spacing. If two are specified, the first gives the horizontal spacing and the second the vertical spacing. Lengths may not be negative.
		*/
		'border-spacing'():void;
		/**
		Specifies the inline base direction or directionality of any bidi paragraph, embedding, isolate, or override established by the box. Note: for HTML content use the 'dir' attribute and 'bdo' element rather than this property.
		*/
		'direction'():void;
		/**
		Determines the background painting area.
		@alias bgclip
		*/
		'background-clip'():void;
		/** @alias background-clip */
		'bgclip'():void;
		/**
		Sets the color of the left border.
		@alias bcl
		*/
		'border-left-color'():void;
		/** @alias border-left-color */
		'bcl'():void;
		/**
		@font-face descriptor. Specifies the resource containing font data. It is required, whether the font is downloadable or locally installed.
		*/
		'src'():void;
		/**
		Determines whether touch input may trigger default behavior supplied by user agent.
		*/
		'touch-action'():void;
		/**
		Sets the color of the right border.
		@alias bcr
		*/
		'border-right-color'():void;
		/** @alias border-right-color */
		'bcr'():void;
		/**
		Specifies the name of the CSS property to which the transition is applied.
		*/
		'transition-property'():void;
		/**
		Defines a list of animations that apply. Each name is used to select the keyframe at-rule that provides the property values for the animation.
		*/
		'animation-name'():void;
		/**
		Processes an element’s rendering before it is displayed in the document, by applying one or more filter effects.
		*/
		'filter'():void;
		/**
		Defines the length of time that an animation takes to complete one cycle.
		*/
		'animation-duration'():void;
		/**
		Specifies whether the UA may break within a word to prevent overflow when an otherwise-unbreakable string is too long to fit within the line box.
		*/
		'overflow-wrap'():void;
		/**
		Defines when the transition will start. It allows a transition to begin execution some period of time from when it is applied.
		*/
		'transition-delay'():void;
		/**
		Paints along the outline of the given graphical element.
		*/
		'stroke'():void;
		/**
		Specifies variant representations of the font
		*/
		'font-variant'():void;
		/**
		Sets the thickness of the bottom border.
		@alias bwb
		*/
		'border-bottom-width'():void;
		/** @alias border-bottom-width */
		'bwb'():void;
		/**
		Defines when the animation will start.
		*/
		'animation-delay'():void;
		/**
		Sets the thickness of the top border.
		@alias bwt
		*/
		'border-top-width'():void;
		/** @alias border-top-width */
		'bwt'():void;
		/**
		Specifies how long the transition from the old value to the new value should take.
		*/
		'transition-duration'():void;
		/**
		Sets the flex basis.
		@alias flb
		*/
		'flex-basis'():void;
		/** @alias flex-basis */
		'flb'():void;
		/**
		Provides a rendering hint to the user agent, stating what kinds of changes the author expects to perform on the element.
		*/
		'will-change'():void;
		/**
		Defines what values are applied by the animation outside the time it is executing.
		*/
		'animation-fill-mode'():void;
		/**
		Width of the outline.
		*/
		'outline-width'():void;
		/**
		Controls the algorithm used to lay out the table cells, rows, and columns.
		*/
		'table-layout'():void;
		/**
		Specifies how the contents of a replaced element should be scaled relative to the box established by its used height and width.
		*/
		'object-fit'():void;
		/**
		Controls the order in which children of a flex container appear within the flex container, by assigning them to ordinal groups.
		*/
		'order'():void;
		/**
		Describes how the intermediate values used during a transition will be calculated.
		*/
		'transition-timing-function'():void;
		/**
		Specifies whether or not an element is resizable by the user, and if so, along which axis/axes.
		*/
		'resize'():void;
		/**
		Style of the outline.
		*/
		'outline-style'():void;
		/**
		Sets the thickness of the right border.
		@alias bwr
		*/
		'border-right-width'():void;
		/** @alias border-right-width */
		'bwr'():void;
		/**
		Specifies the width of the stroke on the current object.
		*/
		'stroke-width'():void;
		/**
		Defines the number of times an animation cycle is played. The default value is one, meaning the animation will play from beginning to end once.
		*/
		'animation-iteration-count'():void;
		/**
		Aligns a flex container’s lines within the flex container when there is extra space in the cross-axis, similar to how 'justify-content' aligns individual items within the main-axis.
		@alias ac
		*/
		'align-content'():void;
		/** @alias align-content */
		'ac'():void;
		/**
		Offset the outline and draw it beyond the border edge.
		*/
		'outline-offset'():void;
		/**
		Determines whether or not the 'back' side of a transformed element is visible when facing the viewer. With an identity transform, the front side of an element faces the viewer.
		*/
		'backface-visibility'():void;
		/**
		Sets the thickness of the left border.
		@alias bwl
		*/
		'border-left-width'():void;
		/** @alias border-left-width */
		'bwl'():void;
		/**
		Specifies how flexbox items are placed in the flexbox.
		@alias flf
		*/
		'flex-flow'():void;
		/** @alias flex-flow */
		'flf'():void;
		/**
		Changes the appearance of buttons and other controls to resemble native controls.
		*/
		'appearance'():void;
		/**
		The level of embedding with respect to the bidirectional algorithm.
		*/
		'unicode-bidi'():void;
		/**
		Controls the pattern of dashes and gaps used to stroke paths.
		*/
		'stroke-dasharray'():void;
		/**
		Specifies the distance into the dash pattern to start the dash.
		*/
		'stroke-dashoffset'():void;
		/**
		@font-face descriptor. Defines the set of Unicode codepoints that may be supported by the font face for which it is declared.
		*/
		'unicode-range'():void;
		/**
		Specifies additional spacing between “words”.
		*/
		'word-spacing'():void;
		/**
		The text-size-adjust CSS property controls the text inflation algorithm used on some smartphones and tablets. Other browsers will ignore this property.
		*/
		'text-size-adjust'():void;
		/**
		Sets the style of the top border.
		@alias bst
		*/
		'border-top-style'():void;
		/** @alias border-top-style */
		'bst'():void;
		/**
		Sets the style of the bottom border.
		@alias bsb
		*/
		'border-bottom-style'():void;
		/** @alias border-bottom-style */
		'bsb'():void;
		/**
		Defines whether or not the animation should play in reverse on alternate cycles.
		*/
		'animation-direction'():void;
		/**
		Provides a hint to the user-agent about what aspects of an image are most important to preserve when the image is scaled, to aid the user-agent in the choice of an appropriate scaling algorithm.
		*/
		'image-rendering'():void;
		/**
		Applies the same transform as the perspective(<number>) transform function, except that it applies only to the positioned or transformed children of the element, not to the transform on the element itself.
		*/
		'perspective'():void;
		/**
		specifies, as a space-separated track list, the line names and track sizing functions of the grid.
		@alias gtc
		*/
		'grid-template-columns'():void;
		/** @alias grid-template-columns */
		'gtc'():void;
		/**
		Specifies the position of the '::marker' pseudo-element's box in the list item.
		*/
		'list-style-position'():void;
		/**
		Provides low-level control over OpenType font features. It is intended as a way of providing access to font features that are not widely used but are needed for a particular use case.
		*/
		'font-feature-settings'():void;
		/**
		Indicates that an element and its contents are, as much as possible, independent of the rest of the document tree.
		*/
		'contain'():void;
		/**
		If background images have been specified, this property specifies their initial position (after any resizing) within their corresponding background positioning area.
		*/
		'background-position-x'():void;
		/**
		Defines how nested elements are rendered in 3D space.
		*/
		'transform-style'():void;
		/**
		For elements rendered as a single box, specifies the background positioning area. For elements rendered as multiple boxes (e.g., inline boxes on several lines, boxes on several pages) specifies which boxes 'box-decoration-break' operates on to determine the background positioning area(s).
		@alias bgo
		*/
		'background-origin'():void;
		/** @alias background-origin */
		'bgo'():void;
		/**
		Sets the style of the left border.
		@alias bsl
		*/
		'border-left-style'():void;
		/** @alias border-left-style */
		'bsl'():void;
		/**
		The font-display descriptor determines how a font face is displayed based on whether and when it is downloaded and ready to use.
		*/
		'font-display'():void;
		/**
		Specifies a clipping path where everything inside the path is visible and everything outside is clipped out.
		*/
		'clip-path'():void;
		/**
		Controls whether hyphenation is allowed to create more break opportunities within a line of text.
		*/
		'hyphens'():void;
		/**
		Specifies whether the background images are fixed with regard to the viewport ('fixed') or scroll along with the element ('scroll') or its contents ('local').
		@alias bga
		*/
		'background-attachment'():void;
		/** @alias background-attachment */
		'bga'():void;
		/**
		Sets the style of the right border.
		@alias bsr
		*/
		'border-right-style'():void;
		/** @alias border-right-style */
		'bsr'():void;
		/**
		The color of the outline.
		*/
		'outline-color'():void;
		/**
		Logical 'margin-bottom'. Mapping depends on the parent element’s 'writing-mode', 'direction', and 'text-orientation'.
		*/
		'margin-block-end'():void;
		/**
		Defines whether the animation is running or paused.
		*/
		'animation-play-state'():void;
		/**
		Specifies quotation marks for any number of embedded quotations.
		*/
		'quotes'():void;
		/**
		If background images have been specified, this property specifies their initial position (after any resizing) within their corresponding background positioning area.
		*/
		'background-position-y'():void;
		/**
		Selects a normal, condensed, or expanded face from a font family.
		*/
		'font-stretch'():void;
		/**
		Specifies the shape to be used at the end of open subpaths when they are stroked.
		*/
		'stroke-linecap'():void;
		/**
		Determines the alignment of the replaced element inside its box.
		*/
		'object-position'():void;
		/**
		Property accepts one or more names of counters (identifiers), each one optionally followed by an integer. The integer gives the value that the counter is set to on each occurrence of the element.
		*/
		'counter-reset'():void;
		/**
		Logical 'margin-top'. Mapping depends on the parent element’s 'writing-mode', 'direction', and 'text-orientation'.
		*/
		'margin-block-start'():void;
		/**
		Manipulate the value of existing counters.
		*/
		'counter-increment'():void;
		/**
		undefined
		*/
		'size'():void;
		/**
		Specifies the color of text decoration (underlines overlines, and line-throughs) set on the element with text-decoration-line.
		@alias tdc
		*/
		'text-decoration-color'():void;
		/** @alias text-decoration-color */
		'tdc'():void;
		/**
		Sets the image that will be used as the list item marker. When the image is available, it will replace the marker set with the 'list-style-type' marker.
		*/
		'list-style-image'():void;
		/**
		Describes the optimal number of columns into which the content of the element will be flowed.
		*/
		'column-count'():void;
		/**
		Shorthand property for setting 'border-image-source', 'border-image-slice', 'border-image-width', 'border-image-outset' and 'border-image-repeat'. Omitted values are set to their initial values.
		*/
		'border-image'():void;
		/**
		Sets the gap between columns. If there is a column rule between columns, it will appear in the middle of the gap.
		@alias cg
		*/
		'column-gap'():void;
		/** @alias column-gap */
		'cg'():void;
		/**
		Defines rules for page breaks inside an element.
		*/
		'page-break-inside'():void;
		/**
		Specifies the opacity of the painting operation used to paint the interior the current object.
		*/
		'fill-opacity'():void;
		/**
		Logical 'padding-left'. Mapping depends on the parent element’s 'writing-mode', 'direction', and 'text-orientation'.
		*/
		'padding-inline-start'():void;
		/**
		In the separated borders model, this property controls the rendering of borders and backgrounds around cells that have no visible content.
		*/
		'empty-cells'():void;
		/**
		Specifies control over which ligatures are enabled or disabled. A value of ‘normal’ implies that the defaults set by the font are used.
		*/
		'font-variant-ligatures'():void;
		/**
		The text-decoration-skip CSS property specifies what parts of the element’s content any text decoration affecting the element must skip over. It controls all text decoration lines drawn by the element and also any text decoration lines drawn by its ancestors.
		*/
		'text-decoration-skip'():void;
		/**
		Defines the way of justifying a box inside its container along the appropriate axis.
		@alias js
		*/
		'justify-self'():void;
		/** @alias justify-self */
		'js'():void;
		/**
		Defines rules for page breaks after an element.
		*/
		'page-break-after'():void;
		/**
		specifies, as a space-separated track list, the line names and track sizing functions of the grid.
		@alias gtr
		*/
		'grid-template-rows'():void;
		/** @alias grid-template-rows */
		'gtr'():void;
		/**
		Logical 'padding-right'. Mapping depends on the parent element’s 'writing-mode', 'direction', and 'text-orientation'.
		*/
		'padding-inline-end'():void;
		/**
		Shorthand that specifies the gutters between grid columns and grid rows in one declaration. Replaced by 'gap' property.
		*/
		'grid-gap'():void;
		/**
		Shorthand that resets all properties except 'direction' and 'unicode-bidi'.
		*/
		'all'():void;
		/**
		Shorthand for 'grid-column-start' and 'grid-column-end'.
		@alias gc
		*/
		'grid-column'():void;
		/** @alias grid-column */
		'gc'():void;
		/**
		Specifies the opacity of the painting operation used to stroke the current object.
		*/
		'stroke-opacity'():void;
		/**
		Logical 'margin-left'. Mapping depends on the parent element’s 'writing-mode', 'direction', and 'text-orientation'.
		*/
		'margin-inline-start'():void;
		/**
		Logical 'margin-right'. Mapping depends on the parent element’s 'writing-mode', 'direction', and 'text-orientation'.
		*/
		'margin-inline-end'():void;
		/**
		Controls the color of the text insertion indicator.
		*/
		'caret-color'():void;
		/**
		Specifies the minimum number of line boxes in a block container that must be left in a fragment before a fragmentation break.
		*/
		'orphans'():void;
		/**
		Specifies the position of the caption box with respect to the table box.
		*/
		'caption-side'():void;
		/**
		Establishes the origin for the perspective property. It effectively sets the X and Y position at which the viewer appears to be looking at the children of the element.
		*/
		'perspective-origin'():void;
		/**
		Indicates what color to use at that gradient stop.
		*/
		'stop-color'():void;
		/**
		Specifies the minimum number of line boxes of a block container that must be left in a fragment after a break.
		*/
		'widows'():void;
		/**
		Specifies the scrolling behavior for a scrolling box, when scrolling happens due to navigation or CSSOM scrolling APIs.
		*/
		'scroll-behavior'():void;
		/**
		Specifies the gutters between grid columns. Replaced by 'column-gap' property.
		@alias gcg
		*/
		'grid-column-gap'():void;
		/** @alias grid-column-gap */
		'gcg'():void;
		/**
		A shorthand property which sets both 'column-width' and 'column-count'.
		*/
		'columns'():void;
		/**
		Describes the width of columns in multicol elements.
		*/
		'column-width'():void;
		/**
		Defines the formula that must be used to mix the colors with the backdrop.
		*/
		'mix-blend-mode'():void;
		/**
		Kerning is the contextual adjustment of inter-glyph spacing. This property controls metric kerning, kerning that utilizes adjustment data contained in the font.
		*/
		'font-kerning'():void;
		/**
		Specifies inward offsets from the top, right, bottom, and left edges of the image, dividing it into nine regions: four corners, four edges and a middle.
		*/
		'border-image-slice'():void;
		/**
		Specifies how the images for the sides and the middle part of the border image are scaled and tiled. If the second keyword is absent, it is assumed to be the same as the first.
		*/
		'border-image-repeat'():void;
		/**
		The four values of 'border-image-width' specify offsets that are used to divide the border image area into nine parts. They represent inward distances from the top, right, bottom, and left sides of the area, respectively.
		*/
		'border-image-width'():void;
		/**
		Shorthand for 'grid-row-start' and 'grid-row-end'.
		@alias gr
		*/
		'grid-row'():void;
		/** @alias grid-row */
		'gr'():void;
		/**
		Determines the width of the tab character (U+0009), in space characters (U+0020), when rendered.
		*/
		'tab-size'():void;
		/**
		Specifies the gutters between grid rows. Replaced by 'row-gap' property.
		@alias grg
		*/
		'grid-row-gap'():void;
		/** @alias grid-row-gap */
		'grg'():void;
		/**
		Specifies the line style for underline, line-through and overline text decoration.
		@alias tds
		*/
		'text-decoration-style'():void;
		/** @alias text-decoration-style */
		'tds'():void;
		/**
		Specifies what set of line breaking restrictions are in effect within the element.
		*/
		'line-break'():void;
		/**
		The values specify the amount by which the border image area extends beyond the border box on the top, right, bottom, and left sides respectively. If the fourth value is absent, it is the same as the second. If the third one is also absent, it is the same as the first. If the second one is also absent, it is the same as the first. Numbers represent multiples of the corresponding border-width.
		*/
		'border-image-outset'():void;
		/**
		Shorthand for setting 'column-rule-width', 'column-rule-style', and 'column-rule-color' at the same place in the style sheet. Omitted values are set to their initial values.
		*/
		'column-rule'():void;
		/**
		Defines the default justify-self for all items of the box, giving them the default way of justifying each box along the appropriate axis
		@alias ji
		*/
		'justify-items'():void;
		/** @alias justify-items */
		'ji'():void;
		/**
		Determine a grid item’s size and location within the grid by contributing a line, a span, or nothing (automatic) to its grid placement. Shorthand for 'grid-row-start', 'grid-column-start', 'grid-row-end', and 'grid-column-end'.
		@alias ga
		*/
		'grid-area'():void;
		/** @alias grid-area */
		'ga'():void;
		/**
		When two line segments meet at a sharp angle and miter joins have been specified for 'stroke-linejoin', it is possible for the miter to extend far beyond the thickness of the line stroking the path.
		*/
		'stroke-miterlimit'():void;
		/**
		Describes how the last line of a block or a line right before a forced line break is aligned when 'text-align' is set to 'justify'.
		*/
		'text-align-last'():void;
		/**
		The backdrop-filter CSS property lets you apply graphical effects such as blurring or color shifting to the area behind an element. Because it applies to everything behind the element, to see the effect you must make the element or its background at least partially transparent.
		*/
		'backdrop-filter'():void;
		/**
		Specifies the size of implicitly created rows.
		@alias gar
		*/
		'grid-auto-rows'():void;
		/** @alias grid-auto-rows */
		'gar'():void;
		/**
		Specifies the shape to be used at the corners of paths or basic shapes when they are stroked.
		*/
		'stroke-linejoin'():void;
		/**
		Specifies an orthogonal rotation to be applied to an image before it is laid out.
		*/
		'shape-outside'():void;
		/**
		Specifies what line decorations, if any, are added to the element.
		@alias tdl
		*/
		'text-decoration-line'():void;
		/** @alias text-decoration-line */
		'tdl'():void;
		/**
		The scroll-snap-align property specifies the box’s snap position as an alignment of its snap area (as the alignment subject) within its snap container’s snapport (as the alignment container). The two values specify the snapping alignment in the block axis and inline axis, respectively. If only one value is specified, the second value defaults to the same value.
		*/
		'scroll-snap-align'():void;
		/**
		Indicates the algorithm (or winding rule) which is to be used to determine what parts of the canvas are included inside the shape.
		*/
		'fill-rule'():void;
		/**
		Controls how the auto-placement algorithm works, specifying exactly how auto-placed items get flowed into the grid.
		@alias gaf
		*/
		'grid-auto-flow'():void;
		/** @alias grid-auto-flow */
		'gaf'():void;
		/**
		Defines how strictly snap points are enforced on the scroll container.
		*/
		'scroll-snap-type'():void;
		/**
		Defines rules for page breaks before an element.
		*/
		'page-break-before'():void;
		/**
		Determine a grid item’s size and location within the grid by contributing a line, a span, or nothing (automatic) to its grid placement.
		@alias gcs
		*/
		'grid-column-start'():void;
		/** @alias grid-column-start */
		'gcs'():void;
		/**
		Specifies named grid areas, which are not associated with any particular grid item, but can be referenced from the grid-placement properties.
		@alias gta
		*/
		'grid-template-areas'():void;
		/** @alias grid-template-areas */
		'gta'():void;
		/**
		Describes the page/column/region break behavior inside the principal box.
		*/
		'break-inside'():void;
		/**
		In continuous media, this property will only be consulted if the length of columns has been constrained. Otherwise, columns will automatically be balanced.
		*/
		'column-fill'():void;
		/**
		Determine a grid item’s size and location within the grid by contributing a line, a span, or nothing (automatic) to its grid placement.
		@alias gce
		*/
		'grid-column-end'():void;
		/** @alias grid-column-end */
		'gce'():void;
		/**
		Specifies an image to use instead of the border styles given by the 'border-style' properties and as an additional background layer for the element. If the value is 'none' or if the image cannot be displayed, the border styles will be used.
		*/
		'border-image-source'():void;
		/**
		The overflow-anchor CSS property provides a way to opt out browser scroll anchoring behavior which adjusts scroll position to minimize content shifts.
		@alias ofa
		*/
		'overflow-anchor'():void;
		/** @alias overflow-anchor */
		'ofa'():void;
		/**
		Determine a grid item’s size and location within the grid by contributing a line, a span, or nothing (automatic) to its grid placement.
		@alias grs
		*/
		'grid-row-start'():void;
		/** @alias grid-row-start */
		'grs'():void;
		/**
		Determine a grid item’s size and location within the grid by contributing a line, a span, or nothing (automatic) to its grid placement.
		@alias gre
		*/
		'grid-row-end'():void;
		/** @alias grid-row-end */
		'gre'():void;
		/**
		Specifies control over numerical forms.
		*/
		'font-variant-numeric'():void;
		/**
		Defines the blending mode of each background layer.
		*/
		'background-blend-mode'():void;
		/**
		The text-decoration-skip-ink CSS property specifies how overlines and underlines are drawn when they pass over glyph ascenders and descenders.
		@alias tdsi
		*/
		'text-decoration-skip-ink'():void;
		/** @alias text-decoration-skip-ink */
		'tdsi'():void;
		/**
		Sets the color of the column rule
		*/
		'column-rule-color'():void;
		/**
		In CSS setting to 'isolate' will turn the element into a stacking context. In SVG, it defines whether an element is isolated or not.
		*/
		'isolation'():void;
		/**
		Provides hints about what tradeoffs to make as it renders vector graphics elements such as <path> elements and basic shapes such as circles and rectangles.
		*/
		'shape-rendering'():void;
		/**
		Sets the style of the rule between columns of an element.
		*/
		'column-rule-style'():void;
		/**
		Logical 'border-right-width'. Mapping depends on the parent element’s 'writing-mode', 'direction', and 'text-orientation'.
		*/
		'border-inline-end-width'():void;
		/**
		Logical 'border-left-width'. Mapping depends on the parent element’s 'writing-mode', 'direction', and 'text-orientation'.
		*/
		'border-inline-start-width'():void;
		/**
		Specifies the size of implicitly created columns.
		@alias gac
		*/
		'grid-auto-columns'():void;
		/** @alias grid-auto-columns */
		'gac'():void;
		/**
		This is a shorthand property for both 'direction' and 'block-progression'.
		*/
		'writing-mode'():void;
		/**
		Indicates the algorithm which is to be used to determine what parts of the canvas are included inside the shape.
		*/
		'clip-rule'():void;
		/**
		Specifies control over capitalized forms.
		*/
		'font-variant-caps'():void;
		/**
		Used to align (start-, middle- or end-alignment) a string of text relative to a given point.
		*/
		'text-anchor'():void;
		/**
		Defines the opacity of a given gradient stop.
		*/
		'stop-opacity'():void;
		/**
		The mask CSS property alters the visibility of an element by either partially or fully hiding it. This is accomplished by either masking or clipping the image at specific points.
		*/
		'mask'():void;
		/**
		Describes the page/column break behavior after the generated box.
		*/
		'column-span'():void;
		/**
		Allows control of glyph substitute and positioning in East Asian text.
		*/
		'font-variant-east-asian'():void;
		/**
		Sets the position of an underline specified on the same element: it does not affect underlines specified by ancestor elements. This property is typically used in vertical writing contexts such as in Japanese documents where it often desired to have the underline appear 'over' (to the right of) the affected run of text
		*/
		'text-underline-position'():void;
		/**
		Describes the page/column/region break behavior after the generated box.
		*/
		'break-after'():void;
		/**
		Describes the page/column/region break behavior before the generated box.
		*/
		'break-before'():void;
		/**
		Defines whether the content of the <mask> element is treated as as luminance mask or alpha mask.
		*/
		'mask-type'():void;
		/**
		Sets the width of the rule between columns. Negative values are not allowed.
		*/
		'column-rule-width'():void;
		/**
		The row-gap CSS property specifies the gutter between grid rows.
		@alias rg
		*/
		'row-gap'():void;
		/** @alias row-gap */
		'rg'():void;
		/**
		Specifies the orientation of text within a line.
		*/
		'text-orientation'():void;
		/**
		The scroll-padding property is a shorthand property which sets all of the scroll-padding longhands, assigning values much like the padding property does for the padding-* longhands.
		*/
		'scroll-padding'():void;
		/**
		Shorthand for setting grid-template-columns, grid-template-rows, and grid-template-areas in a single declaration.
		@alias gt
		*/
		'grid-template'():void;
		/** @alias grid-template */
		'gt'():void;
		/**
		Logical 'border-right-color'. Mapping depends on the parent element’s 'writing-mode', 'direction', and 'text-orientation'.
		*/
		'border-inline-end-color'():void;
		/**
		Logical 'border-left-color'. Mapping depends on the parent element’s 'writing-mode', 'direction', and 'text-orientation'.
		*/
		'border-inline-start-color'():void;
		/**
		The scroll-snap-stop CSS property defines whether the scroll container is allowed to "pass over" possible snap positions.
		*/
		'scroll-snap-stop'():void;
		/**
		Adds a margin to a 'shape-outside'. This defines a new shape that is the smallest contour that includes all the points that are the 'shape-margin' distance outward in the perpendicular direction from a point on the underlying shape.
		*/
		'shape-margin'():void;
		/**
		Defines the alpha channel threshold used to extract the shape using an image. A value of 0.5 means that the shape will enclose all the pixels that are more than 50% opaque.
		*/
		'shape-image-threshold'():void;
		/**
		The gap CSS property is a shorthand property for row-gap and column-gap specifying the gutters between grid rows and columns.
		@alias g
		*/
		'gap'():void;
		/** @alias gap */
		'g'():void;
		/**
		Logical 'min-height'. Mapping depends on the element’s 'writing-mode'.
		*/
		'min-inline-size'():void;
		/**
		Specifies an orthogonal rotation to be applied to an image before it is laid out.
		*/
		'image-orientation'():void;
		/**
		Logical 'height'. Mapping depends on the element’s 'writing-mode'.
		*/
		'inline-size'():void;
		/**
		Logical 'padding-top'. Mapping depends on the parent element’s 'writing-mode', 'direction', and 'text-orientation'.
		*/
		'padding-block-start'():void;
		/**
		Logical 'padding-bottom'. Mapping depends on the parent element’s 'writing-mode', 'direction', and 'text-orientation'.
		*/
		'padding-block-end'():void;
		/**
		The text-combine-upright CSS property specifies the combination of multiple characters into the space of a single character. If the combined text is wider than 1em, the user agent must fit the contents within 1em. The resulting composition is treated as a single upright glyph for layout and decoration. This property only has an effect in vertical writing modes.

This is used to produce an effect that is known as tate-chū-yoko (縦中横) in Japanese, or as 直書橫向 in Chinese.
		*/
		'text-combine-upright'():void;
		/**
		Logical 'width'. Mapping depends on the element’s 'writing-mode'.
		*/
		'block-size'():void;
		/**
		Logical 'min-width'. Mapping depends on the element’s 'writing-mode'.
		*/
		'min-block-size'():void;
		/**
		The scroll-padding-top property defines offsets for the top of the optimal viewing region of the scrollport: the region used as the target region for placing things in view of the user. This allows the author to exclude regions of the scrollport that are obscured by other content (such as fixed-positioned toolbars or sidebars) or simply to put more breathing room between a targeted element and the edges of the scrollport.
		*/
		'scroll-padding-top'():void;
		/**
		Logical 'border-right-style'. Mapping depends on the parent element’s 'writing-mode', 'direction', and 'text-orientation'.
		*/
		'border-inline-end-style'():void;
		/**
		Logical 'border-top-width'. Mapping depends on the parent element’s 'writing-mode', 'direction', and 'text-orientation'.
		*/
		'border-block-start-width'():void;
		/**
		Logical 'border-bottom-width'. Mapping depends on the parent element’s 'writing-mode', 'direction', and 'text-orientation'.
		*/
		'border-block-end-width'():void;
		/**
		Logical 'border-bottom-color'. Mapping depends on the parent element’s 'writing-mode', 'direction', and 'text-orientation'.
		*/
		'border-block-end-color'():void;
		/**
		Logical 'border-left-style'. Mapping depends on the parent element’s 'writing-mode', 'direction', and 'text-orientation'.
		*/
		'border-inline-start-style'():void;
		/**
		Logical 'border-top-color'. Mapping depends on the parent element’s 'writing-mode', 'direction', and 'text-orientation'.
		*/
		'border-block-start-color'():void;
		/**
		Logical 'border-bottom-style'. Mapping depends on the parent element’s 'writing-mode', 'direction', and 'text-orientation'.
		*/
		'border-block-end-style'():void;
		/**
		Logical 'border-top-style'. Mapping depends on the parent element’s 'writing-mode', 'direction', and 'text-orientation'.
		*/
		'border-block-start-style'():void;
		/**
		The font-variation-settings CSS property provides low-level control over OpenType or TrueType font variations, by specifying the four letter axis names of the features you want to vary, along with their variation values.
		*/
		'font-variation-settings'():void;
		/**
		Controls the order that the three paint operations that shapes and text are rendered with: their fill, their stroke and any markers they might have.
		*/
		'paint-order'():void;
		/**
		Specifies the color space for imaging operations performed via filter effects.
		*/
		'color-interpolation-filters'():void;
		/**
		Specifies the marker that will be drawn at the last vertices of the given markable element.
		*/
		'marker-end'():void;
		/**
		The scroll-padding-left property defines offsets for the left of the optimal viewing region of the scrollport: the region used as the target region for placing things in view of the user. This allows the author to exclude regions of the scrollport that are obscured by other content (such as fixed-positioned toolbars or sidebars) or simply to put more breathing room between a targeted element and the edges of the scrollport.
		*/
		'scroll-padding-left'():void;
		/**
		Indicates what color to use to flood the current filter primitive subregion.
		*/
		'flood-color'():void;
		/**
		Indicates what opacity to use to flood the current filter primitive subregion.
		*/
		'flood-opacity'():void;
		/**
		Defines the color of the light source for filter primitives 'feDiffuseLighting' and 'feSpecularLighting'.
		*/
		'lighting-color'():void;
		/**
		Specifies the marker that will be drawn at the first vertices of the given markable element.
		*/
		'marker-start'():void;
		/**
		Specifies the marker that will be drawn at all vertices except the first and last.
		*/
		'marker-mid'():void;
		/**
		Specifies the marker symbol that shall be used for all points on the sets the value for all vertices on the given ‘path’ element or basic shape.
		*/
		'marker'():void;
		/**
		The place-content CSS shorthand property sets both the align-content and justify-content properties.
		*/
		'place-content'():void;
		/**
		The offset-path CSS property specifies the offset path where the element gets positioned. The exact element’s position on the offset path is determined by the offset-distance property. An offset path is either a specified path with one or multiple sub-paths or the geometry of a not-styled basic shape. Each shape or path must define an initial position for the computed value of "0" for offset-distance and an initial direction which specifies the rotation of the object to the initial position.

In this specification, a direction (or rotation) of 0 degrees is equivalent to the direction of the positive x-axis in the object’s local coordinate system. In other words, a rotation of 0 degree points to the right side of the UA if the object and its ancestors have no transformation applied.
		*/
		'offset-path'():void;
		/**
		The offset-rotate CSS property defines the direction of the element while positioning along the offset path.
		*/
		'offset-rotate'():void;
		/**
		The offset-distance CSS property specifies a position along an offset-path.
		*/
		'offset-distance'():void;
		/**
		The transform-box CSS property defines the layout box to which the transform and transform-origin properties relate.
		*/
		'transform-box'():void;
		/**
		The CSS place-items shorthand property sets both the align-items and justify-items properties. The first value is the align-items property value, the second the justify-items one. If the second value is not present, the first value is also used for it.
		*/
		'place-items'():void;
		/**
		Logical 'max-height'. Mapping depends on the element’s 'writing-mode'.
		*/
		'max-inline-size'():void;
		/**
		Logical 'max-width'. Mapping depends on the element’s 'writing-mode'.
		*/
		'max-block-size'():void;
		/**
		Used by the parent of elements with display: ruby-text to control the position of the ruby text with respect to its base.
		*/
		'ruby-position'():void;
		/**
		The scroll-padding-right property defines offsets for the right of the optimal viewing region of the scrollport: the region used as the target region for placing things in view of the user. This allows the author to exclude regions of the scrollport that are obscured by other content (such as fixed-positioned toolbars or sidebars) or simply to put more breathing room between a targeted element and the edges of the scrollport.
		*/
		'scroll-padding-right'():void;
		/**
		The scroll-padding-bottom property defines offsets for the bottom of the optimal viewing region of the scrollport: the region used as the target region for placing things in view of the user. This allows the author to exclude regions of the scrollport that are obscured by other content (such as fixed-positioned toolbars or sidebars) or simply to put more breathing room between a targeted element and the edges of the scrollport.
		*/
		'scroll-padding-bottom'():void;
		/**
		The scroll-padding-inline-start property defines offsets for the start edge in the inline dimension of the optimal viewing region of the scrollport: the region used as the target region for placing things in view of the user. This allows the author to exclude regions of the scrollport that are obscured by other content (such as fixed-positioned toolbars or sidebars) or simply to put more breathing room between a targeted element and the edges of the scrollport.
		*/
		'scroll-padding-inline-start'():void;
		/**
		The scroll-padding-block-start property defines offsets for the start edge in the block dimension of the optimal viewing region of the scrollport: the region used as the target region for placing things in view of the user. This allows the author to exclude regions of the scrollport that are obscured by other content (such as fixed-positioned toolbars or sidebars) or simply to put more breathing room between a targeted element and the edges of the scrollport.
		*/
		'scroll-padding-block-start'():void;
		/**
		The scroll-padding-block-end property defines offsets for the end edge in the block dimension of the optimal viewing region of the scrollport: the region used as the target region for placing things in view of the user. This allows the author to exclude regions of the scrollport that are obscured by other content (such as fixed-positioned toolbars or sidebars) or simply to put more breathing room between a targeted element and the edges of the scrollport.
		*/
		'scroll-padding-block-end'():void;
		/**
		The scroll-padding-inline-end property defines offsets for the end edge in the inline dimension of the optimal viewing region of the scrollport: the region used as the target region for placing things in view of the user. This allows the author to exclude regions of the scrollport that are obscured by other content (such as fixed-positioned toolbars or sidebars) or simply to put more breathing room between a targeted element and the edges of the scrollport.
		*/
		'scroll-padding-inline-end'():void;
		/**
		The place-self CSS property is a shorthand property sets both the align-self and justify-self properties. The first value is the align-self property value, the second the justify-self one. If the second value is not present, the first value is also used for it.
		*/
		'place-self'():void;
		/**
		The font-optical-sizing CSS property allows developers to control whether browsers render text with slightly differing visual representations to optimize viewing at different sizes, or not. This only works for fonts that have an optical size variation axis.
		*/
		'font-optical-sizing'():void;
		/**
		The grid CSS property is a shorthand property that sets all of the explicit grid properties ('grid-template-rows', 'grid-template-columns', and 'grid-template-areas'), and all the implicit grid properties ('grid-auto-rows', 'grid-auto-columns', and 'grid-auto-flow'), in a single declaration.
		*/
		'grid'():void;
		/**
		Logical 'border-left'. Mapping depends on the parent element’s 'writing-mode', 'direction', and 'text-orientation'.
		*/
		'border-inline-start'():void;
		/**
		Logical 'border-right'. Mapping depends on the parent element’s 'writing-mode', 'direction', and 'text-orientation'.
		*/
		'border-inline-end'():void;
		/**
		Logical 'border-bottom'. Mapping depends on the parent element’s 'writing-mode', 'direction', and 'text-orientation'.
		*/
		'border-block-end'():void;
		/**
		The offset CSS property is a shorthand property for animating an element along a defined path.
		*/
		'offset'():void;
		/**
		Logical 'border-top'. Mapping depends on the parent element’s 'writing-mode', 'direction', and 'text-orientation'.
		*/
		'border-block-start'():void;
		/**
		The scroll-padding-block property is a shorthand property which sets the scroll-padding longhands for the block dimension.
		*/
		'scroll-padding-block'():void;
		/**
		The scroll-padding-inline property is a shorthand property which sets the scroll-padding longhands for the inline dimension.
		*/
		'scroll-padding-inline'():void;
		/**
		The overscroll-behavior-block CSS property sets the browser's behavior when the block direction boundary of a scrolling area is reached.
		*/
		'overscroll-behavior-block'():void;
		/**
		The overscroll-behavior-inline CSS property sets the browser's behavior when the inline direction boundary of a scrolling area is reached.
		*/
		'overscroll-behavior-inline'():void;
		/**
		Shorthand property for setting 'motion-path', 'motion-offset' and 'motion-rotation'.
		*/
		'motion'():void;
		/**
		Preserves the readability of text when font fallback occurs by adjusting the font-size so that the x-height is the same regardless of the font used.
		*/
		'font-size-adjust'():void;
		/**
		The inset CSS property defines the logical block and inline start and end offsets of an element, which map to physical offsets depending on the element's writing mode, directionality, and text orientation. It corresponds to the top and bottom, or right and left properties depending on the values defined for writing-mode, direction, and text-orientation.
		*/
		'inset'():void;
		/**
		Selects the justification algorithm used when 'text-align' is set to 'justify'. The property applies to block containers, but the UA may (but is not required to) also support it on inline elements.
		*/
		'text-justify'():void;
		/**
		Specifies the motion path the element gets positioned at.
		*/
		'motion-path'():void;
		/**
		The inset-inline-start CSS property defines the logical inline start inset of an element, which maps to a physical offset depending on the element's writing mode, directionality, and text orientation. It corresponds to the top, right, bottom, or left property depending on the values defined for writing-mode, direction, and text-orientation.
		*/
		'inset-inline-start'():void;
		/**
		The inset-inline-end CSS property defines the logical inline end inset of an element, which maps to a physical inset depending on the element's writing mode, directionality, and text orientation. It corresponds to the top, right, bottom, or left property depending on the values defined for writing-mode, direction, and text-orientation.
		*/
		'inset-inline-end'():void;
		/**
		The scale CSS property allows you to specify scale transforms individually and independently of the transform property. This maps better to typical user interface usage, and saves having to remember the exact order of transform functions to specify in the transform value.
		@alias scale
		*/
		'scale'():void;
		/** @alias scale */
		'scale'():void;
		/**
		The rotate CSS property allows you to specify rotation transforms individually and independently of the transform property. This maps better to typical user interface usage, and saves having to remember the exact order of transform functions to specify in the transform value.
		@alias rotate
		*/
		'rotate'():void;
		/** @alias rotate */
		'rotate'():void;
		/**
		The translate CSS property allows you to specify translation transforms individually and independently of the transform property. This maps better to typical user interface usage, and saves having to remember the exact order of transform functions to specify in the transform value.
		*/
		'translate'():void;
		/**
		Defines an anchor point of the box positioned along the path. The anchor point specifies the point of the box which is to be considered as the point that is moved along the path.
		*/
		'offset-anchor'():void;
		/**
		Specifies the initial position of the offset path. If position is specified with static, offset-position would be ignored.
		*/
		'offset-position'():void;
		/**
		The padding-block CSS property defines the logical block start and end padding of an element, which maps to physical padding properties depending on the element's writing mode, directionality, and text orientation.
		*/
		'padding-block'():void;
		/**
		The orientation CSS @media media feature can be used to apply styles based on the orientation of the viewport (or the page box, for paged media).
		*/
		'orientation'():void;
		/**
		The user-zoom CSS descriptor controls whether or not the user can change the zoom factor of a document defined by @viewport.
		*/
		'user-zoom'():void;
		/**
		The margin-block CSS property defines the logical block start and end margins of an element, which maps to physical margins depending on the element's writing mode, directionality, and text orientation.
		*/
		'margin-block'():void;
		/**
		The margin-inline CSS property defines the logical inline start and end margins of an element, which maps to physical margins depending on the element's writing mode, directionality, and text orientation.
		*/
		'margin-inline'():void;
		/**
		The padding-inline CSS property defines the logical inline start and end padding of an element, which maps to physical padding properties depending on the element's writing mode, directionality, and text orientation.
		*/
		'padding-inline'():void;
		/**
		The inset-block CSS property defines the logical block start and end offsets of an element, which maps to physical offsets depending on the element's writing mode, directionality, and text orientation. It corresponds to the top and bottom, or right and left properties depending on the values defined for writing-mode, direction, and text-orientation.
		*/
		'inset-block'():void;
		/**
		The inset-inline CSS property defines the logical block start and end offsets of an element, which maps to physical offsets depending on the element's writing mode, directionality, and text orientation. It corresponds to the top and bottom, or right and left properties depending on the values defined for writing-mode, direction, and text-orientation.
		*/
		'inset-inline'():void;
		/**
		The border-block-color CSS property defines the color of the logical block borders of an element, which maps to a physical border color depending on the element's writing mode, directionality, and text orientation. It corresponds to the border-top-color and border-bottom-color, or border-right-color and border-left-color property depending on the values defined for writing-mode, direction, and text-orientation.
		*/
		'border-block-color'():void;
		/**
		The border-block CSS property is a shorthand property for setting the individual logical block border property values in a single place in the style sheet.
		*/
		'border-block'():void;
		/**
		The border-inline CSS property is a shorthand property for setting the individual logical inline border property values in a single place in the style sheet.
		*/
		'border-inline'():void;
		/**
		The inset-block-start CSS property defines the logical block start offset of an element, which maps to a physical offset depending on the element's writing mode, directionality, and text orientation. It corresponds to the top, right, bottom, or left property depending on the values defined for writing-mode, direction, and text-orientation.
		*/
		'inset-block-start'():void;
		/**
		The inset-block-end CSS property defines the logical block end offset of an element, which maps to a physical offset depending on the element's writing mode, directionality, and text orientation. It corresponds to the top, right, bottom, or left property depending on the values defined for writing-mode, direction, and text-orientation.
		*/
		'inset-block-end'():void;
		/**
		Deprecated. Use 'isolation' property instead when support allows. Specifies how the accumulation of the background image is managed.
		*/
		'enable-background'():void;
		/**
		Controls glyph orientation when the inline-progression-direction is horizontal.
		*/
		'glyph-orientation-horizontal'():void;
		/**
		Controls glyph orientation when the inline-progression-direction is vertical.
		*/
		'glyph-orientation-vertical'():void;
		/**
		Indicates whether the user agent should adjust inter-glyph spacing based on kerning tables that are included in the relevant font or instead disable auto-kerning and set inter-character spacing to a specific length.
		*/
		'kerning'():void;
		/**
		The image-resolution property specifies the intrinsic resolution of all raster images used in or on the element. It affects both content images (e.g. replaced elements and generated content) and decorative images (such as background-image). The intrinsic resolution of an image is used to determine the image’s intrinsic dimensions.
		*/
		'image-resolution'():void;
		/**
		The max-zoom CSS descriptor sets the maximum zoom factor of a document defined by the @viewport at-rule. The browser will not zoom in any further than this, whether automatically or at the user's request.

A zoom factor of 1.0 or 100% corresponds to no zooming. Larger values are zoomed in. Smaller values are zoomed out.
		*/
		'max-zoom'():void;
		/**
		The min-zoom CSS descriptor sets the minimum zoom factor of a document defined by the @viewport at-rule. The browser will not zoom out any further than this, whether automatically or at the user's request.

A zoom factor of 1.0 or 100% corresponds to no zooming. Larger values are zoomed in. Smaller values are zoomed out.
		*/
		'min-zoom'():void;
		/**
		A distance that describes the position along the specified motion path.
		*/
		'motion-offset'():void;
		/**
		Defines the direction of the element while positioning along the motion path.
		*/
		'motion-rotation'():void;
		/**
		Defines the positioning of snap points along the x axis of the scroll container it is applied to.
		*/
		'scroll-snap-points-x'():void;
		/**
		Defines the positioning of snap points along the y axis of the scroll container it is applied to.
		*/
		'scroll-snap-points-y'():void;
		/**
		Defines the x and y coordinate within the element which will align with the nearest ancestor scroll container’s snap-destination for the respective axis.
		*/
		'scroll-snap-coordinate'():void;
		/**
		Define the x and y coordinate within the scroll container’s visual viewport which element snap points will align with.
		*/
		'scroll-snap-destination'():void;
		/**
		The border-block-style CSS property defines the style of the logical block borders of an element, which maps to a physical border style depending on the element's writing mode, directionality, and text orientation.
		*/
		'viewport-fit'():void;
		/**
		The border-block-style CSS property defines the style of the logical block borders of an element, which maps to a physical border style depending on the element's writing mode, directionality, and text orientation. It corresponds to the border-top-style and border-bottom-style, or border-left-style and border-right-style properties depending on the values defined for writing-mode, direction, and text-orientation.
		*/
		'border-block-style'():void;
		/**
		The border-block-width CSS property defines the width of the logical block borders of an element, which maps to a physical border width depending on the element's writing mode, directionality, and text orientation. It corresponds to the border-top-width and border-bottom-width, or border-left-width, and border-right-width property depending on the values defined for writing-mode, direction, and text-orientation.
		*/
		'border-block-width'():void;
		/**
		The border-inline-color CSS property defines the color of the logical inline borders of an element, which maps to a physical border color depending on the element's writing mode, directionality, and text orientation. It corresponds to the border-top-color and border-bottom-color, or border-right-color and border-left-color property depending on the values defined for writing-mode, direction, and text-orientation.
		*/
		'border-inline-color'():void;
		/**
		The border-inline-style CSS property defines the style of the logical inline borders of an element, which maps to a physical border style depending on the element's writing mode, directionality, and text orientation. It corresponds to the border-top-style and border-bottom-style, or border-left-style and border-right-style properties depending on the values defined for writing-mode, direction, and text-orientation.
		*/
		'border-inline-style'():void;
		/**
		The border-inline-width CSS property defines the width of the logical inline borders of an element, which maps to a physical border width depending on the element's writing mode, directionality, and text orientation. It corresponds to the border-top-width and border-bottom-width, or border-left-width, and border-right-width property depending on the values defined for writing-mode, direction, and text-orientation.
		*/
		'border-inline-width'():void;
		/**
		The overflow-block CSS media feature can be used to test how the output device handles content that overflows the initial containing block along the block axis.
		*/
		'overflow-block'():void;
		/**
		@counter-style descriptor. Specifies the symbols used by the marker-construction algorithm specified by the system descriptor. Needs to be specified if the counter system is 'additive'.
		*/
		'additive-symbols'():void;
		/**
		Provides alternative text for assistive technology to replace the generated content of a ::before or ::after element.
		*/
		'alt'():void;
		/**
		IE only. Used to extend behaviors of the browser.
		*/
		'behavior'():void;
		/**
		Specifies whether individual boxes are treated as broken pieces of one continuous box, or whether each box is individually wrapped with the border and padding.
		*/
		'box-decoration-break'():void;
		/**
		@counter-style descriptor. Specifies a fallback counter style to be used when the current counter style can’t create a representation for a given counter value.
		*/
		'fallback'():void;
		/**
		The value of 'normal' implies that when rendering with OpenType fonts the language of the document is used to infer the OpenType language system, used to select language specific features when rendering.
		*/
		'font-language-override'():void;
		/**
		Controls whether user agents are allowed to synthesize bold or oblique font faces when a font family lacks bold or italic faces.
		*/
		'font-synthesis'():void;
		/**
		For any given character, fonts can provide a variety of alternate glyphs in addition to the default glyph for that character. This property provides control over the selection of these alternate glyphs.
		*/
		'font-variant-alternates'():void;
		/**
		Specifies the vertical position
		*/
		'font-variant-position'():void;
		/**
		Controls the state of the input method editor for text fields.
		*/
		'ime-mode'():void;
		/**
		Sets the mask layer image of an element.
		*/
		'mask-image'():void;
		/**
		Indicates whether the mask layer image is treated as luminance mask or alpha mask.
		*/
		'mask-mode'():void;
		/**
		Specifies the mask positioning area.
		*/
		'mask-origin'():void;
		/**
		Specifies how mask layer images are positioned.
		*/
		'mask-position'():void;
		/**
		Specifies how mask layer images are tiled after they have been sized and positioned.
		*/
		'mask-repeat'():void;
		/**
		Specifies the size of the mask layer images.
		*/
		'mask-size'():void;
		/**
		Provides an way to control directional focus navigation.
		*/
		'nav-down'():void;
		/**
		Provides an input-method-neutral way of specifying the sequential navigation order (also known as 'tabbing order').
		*/
		'nav-index'():void;
		/**
		Provides an way to control directional focus navigation.
		*/
		'nav-left'():void;
		/**
		Provides an way to control directional focus navigation.
		*/
		'nav-right'():void;
		/**
		Provides an way to control directional focus navigation.
		*/
		'nav-up'():void;
		/**
		@counter-style descriptor. Defines how to alter the representation when the counter value is negative.
		*/
		'negative'():void;
		/**
		Logical 'bottom'. Mapping depends on the parent element’s 'writing-mode', 'direction', and 'text-orientation'.
		*/
		'offset-block-end'():void;
		/**
		Logical 'top'. Mapping depends on the parent element’s 'writing-mode', 'direction', and 'text-orientation'.
		*/
		'offset-block-start'():void;
		/**
		Logical 'right'. Mapping depends on the parent element’s 'writing-mode', 'direction', and 'text-orientation'.
		*/
		'offset-inline-end'():void;
		/**
		Logical 'left'. Mapping depends on the parent element’s 'writing-mode', 'direction', and 'text-orientation'.
		*/
		'offset-inline-start'():void;
		/**
		@counter-style descriptor. Specifies a “fixed-width” counter style, where representations shorter than the pad value are padded with a particular <symbol>
		*/
		'pad'():void;
		/**
		@counter-style descriptor. Specifies a <symbol> that is prepended to the marker representation.
		*/
		'prefix'():void;
		/**
		@counter-style descriptor. Defines the ranges over which the counter style is defined.
		*/
		'range'():void;
		/**
		Specifies how text is distributed within the various ruby boxes when their contents do not exactly fill their respective boxes.
		*/
		'ruby-align'():void;
		/**
		Determines whether, and on which side, ruby text is allowed to partially overhang any adjacent text in addition to its own base, when the ruby text is wider than the ruby base.
		*/
		'ruby-overhang'():void;
		/**
		Determines whether, and on which side, ruby text is allowed to partially overhang any adjacent text in addition to its own base, when the ruby text is wider than the ruby base.
		*/
		'ruby-span'():void;
		/**
		Determines the color of the top and left edges of the scroll box and scroll arrows of a scroll bar.
		*/
		'scrollbar-3dlight-color'():void;
		/**
		Determines the color of the arrow elements of a scroll arrow.
		*/
		'scrollbar-arrow-color'():void;
		/**
		Determines the color of the main elements of a scroll bar, which include the scroll box, track, and scroll arrows.
		*/
		'scrollbar-base-color'():void;
		/**
		Determines the color of the gutter of a scroll bar.
		*/
		'scrollbar-darkshadow-color'():void;
		/**
		Determines the color of the scroll box and scroll arrows of a scroll bar.
		*/
		'scrollbar-face-color'():void;
		/**
		Determines the color of the top and left edges of the scroll box and scroll arrows of a scroll bar.
		*/
		'scrollbar-highlight-color'():void;
		/**
		Determines the color of the bottom and right edges of the scroll box and scroll arrows of a scroll bar.
		*/
		'scrollbar-shadow-color'():void;
		/**
		Determines the color of the track element of a scroll bar.
		*/
		'scrollbar-track-color'():void;
		/**
		@counter-style descriptor. Specifies a <symbol> that is appended to the marker representation.
		*/
		'suffix'():void;
		/**
		@counter-style descriptor. Specifies which algorithm will be used to construct the counter’s representation based on the counter value.
		*/
		'system'():void;
		/**
		@counter-style descriptor. Specifies the symbols used by the marker-construction algorithm specified by the system descriptor.
		*/
		'symbols'():void;
		/**
		The aspect-ratio   CSS property sets a preferred aspect ratio for the box, which will be used in the calculation of auto sizes and some other layout functions.
		*/
		'aspect-ratio'():void;
		/**
		In combination with elevation, the azimuth CSS property enables different audio sources to be positioned spatially for aural presentation. This is important in that it provides a natural way to tell several voices apart, as each can be positioned to originate at a different location on the sound stage. Stereo output produce a lateral sound stage, while binaural headphones and multi-speaker setups allow for a fully three-dimensional stage.
		*/
		'azimuth'():void;
		/**
		The border-end-end-radius CSS property defines a logical border radius on an element, which maps to a physical border radius that depends on on the element's writing-mode, direction, and text-orientation.
		*/
		'border-end-end-radius'():void;
		/**
		The border-end-start-radius CSS property defines a logical border radius on an element, which maps to a physical border radius depending on the element's writing-mode, direction, and text-orientation.
		*/
		'border-end-start-radius'():void;
		/**
		The border-start-end-radius CSS property defines a logical border radius on an element, which maps to a physical border radius depending on the element's writing-mode, direction, and text-orientation.
		*/
		'border-start-end-radius'():void;
		/**
		The border-start-start-radius CSS property defines a logical border radius on an element, which maps to a physical border radius that depends on the element's writing-mode, direction, and text-orientation.
		*/
		'border-start-start-radius'():void;
		/**
		The box-align CSS property specifies how an element aligns its contents across its layout in a perpendicular direction. The effect of the property is only visible if there is extra space in the box.
		*/
		'box-align'():void;
		/**
		The box-direction CSS property specifies whether a box lays out its contents normally (from the top or left edge), or in reverse (from the bottom or right edge).
		*/
		'box-direction'():void;
		/**
		The -moz-box-flex and -webkit-box-flex CSS properties specify how a -moz-box or -webkit-box grows to fill the box that contains it, in the direction of the containing box's layout.
		*/
		'box-flex'():void;
		/**
		The box-flex-group CSS property assigns the flexbox's child elements to a flex group.
		*/
		'box-flex-group'():void;
		/**
		The box-lines CSS property determines whether the box may have a single or multiple lines (rows for horizontally oriented boxes, columns for vertically oriented boxes).
		*/
		'box-lines'():void;
		/**
		The box-ordinal-group CSS property assigns the flexbox's child elements to an ordinal group.
		*/
		'box-ordinal-group'():void;
		/**
		The box-orient CSS property specifies whether an element lays out its contents horizontally or vertically.
		*/
		'box-orient'():void;
		/**
		The -moz-box-pack and -webkit-box-pack CSS properties specify how a -moz-box or -webkit-box packs its contents in the direction of its layout. The effect of this is only visible if there is extra space in the box.
		*/
		'box-pack'():void;
		/**
		The color-adjust property is a non-standard CSS extension that can be used to force printing of background colors and images in browsers based on the WebKit engine.
		*/
		'color-adjust'():void;
		/**
		The counter-set CSS property sets a CSS counter to a given value. It manipulates the value of existing counters, and will only create new counters if there isn't already a counter of the given name on the element.
		*/
		'counter-set'():void;
		/**
		The hanging-punctuation CSS property specifies whether a punctuation mark should hang at the start or end of a line of text. Hanging punctuation may be placed outside the line box.
		*/
		'hanging-punctuation'():void;
		/**
		The initial-letter CSS property specifies styling for dropped, raised, and sunken initial letters.
		*/
		'initial-letter'():void;
		/**
		The initial-letter-align CSS property specifies the alignment of initial letters within a paragraph.
		*/
		'initial-letter-align'():void;
		/**
		The line-clamp property allows limiting the contents of a block container to the specified number of lines; remaining content is fragmented away and neither rendered nor measured. Optionally, it also allows inserting content into the last line box to indicate the continuity of truncated/interrupted content.
		*/
		'line-clamp'():void;
		/**
		The line-height-step CSS property defines the step units for line box heights. When the step unit is positive, line box heights are rounded up to the closest multiple of the unit. Negative values are invalid.
		*/
		'line-height-step'():void;
		/**
		The margin-trim property allows the container to trim the margins of its children where they adjoin the container’s edges.
		*/
		'margin-trim'():void;
		/**
		The mask-border CSS property lets you create a mask along the edge of an element's border.

This property is a shorthand for mask-border-source, mask-border-slice, mask-border-width, mask-border-outset, mask-border-repeat, and mask-border-mode. As with all shorthand properties, any omitted sub-values will be set to their initial value.
		*/
		'mask-border'():void;
		/**
		The mask-border-mode CSS property specifies the blending mode used in a mask border.
		*/
		'mask-border-mode'():void;
		/**
		The mask-border-outset CSS property specifies the distance by which an element's mask border is set out from its border box.
		*/
		'mask-border-outset'():void;
		/**
		The mask-border-repeat CSS property defines how the edge regions of a source image are adjusted to fit the dimensions of an element's mask border.
		*/
		'mask-border-repeat'():void;
		/**
		The mask-border-slice CSS property divides the image specified by mask-border-source into regions. These regions are used to form the components of an element's mask border.
		*/
		'mask-border-slice'():void;
		/**
		The mask-border-source CSS property specifies the source image used to create an element's mask border.

The mask-border-slice property is used to divide the source image into regions, which are then dynamically applied to the final mask border.
		*/
		'mask-border-source'():void;
		/**
		The mask-border-width CSS property specifies the width of an element's mask border.
		*/
		'mask-border-width'():void;
		/**
		The mask-clip CSS property determines the area, which is affected by a mask. The painted content of an element must be restricted to this area.
		*/
		'mask-clip'():void;
		/**
		The mask-composite CSS property represents a compositing operation used on the current mask layer with the mask layers below it.
		*/
		'mask-composite'():void;
		/**
		The max-liens property forces a break after a set number of lines
		*/
		'max-lines'():void;
		/**
		The overflow-clip-box CSS property specifies relative to which box the clipping happens when there is an overflow. It is short hand for the overflow-clip-box-inline and overflow-clip-box-block properties.
		*/
		'overflow-clip-box'():void;
		/**
		The overflow-inline CSS media feature can be used to test how the output device handles content that overflows the initial containing block along the inline axis.
		*/
		'overflow-inline'():void;
		/**
		The overscroll-behavior CSS property is shorthand for the overscroll-behavior-x and overscroll-behavior-y properties, which allow you to control the browser's scroll overflow behavior — what happens when the boundary of a scrolling area is reached.
		*/
		'overscroll-behavior'():void;
		/**
		The overscroll-behavior-x CSS property is allows you to control the browser's scroll overflow behavior — what happens when the boundary of a scrolling area is reached — in the x axis direction.
		*/
		'overscroll-behavior-x'():void;
		/**
		The overscroll-behavior-y CSS property is allows you to control the browser's scroll overflow behavior — what happens when the boundary of a scrolling area is reached — in the y axis direction.
		*/
		'overscroll-behavior-y'():void;
		/**
		This property controls how ruby annotation boxes should be rendered when there are more than one in a ruby container box: whether each pair should be kept separate, the annotations should be collapsed and rendered as a group, or the separation should be determined based on the space available.
		*/
		'ruby-merge'():void;
		/**
		The scrollbar-color CSS property sets the color of the scrollbar track and thumb.
		*/
		'scrollbar-color'():void;
		/**
		The scrollbar-width property allows the author to set the maximum thickness of an element’s scrollbars when they are shown. 
		*/
		'scrollbar-width'():void;
		/**
		The scroll-margin property is a shorthand property which sets all of the scroll-margin longhands, assigning values much like the margin property does for the margin-* longhands.
		*/
		'scroll-margin'():void;
		/**
		The scroll-margin-block property is a shorthand property which sets the scroll-margin longhands in the block dimension.
		*/
		'scroll-margin-block'():void;
		/**
		The scroll-margin-block-start property defines the margin of the scroll snap area at the start of the block dimension that is used for snapping this box to the snapport. The scroll snap area is determined by taking the transformed border box, finding its rectangular bounding box (axis-aligned in the scroll container’s coordinate space), then adding the specified outsets.
		*/
		'scroll-margin-block-start'():void;
		/**
		The scroll-margin-block-end property defines the margin of the scroll snap area at the end of the block dimension that is used for snapping this box to the snapport. The scroll snap area is determined by taking the transformed border box, finding its rectangular bounding box (axis-aligned in the scroll container’s coordinate space), then adding the specified outsets.
		*/
		'scroll-margin-block-end'():void;
		/**
		The scroll-margin-bottom property defines the bottom margin of the scroll snap area that is used for snapping this box to the snapport. The scroll snap area is determined by taking the transformed border box, finding its rectangular bounding box (axis-aligned in the scroll container’s coordinate space), then adding the specified outsets.
		*/
		'scroll-margin-bottom'():void;
		/**
		The scroll-margin-inline property is a shorthand property which sets the scroll-margin longhands in the inline dimension.
		*/
		'scroll-margin-inline'():void;
		/**
		The scroll-margin-inline-start property defines the margin of the scroll snap area at the start of the inline dimension that is used for snapping this box to the snapport. The scroll snap area is determined by taking the transformed border box, finding its rectangular bounding box (axis-aligned in the scroll container’s coordinate space), then adding the specified outsets.
		*/
		'scroll-margin-inline-start'():void;
		/**
		The scroll-margin-inline-end property defines the margin of the scroll snap area at the end of the inline dimension that is used for snapping this box to the snapport. The scroll snap area is determined by taking the transformed border box, finding its rectangular bounding box (axis-aligned in the scroll container’s coordinate space), then adding the specified outsets.
		*/
		'scroll-margin-inline-end'():void;
		/**
		The scroll-margin-left property defines the left margin of the scroll snap area that is used for snapping this box to the snapport. The scroll snap area is determined by taking the transformed border box, finding its rectangular bounding box (axis-aligned in the scroll container’s coordinate space), then adding the specified outsets.
		*/
		'scroll-margin-left'():void;
		/**
		The scroll-margin-right property defines the right margin of the scroll snap area that is used for snapping this box to the snapport. The scroll snap area is determined by taking the transformed border box, finding its rectangular bounding box (axis-aligned in the scroll container’s coordinate space), then adding the specified outsets.
		*/
		'scroll-margin-right'():void;
		/**
		The scroll-margin-top property defines the top margin of the scroll snap area that is used for snapping this box to the snapport. The scroll snap area is determined by taking the transformed border box, finding its rectangular bounding box (axis-aligned in the scroll container’s coordinate space), then adding the specified outsets.
		*/
		'scroll-margin-top'():void;
		/**
		The scroll-snap-type-x CSS property defines how strictly snap points are enforced on the horizontal axis of the scroll container in case there is one.

Specifying any precise animations or physics used to enforce those snap points is not covered by this property but instead left up to the user agent.
		*/
		'scroll-snap-type-x'():void;
		/**
		The scroll-snap-type-y CSS property defines how strictly snap points are enforced on the vertical axis of the scroll container in case there is one.

Specifying any precise animations or physics used to enforce those snap points is not covered by this property but instead left up to the user agent.
		*/
		'scroll-snap-type-y'():void;
		/**
		The text-decoration-thickness CSS property sets the thickness, or width, of the decoration line that is used on text in an element, such as a line-through, underline, or overline.
		@alias tdt
		*/
		'text-decoration-thickness'():void;
		/** @alias text-decoration-thickness */
		'tdt'():void;
		/**
		The text-emphasis CSS property is a shorthand property for setting text-emphasis-style and text-emphasis-color in one declaration. This property will apply the specified emphasis mark to each character of the element's text, except separator characters, like spaces,  and control characters.
		@alias te
		*/
		'text-emphasis'():void;
		/** @alias text-emphasis */
		'te'():void;
		/**
		The text-emphasis-color CSS property defines the color used to draw emphasis marks on text being rendered in the HTML document. This value can also be set and reset using the text-emphasis shorthand.
		@alias tec
		*/
		'text-emphasis-color'():void;
		/** @alias text-emphasis-color */
		'tec'():void;
		/**
		The text-emphasis-position CSS property describes where emphasis marks are drawn at. The effect of emphasis marks on the line height is the same as for ruby text: if there isn't enough place, the line height is increased.
		@alias tep
		*/
		'text-emphasis-position'():void;
		/** @alias text-emphasis-position */
		'tep'():void;
		/**
		The text-emphasis-style CSS property defines the type of emphasis used. It can also be set, and reset, using the text-emphasis shorthand.
		@alias tes
		*/
		'text-emphasis-style'():void;
		/** @alias text-emphasis-style */
		'tes'():void;
		/**
		The text-underline-offset CSS property sets the offset distance of an underline text decoration line (applied using text-decoration) from its original position.
		*/
		'text-underline-offset'():void;
		/**
		The speak-as descriptor specifies how a counter symbol constructed with a given @counter-style will be represented in the spoken form. For example, an author can specify a counter symbol to be either spoken as its numerical value or just represented with an audio cue.
		*/
		'speak-as'():void;
		/**
		The bleed CSS at-rule descriptor, used with the @page at-rule, specifies the extent of the page bleed area outside the page box. This property only has effect if crop marks are enabled using the marks property.
		*/
		'bleed'():void;
		/**
		The marks CSS at-rule descriptor, used with the @page at-rule, adds crop and/or cross marks to the presentation of the document. Crop marks indicate where the page should be cut. Cross marks are used to align sheets.
		*/
		'marks'():void;
	}

}

