def Merge(A, i, m, j):
    """Merge two sorted subarrays A[i:m+1] and A[m+1:j+1]"""
    left = A[i:m+1]
    right = A[m+1:j+1]
    k = i
    l = 0
    r = 0
    while l < len(left) and r < len(right):
        if left[l] <= right[r]:
            A[k] = left[l]
            l += 1
        else:
            A[k] = right[r]
            r += 1
        k += 1
    while l < len(left):
        A[k] = left[l]
        l += 1
        k += 1
    while r < len(right):
        A[k] = right[r]
        r += 1
        k += 1

def MergeSort(A, i, j):
    """Sort array A from index i to j using merge sort"""
    if i < j:
        m = (i + j) // 2
        MergeSort(A, i, m)
        MergeSort(A, m + 1, j)
        Merge(A, i, m, j)
    return A

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
