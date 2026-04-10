// CJK (Chinese) document — compile with: typst compile cjk-document.typ
#set document(title: "中文文档示例", author: "作者")
#set page(paper: "a4", margin: 2.5cm)
#set text(
  lang: "zh",
  font: ("Source Han Serif SC", "SimSun", "Microsoft YaHei", "Noto Serif CJK SC"),
  size: 11pt,
)
#set heading(numbering: "1.1")
#set par(justify: true, leading: 1em, first-line-indent: 2em)

= 文档标题

这是一个中文文档模板，展示了正确的中文排版设置。

== 字体说明

本文档使用思源宋体作为首选字体，依次回退到宋体、微软雅黑和 Noto Serif CJK。请确保系统中安装了至少一种字体。

== 数学公式

欧拉公式：$ e^(i pi) + 1 = 0 $

== 列表

- 第一项
- 第二项
  - 嵌套项

+ 编号一
+ 编号二
