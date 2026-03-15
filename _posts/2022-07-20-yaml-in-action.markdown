---
layout: post
title:  "YAML in Action"
date:   2022-07-20 12:30:00 +0800
categories: 云原生
tags:
  - YAML
  - 云原生

---

* Do not remove this line (it will not be displayed)
{:toc}

> 编程免不了要写配置文件，怎么写配置也是一门学问。YAML 是专门用来写配置文件的语言，非常简洁和强大，远比 JSON 格式方便。


YAML 是一种较为人性化的数据序列化语言，可以配合目前大多数编程语言使用。YAML 的语法比较简洁直观，特点是使用空格来表达层次结构，其最大优势在于数据结构方面的表达，所以 YAML 更多应用于编写配置文件，其文件一般以 `.yaml` 或 `.yml` 为后缀。


# 基本语法

* 大小写敏感
* 用缩进表示层级关系
* 缩进**不允许**使用 `tab`，只允许`空格`
* 缩进的空格数不重要，只要相同层级的元素左对齐即可
* `#` 表示注释，从这个字符一直到行尾，都会被解析器忽略
* 允许使用两个感叹号，强制转换数据类型


# 数据结构 (3种)

* 对象：键值对的集合，又称为映射 (mapping) / 哈希 (hashes) / 字典 (dictionary)
* 数组：一组按次序排列的值，又称为序列 (sequence) / 列表 (list)
* 纯量 (scalars)：单个的、不可再分的值

## 对象

对象的一组键值对，使用冒号结构表示。

{% highlight text %}
animal: pets
{% endhighlight %}

Yaml 也允许另一种写法，将所有键值对写成一个行内对象。

{% highlight text %}
hash: { name: Steve, foo: bar }
{% endhighlight %}


## 数组

一组连词线开头的行，构成一个数组。

{% highlight text %}
- Cat
- Dog
- Goldfish
{% endhighlight %}

数据结构的子成员是一个数组，则可以在该项下面缩进一个空格。

{% highlight text %}
 - Cat
 - Dog
 - Goldfish
{% highlight text %}

数组也可以采用**行内表示法**。

{% endhighlight %}
animal: [Cat, Dog]
{% highlight text %}



## 纯量 (scalars)

纯量是最基本的、不可再分的值。以下数据类型都属于 JavaScript 的纯量。

* 字符串
* 布尔值
* 整数
* 浮点数
* Null
* 时间
* 日期

**数值**直接以字面量的形式表示。

{% endhighlight %}
number: 12.30
{% highlight text %}

**布尔值**用`true`和`false`表示。

{% endhighlight %}
isSet: true
{% highlight text %}

**null**用`~`表示。

{% endhighlight %}
parent: ~
{% highlight text %}

**时间**采用 ISO8601 格式。

{% endhighlight %}
iso8601: 2001-12-14t21:59:43.10-05:00
{% highlight text %}

**日期**采用复合 iso8601 格式的年、月、日表示。

{% endhighlight %}
date: 1976-07-31
{% highlight text %}

YAML 允许使用两个感叹号，强制转换数据类型。

{% endhighlight %}
e: !!str 123
f: !!str true
{% highlight text %}

## 复合结构

**对象**和**数组**可以结合使用，形成**复合结构**。

{% endhighlight %}
languages:
 - Ruby
 - Perl
 - Python
websites:
 YAML: yaml.org
 Ruby: ruby-lang.org
 Python: python.org
 Perl: use.perl.org
{% highlight text %}



# 字符串

字符串是最常见，也是最复杂的一种数据类型。**字符串默认不使用引号表示**。

{% endhighlight %}
str: 这是一行字符串
{% highlight text %}

如果字符串之中包含空格或特殊字符，需要放在引号之中。

{% endhighlight %}
str: '内容： 字符串'
{% highlight text %}

单引号和双引号都可以使用，双引号不会对特殊字符转义。

{% endhighlight %}
s1: '内容\n字符串'
s2: "内容\n字符串"
{% highlight text %}

单引号之中如果还有单引号，必须连续使用两个单引号转义。

{% endhighlight %}
str: 'labor''s day'
{% highlight text %}

字符串可以写成多行，从第二行开始，必须有一个单空格缩进。换行符会被转为空格。

{% endhighlight %}
str: 这是一段
  多行
  字符串
{% highlight text %}

多行字符串可以使用`|`保留换行符，也可以使用`>`折叠换行。

{% endhighlight %}
this: |
  Foo
  Bar
that: >
  Foo
  Bar
{% highlight text %}

转为 JavaScript 代码如下。

{% endhighlight %}
{ this: 'Foo\nBar\n', that: 'Foo Bar\n' }
{% highlight text %}

