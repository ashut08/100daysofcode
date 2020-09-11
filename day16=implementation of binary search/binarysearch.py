
a=[3,5,7,8,9,10]
f=6

import sys
sys.setrecursionlimit(10**6) 
#The “sys” module in Python provides a function called setrecursionlimit() to modify the recursion limit in Python. 
# It takes one parameter, the value of the new recursion limit. By default, this value is usually 10^4. If you are dealing with large inputs, you can set it to, 10^6 so that large inputs can be handled without any errors.
# here i using setrecursionlimit function beacuse i got error maximum recursion depth exceeded error without it.

#function for binary search
def BinarySearch(seq,v,l,r):
    if(r-l==0):
        return(False)
    mid=l+r//2
    if(v==seq[mid]):
        return(True)
    if(v<seq[mid]):
        return(BinarySearch(seq,v,l,mid))
    else:
        return(BinarySearch(seq,v,mid+1,r))

#calling function
result = BinarySearch(a, f, 0,len(a)-1, ) 
  
if result != False: 
    print("Element is present ") 
else: 
    print("Element is not present in array") 
