// CJK (Chinese) document — compile with: typst compile cjk-document.typ
#set document(title: "中文文档示例", author: "作者")
#set page(paper: "a4", margin: 2.5cm)
// Font fallback chain — `SimSun` (Windows native) first so the most common
// student setup compiles with the OS-default serif as the actual rendered
// font. Typst still emits one warning per font name it cannot locate on
// the host machine, but those are informational ("this font is missing,
// trying the next one"); the PDF is valid as long as ONE name in the
// chain matches.
#set text(
  lang: "zh",
  font: ("SimSun", "Microsoft YaHei", "Source Han Serif SC", "Noto Serif CJK SC"),
  size: 11pt,
)
#set heading(numbering: "1.1")
#set par(justify: true, leading: 1em, first-line-indent: 2em)

= 文档标题

这是一个中文文档模板，展示了正确的中文排版设置。

== 字体说明

本文档的字体回退链以 Windows 原生 *宋体（SimSun）* 起头，依次回退到微软雅黑、思源宋体（Source Han Serif SC）和 Noto Serif CJK SC。Typst 会对回退链里没装上的字体名各发一条 `unknown font family` 提示——这是说明性信息，只要链里有任意一个字体被识别到，PDF 就能正常输出。Mac 学员可以把回退链头部换成 Songti SC，Linux 学员可以换成 Noto Serif CJK SC。

== 数学公式

欧拉公式：$ e^(i pi) + 1 = 0 $

== 列表

- 第一项
- 第二项
  - 嵌套项

+ 编号一
+ 编号二
