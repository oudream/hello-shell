import inspect
import types
import json


# *** if isinstance(value, types.FunctionType):
# *** inspect.ismethod inspect.isfunction

class Hello:
    def __init__(self):
        pass

    class Class1:
        def __init__(self):
            self.attr1 = 1
            self.attr2 = 'a'
            self.attr3 = True
            self.attr4 = 1.1
            self.attr5 = []

        def say(self):
            print('i say : ', self.attr1, self.attr5)

    def run(self):
        c1 = Hello.Class1()
        print('\n--- hasattr ---')
        print('c1 hasattr say: ', hasattr(c1, 'say'))
        fn = getattr(c1, 'say')
        if inspect.ismethod(fn):
            fn()
        print('\n--- dir Class ---')
        print(dir(Hello.Class1))
        print('\n--- dir object ---')
        print(dir(c1))
        print('\n--- vars Class ---')
        print(vars(Hello.Class1))
        print('\n--- vars object ---')
        print(vars(c1))
        print('\n--- type ---')
        print(vars(type(c1)))
        print('\n--- type vars ---')
        for name, value in vars(type(c1)).items():
            if name.startswith('__') and name.endswith('__'):
                pass
            else:
                # if isinstance(value, types.FunctionType):
                # callable(value)
                if inspect.isfunction(value):
                    value(c1)
            print('%s=%s' % (name, value))


def run():
    hello = Hello()
    hello.run()


if __name__ == '__main__':
    run()
else:
    run()
