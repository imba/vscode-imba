export class Item

    @title = 'untitled'
    @buffer = Stream.new(@hello(@title))
    
    def hello value
        value.toUpperCase()


# Implicit self style #

export class Item
    title = 'untitled'
    buffer = Stream.new(hello(title))
    
    def hello value
        value.toUpperCase()