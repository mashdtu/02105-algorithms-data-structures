#import "@preview/diagraph:0.3.6": *
#import "@preview/chic-hdr:0.5.0": *
#import "@preview/rexllent:0.4.0": *

#show heading: set block(above: 2em)
#show heading: set block(below: 1em)
#show link: it => underline(text(fill: blue)[#it])

#let first-heading = state("first-heading", true)
#show heading.where(level: 1): it => {
    context if first-heading.get() {
        first-heading.update(false)
        it
    } else {
        pagebreak(weak: true) + it
    }
}

#let numberingH(c) = {
    if c.numbering != none {
        return numbering(c.numbering, ..counter(heading).at(c.location()))
    }
    return ""
}

#let currentH(level) = {
    let elems = query(selector(heading.where(level: level)).after(here()))

    if elems.len() != 0 and elems.first().location().page() == here().page() {
        return [#numberingH(elems.first()) #elems.first().body]
    } else {
        elems = query(selector(heading.where(level: level)).before(here()))
        if elems.len() != 0 {
            return [#numberingH(elems.last()) #elems.last().body]
        }
    }
    return ""
}

#set page(
    paper: "a4",
    margin: (x: 2.5cm, y: 2.5cm),
    number-align: right,
)

#set par(
    justify: true,
)

#set text(
    font: "New Computer Modern",
    size: 12pt,
)

#set heading(
    numbering: "1.1 ",
)

#let ansline = line(
    start: (0%, 0%),
    end: (100%, 0%),
    stroke: (thickness: 1pt, dash: "dashed"),
)

#let title = "Week 5 Exercise Sheet"
#let subtitle = "Graph Algorithms I: Undirected Graphs, Representation, Searching, Modelling"
#let subject = "02105 Algorithms & Data Structures 1"
#let date = "March 5th, 2026"

#let author = (if read("../.secret").trim() == "" { "name" } else { read("../.secret").trim() },)

#align(center)[
    #text(32pt)[#smallcaps(title)] \ #text(12pt)[#subtitle] \ #text(fill: black.lighten(25%), [#subject])
]

#{
    grid(
        columns: (1fr,) * author.len(),
        column-gutter: -120pt,
        ..author.map(a => align(center)[#a])
    )
}

#align(center)[
    #date
]


#outline()
#pagebreak()

#counter(page).update(1)
#show: chic.with(
    chic-footer(
        right-side: "Page " + context str(counter(page).get().first()) + " of " + str(counter(page).final().first()),
    ),
)

= Representation, Properties and Algorithms
Consider the graphs in Figure (1).

#align(center, [
    #image("/assets/image-3.png", height: 96pt)
    Figure (1): Graphs for the exercises. (a) is the _Petersen_ graph.
])

Solve the following exercises.

== [w] Show adjacency lists and adjacency matrices for $(a)$ and $(c)$.

== [w] Simulate DFS on $(a)$ starting in vertex $0$. Assume the adjacency lists are sorted. Specify the DFS-tree and discovery and finish times.

== [w] Simulate BFS on $(a)$ starting in vertex $0$. Assume the adjacency lists are sorted. Specify the BFS-tree and the distance for each vertex

== Specify the connected components of $(a)$, $(b)$, and $(c)$.

== Which of $(a)$, $(b)$, and $(c)$ are bipartite?




= Depth-First Search using a Stack
== Explain how to implement DFS without using recursion. _Hint_: use an (explicit) stack




= Find a Cycle
== Give an algorithm that determines if a graph is _cyclic_, ie. contains a cycle. How fast is your algorithm?




= Number of Shortest Paths 
== Give an algorithm that given two vertices $s$ and $t$ in $G$ returns the number of shortest paths between $s$ and $t$ in $G.$


= Mazes and Grid Graphs (exam 2010)
A $k times k$ grid graph is a graph where the vertices are arranged in $k$ rows each containing $k$ vertices. Only vertices that are adjacent in the horizontal or vertical direction may have an edge between them. See Figure (2)(a).

#align(center, [
    #image("/assets/image-4.png", width: 90%)
    Figure (2):
    (a) a $6 times 6$ grid graph. (b), (c), and (d) are $6 times 6$ mazes. (b) is happy, (c) is unhappy since the end field cannot be reached, and (d) is unhappy since it contains a circular walk.
])


A $k times k$ maze is a square drawing consisting of $k^2$ fields arranged in $k$ rows each containing $k$ fields. Each of the four sides of each field is either a wall or empty. A walk in a maze is a sequence of fields $f_1, . . . , f_j$ such that any pair $f, f'$ of consecutive fields in the sequence are adjacent in the horizontal or vertical direction and the shared side of $f$ and $f'$ is empty. A special field in the maze is designated as begin and another special field is designated as end. A maze is happy if the following conditions hold:

- There is exactly one unique walk in the maze from begin to end.
- There is a walk from begin to any field in the maze.
- There are no circular walks, i.e., walks that start and end in the same field.

A maze that is not happy is _unhappy_. See Figure (2)(b)-(d). Solve the following exercises.

== Let the $n$ and $m$ denote the number of vertices and edges, respectively, in a $k times k$ grid graph. Express $n$ and $m$ as a function of $k$ in asymptotic notation.


== Explain how to model a $k times k$ maze as a $k times k$ grid graph.


== Draw the maze in Figure (2)(b) as a grid graph.


== Give an algorithm, that given a $k times k$ maze modelled as a $k times k$ grid graph, determines if the maze is happy. Argue the correctness of your algorithm and analyze it's running time as a function of $k$.




= Construction Work
Alice and Christa are new students at DTU. Due to all the construction work, it's very difficult to find their way from one building to another between classes. We want to help Alice and Christa by giving an algorithm to compute whether they can get from building $a$ to $b$ by following paths.

*Input* $quad$ Line 1 contain four integers $N$, $M$, $a$, and $b$ separated by spaces, where $N$ is the number of buildings, $M$ is the number of paths between buildings, $a$ is the building they start in and $b$ is the building they want to reach. Line $2 . . . M +1$ each contain two integers $u$ and $v$, $0 <= u, v <= N - 1$, indicating that there is a path between building $u$ and $v$.

*Output* $quad$ A single line with "YES" if there is a way to get from from building $a$ to building $b$ and "NO" otherwise.

== [$dagger$] Give an algorithm that computes whether Alice and Christa can get from building $a$ to $b$.





= Euler Tours and Euler Paths
Let $G$ be a connected graph with $n$ vertices and $m$ edges. An Euler tour in $G$ is a cycle that contains all edges in $G$ exactly once. An Euler path in $G$ is a path that contains all edges in $G$ exactly once. Solve the following exercises.


== Which of the drawings below can you draw without lifting the pencil? Can you start and end at the same place
#image("/assets/image-5.png", width: 75%)


== [\*] Show that $G$ has an Euler tour if and only if all vertices have even degree.


== [\*] Show that $G$ has an Euler path if and only if 2 or 0 vertices have odd degree.


== Give an $O(n + m)$ time algorithm that determines if $G$ has an Euler tour.


== Give an $O(n + m)$ algorithm that finds an Euler tour in $G$ if it exists.







= Diameter of Trees
Let $T$ be a tree with n vertices. The diameter of $T$ is the longest shortest path between any pair
of vertices in $T$. Solve the following exercises.

== Give algorithm to compute the diameter of $T$ in $O(n^2)$ time.

== Give algorithm to compute the diameter of $T$ in $O(n)$ time.




