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

#let title = "Week 2 Exercise Sheet"
#let subtitle = "Basic Concepts II: Searching, Sorting"
#let subject = "02105 Algorithms and Data Structures"
#let date = "February 5th, 2026"

#let author = (if read("../.secret").trim() == "" { "name" } else { read("../.secret").trim() },)

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




= Run by Hand and Properties

== [w] Show the execution of insertion sort on the array $A = [31, 41, 59, 26, 41, 58]$.

#align(center, [
    #image("assets/image-1.png", width: 65%)
])


== [w] Modify the pseudocode for insertion sort to sort the input array in non-decreasing order instead of non-increasing order.
Psuedocode for insertion sort:
```
InsertionSort(A, n)
    for i = 1 to n-1
        j = 1
        while j > 0 and A[j-1] > A[j]
            swap A[j] and A[j-1]
            j = j - 1
```
\

Modified (swapped ">" for "<" at line 4):
```
InsertionSort(A, n)
    for i = 1 to n-1
        j = 1
        while j > 0 and A[j-1] < A[j]
            swap A[j] and A[j-1]
            j = j - 1
```

== Show the execution of merge sort on the array $A = [3, 41, 52, 26, 38, 57, 9, 49]$





== Convince yourself that insertion sort may be expressed recursively as follows: to sort $A[0, n - 1]$ we recursively sort $A[0, n - 2]$ and then insert $A[n - 1]$ into to the sorted array $A[0, n - 2]$. Write a recurrence for the running time and then find a solution






== A friend suggest that you should use binary search to speed up the insertion step in insertion sort. Will this work and if so, how will it affect the running time of the algorithm?
Binary search pseudocode:
```
BinarySearch(A, i, j, x)
    if j < i
        return false
    m = floor((i+j)/2)
    if A[m] = x
        return true
    if A[m] < x
        return BINARYSEARCH(A, m+1, j, x)
    else
        return BINARYSEARCH(A, i, m-1, x)
```





#pagebreak()
= Duplicates and Close Neighbours

Let $A[0..n - 1]$ be an array of integers.

== [w] A duplicate in $A$ is a pair of entries $i$ and $j$ such that $A[i] = A[j]$. Give an algorithm that determines if there is a duplicate in $A$ in $O(n^2)$ time.
```
for i in A
    for j in b
        if A[i] = B[j]
            return true
        else
            return false
```



== Give an algorithm that determines if there is a duplicate in $A$ in $O(n log n)$ time. _Hint_: use merge sort.
Modified mergesort:
```
MergeSort(A, i, j)
    if i < j
        m = floor((i+j)/2)
        MergeSort(A, i, m)
        MergeSort(A, m+1, j)
        Merge(A, i, m, j)
        if (A[i] = A[j])
            return true
    return false
```


== A closest pair in $A$ is a pair of entries $i$ and $j$ such that $|A[i] - A[j]|$ is minimal among all the pairs of entries. Give an algorithm that finds a closest pair in $A$ in $O(n log n)$ time.
Modified mergesort:
```
p1 = 0
p2 = 0
MergeSort(A, i, j)
    if i < j
        m = floor((i+j)/2)
        MergeSort(A, i, m)
        MergeSort(A, m+1, j)
        Merge(A, i, m, j)
        if (|A[i] - A[j]| < d)
            p1 = i
            p2 = j
    return [p1, p2]
```


#pagebreak()
= Stones
Josefine likes to go to the beach and collect stones. Josefine likes to bring home as many stones as possible, but she can only carry $W$ kilograms of stones.


== [$dagger$] Give an algorithm that, given a list of the weights of $N$ stones and the maximum weight $W$, determines the maximal number of stones she can bring home that day.
This can be done by sorting the array, then taking the sum of each element in order, until the sum exeeds $W$. View 3.1.py or 3.1.ipynb for full program.
```py
def MaxWeight(weights, N, W):
    """Determine maximum number of stones"""
    s = 0
    i = 0
    weights = MergeSort(weights, 0, N)
    while s <= W and i < N:
        s += weights[i]
        print(s)
        i += 1
    return i - 1

MaxWeight([2, 3, 4, 6, 1], 5, 8)
```

Time complexity is equivalent to that of merge sort:
$
    T(n) = a n log_2 n + b n + c n + d
    ->
    O(n log_2 n)
$



#pagebreak()
= Correctness of Merge Sort
== Show that merge sort sorts all arrays correctly. You can assume that merge correctly merges sorted arrays. _Hint_: use induction.





#pagebreak()
= 2Sum and 3Sum
Let $A[0..n - 1]$ be an array of integers (positive and negative). The array $A$ has a 2-sum if there exist two entries $i$ and $j$ such that $A[i] + A[ j] = 0$. Similarly, $A$ has a 3-sum if there exists three entries $i$, $j$ and $k$ such that $A[i] + A[ j] + A[k] = 0$. Solve the following exercises.


== [w] Give a simple algorithm that determines if $A$ has a 2-sum in $O(n^2)$ time.
```
TwoSum1(A)
    for i = 0 to n-1
        for j = i to n-1
            if A[i] + A[j] = 0
                return true
    return false
```

Time complexity is evaluated:
$
    T(n) = a n^2 + b
    ->
    O(n^2)
$


== Give an algorithm that determines if $A$ has a 2-sum in $O(n log n)$ time. _Hint_: use binary search





== Give an algorithm that determines if $A$ has a 3-sum in $O(n^3)$ time
```
ThreeSum1(A)
    for i = 0 to n-1
        for j = i to n-1
            for k = j to n-1
                if A[i] + A[j] + A[k] = 0
                    return true
    return false
```

Time complexity is evaluated:
$
    T(n) = a n^3 + b
    ->
    O(n^3)
$


== Give an algorithm that determines if $A$ has a 3-sum in $O(n^2 log n)$ time. _Hint_: use binary search.





== [\*\*] Give an algorithm that determines if $A$ has a 3-sum in $O(n^2)$ time.




#pagebreak()
= Selection, Partition, and Quick Sort
Let $A[0..n - 1]$ be an array of distinct integers. The integer with rank $k$ in $A$ is the $k$'th smallest integer among the integers in $A$. The median of $A$ is the integer in $A$ with rank $floor.l (n - 1)/2 floor.r$. Solve the following exercises.


== Give an algorithm that given a $k$ finds the integer with rank $k$ in $A$ in $O(n log n)$ time.
```
MergeSort(A, i, j)
    if i < j
        m = floor((i+j)/2)
        MergeSort(A, i, m)
        MergeSort(A, m+1, j)
        Merge(A, i, m, j)

FindRankK(A, k)
    MergeSort(A, 0, len(A))
    return A[k]
```

Time complexity is evaluated:
$
  T(n) = a n log_2 n + b n + c
  ->
  O(n log_2 n)
$


== A partition of $A$ is a separation of $A$ into two arrays `Alow` and `Ahigh` such that `Alow` contains all integers from $A$ that are smaller than or equal to the median of $A$ and `Ahigh` contains all the integers from $A$ that are larger than the median of $A$. Assume in the following that you are given a linear time algorithm to determine the median of an array. Give an algorithm to compute a partition of $A$ in $O(n)$ time.






== [\*] Give an algorithm to sort $A$ in $O(n log n)$ time using recursive partition.




== [\*\*] Give an algorithm that given a $k$ finds the integer with rank $k$ in $A$ in $O(n)$ time.




