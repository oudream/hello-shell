import json


class Hello:
    def __init__(self, loadpath, savepath):
        self.loadpath = loadpath
        self.savepath = savepath

    def save(self):
        data = {}
        data['people'] = []
        data['people'].append({
            'name': 'Scott',
            'website': 'stackabuse.com',
            'from': 'Nebraska'
        })
        data['people'].append({
            'name': 'Larry',
            'website': 'google.com',
            'from': 'Michigan'
        })
        data['people'].append({
            'name': 'Tim',
            'website': 'apple.com',
            'from': 'Alabama'
        })
        with open(self.savepath, 'w') as outfile:
            json.dump(data, outfile)

    def load(self):
        with open(self.loadpath) as json_file:
            data = json.load(json_file)
            for p in data['people']:
                print('Name: ' + p['name'])
                print('Website: ' + p['website'])
                print('From: ' + p['from'])
                print('')

    def run(self):
        print('\n--- save ---')
        self.save()
        print('\n--- load ---')
        self.load()


class Hello2:
    def __init__(self, loadpath, savepath):
        self.loadpath = loadpath
        self.savepath = savepath

    def load(self):
        with open(self.loadpath) as json_file:
            data = json.load(json_file)
            for p in data['people']:
                print('Name: ' + p['name'])
                print('Website: ' + p['website'])
                print('From: ' + p['from'])
                print('')

    class Class1:
        def __init__(self):
            self.attr1 = 1
            self.attr2 = 'a'
            self.attr3 = True
            self.attr4 = 1.1
            self.attr5 = []

        def say(self):
            print('a')

    def run(self):
        c1 = Hello2.Class1()
        for name, value in vars(c1).items():
            print('%s=%s' % (name, value))

        return
        print('\n--- save ---')
        self.save()
        print('\n--- load ---')
        self.load()


def run():
    hello = Hello2('/eee/json/json1.json', '/eee/json/json1.json')
    hello.run()


if __name__ == '__main__':
    run()
else:
    run()
