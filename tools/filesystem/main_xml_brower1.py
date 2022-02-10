try:
    import xml.etree.cElementTree as ET
except ImportError:
    import xml.etree.ElementTree as ET


class Hello:
    def __init__(self, loadpath, savepath):
        self.loadpath = loadpath
        self.savepath = savepath
        self.tree = ET.ElementTree(file=loadpath)

    def printall(self):
        for elem in self.tree.iter():
            print(elem.tag, elem.attrib)
            # print(elem.tag, elem.attrib, elem.text)

    def printchildren(self):
        root = self.tree.getroot()
        for child_of_root in root:
            print(child_of_root.tag, child_of_root.attrib)

    def printchild(self):
        root = self.tree.getroot()
        print(root[0].tag, root[0].text)

    def insert(self):
        e = self.tree.find('a/b')
        if e is not None:
            e1 = ET.Element('c', {'n1':'v1'})
            e.insert(0, e1)
        ET.register_namespace('', "http://www.topografix.com/GPX/1/1")
        ET.register_namespace('', "http://www.topografix.com/GPX/1/0")
        self.tree.write(self.savepath, encoding='utf-8', xml_declaration=True)

    def run(self):
        print('\n--- printall ---')
        self.printall()
        print('\n--- printchildren ---')
        self.printchildren()
        print('\n--- printchild ---')
        self.printchild()
        print('\ninsert')
        self.insert()


def run():
    hello = Hello('/eee/xml/xml1.xml', '/eee/xml/save1.xml')
    hello.run()


if __name__ == '__main__':
    run()
else:
    run()
