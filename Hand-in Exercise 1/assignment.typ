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

#let title = "Hand-in Exercise 1"
#let subtitle = "Time Complexity and Running Time"
#let subject = "02105 Algorithms & Data Structures 1"
#let date = "March 4th, 2026"

#let author = ("mashdtu",)

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

= Complexity

== Arrange the following functions in increasing order according to asymptotic growth. That is, if $g(n)$ immediately follows $f(n)$ in your list, then $f(n) = O(g(n))$.
$
    sqrt(log n)
    quad quad 18 dot log (n^2)
    quad quad (log n) dot n
    quad quad 3^(n - 4)
    quad quad n^2
    quad quad 3 dot log^3 n
$


#ansline

We find $O(g(n))$ for each function:
$
         O(sqrt(log n)) & = sqrt(log n) \
    O(18 dot log (n^2)) & = log n \
       O((log n) dot n) & = n log n \
           O(3^(n - 4)) & = 3^n \
                 O(n^2) & = n^2 \
       O(3 dot log^3 n) & = log^3 n
$
To rank each by their asymptotic growth they are plotted against eachother in a logarithmic coordinate system.
#align(center, [
    #image("assets/WhatsApp Image 2026-03-03 at 14.33.12.jpeg", width: 60%)
])

It becomes clear that the functions $O(g(n))$ rank from fastest to slowest as follows.#footnote("The legend of the graph is ordered in terms of asymptotic growth speed from fastest to slowest.")
$
    sqrt(log n)
    quad quad log n
    quad quad log^3 n
    quad quad n log n
    quad quad n^2
    quad quad 3^n
$

Which corresponds to the following order of original functions $g(n)$.
$
    sqrt(log n)
    quad quad 18 dot log (n^2)
    quad quad 3 dot log^3 n
    quad quad (log n) dot n
    quad quad n^2
    quad quad 3^(n - 4)
$


#ansline



== State the running time for each of the following algorithms. Write your solution in $O$-notation as a function of $n$.
#grid(
    columns: (1fr, 1fr, 1fr),
    [
        ```
        Alg1(n)
            i = 1
            c = 0
            while i <= n do
                for j = 1 to i do
                    c = i + j
                end for
                i = 2 * i
            end while
        ```
    ],
    [
        ```
        Alg2(n)
            if n <= 1 then
                return 1
            else
                return 1 +
                    Alg2(n/2)
            end if
        ```
    ],
    [
        ```
        Alg3(n)
            c = 0
            for i = 1 to ceil(sqrt(n)) do
                for j = i to ceil(sqrt(n)) do
                    c = i + j
                end for
            end for
        ```
    ],
)

#ansline


*Algorithm 1*
\
Line by line `Alg1` is executed as
$
    c + k dot (i dot (c) + c)
$
where $i = {1, 2, 4, 8, 16, ..., 2^k}$ and $2^k <= n <=> k = log_2 n$. As such, the external loop runs a total of $floor(log_2 n)$ times. Since $i$ does not change while inside each iteration of the internal loop, we know that the internal loop runs a total of $i$ times. The total work $T$ is computed.
$
    T(n) = sum_(i = {1, 2, 4, 8, ..., 2^k}) i
    = 1 + 2 + 4 + 8 + ... + 2^k
    = 2^(k+1)
$
Since $2^k <= n space => space 2^(k + 1) <= 2n space => space T(n) <= 2n space => space T(n) = O(n)$. Thus the algorithm is of time complexity $O(n)$.
\ \

*Algorithm 2*
\
Line by line `Alg2` is executed as
$
    c + i dot c
$
where $i = {n, n/2, n/4, n/8, ..., n/2^k}$, and $n/2^k >= 1 space => space 2^k = n space => space k = ceil(log_2 n)$. The total work $T$ is computed.
$
    T(n) = sum_(k=0)^(ceil(log_2 n)) c
    = c dot (ceil(log_2 n) + 1)
    = O(log_2 n)
$
Thus the algorithm is of time complexity $O(log_2 n)$.

#pagebreak()
*Algorithm 3*
\
Line by line `Alg3` is executed as
$
    c + i dot (j dot c)
$
where $i = {1, 2, 3, ..., ceil(sqrt(n))}$ and $j = ceil(sqrt(n)) - i$. The total work $T$ is computed using substitution.
$
    m = ceil(sqrt(n))
    space => space
    T(n) &= sum_(i=1)^(m) (m - i + 1)
    = m dot (m + 1) - sum_(i=1)^(m) i
    \
    &= m dot (m + 1) - (m dot (m + 1))/2
    = (m dot (m + 1))/2
$
Substituting $ceil(sqrt(n))$ back in:
$
    T(n) = (m dot (m + 1))/2
    = (ceil(sqrt(n)) dot (ceil(sqrt(n)) + 1))/2
    approx (sqrt(n) dot sqrt(n))/2
    = n/2
    space <=> space
    T(n) = O(n)
$
Thus the algorithm is of time complexity $O(n)$.


#ansline





#pagebreak()
= Superhero Team
Consider building a team $T$ of superheroes from a set $S$ of available superheroes. Each superhero has a _cost_. A _superhero team_ $T$ is a subset of $S$ and the _cost_ of $T$ is the sum of cost of all superheroes in $T$. Throughout the exercise, we let $m$ denote the size of $S$ and assume that $S$ is given as an array $A$ where each entry contains the cost of a superhero.



== Give an algorithm that computes the cost of a cheapest team of 7 superheroes. Analyse the running time of your algorithm in terms of parameter $m$.

#ansline





#ansline


== As exercise 2.1 but now we want an algorithm that computes the cost of a cheapest team of $floor(sqrt(m))$ superheroes. Analyse the running time of your algorithm in terms of parameter $m$.

#ansline



#ansline


== Give an algorithm that computes the number of _distinct_ costs of superheroes, i.e., the number of different costs of the superheroes in $S$. Analyse the running time of your algorithm in terms of parameter $m$.

#ansline



#ansline




