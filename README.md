# my-windows-shortcut-operation

键鼠增强工具链，解决**高频**操作**效率低**的问题。打造系统化的 windows 操作**提速**方案。

效率至上，减少无效的消耗，助力节省更多的时间为了工具之外的本质事情。这是一个质朴的程序员，能够做到的事情。对于享受操作快感而言。这也是一份乐趣。献给跻身繁忙世界的人，也献给我曾荒诞不羁的思绪。
## 
#Requires AutoHotkey v2.0-a 支持2.0以及以上版本
## 功能

### 一. 快捷键

#### 虚拟桌面 & 窗口 & 屏幕

双屏，三屏，以及 4 桌面设计，和 2 桌面设计。用户可以自由发挥。比如，初始化 4 个虚拟桌面，映射到上下左右鼠标手势，以及 vim 的 hjkl。比如，三屏幕显示器，可以在一个屏幕上面固定一些常驻窗口，在另外两个显示器上面进行双屏工作。本项目提供了库函数供操作和调用。以及基本的个人配置。

1.  自动初始化虚拟桌面数量
2.  鼠标手势快速切换虚拟桌面
3.  键盘快捷键快速切换虚拟桌面
4.  窗口固定快速传递到其他虚拟桌面
5.  窗口固定到所有的虚拟桌面
6.  双屏显示器，窗口屏幕间快速移动
7.  双虚拟桌面，窗口虚拟桌面间快速移动

目前配置：

1.  开机初始化桌面数量：2
2.  `ctrl + win + j` 定位到“上”桌面
3.  `ctrl + win + k` 定位到“下”桌面
4.  `capslock + f` 在上下桌面循环切换
5.  `capslock + alt + f` 将当前窗口传送到另外一个虚拟桌面
6.  `capslock + t` 锁定当前 windows 窗口，置于最前面。
7.  `capslock + a` 当前应用出现在所有虚拟桌面的任务栏。
8.  等

#### 软件启动

启动逻辑为，如果无运行就打开，否则，激活，或者最小化窗口。（逻辑参考了微信的设计）

- `ctrl+win+r` window terminal 的快速打开 （这个也是个痛点，大多数人，都是 win+r，输入 cmd。这太慢了，不够直接）
- `capslock & u` 打开 wsl

- `ctrl+alt+ w |e| r| f| v` 来映射必备的软件（这几个按键在键盘上的排列形成的图形很容易让人记住）。看个人口味修改。个人映射了。微信，e-vscode，r-notion，f-flunet reader，v-music

#### 媒体控制

- `ctrl+win+d|e ` 音量调大|调小（在此之前的日常使用每次，都需要移动鼠标然后控制音量，太麻烦了。）

### 二. 鼠标手势

借助 strokesplus.net，手势的配置能力。配置操控。（**通过手势触发 ahk 后者其他软件自身具备的快捷键**）

- 系统级别控制：如，虚拟桌面，媒体。
   1. 虚拟桌面：
      - 切换虚拟桌面

      - 双虚拟桌面应用中，移动当前窗口到其他虚拟桌面。

      - **双显示器**，中，移动当前窗口到另外一个显示器。

      - **三显示器**的完美设计理念。操作加持。如有需要，欢迎交流。不便瞎扯。

   2. 媒体：
        - 音量控制大小
        - 切歌曲
- 应用级别控制：如，常见的 tab 切换，关闭 tab，等每个应用会有不同，也会抽取他们相同的部分（尽量减少记忆负担）。
  1. chrome： 刷新，关闭，关闭其他，tab 切换，回退历史
  2. vscode： md 预览，关闭 tab，tab 切换。
  3. idea，sublime等

## 安装

1. git clone

2. 启用快捷键：
   1. 安装[ahk](https://www.autohotkey.com/)
   2. 配置 ahk 脚本开机启动.（至此快捷键以可用）
   - Press Win + R, enter shell:startup, then click OK
   - Create a shortcut to the `boot.ahk` file here
3. 启用手势：
   1. 安装[strokens Plus](https://www.strokesplus.com/downloads/)
   2. 启动 strokens Plus 导入本项目的 strokens plus 配置文件。xxx.spexport

### 自定义

快捷键查看和自定义，查看 [[shortcut.ahk]]

手势查看和自定义，将[fullStrokesPlusConfig.spexport](fullStrokesPlusConfig.spexport) 文件导入，strokens plus。在 strokens plus 面板中查看和自定义手势配置

## Thanks

- ahk **全局**按键
- strokesplus.net **全局**手势

另外推荐

- quicker **全局**导航
- listary **全局**搜索
- utools 这个目前，只是用了用翻译的调用，和全局谷歌搜索调用。太乱了。

## 参考

1. 键位设计理念。vim，emacs，单手操作理念
2. 虚拟桌面部分控制参考
   - https://github.com/pmb6tz/windows-desktop-switcher
3. 部分功能可能随着 windows 的更新失效，可尝试更新[VirtualDesktopAccessor.ddl](VirtualDesktopAccessor.ddl) 

   - https://github.com/skottmckay/VirtualDesktopAccessor/tree/master/x64/Release

   - https://github.com/Ciantic/VirtualDesktopAccessor/releases
4. 切换桌面背景，用于区分不同的虚拟桌面。win11原生已经支持，可以参考 
   - https://zhuanlan.zhihu.com/p/543942561

## 背景 & 构想

专业的人士，在使用计算机时，往往有对于自己相关需求有高频操作指向性。操作系统提供了泛化的精简操作设计，以满足不同的人，进行相对通用的简单操作。然而，正是这种通用和直接的设计和使用之中产生了效率的矛盾，计算机本质就是一个工具，那么如何更加快速的为人所用。内容，本质的直接获得。这是一个专业人士相对于普通用户，最大的矛盾。

要效率就会增加操作。要效率就会缩减人群适应力。然而，本着专业人士的效率立场，丰富操作，并且尽量做到简化，这种矛盾的平衡。值得拥有。

整体的设计思路。脱离整体基础设计，拉升层级。在传统的基础上，建立一套虚拟层级。提取日常使用的高频操作，努力建立直接映射到键盘和鼠标的一步性操作使用体验。并且结构化这些直接操作以使得构建出虚拟层级。

虚拟层级的建立，需要满足两个特点。第一个就是足够高效，这是本质，第二个，一定是系统性的，只有系统性的操作，才会让繁杂的记忆变得简化。降低高效带来的多操作的对用户而言的记忆和掌握难度。

（这牛逼吹的，我感觉代码的字数都没有牛逼吹的多。不过真的是，有些东西，用过就回不去了。）
