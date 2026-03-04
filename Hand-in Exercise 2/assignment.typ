#import "@preview/diagraph:0.3.6": *
#import "@preview/chic-hdr:0.5.0": *
#import "@preview/rexllent:0.4.0": *

#show heading: set block(above: 2em)
#show heading: set block(below: 1em)
#show link: it => underline(text(fill: blue)[#it])
#show selector(<nonumber>): set heading(numbering: none)

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

#let title = "Hand-in Exercise 2"
#let subtitle = "The Game of Pacman"
#let subject = "02105 Algorithms & Data Structures 1"
#let date = "March 26th, 2026"

#let author = (if read("../.secret").trim() == "" { "name" } else { read("../.secret").trim() },)

#align(center)[
    #text(32pt)[#smallcaps(title)] \ #text(18pt)[#subtitle] \ #text(fill: black.lighten(25%), [#subject])
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

= Introduction <nonumber>
In your new job as chief map designer for a new version of the classic Pacman game you need to be able to efficiently evaluate different map designs from your developers. Luckily, all map designs are constructed in a simple and well defined format, so you can automate your evaluation of them. The format is illustrated in Figure 1. We define a map as a quadratic grid of size $N times N$. In Figure 1 $N$ is 8, 8, and 7, respectively. Each map consists of walls (marked with \#), one or more ghosts (marked with G), and exactly one Pacman (marked with P) (except in exercise 4). Pacman and the ghosts can move/stand on all fields that are not walls and are inside the grid.

#align(center, [
    #image("/assets/image.png", height: 96pt)
    Figure (1): Three Maps.
])

= Counting Ghosts
We want to compute the number of ghosts on a given map. For example, on the three maps in Figure (1) there are 3, 7, and 1 ghosts, respectively.

== Give an algorithm that, given a map, computes the number of ghosts on the map. Analyze the running time of your algorithm in terms of parameter $N$.


== [$dagger$] Implement your algorithm.





= Reachable Ghosts
Now we want to compute which ghost that are an actual threat to Pacman. More precisely, we want to know how many ghosts that can reach Pacman on a given map, that is, that has a path to Pacman. For example, on the three maps in Figure (1) there are 2, 5, and 1 ghosts that can reach Pacman, respectively.

== Give an algorithm that, given a map, computes the number of ghosts that can reach Pacman. Analyze the running time of your algorithm in terms of parameter $N$.


== [$dagger$] Implement your algorithm.





= Closest Ghost
When we compute the number of ghosts that can reach Pacman, we would like to know which ghost that is the biggest immediate threat and where it is in relation to Pacman. More precisely, we want to compute the shortest path from Pacman to the closest ghost. Pacman can only move one field up, down, left, or right -- abbreviated `N`, `S`, `W` and `E`. For example, the shortest paths on the three maps in Figure (1) are `SSWWW`, `N` and `WWWWNNEEEENNWWWW` respectively.



== Give an algorithm, that given a map computes the shortest path from Pacman to a ghost. If there are more than one possible ghost choose any of them. You can assume that there is always at least one ghost that can reach Pacman. Output should be the sequence of `N`, `S`, `W`, and `E` as a string. Analyze the running time of your algorithm in terms of parameter $N$.


== [$dagger$] Implement your algorithm.





= Multiplayer Closest Ghost
A few of the maps also have a multiplayer version with multiple Pacman players that helps each other. The maps are as before, but now there can be more Pacmen, marked with P. See figure (2).
#align(center, [
    #image("/assets/image-1.png",height: 96pt)
    Figure (2): Multiplayer Pacman.
])
In this situation we want to compute the shortest path from a Pacman to a ghost, that is, we want to find the shortest path among all possible pairs of Pacmen and ghosts. For example, in Figure (2) the shortest path is the path from Pacman in the upper right corner to the ghost below it (given by `SS`). All other pairs consisting of a Pacman and a ghost have a longer shortest path.

== Give an algorithm, that given a map computes the shortest path from a Pacman to a ghost. If there are more than one possible pair you can choose any of them. You can assume that there is always at least one ghost that can reach at least one Pacman. Output should be the length of the path. Analyze the running time of your algorithm in terms of parameter $N$.


== [$dagger$] Implement your algorithm.






