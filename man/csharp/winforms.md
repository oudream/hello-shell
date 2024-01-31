
### winforms source
- https://github.com/dotnet/winforms

### examples
- https://github.com/ZacharyPatten/dotnet-winforms-examples

###
```text
在整个窗体生命周期中，有以下6个重要的事件：
1.Load：窗体加载时触发，主要用于加载初始数据
2.Shown：窗体显示时触发
3.Activated：窗体获取焦点时触发
4.Deactivate：窗体失去焦点时触发
5.FormClosing：窗体关闭过程中触发
6.FormClosed：窗体关闭完成触发
```
```javascript
this.Load += new System.EventHandler(this.MainForm_Load);
this.Shown += new System.EventHandler(this.MainForm_Shown);
this.Activated += new System.EventHandler(this.MainForm_Activated);
this.Deactivate += new System.EventHandler(this.MainForm_Deactivate);
this.FormClosing += new System.Windows.Forms.FormClosingEventHandler(this.MainForm_FormClosing);
this.FormClosed += new System.Windows.Forms.FormClosedEventHandler(this.MainForm_FormClosed);

private void MainForm_Load(object sender, EventArgs e)
private void MainForm_Shown(object sender, EventArgs e)
private void MainForm_Activated(object sender, EventArgs e)
private void MainForm_Deactivate(object sender, EventArgs e)
private void MainForm_FormClosed(object sender, FormClosedEventArgs e)
private void MainForm_FormClosing(object sender, FormClosingEventArgs e)
```

###
- https://github.com/NikolaGrujic91/WinForms-Examples
```text
WinForms Examples
List of repositories containing WinForms examples written in C#.

WinForms Control Click - implementation of control click tracking event.
WinForms Color Selector - implementation of color selector from list of system known colors.
WinForms Installed Fonts Viewer - implementation of installed fonts viewer.
WinForms Event Tracker - implementation of tracking of keyboard and mouse events.
WinForms Error Provider Validation - implementation of ErrorProvider validation
WinForms Image Menu Items - implementation of menu items with image.
WinForms List View - implementation of ListView and all of its view modes.
WinForms Tree View - implementation of basic TreeView.
WinForms Tree View Drag and Drop - implementation of Drag and Drop between two TreeView controls.
WinForms ToolBar - implementation of ToolBar control modes.
WinForms User Control Progress Bar - implementation of ProgressBar as a UserControl.
WinForms Inherited Control Directory Tree - implementation of TreeView for displaying directories as inherited control.
WinForms ListBox Object Binding - implementation of ListBox object binding.
WinForms Docking Windows - implementation of docking a Form inside of the other Form.
WinForms MVC - implementation of MVC pattern for WinForms apllication.
WinForms ComboBox Auto Fit Content - implementation of ComboBox dropdown auto fitting content.
```

###
- https://github.com/smokindinesh/Csharp-windows-form-sample
```text
About
Sample application for learning C# windows form application. Detail of all projects are in http://codeincodeblock.com/

List of articles:

Calculator program
Image Viewer
Maze Game
Math Quiz Game
Matching Game
Drawing Basic Shapes
Pixel Plot on Form
```
