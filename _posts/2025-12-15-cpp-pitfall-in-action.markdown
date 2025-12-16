---
layout: post
title:  "CPP Pitfall in Action"
date:   2025-12-15 08:30:00 +0800
categories: [C/C++]
---

* Do not remove this line (it will not be displayed)
{:toc}



# 全局变量初始化机制

C++ 标准规定：

* 同一编译单元（`.cpp` 文件）内，**全局变量按声明顺序初始化**
* **不同编译单元之间的初始化顺序未定义**（`unspecified`）
* 静态局部变量在首次访问时初始化（线程安全，C++11 后）


# 链接器处理静态库的机制

当链接器处理静态库时：

* 静态库是 `.o` 文件的集合（`archive`）
* **链接器只链接被引用的符号**
* 如果符号未被引用，对应的 `.o` 文件不会被链接
* **链接顺序影响哪些符号被引用**






