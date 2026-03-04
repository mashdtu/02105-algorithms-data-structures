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

#let title = "Week 1 Exercise Sheet"
#let subtitle = "Basic Concepts I: Introduction, Algorithms, Data Structures, Peaks"
#let subject = "02105 Algorithms and Data Structures"
#let date = "February 5th, 2026"

#let author = ("mashdtu",)

#align(center)[
    #text(32pt)[#smallcaps(title)] \ #text(14pt)[#subtitle] \ #text(fill:black.lighten(25%), [#subject])
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




= Find Peaks

Let $A = [2, 1, 3, 7, 3, 11, 1, 5, 7, 10]$ be an array. Solve the following exercises.

== [$w$] Specify all peaks in $A$
For a value $A[i] in A$ to be a peak, the immediate neighbours to the value must both be less than or equal to $A[i]$. I.e. $A[i-1] <= A[i] >= A[i+1]$. The peaks in $A$ are $A[0] = 2$, $A[3] = 7$, $A[5] = 11$ and $A[9] = 10$.


== [$w$] Specify which peaks the two linear time algorithms find.

The two linear time algorithms are Algorithm 1 and Algorithm 2.

*Algorithm 1 (Peak1)*
```
Peak1(A, n)
    if A[0] >= A[1] return 0
    for i = 1 to n-2
        if A[i-1] <= A[i] >= A[i+1] return i
    if A[n-2] <= A[n-1] return n-1
```

This algorithm is applied to each index of the array from left to right, i.e. from smallest index to largest in the array. As such, it will find the leftmost peak in the array $A[0] = 2$.

*Algorithm 2 (FindMax)*
```
FindMax(A, n)
    max = 0
    for i = 0 to n-1
        if (A[i] > max) max = A[i]
    return max
```
This algorithm is also applied from left to right, i.e. from smallest index to largest in the array. It will also find the same leftmost peak of $A[0] = 2$.



== Specify the sequence of recursive calls the recursive algorithm produces. First, assume the algorithm visits the left half of the array if both directions are valid. Then, specify all the possible sequences of recursive calls the algorithm can make when picking any of the two valid directions.







= Valleys

== [$w$] Propose a _valley_ problem analogous to the peak problem. Give a precise definition of the valley problem, including specifying the input and output.



= Algorithms and Applications

== Pick a data structure from your introductory programming course and discuss its strengths and limitations.


== Suggest a real-world problem where only the optimal solution will do. Similarly, suggest a real-world problem where an approximate solution suffices.

== Suggest relevant measures of complexity of algorithms other than time. Suggest at least 3.



= Properties of Peaks
Let $A$ be an array of length $n >= 1$. Solve the following exercises.

== Prove that there is always at least one peak in $A$.


== What is the maximum number of peaks in $A$?



== Suppose we change the definition of peak as follows: $A[i]$ is a peak if $A[i]$ is _strictly larger_ than its neighbours. What is the effect on the above properties? Can we still find a peak in $O(log n)$ time with the recursive algorithm?


= Peaks

== [$dagger$] Implement and test one of the two linear time algorithms for finding peaks.

== [$dagger$] Implement the recursive algorithm for finding peaks (be careful not to go out of bounds)

== Describe the worst-case inputs for each of the three peak algorithms.

== Design an iterative version of the recursive algorithm for finding peaks. Write the pseudocode for the algorithm.

== Prove that the recursive algorithm always finds a peak. _Hint_: Define an appropriate invariant that is valid in each recursive call and use induction.


= Fun with arrays
Let $A$ be an array of integers of length $n$. Consider the following pseudocode.
```
ArrayFun(A, n)
for i=0 to n-1 do
    for j=0 to n-1 do
        if A[i] + A[j] = 0 then
            return true
        end if
    end for
end for
return false
```


== Explain briefly and concisely what `ArrayFun` computes.

== Analyse the running time of `ArrayFun` on an array of length $n$.

== Suppose we change "$j = 0$" to "$j = i + 1$". Briefly describe what `ArrayFun` now computes and analyse the running time.



= 2D Peaks
Let $M$ be an $n times n$ matrix (2D-array). An entry $M[i, j]$ is a peak if it is no smaller than its $N$, $E$, $S$ and $W$ neighbours. I.e.:
$
    M[i][j] >= M[i - 1][j], thick
    M[i][j] >= M[i + 1][j], thick
    M[i][j] >= M[i][j - 1], thick
    M[i][j] >= M[i][j + 1].
$
We are interested in efficient algorithms for finding peaks in $A$.

== Give a simple algorithm that takes $O(n^2)$ times.

== [\*] Give an algorithm that takes $O(n log n)$ time. _Hint_: Start by finding the maximum number in the canter column and use this to solve the problem recursively.

== [\*\*] Give an algorithm that takes $O(n)$ time. _Hint_: Construct a recursive solution that divides $M$ into 4 quadrants.



