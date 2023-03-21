# my-windows-shortcut-operation
键鼠增强工具链。直击传统windows痛点，摆脱高频低效束缚，打造系统化的优化提升方案。

当我们适应了低效的操作，便会觉得不以为然，同样当我们适应了高效的操作，便会发现新世界。效率至上，减少无效的消耗，助力节省更多的时间为了工具之外的本质事情。这是一个质朴的程序员，能够做到的事情。对于享受操作快感而言。这也是一份乐趣。献给跻身繁忙世界的人，也献给我曾荒诞不羁的思绪。

## 背景 & 构想
专业的人士，在使用计算机时，往往有对于自己相关需求有高频操作指向性。操作系统提供了泛化的精简操作设计，以满足不同的人，进行相对通用的简单操作。然而，正是这种通用和直接的设计和使用之中产生了效率的矛盾，计算机本质就是一个工具，那么如何更加快速的为人所用。内容，本质的直接获得。这是一个专业人士相对于普通用户，最大的矛盾。

要效率就会增加操作。要效率就会缩减人群适应力。然而，本着专业人士的效率立场，丰富操作，并且尽量做到简化，这种矛盾的平衡。值得拥有。

整体的设计思路。脱离整体基础设计，拉升层级。在传统的基础上，建立一套虚拟层级。提取日常使用的高频操作，努力建立直接映射到键盘和鼠标的一步性操作使用体验。并且结构化这些直接操作以使得构建出虚拟层级。

虚拟层级的建立，需要满足两个特点。第一个就是足够高效，这是本质，第二个，一定是系统性的，只有系统性的操作，才会让繁杂的记忆变得简化。降低高效带来的多操作的对用户而言的记忆和掌握难度。

（这牛逼吹的，我感觉代码的字数都没有牛逼吹的多。不过真的是，有些东西，用过就回不去了。）

## 功能
### 一. 快捷键
1. 虚拟桌面 & 窗口 & 屏幕 （**震惊，全网最强，你从来没有体验过的虚拟桌面玩法**）
   1. 自动初始化虚拟桌面数量
   2. 鼠标手势快速切换虚拟桌面
   3. 键盘快捷键快速切换虚拟桌面
   4. 窗口固定快速传递到其他虚拟桌面
   5. 窗口固定到所有的虚拟桌面   
   6. 双屏显示器，窗口屏幕间快速移动
   7. 双虚拟桌面，窗口虚拟桌面间快速移动

注意：双屏，三屏，以及4桌面设计，和2桌面设计。这些都是逻辑上面的概念，用户可以自由发挥。比如，初始化4个虚拟桌面，映射到上下左右鼠标手势，以及vim的hjkl。比如，三屏幕显示器，可以在一个屏幕上面固定一些常驻窗口，在另外两个显示器上面进行双屏工作。

2. **软件启动**，支持列表：
* ctrl+win+r，window terminal的快速打开 （这个也是个痛点，大多数人，都是win+r，输入cmd。这太慢了，不够直接）
* ctrl+alt+ w |e| r| f| v 来映射必备的软件（这几个按键在键盘上的排列很容易让人记住）。个人映射了。微信，e-vscode，r-notion，f-chrome，v-music
启动软件的逻辑为，如果无运行就打开，否则，激活，或者最小化窗口。（这个逻辑参考了微信的设计。且比系统自带的，使用win+num键的方式，操作更加舒服）

3. 媒体控制 ctrl+win+d|e ^#d::SendInput, {Volume_Down} ^#e::SendInput, {Volume_Up} （日常每次，都需要移动鼠标然后控制音量，太麻烦了。）

具体快捷键操作查看：[[shortcut.ahk]]

### 二. 鼠标手势
借助strokesplus.net，配置全局或者应用级别的手势。全局级别操控功能如：虚拟桌面切换，窗口切换虚拟桌面，窗口移动屏幕，媒体音量控制。局部操控级别：如，常见的tab切换，关闭tab，等每个应用会有不同，也会抽取他们相同的部分（尽量减少记忆负担）。

1. 针对具体应用的具体设置
如：chrome：
刷新，关闭，关闭其他，tab切换，回退历史

再比如：vscode：
md预览，关闭tab，tab切换。

2. 虚拟桌面：
切换虚拟桌面

双虚拟桌面应用中，移动当前窗口到其他虚拟桌面。

双显示器，中，移动当前窗口到另外一个显示器。

三显示器的完美设计理念。操作加持。如有需要，欢迎交流。不便瞎扯。

3. 媒体：
音量控制大小。切歌曲

## 安装
1. git clone

2. 启用快捷键： 
   1. 安装[ahk](https://www.autohotkey.com/)
   2. 配置ahk脚本开机启动.（至此快捷键以可用）
   - Press Win + R, enter shell:startup, then click OK
   - Create a shortcut to the `boot.ahk` file here
     
3. 启用手势：  
   1. 安装[strokens Plus](https://www.strokesplus.com/downloads/)
   2. 启动strokens Plus导入本项目的strokens plus配置文件。xxx.spexport

## 使用

### 手势使用
参考strokens plus手势配置。将[fullStrokesPlusConfig.spexport](fullStrokesPlusConfig.spexport) 文件导入，strokens plus。在strokens plus面板中查看手势的配置。

### 快捷键使用
参考[shortcut.ahk](shortcut.ahk)部分。

手势是可以和快捷键配合的。所以，strokens plus 和 ahk 的配合，能够充分的给你的创造力以空间。

既能单打，又能群殴。灰常nice,谁用谁知道~~~~

## 感恩遇见纯粹而强大的软件
- ahk **全局**按键
- strokesplus.net  **全局**手势

另外推荐
- quicker **全局**导航
- listary **全局**搜索
- utools 这个目前，只是用了用翻译的调用，和全局谷歌搜索调用。太乱了。

## 参考
1. 键位设计理念。vim，emacs，单手操作理念
2. 虚拟桌面部分控制参考
   - https://github.com/pmb6tz/windows-desktop-switcher
3. [VirtualDesktopAccessor.ddl文件](VirtualDesktopAccessor.ddl) 部分可能随着windows的更新失效，建议参考进行升级 

   - https://github.com/skottmckay/VirtualDesktopAccessor/tree/master/x64/Release

   - https://github.com/Ciantic/VirtualDesktopAccessor/releases
