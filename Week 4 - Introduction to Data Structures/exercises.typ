#import "@preview/diagraph:0.3.6": *

#show heading: set block(above: 2em)
#show heading: set block(below: 1em)
#show link: it => underline(text(fill: blue)[#it])
#show heading.where(level: 3): set heading(outlined: false)

#set page(
    paper: "a4",
    margin: (x: 2.5cm, y: 2.5cm),
    numbering: "1 of 1",
    number-align: right,
    header: none
)

#set par(
    justify: true,
)

#set text(
    font: "New Computer Modern",
    size: 12pt
)

#set heading(
    numbering: "1.1 ",
)

#let ansline = line(
    start: (0%, 0%),
    end: (100%, 0%),
    stroke: (thickness: 1pt, dash: "dashed")
)

#let title = "Week 4 Exercise Sheet"
#let subtitle = "Data Structures I: Stack, Queues, Linked Lists, Trees"
#let subject = "02105 Algorithms and Data Structures"
#let date = "February 26th, 2026"

#let author = ("mashdtu",)

#align(center)[
    #text(32pt)[#smallcaps(title)] \ #text(18pt)[#subtitle] \ #text(fill:black.lighten(25%), [#subject])
]

#{
    grid(columns: (1fr,) * author.len(),
        column-gutter: 2pt,
        ..author.map(a => align(center)[#a])
    )
}

#align(center)[
    #date
]

//#v(16pt)
//#grid(columns: (1cm, 1fr, 1cm),
//    column-gutter: 2pt,
//    [],
//    [- The number of #sym.star.filled's gives a rough indicator of the task's difficulty. You should aim to solve at least all tasks with at most three #sym.star.filled's. Tasks with more stars can be hard or require mathematical background that you should have from previous courses.
//
//    - You can always ask us for feedback or help during the exercise class.
//
//    - We recommend that you first read all tasks during class. Make sure that you have a rough approach for every task in mind before you start working on the details. Ask for help if a task is unclear such that you do not get stuck when we are not there to help.],
//    []
//)

//#pagebreak()
#outline()

//#v(16pt)
//#grid(columns: (1cm, 1fr, 1cm),
//    column-gutter: 2pt,
//    [],
//    [],
//    []
//)

    

#pagebreak()



