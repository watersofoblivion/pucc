#include <iostream>

#ifndef BIN_BUILDER
#define BIN_BUILDER

template <typename T>
class Builder {
    Builder() = default;
    friend T;

public:
    static T builder() {
        return T{};
    }

    T& Build() {
        return static_cast<T&>(*this);
    }
};

class Foo : public Builder<Foo> {
    std::string data;

public:
    Foo&& Data(std::string data) && {
        this->data = data;
        return std::move(*this);
    }

    void Print() const {
        std::cout << "Printing data: " << data << std::endl;
    }
};

#endif
