# my-windows-shortcut-operation
键鼠完美增强工具链。直击切实传统windows痛点，摆脱高频低效束缚，打造系统化的优化提升方案。

当我们适应了低效的操作，便会觉得不以为然，同样当我们适应了高效的操作，便会发现新世界。效率至上，减少无效的消耗，助力节省更多的时间为了工具之外的本质事情。这是一个质朴的程序员，能够做到的事情。对于享受操作快感而言。这也是一份乐趣。献给跻身繁忙世界的人，也献给我曾荒诞不羁的思绪。

## 痛点&分析
专业的人士，在使用计算机时，往往有对于自己相关需求有高频操作指向性。操作系统提供了泛化的精简操作设计，以满足不同的人，进行相对通用的简单操作。然而，正是这种通用和直接的设计和使用之中产生了效率的矛盾，计算机本质就是一个工具，那么如何更加快速的为人所用。内容，本质的直接获得。这是一个专业人士相对于普通用户，最大的矛盾。

要效率就会增加操作。要效率就会缩减人群适应力。然而，本着专业人士的效率立场，丰富操作，并且尽量做到简化，这种矛盾的平衡。值得拥有。

整体的设计思路。脱离整体基础设计，拉升层级。在传统的基础上，建立一套虚拟层级。提取日常使用的高频操作，努力建立直接映射到键盘和鼠标的一步性操作使用体验。并且结构化这些直接操作以使得构建出虚拟层级。

虚拟层级的建立，需要满足两个特点。第一个就是足够高效，这是本质，第二个，一定是系统性的，只有系统性的操作，才会让繁杂的记忆变得简化。降低高效带来的多操作的对用户而言的记忆和掌握难度。

（这牛逼吹的，我感觉代码的字数都没有牛逼吹的多。）

## 软件支持
ahk
strokesplus.net
quicker
listary
utools

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
三显示器的完美设计理念。操作加持。如有需要，欢迎交流。不便瞎扯。

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

## 参考
1. vim键位设计，emacs键位设计，单手操作键位设计理念。
2. 虚拟桌面部分控制参考，https://github.com/pmb6tz/windows-desktop-switcher
3. VirtualDesktopAccessor.DDL 部分可能随着windows的更新失效，建议参考 https://github.com/skottmckay/VirtualDesktopAccessor/tree/master/x64/Release
