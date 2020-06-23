---
title: LaTex on Sublime Text
date: 2018-07-19T21:10:00+08:00
---

### Sublime Text中LaTex环境的配置

工具：LaTexing插件、MacTex（Mac），MiKTex（Win）,注意Win上安装MiKTex时路径不能有空格，不然会报路径中找不到latexmk命令。当使用CTex套件安装MiKTex时，其中latexmk包的版本可能比较低，会导致latexing无法打开日志文件等错误。

#### 1. LaTexing插件配置
```json
{
    "debug": false,
    "fallback_encoding": "utf_8",
    "open_pdf_on_load": false,
    "build_arguments": ["-shell-escape"],
    "quick_build": [
        {
            "name": "Default Build: latexmk",
            "primary": true,
            "cmds": ["xelatex"]
        },
        {
            "name": "Quick Build 1: xelatex + bibtex + xelatex (2x)",
            "cmds": ["xelatex", "bibtex", "xelatex", "xelatex"]
        },
        {
            "name": "Quick Build 2: xelatex + biber + xelatex (2x)",
            "cmds": ["xelatex", "biber", "xelatex", "xelatex"]
        }
    ],
    "typeset_on_save": true
}
```
#### 2. 配置中文Snippet
```xml
<snippet>
	<content><![CDATA[
%!TEX program = xelatex
%!TEX TS-program = xelatex
%!TEX encoding = UTF-8 Unicode

\\documentclass[a4paper]{article}
\\usepackage[UTF8, heading = false, scheme = plain]{ctex}
\\usepackage{graphicx}
\\usepackage{cite}
\\usepackage{geometry}
\\geometry{left=2.0cm, right=2.0cm, top=2.5cm, bottom=2.5cm}
\\usepackage[colorlinks,linkcolor=red,anchorcolor=blue,citecolor=green]{hyperref}
\\usepackage{subfig}
\\usepackage{caption}
\\captionsetup{font={scriptsize}}

\\renewcommand\figurename{图}

\\makeatletter
\\let\@afterindentfalse\@afterindenttrue
\\@afterindenttrue
\\makeatother
\\setlength{\parindent}{2em}  

\\linespread{1.4}
\\setlength{\parskip}{0.5\baselineskip}

\\title{${1:this}}
\\author{Kaiya Xiong}
\\date{\today}

\\begin{document}
\\maketitle

$0

\\end{document}

]]></content>
	<!-- Optional: Set a tabTrigger to define how to trigger the snippet -->
	<!-- <tabTrigger>hello</tabTrigger> -->
	<!-- Optional: Set a scope to limit where the snippet will trigger -->
	<!-- <scope>source.python</scope> -->
	 <tabTrigger>zh</tabTrigger>
    <scope>text.tex.latex</scope>
    <description>zh basic article </description></snippet>

```
#### 3. 配置Beamer Snippet
```xml
<snippet>
	<content><![CDATA[
%!TEX program = xelatex
%!TEX TS-program = xelatex
%!TEX encoding = UTF-8 Unicode

\\documentclass[aspectratio=169]{beamer}
\\usepackage[UTF8, heading = false, scheme = plain]{ctex}
\\usepackage{silence}
\\WarningFilter{biblatex}{Patching footnotes failed}
\\usepackage[hyperref=true,backend=biber,sorting=none,backref=true,style=ieee]{biblatex}
\\addbibresource{references.bib}
\\renewcommand{\footnotesize}{\tiny}
\\usepackage{graphicx}
\\usepackage{subfig}
\\usepackage{caption}
\\captionsetup{font={scriptsize}}
\\renewcommand\figurename{图}
\\newcommand\blfootnote[1]{
  \begingroup
  \renewcommand\thefootnote{}\footnote{#1}
  \addtocounter{footnote}{-1}
  \endgroup
}
% \usepackage{tikz}

\\title{${1:this}}
\\author{Kaiya Xiong}
\\date{\today}
\\institute[JNU]{Jinan University}

\\begin{document}
\\begin{frame}
\\titlepage
\\end{frame}
$0


\\end{document}

]]></content>
	<!-- Optional: Set a tabTrigger to define how to trigger the snippet -->
	<!-- <tabTrigger>hello</tabTrigger> -->
	<!-- Optional: Set a scope to limit where the snippet will trigger -->
	<!-- <scope>source.python</scope> -->
	 <tabTrigger>beamer</tabTrigger>
    <scope>text.tex.latex</scope>
    <description>zh basic beamer </description></snippet>

```



