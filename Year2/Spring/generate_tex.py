from bs4 import BeautifulSoup

INPUT_HTML = "problems.html"
OUTPUT_TEX = "complex_analysis_problems.tex"


def escape_latex(text):
    replacements = {
            "\\lt": r"<",
            }

    for old, new in replacements.items():
        text = text.replace(old, new)

    return text


# Read HTML
with open(INPUT_HTML, "r", encoding="utf-8") as f:
    html = f.read()

soup = BeautifulSoup(html, "html.parser")

table = soup.find("table")

if table is None:
    raise ValueError("No table found in HTML.")

rows = table.find_all("tr")

latex = r"""
\documentclass[10pt]{article}

\usepackage[letterpaper,top=1in,left=1in,right=1in]{geometry}
\usepackage[dvipsnames,svgnames]{xcolor}
\usepackage[shortlabels]{enumitem}
\usepackage[framemethod=TikZ]{mdframed}
\usepackage{amsmath,amssymb,amsthm}
\usepackage[colorlinks]{hyperref}
\usepackage{multicol}
\usepackage{tabularx}
\usepackage{bbm}
\usepackage{tikz-cd}
\usepackage{mathrsfs}

\hypersetup{
    colorlinks=true,
    linkcolor=blue,
    filecolor=magenta,
    urlcolor=magenta,
    pdftitle={{CA comps problems}}
}

\usepackage{mathtools}
\usepackage{thmtools}
\usepackage[textsize=footnotesize]{todonotes}
\usepackage{titling}
\usepackage{cancel}

\mdfdefinestyle{mdblackbox}{linecolor=black,backgroundcolor=RedViolet!5!gray!5,
linewidth=3pt,rightline=false,leftline=true,topline=false,bottomline=false,}
\declaretheoremstyle[mdframed={style=mdblackbox}]{thmblackbox}

\declaretheoremstyle[spaceabove=6pt,spacebelow=6pt]{boldhead}

\declaretheorem[style=boldhead,name=Problem]{problem}
\declaretheorem[style=boldhead,name=Claim,numberwithin=problem]{claim}
\declaretheorem[style=thmblackbox,name=Remark,numberwithin=problem]{remark}

\providecommand{\ol}{\overline}
\providecommand{\tensor}{\otimes}
\renewcommand{\hom}{\operatorname{Hom}}
\providecommand{\tor}{\operatorname{Tor}}
\providecommand{\Gal}{\operatorname{Gal}}
\providecommand{\ceil}[1]{\left\lceil #1 \right\rceil}
\providecommand{\floor}[1]{\left\lfloor #1 \right\rfloor}
\newcommand{\dd}{\,\mathrm{d}}
\providecommand{\ul}{\underline}
\providecommand{\eps}{\varepsilon}
\providecommand{\half}{\frac{1}{2}}
\providecommand{\CC}{\mathbb C}
\providecommand{\FF}{\mathbb F}
\providecommand{\II}{\mathbb I}
\providecommand{\NN}{\mathbb N}
\providecommand{\QQ}{\mathbb Q}
\providecommand{\RR}{\mathbb R}
\providecommand{\ZZ}{\mathbb Z}
\providecommand{\ind}{\mathbbm 1}
\providecommand{\dg}{^\circ}
\providecommand{\ii}{\item}
\providecommand{\setdiff}{\smallsetminus}
\providecommand{\alert}[1]{{\sffamily\textbf{\textcolor{blue}{#1}}}}
\providecommand{\inv}{^{-1}}
\providecommand{\mb}[1]{\mathbf{#1}}
\newcommand{\what}{\widehat}

\newenvironment{soln}{\begin{proof}[Solution]}{\end{proof}}

\providecommand{\pow}{\operatorname{Pow}}
\providecommand{\vocab}[1]{{\textbf{\textcolor{ForestGreen}{#1}}}}
\providecommand{\lcm}{\operatorname{lcm}}
\providecommand{\abs}[1]{\left\lvert #1\right\rvert}
\providecommand{\smabs}[1]{\lvert #1\rvert}
\providecommand{\innerprod}[1]{\langle\!\langle #1\rangle\!\rangle}
\providecommand{\norm}[1]{\left\| #1\right\|}
\providecommand{\smnorm}[1]{\| #1\|}
\providecommand{\gr}{\operatorname{gr}}

\begin{document}

\title{Complex Analysis Problems}
\date{}
\maketitle
"""

count = 0

for row in rows:
    cells = row.find_all(["td", "th"])

    # Expected columns:
    # 0 = year
    # 1 = problem number
    # 2 = area
    # 3 = keywords
    # 4 = theorem
    # 5 = question
    # 6 = ref
    # 7 = status

    if len(cells) < 6:
        continue

    # Skip header row
    first_cell = cells[0].get_text(strip=True).lower()
    if first_cell == "year":
        continue

    area = cells[2].get_text(" ", strip=True)

    # Only include Complex Analysis problems
    if area != "Complex Analysis":
        continue

    year = cells[0].get_text(" ", strip=True)
    problem_number = cells[1].get_text(" ", strip=True)
    question = cells[5].get_text(" ", strip=True)

    year = escape_latex(year)
    problem_number = escape_latex(problem_number)
    question = escape_latex(question)

    latex += rf"""
\begin{{problem}}
[{year} {problem_number}]
{question}
\end{{problem}}

\begin{{soln}}

\end{{soln}}

\vspace{{1cm}}
"""

    count += 1

latex += r"""
\end{document}
"""

with open(OUTPUT_TEX, "w", encoding="utf-8") as f:
    f.write(latex)

print(f"Wrote {OUTPUT_TEX}")
print(f"Included {count} Complex Analysis problems.")
