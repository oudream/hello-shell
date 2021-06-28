
#include <iostream>

using namespace std;

class MyClass {
public:
    static int FunA(int a, int b) {
        cout << "call FunA" << endl;
        return a + b;
    }

    void FunB() {
        cout << "call FunB" << endl;
    }

    void FunC() {
        cout << "call FunC" << endl;
    }

    void FunD(int i) {
        cout << "call FunD - " << i << endl;
    }

    int pFun1(int (*p)(int, int), int a, int b) {
        return (*p)(a, b);
    }

    void pFun2(void (MyClass::*nonstatic)()) {
        (this->*nonstatic)();
    }
};

int main()
{
    MyClass *obj = new MyClass;
    // 静态函数指针的使用
    int (*pFunA)(int, int) = &MyClass::FunA;
    cout << pFunA(1, 2) << endl;

    // 成员函数指针的使用
    void (MyClass::*pFunB)() = &MyClass::FunB;
    (obj->*pFunB)();

    // 成员函数指针的使用
    void (MyClass::*pFunD)(int) = &MyClass::FunD;
    (obj->*pFunD)(10);

    // 通过 pFun1 只能调用静态方法
    obj->pFun1(&MyClass::FunA, 1, 2);

    // 通过 pFun2 就是调用成员方法
    obj->pFun2(&MyClass::FunB);
    obj->pFun2(&MyClass::FunC);
    obj->pFun2(pFunB);

    delete obj;
    return 0;
}