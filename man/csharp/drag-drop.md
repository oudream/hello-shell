
### .NET中的Drag and Drop操作（一）
- https://blog.csdn.net/jumtre/article/details/17259897
- https://learn.microsoft.com/zh-cn/dotnet/desktop/winforms/advanced/walkthrough-performing-a-drag-and-drop-operation-in-windows-forms?view=netframeworkdesktop-4.8
```text
1：将能接受拖放的控件的AllowDrop属性设置为True，可以在设计和运行时设置；

2：为能接受拖放的控件添加4个事件分别是DragEnter，DragOver，DragLeave，DragDrop，ItemDrag；

3：实现DragEnter，DragOver，DragLeave事件对应的方法，当用鼠标拖拽一个对象到控件的窗口时，首先触发DragEnter，然后是DragOver，当离开窗体时触发DragLeave。主要操作是设置判断对象是否是要接受的类型，以及鼠标的样式；

4：实现DragDrop事件对应的方法；当用户拖拽对象到控件上，并释放时触发，这时主要是接受对象并操作显示；

5：实现ItemDrag的事件对应的方法，调用DoDragDrop方法，传递要拖拽的数据对象；
```
