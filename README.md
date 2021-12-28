# my-windows-shortcut-operation
借助ahk 快捷键控制，以及strokesplus.net手势控制。全方位提升windows键鼠操作体验。

## 特性
### 一. 快捷键
1. 虚拟桌面和窗口操作
   1. 自动初始化虚拟桌面数量
   2. 鼠标手势快速切换虚拟桌面
   3. 键盘快捷键快速切换虚拟桌面
   4. 应用程序，固定快速传递到其他虚拟桌面
   5. 应用程序，固定到所有的虚拟桌面   
   6. 双屏显示器，窗口快速移动
   7. 双虚拟桌面，间，窗口快速移动

2. 快捷键软件启动，处理逻辑为，如果无运行就打开，否则，激活，或者最小化窗口。支持列表：

* ctrl+win+r，window terminal的快速打开
* ctrl+alt+ w |e| r| f| v 键群，设计了最舒服的几个位置。来映射必备的软件。个人映射了。微信，e-vscode，r-notion，f-chrome，v-music

3. 媒体控制 ctrl+win+d|e ^#d::SendInput, {Volume_Down} ^#e::SendInput, {Volume_Up}

具体快捷键操作查看：[[shortcut.ahk]]

### 二. 鼠标手势
借助strokesplus.net，配置了很多手势。

chrome：
刷新，关闭，关闭其他，tab切换，回退历史

vscode：
md预览，关闭tab，tab切换。

虚拟桌面：
切换虚拟桌面
双虚拟桌面应用中，移动当前窗口到其他虚拟桌面。
双显示器，中，移动当前窗口到另外一个显示器。

媒体：
音量控制大小。

## 安装&使用
1. git clone

2. 启用快捷键： 
   1. 安装[ahk](https://www.autohotkey.com/)
   2. 配置ahk脚本开机启动.（至此快捷键以可用）
   - Press Win + R, enter shell:startup, then click OK
   - Create a shortcut to the `boot.ahk` file here
     
3. 启用手势：  
   1. 安装[strokens Plus](https://www.strokesplus.com/downloads/)
   2. 启动strokens Plus导入本项目的strokens plus配置文件。xxx.spexport

## 修改参考
1. ahk语法
2. vim键位设计，emacs键位设计。单手键位考虑
