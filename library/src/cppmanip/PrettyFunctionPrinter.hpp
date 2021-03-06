#ifndef CPPMANIP_8537935905244EB2B44A1991E6B21577_HPP
#define CPPMANIP_8537935905244EB2B44A1991E6B21577_HPP
#include "FunctionPrinter.hpp"

namespace cppmanip
{

class PrettyFunctionPrinter : public FunctionPrinter
{
public:
    virtual std::string printFunction(const std::string& name, const Strings& args, const std::string& body);
    virtual std::string printFunctionCall(const std::string& name, const Strings& args);
};

}
#endif // CPPMANIP_8537935905244EB2B44A1991E6B21577_HPP
