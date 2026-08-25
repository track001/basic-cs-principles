# Basic CS Principles

Basic computer science principles explained in plain language, with simple examples, visual notes, and small working demos.

This repo is meant to make core computer science concepts easier to understand without assuming a strong computer science background.

---

## Topics

### 1. Recursion + Base Case

**Recursion** is when a function calls itself with a smaller version of the same problem.

A **base case** is the condition that tells the function when to stop calling itself.

For example:

```text
factorial(5)
= 5 * factorial(4)
= 5 * 4 * factorial(3)
= 5 * 4 * 3 * factorial(2)
= 5 * 4 * 3 * 2 * factorial(1)

factorial(1) = BASE CASE
```

### Easy Way to Remember

```text
recursion = function calls itself
base case = where it stops
```

The function keeps making the problem smaller until it reaches the base case.

Once it reaches the base case, the answers start returning back through the earlier function calls.

```text
factorial(1) = 1

2 * 1 = 2
3 * 2 = 6
4 * 6 = 24
5 * 24 = 120
```

This repo includes a PowerShell WinForms demo that shows this process happening step by step.

---

## 2. Hash Maps

A **hash map** stores information using a **key and value**.

```text
key -> value
```

For example:

```text
"Ti" -> phone number
"Alex" -> phone number
"Jordan" -> phone number
```

The computer uses a **hash function** to take the key and calculate where the value should be stored.

```text
"Ti"
  |
  v
hash function
  |
  v
location 27
  |
  v
stored value
```

This is efficient because the computer usually does not need to search through every item one by one.

Instead, the key helps it jump close to the correct location.

### Easy Way to Remember

```text
key -> hash -> location -> value
```

A simple way to think about it is a set of lockers.

Instead of opening every locker looking for something, the key tells you which locker to check.

---

## 3. Breadth-First Search vs. Depth-First Search

Both **BFS** and **DFS** are ways of searching through structures like trees and graphs.

Example tree:

```text
        A
       / \
      B   C
     / \   \
    D   E   F
```

### Breadth-First Search

**Breadth-First Search (BFS)** searches level by level.

One possible BFS order is:

```text
A -> B -> C -> D -> E -> F
```

It searches everything nearby before going deeper.

### Easy Way to Remember

```text
BFS = wide first
```

Think about exploring a maze by checking every hallway one step away before moving farther away.

BFS commonly uses a **queue**.

```text
first in -> first out
```

---

### Depth-First Search

**Depth-First Search (DFS)** follows one path as far as possible before going back and trying another path.

One possible DFS order is:

```text
A -> B -> D -> E -> C -> F
```

### Easy Way to Remember

```text
DFS = deep first
```

Think about exploring a maze by choosing one hallway and following it until you hit a dead end.

DFS commonly uses a **stack** or recursion.

---

## 4. Convolutional Neural Networks

A **Convolutional Neural Network (CNN)** is a type of neural network that is especially useful for image recognition.

A digital image is basically a large grid of numbers representing pixels.

A CNN uses small learned filters that move across the image looking for patterns.

A simplified version looks like:

```text
pixels
  |
  v
edges
  |
  v
shapes
  |
  v
objects
```

Early parts of the network might recognize things like:

- edges
- lines
- corners
- curves

Later parts can combine those patterns into things like:

- eyes
- faces
- wheels
- animals
- objects

CNNs are efficient because the same learned filter can be reused across many parts of an image.

The network does not need to learn a completely different detector for every single pixel location.

### Easy Way to Remember

```text
CNN = small filters looking for patterns in images
```

Or:

```text
pixels -> edges -> shapes -> objects
```

---

## 5. NP-Hard vs. NP-Complete

These terms describe different types of difficult computational problems.

### NP

A problem is in **NP** if a proposed solution can be checked efficiently.

A simple way to think about this is Sudoku.

Finding the solution can be difficult.

Checking whether a completed Sudoku board follows the rules is much easier.

---

### NP-Hard

An **NP-hard** problem is at least as difficult as the hardest problems in NP.

An NP-hard problem does **not** necessarily have to be in NP itself.

---

### NP-Complete

An **NP-complete** problem is both:

```text
NP
+
NP-hard
```

So:

```text
NP-complete = NP + NP-hard
```

### Easy Way to Remember

```text
NP = solution can be checked efficiently

NP-hard = at least as hard as the hardest NP problems

NP-complete = both NP and NP-hard
```

---

## 6. I²C + Arduino

**I²C** stands for:

```text
Inter-Integrated Circuit
```

It is a communication method that lets a controller such as an Arduino communicate with other electronic devices.

Examples include:

- temperature sensors
- OLED displays
- accelerometers
- clocks
- other microcontrollers

I²C mainly uses two communication wires.

### SDA

```text
SDA = Serial Data
```

SDA carries the actual information.

### SCL

```text
SCL = Serial Clock
```

SCL provides the timing for the communication.

### Easy Way to Remember

```text
SDA = WHAT is being communicated
SCL = WHEN it is being communicated
```

I²C devices also have addresses.

For example:

```text
Arduino
  |
  |-- 0x3C -> OLED display
  |
  |-- 0x48 -> temperature sensor
  |
  `-- 0x68 -> accelerometer
```

The Arduino can use the address to communicate with a specific device even though several devices are sharing the same SDA and SCL lines.

---

# PowerShell Recursion Demo

This repo includes:

```text
recursion-demo.ps1
```

The script is a PowerShell WinForms GUI that demonstrates recursion using factorials.

It shows:

- the recursive function
- the base case
- each recursive call going down
- when the base case is reached
- the answers returning back up
- the final factorial result

The GUI uses a black and dark green plant theme.

---

## Running the PowerShell Demo

Open PowerShell in the repository directory and run:

```powershell
.\recursion-demo.ps1
```

If PowerShell blocks the script because of the local execution policy, you can temporarily allow scripts for the current PowerShell session:

```powershell
Set-ExecutionPolicy -Scope Process Bypass
```

Then run:

```powershell
.\recursion-demo.ps1
```

Using `-Scope Process` means the execution policy change only applies to that PowerShell session.

---

# Quick Review

| Concept | What to Remember |
|---|---|
| **Recursion** | A function calls itself |
| **Base Case** | The condition where recursion stops |
| **Hash Map** | Key -> hash -> value |
| **BFS** | Search wide, level by level |
| **DFS** | Search deep, one path at a time |
| **CNN** | Filters detect patterns in images |
| **NP** | A proposed solution can be checked efficiently |
| **NP-Hard** | At least as hard as the hardest NP problems |
| **NP-Complete** | Both NP and NP-hard |
| **I²C** | SDA = data, SCL = clock |

---

# Goal

The goal of this repo is to build a small reference for basic computer science principles that I can come back to later without needing to relearn everything from a textbook.

The focus is:

- plain language
- simple examples
- working demos
- understanding what the computer is actually doing
- making the concepts easy to remember
