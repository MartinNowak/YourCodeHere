// RPN calculator
import std.algorithm, std.container.array,
    std.conv, std.stdio, std.meta;

void main()
{
    Array!int stack;

    void binop(string op)()
    {
        stack[$ - 2] = mixin("stack[$ - 2] " ~
                             op ~ " stack[$ - 1]");
        stack.removeBack();
        writeln(stack[$ - 1]);
    }

    void process(in char[] token)
    {
        alias Ops = AliasSeq!("+", "-", "*", "/", "%");
    Lswitch:
        switch (token)
        {
            foreach (op; Ops)
            {
        case op:
                binop!op();
                break Lswitch;
            }

        case "=":
            writeln(stack[$ - 1]);
            stack.removeBack();
            break;

        default:
            stack.insertBack(token.to!int);
            break;
        }
    }

    stdin.byLine.map!splitter.joiner.each!process;
}
