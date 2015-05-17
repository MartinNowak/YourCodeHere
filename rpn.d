import std.algorithm, std.container.array, std.conv, std.stdio;

void main()
{
    Array!int stack;

    void binop(string op)()
    {
        stack[$ - 2] = mixin("stack[$ - 2] " ~ op ~ " stack[$ - 1]");
        stack.removeBack();
        writeln(stack[$ - 1]);
    }

    foreach (token; stdin.byLine.map!splitter.joiner)
    {
        switch (token)
        {
        case "+": binop!"+"(); break;
        case "-": binop!"-"(); break;
        case "*": binop!"*"(); break;
        case "/": binop!"/"(); break;
        case "%": binop!"%"(); break;
        case "=":
            writeln(stack[$ - 1]);
            stack.removeBack();
            break;
        default:
            stack.insertBack(token.to!int);
            break;
        }
    }
}
