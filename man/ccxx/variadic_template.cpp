
// https://en.wikipedia.org/wiki/Variadic_template
// https://docs.microsoft.com/zh-cn/cpp/cpp/ellipses-and-variadic-templates


#include <iostream>
// using aliases for cleaner syntax

template<unsigned...> struct seq { using type = seq; };

template<class S1, class S2> struct concat;

template<unsigned... I1, unsigned... I2>
struct concat<seq<I1...>, seq<I2...>>
	: seq<I1..., (sizeof...(I1) + I2)...> {};

template<unsigned N>
struct make_integer_sequence : concat<typename make_integer_sequence<N / 2>::type, typename make_integer_sequence<N - N / 2>::type>::type {};

template<> struct make_integer_sequence<1> : seq<0> {};

int printItem(unsigned k)
{
	std::cout << k << ' ';
	return 0;
}

template<unsigned... I1>
void printTemplate(seq<I1...> a)
{
	int nn[] = { printItem(I1)... };
}

int main()
{
	make_integer_sequence<10> a;
	printTemplate(a);
}

