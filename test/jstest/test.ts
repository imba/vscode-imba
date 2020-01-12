class Hello {
	
    program:Buffer
    other = 'hello'
    list: any[] = [1,2,3]
	
	constructor(program,aba){
        this.program = program;
        this.test = (aba as string).toLowerCase();
    }
    
    setup(){
        test
        return this.program;
    }
};

// must be a better way
let { a, b }: { a: string, b: number } = o;

// let { a|string, b|number } = o;
// let { a@string, b@number } = o;