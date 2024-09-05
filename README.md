Sample documentation. 


Automatically generate Mermaid markdown code-flows using CodeBERT. 

---
```python
def max(a, b): 
   if a > b: 
      return a 
   else: 
      return b
```
```mermaid
graph TD
    A[max] --> B{a > b}
    B -->|Yes| C[return a]
    B -->|No| D[return b]
```
---
```python
def factorial(n):
   if n == 0: 
      return 1
   else:
      return n * factorial(n-1)
```
```mermaid
graph TD
    A[factorial n] --> B{n == 0}
    B --> |Yes| C[return 1]
    B --> |No| D[return n * m]
    D --> |m = factorial n-1| A
```
---
```python
def fibonacci(n): 
   if n <= 1: 
      return n 
   else: 
      return fibonacci(n-1) + fibonacci(n-2)
```
```mermaid
graph TD
    A[fibonacci n] --> B{n <= 1}
    B --> |Yes| C[return n]
    B --> |No| D[return i + j]
    D --> |i = fibonacci n-1| A
    D --> |j = fibonacci n-2| A
```
---
```python
def is_palindrome(s): 
   return s == s[::-1]
```
```mermaid
graph TD
    A[is_palindrome s] --> B{"s == s[::-1?]"}
    B --> |Yes| C[return True]
    B --> |No| D[return False]
```
---
```python
def bubble_sort(arr): 
   for i in range(len(arr)): 
      for j in range(0, len(arr)-i-1): 
         if arr[j] > arr[j+1]: 
            arr[j], arr[j+1] = arr[j+1], arr[j]
```
```mermaid
graph TD
    A[bubble_sort arr] --> B["loop i from 0 to len(arr)-1"]
    B --> C["loop j from 0 to len(arr)-i-2"]
    C --> |End| B
    C --> D{"arr[j] > arr[j+1]?"}
    D --> |Yes| E["swap arr[j] and arr[j+1]"]
    D --> |No| F[continue]
    E --> F
    F --> C
    B --> |End| I[return arr]
```
---
```python
def is_prime(n): 
   if n <= 1: 
      return False
   for i in range(2, int(n**0.5)+1): 
      if n % i == 0: 
         return False 
   return True
```
```mermaid
graph TD
    A[is_prime n] --> B{n <= 1}
    B --> |Yes| C[return False]
    B --> |No| D["loop i from 2 to int(n**0.5)+1"]
    D --> E{"n  % i == 0"}
    E --> |Yes| C
    E --> |No| G[continue]
    G --> D
    D --> |End| F[return True]
```
---
```python
def reverse_list(lst): 
   return lst[::-1]
```
```mermaid
graph TD
    A[reverse_list lst] --> B["return lst[::-1]"]
```
---
```python
def gcd(a, b): 
   while b: 
      a, b = b, a % b 
   return a
```
```mermaid
graph TD
    A[gcd a b] --> B[while b]
    B --> C[a, b = b, a % b]
    C --> B
    B --> |End| D[return a]
```
---
```python
def binary_search(arr, x): 
   l, r = 0, len(arr)-1 
   while l <= r: 
      mid = (l + r) // 2 
      if arr[mid] == x: 
         return mid 
      elif arr[mid] < x: 
         l = mid + 1 
      else: r = mid - 1
   return -1
```
```mermaid
graph TD
    A[biary_search arr x] --> B["l, r = 0, len(arr)-1"]
    B --> C[while l <= r]
    C --> |End| D[return -1]
    C --> E["mid = (l + r) // 2"]
    E --> F{"arr[mid] == x?"}
    F --> |Yes| G[return mid]
    F --> |No| H{"arr[mid] < x"}
    H --> |Yes| I[l = mid + 1]
    H --> |No| J[r = mid - 1]
    J & I --> K[continue]
    K --> C
```
---
```python
def sum_list(lst): 
    return sum(lst)
```
```mermaid
graph TD
    A[sum_list lst] --> B["return sum(lst)"]
```
---
```python
def celsius_to_fahrenheit(c): 
    return (c * 9/5) + 32
```
```mermaid
graph TD
    A[celsius_to_fahrenheit c] --> B["return (c * 9/5) + 32"]
```