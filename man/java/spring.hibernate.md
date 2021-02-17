
### OneToOne OneToMany ManyToMany
- Hibernate中用注解配置一对多双向关联和多对一单向关联
- https://www.cnblogs.com/hmy-1365/p/5790087.html

### hibernate基于注解的维护权反转：@OneToMany(mappedBy=)
- https://www.cnblogs.com/chiangchou/p/mappedBy.html
> mappedBy属性跟xml配置文件里的inverse一样。在一对多或一对一的关系映射中，如果不表明mappedBy属性，默认是由本方维护外键。   
> 但如果两方都由本方来维护的话，会多出一些update语句，性能有一定的损耗。   
> 解决的办法就是在一的一方配置上mappedBy属性，将维护权交给多的一方来维护，就不会有update语句了。  
> 至于为何要将维护权交给多的一方，可以这样考虑：要想一个国家的领导人记住所有人民的名字是不可能的，但可以让所有人民记住领导人的名字！  
> 注意，配了mappedBy属性后，不要再有@JoinColumn，会冲突！