`+`表示保留文字块末尾的换行，`-`表示删除字符串末尾的换行。

{% endhighlight %}
s1: |
  Foo

s2: |+
  Foo


s3: |-
  Foo
{% highlight text %}

转为 JavaScript 代码如下。

{% endhighlight %}
{ s1: 'Foo\n', s2: 'Foo\n\n\n', s3: 'Foo' }
{% highlight text %}

# 引用

锚点`&`和别名`*`，可以用来引用。

{% endhighlight %}
defaults: &defaults
  adapter:  postgres
  host:     localhost

development:
  database: myapp_development
  <<: *defaults

test:
  database: myapp_test
  <<: *defaults
{% highlight text %}

等同于下面的代码。

{% endhighlight %}
defaults:
  adapter:  postgres
  host:     localhost

development:
  database: myapp_development
  adapter:  postgres
  host:     localhost

test:
  database: myapp_test
  adapter:  postgres
  host:     localhost
{% highlight text %}

`&`用来建立锚点（defaults），`<<`表示合并到当前数据，`*`用来引用锚点。

下面是另一个例子。

{% endhighlight %}
- &showell Steve
- Clark
- Brian
- Oren
- *showell
{% highlight text %}

转为 JavaScript 代码如下。

{% endhighlight %}
[ 'Steve', 'Clark', 'Brian', 'Oren', 'Steve' ]
{% highlight text %}









# 使用示例

{% highlight yaml %}
# YAML Ain't Markup Language

person:
  name: &name "mike" # &name 设置锚点
  occupation: "programmer"
  age: !!float 23 # 23.0  # \!!类型转换
  gpa: !!str 3.5 # "3.5"
  fav_num: 1e+10 # 科学计数法
  male: true # 布尔值
  brithday: 1994-02-06 14:33:22 # 时间戳
  flaws: null # 空
  hobbies: # 数组 区块格式
    - hiking
    - movies
    - riding bike
  movies: ["Dark Knight", "Good Will Hunting"] # 数组 内联格式
  friends:
    - name: "Steph"
      age: 22
    - { name: "Adam", age:22 }
  description: > # 字符串 > 折叠换行
    So pay attention to the product description
    and reviews if your primary goal is to
    whip up your morning beverage in record time.
  signature: | # 字符串 | 保留换行
    Mike
    Giraffe Academy
    email - giraffeacademy@gmail.com
  id: *name # *name 引用锚点

  base: &base
    var1: value1

  foo:
    <<: *base # var1: value1   << 合并标签，类型继承
    var2: value2
{% endhighlight %}



# Q&A

## [How do you do block comments in YAML?](https://stackoverflow.com/questions/2276572/how-do-you-do-block-comments-in-yaml)

How do I comment a block of lines in YAML?

YAML supports inline comments, but does not support block comments.

From [Wikipedia](http://en.wikipedia.org/wiki/YAML):

> Comments begin with the number sign ( `#` ), can start anywhere on a line, and continue until the end of the line

## [why --- (3 dashes/hyphen) in yaml file?](https://stackoverflow.com/questions/50788277/why-3-dashes-hyphen-in-yaml-file)

> YAML uses three dashes `---` to separate directives from document content. This also serves to signal the start of a document if no directives are present.

It's not mandatory to have them if you do not begin your `YAML` with a directive. If it's the case, you should use them.

Let's take a look at the documentation

> 3.2.3.4. Directives
>
> Each document may be associated with a set of directives. A directive has a name and an optional sequence of parameters. **Directives are instructions to the YAML processor, and like all other presentation details are not reflected in the YAML serialization tree or representation graph.** This version of YAML defines a two directives, “YAML” and “TAG”. All other directives are reserved for future versions of YAML.

One example of this can also be found in the [documentation](http://yaml.org/spec/1.1/#YAML%20directive/) for directive `YAML`

{% highlight yaml %}
%YAML 1.2 # Attempt parsing
           # with a warning
---
"foo"
{% endhighlight %}



# Tools

* http://nodeca.github.io/js-yaml/


# Refer

* [YAML 语言教程 - 阮一峰](https://www.ruanyifeng.com/blog/2016/07/yaml.html)
* [YAML - In One Video](https://www.youtube.com/watch?v=cdLNKUoMc6c)
* [Brief YAML reference](https://camel.readthedocs.io/en/latest/yamlref.html)
* [YAML Ain’t Markup Language (YAML) Version 1.1](https://yaml.org/spec/1.1/#YAML%20directive/)
* [Learn X in Y minutes](https://learnxinyminutes.com/docs/yaml/)





{% endhighlight %}
