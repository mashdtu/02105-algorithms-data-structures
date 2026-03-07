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

#let title = "Week 6 Exercise Sheet"
#let subtitle = "Graph Algorithms II: Directed Graph, Topological Sorting, Implicit Graphs"
#let subject = "02105 Algorithms & Data Structures 1"
#let date = "March 12th, 2026"

#let author = (if read("../.secret").trim() == "" { "name" } else { read("../.secret").trim() },)

#align(center)[
    #text(32pt)[#smallcaps(title)] \ #text(14pt)[#subtitle] \ #text(fill: black.lighten(25%), [#subject])
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
#align(center, [
    #image("/assets/image-2.png", height: 96pt)
    Figure (1): Graphs for the exercises.
])
\

Consider the graphs in figure (1). Solve the following exercises.


== [w] Show adjacency lists and adjacency matrices for (a) and (b).


== [w] Run DFS or BFS starting in node 4 in (a) and node 5 in (c) by hand.


== Which of (a) and (c) are DAGs? If the graph is a DAG find a topological ordering using the recursive algorithm for topological sorting. If the graph is not a DAG find a cycle.


== Specify strongly connected components of (a) and (c).


== How many topological orderings does (b) have?


== How many strongly connected components does a DAG have?



= Snakes and Ladders
Snakes and ladders is a classic board game. We will look at the following variant. The game
is played on a $n times n$ grid with cells numbered from $1$ to $n^2$ in order (see the figure). Special pairs of cells are _snakes_ that
lead downwards and _ladders_ that lead upwards. A cell can be the endpoint for, at most, one ladder or snake. The goal of the game is to move from cell $1$ to cell $n^2$ in the fewest possible rounds. First, place a piece on cell $1$. In each
round, you can move the piece _at most_ 5 fields forward. If the piece ends in the top of a snake the piece is moved to the
bottom of the snake, and, similarly, if the piece ends in the bottom of a ladder it is moved to the top of the ladder.

== Give an algorithm to compute the fewest number of rounds needed to move a piece from cell $1$ to cell $n^2$.



= DAGs and Topological Sorting
== Professor Tom Opological suggests the following new and simple algorithm to construct a topological ordering: run BFS from a node $s$ with in-degree 0 and sort the nodes by increasing distance to $s$. Does the algorithm work?

== Give an algorithm that given a graph $G$ and an ordering $S$ of the nodes in $G$ determines if $S$ is a topological ordering.


== Given a DAG $G$, does there exist a topological ordering of $G$ that cannot be produced by the recursive algorithm for topological sorting?

== [\*] A _Hamiltonian path_ is a path that visits all nodes exactly once. Give an algorithm that determines if a DAG has a Hamiltonian path.



= Course Planning
Josefine has spent the entire summer deciding what courses she wants to study at The University of Algorithms. A course takes one semester to finish (and as the super student she is, she always succeeds). Some of the courses depend on other courses, and students are therefore not allowed to take them in the same semester. If course $i$ depends on course $j$, Josefine must take course $j$ in an earlier semester than course $i$. She wants to finish her studies in as few semesters as possible. Given the courses Josefine wants to study and the courses they each depend on, compute the fewest number of semesters Josefine needs to use to finish her studies. (Again, she is a super student, so she can take an unlimited number of courses each semester). You can assume there are no cyclic dependencies in the courses Josefine has chosen. Give an algorithm for this problem and implement it.

*Input* $quad$ Line 1 contains integers $N$ and $M$ separated by a space, where $N$ is the number of courses and $M$ is the total number of dependencies. Line $2 . . . M + 1$ contain two integers $i$ and $j$, indicating that course $i$ depends on course $j$, i.e., course $j$ must be completed before course $i$.

*Output* $quad$ A single line with the fewest number of semesters needed for Josefine to complete her studies.

== [\*$dagger$] Give an algorithm for this problem and implement it





= Ethnographers
You're helping a group of ethnographers analyze some oral history data they've collected by interviewing members of a village to learn about the lives of people who've lived there over the past two hundred years. From these interviews, they've learned about a set of $n$ people (all of them now deceased), whom we'll denote $P_1, P_2, . . . , P_n$. They've also collected facts about when these people lived relative to one another. Each fact has one of the following two forms:

#pad(left: 1.5em)[(a) For some $i$ and $j$, person $P_i$ died before $P_j$ was born.]

#pad(left: 1.5em)[(b) For some $i$ and $j$, the life spans of $P_i$ and $P_j$ overlapped at least partially.]

Naturally, they're not sure that all these facts are correct; memories are not so good, and a lot of this was passed down by word of mouth. So what they'd like you to determine is whether the data they've collected is at least internally consistent, in the sense that there could have existed a set of people for which all the facts they've learned simultaneously hold.

== [\*] Give an efficient algorithm to do this: either it should produce proposed dates of birth and death for each of the $n$ people so that all the facts hold true, or it should report (correctly) that no such dates can exist -- that is, the facts collected by the ethnographers are not internally consistent.



= Topological Sorting and DAGs
== Show that a directed graph $G$ is a DAG if and only if $G$ has a topological sorting. _Hint:_ use the Lemma on the correctness of topological sorting.




= Three Bottles
You are given three bottles with capacities of 8, 5, and 3 liters, respectively. Initially, the 8-liter bottle is filled with water, and the two other bottles are empty. Your target is to have precisely 4 liters of water in one of the bottles. You can pour water from one bottle to another, but you must continue until either the bottle you are pouring from is empty or the one you are pouring to is full. 


== [\*] Show it is possible to do this and give the shortest sequence of fillings/empties you can find.


== [\*] Now assume you have n bottles with integer capacities $d_1, . . . , d_n$ in liters and a target of $x$ liters water in a bottle in the end. Give an algorithm to compute the shortest sequence of fillings/empties. Assume that a valid sequence exists. _Hint:_ model the problem as an implicit graph






