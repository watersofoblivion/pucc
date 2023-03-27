#include "builder.h"

#include <iostream>

int main() {
    auto a = Foo::builder()
        .Data("Hello, World!")
        .Build();
    a.Print();

    auto b = Foo::builder()
        .Data(std::string("Hello, world!"))
        .Build();
    b.Print();

    return 0;
}
