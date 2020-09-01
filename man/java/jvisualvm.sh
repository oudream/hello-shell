

# oql
# http://cr.openjdk.java.net/~sundar/8022483/webrev.01/raw_files/new/src/share/classes/com/sun/tools/hat/resources/oqlhelp.html
# https://blog.csdn.net/pange1991/article/details/82023771
select s from java.lang.String s where s.toString().startsWith("abc")

# 查询长度大于等于100的字符串
select s from java.lang.String s where s.value.length >= 100

# 查询长度大于等于256的int数组
select a from [I a where a.length >= 256
#另一种方式：
select a from int[] a where a.length >= 256

# 显示与正则表达式匹配的字符串的内容
select s.value.toString() from java.lang.String s
where /java/.test(s.value.toString())

# /java/ 修改成你的正则表达式，如/^MyClass$/ 就会匹配MyClass这个字符串

# 显示所有File对象的文件路径
select file.path.value.toString() from java.io.File file

# 显示所有ClassLoader类的名称
select classof(cl).name from instanceof java.lang.ClassLoader cl

# 显示由给定id字符串标识的Class的实例
select o from instanceof 0x741012748 o

# 选择某些静态字段引用某些类的所有Properties对象。
select p from java.util.Properties p
where contains(referrers(p), "classof(it).name == 'java.lang.Class'")

# 查询匹配特定名称模式的类的数量
select count(heap.classes(), "/java.io./.test(it.name)")

# 显示所有具有匹配java.io. * 的类
select filter(heap.classes(), "/java.io./.test(it.name)")

# heap.livepaths - 返回给定对象存活的路径数组。此方法接受可选的第二个参数，它是一个布尔标志。此标志指示是否包含弱引用的路径。默认情况下，不包括具有弱引用的路径。
select heap.livepaths(s) from java.lang.String s

# 访问类java.lang.System的静态字段'props'
select heap.findClass("java.lang.System").statics.props

# 获取java.lang.String类的字段数
select heap.findClass("java.lang.String").fields.length

# 找到其对象id被赋予的对象
select heap.findObject("0xf3800b58")

# 选择所有匹配java.net.*的类
select filter(heap.classes(), "/java.net./.test(it.name)")

# 显示每个Reference类型对象的类名
select classof(o).name from instanceof java.lang.ref.Reference o

# 显示java.io.InputStream的所有子类
select heap.findClass("java.io.InputStream").subclasses()

# 显示java.io.BufferedInputStream的所有超类
select heap.findClass("java.io.BufferedInputStream").superclasses()

# 返回两个给定的Java对象是否相同。
select identical(heap.findClass("Foo").statics.bar, heap.findClass("AnotherClass").statics.bar)

# 查询每个java.lang.Object实例被引用的次数
select count(referrers(o)) from java.lang.Object o

# 查询那些对象引用了java.io.File实例对象
select referrers(f) from java.io.File f

# 查询被引用次数超过2的URL对象
select u from java.net.URL u where count(referrers(u)) > 2
