input = <<EOS
Before: [3, 0, 1, 3]
15 2 1 3
After:  [3, 0, 1, 1]

Before: [1, 3, 2, 0]
11 2 2 0
After:  [4, 3, 2, 0]

Before: [0, 3, 3, 1]
14 3 2 0
After:  [3, 3, 3, 1]

Before: [2, 3, 1, 3]
9 2 1 1
After:  [2, 1, 1, 3]

Before: [1, 2, 3, 0]
0 2 1 2
After:  [1, 2, 2, 0]

Before: [3, 2, 1, 3]
8 2 3 2
After:  [3, 2, 3, 3]

Before: [1, 0, 1, 3]
15 2 1 2
After:  [1, 0, 1, 3]

Before: [0, 0, 1, 1]
15 3 1 1
After:  [0, 1, 1, 1]

Before: [1, 3, 2, 3]
9 0 1 0
After:  [1, 3, 2, 3]

Before: [1, 0, 0, 1]
15 3 1 1
After:  [1, 1, 0, 1]

Before: [0, 2, 2, 0]
4 0 1 3
After:  [0, 2, 2, 1]

Before: [0, 0, 3, 1]
5 0 2 0
After:  [0, 0, 3, 1]

Before: [0, 1, 0, 2]
14 3 1 0
After:  [3, 1, 0, 2]

Before: [0, 2, 2, 0]
5 0 2 3
After:  [0, 2, 2, 0]

Before: [1, 1, 2, 3]
10 3 2 0
After:  [2, 1, 2, 3]

Before: [1, 2, 3, 2]
13 0 1 1
After:  [1, 2, 3, 2]

Before: [0, 3, 2, 0]
1 1 2 1
After:  [0, 6, 2, 0]

Before: [1, 2, 2, 3]
1 0 2 1
After:  [1, 2, 2, 3]

Before: [3, 1, 2, 2]
13 0 3 2
After:  [3, 1, 6, 2]

Before: [3, 3, 2, 1]
14 3 2 3
After:  [3, 3, 2, 3]

Before: [0, 3, 1, 0]
5 0 1 0
After:  [0, 3, 1, 0]

Before: [1, 0, 2, 3]
12 0 1 0
After:  [1, 0, 2, 3]

Before: [3, 0, 2, 2]
3 2 2 0
After:  [2, 0, 2, 2]

Before: [0, 1, 1, 3]
6 0 0 1
After:  [0, 0, 1, 3]

Before: [0, 0, 2, 2]
6 0 0 2
After:  [0, 0, 0, 2]

Before: [2, 3, 1, 3]
9 2 1 0
After:  [1, 3, 1, 3]

Before: [3, 0, 1, 1]
15 2 1 1
After:  [3, 1, 1, 1]

Before: [1, 2, 1, 2]
8 0 3 1
After:  [1, 3, 1, 2]

Before: [3, 2, 3, 2]
13 0 3 2
After:  [3, 2, 6, 2]

Before: [0, 0, 0, 2]
6 0 0 1
After:  [0, 0, 0, 2]

Before: [1, 2, 3, 3]
1 1 2 3
After:  [1, 2, 3, 4]

Before: [3, 1, 2, 2]
10 0 2 3
After:  [3, 1, 2, 2]

Before: [0, 2, 3, 3]
5 0 2 3
After:  [0, 2, 3, 0]

Before: [1, 0, 3, 0]
10 2 2 2
After:  [1, 0, 2, 0]

Before: [1, 0, 3, 3]
12 0 1 1
After:  [1, 1, 3, 3]

Before: [0, 1, 3, 2]
6 0 0 1
After:  [0, 0, 3, 2]

Before: [2, 1, 2, 2]
2 2 3 0
After:  [3, 1, 2, 2]

Before: [1, 2, 1, 0]
4 1 1 0
After:  [3, 2, 1, 0]

Before: [3, 1, 0, 3]
7 2 1 0
After:  [1, 1, 0, 3]

Before: [0, 2, 0, 2]
6 0 0 3
After:  [0, 2, 0, 0]

Before: [0, 0, 1, 3]
5 0 3 1
After:  [0, 0, 1, 3]

Before: [1, 3, 2, 0]
10 1 2 2
After:  [1, 3, 2, 0]

Before: [1, 0, 3, 3]
3 3 1 2
After:  [1, 0, 3, 3]

Before: [0, 1, 1, 3]
6 0 0 2
After:  [0, 1, 0, 3]

Before: [2, 0, 3, 1]
0 2 0 2
After:  [2, 0, 2, 1]

Before: [1, 1, 0, 2]
7 2 1 0
After:  [1, 1, 0, 2]

Before: [2, 1, 3, 3]
0 2 0 1
After:  [2, 2, 3, 3]

Before: [0, 2, 2, 1]
6 0 0 0
After:  [0, 2, 2, 1]

Before: [1, 0, 1, 0]
15 2 1 1
After:  [1, 1, 1, 0]

Before: [2, 3, 0, 0]
4 2 3 0
After:  [3, 3, 0, 0]

Before: [3, 1, 1, 2]
13 0 3 3
After:  [3, 1, 1, 6]

Before: [2, 3, 2, 1]
11 0 2 1
After:  [2, 4, 2, 1]

Before: [0, 0, 2, 1]
4 0 3 1
After:  [0, 3, 2, 1]

Before: [2, 3, 1, 2]
13 1 3 3
After:  [2, 3, 1, 6]

Before: [1, 3, 3, 2]
9 0 1 1
After:  [1, 1, 3, 2]

Before: [2, 0, 3, 2]
13 2 3 0
After:  [6, 0, 3, 2]

Before: [0, 0, 2, 0]
3 2 2 2
After:  [0, 0, 2, 0]

Before: [2, 2, 3, 3]
0 2 1 3
After:  [2, 2, 3, 2]

Before: [1, 0, 3, 2]
8 0 3 0
After:  [3, 0, 3, 2]

Before: [0, 2, 3, 2]
6 0 0 1
After:  [0, 0, 3, 2]

Before: [0, 0, 2, 0]
6 0 0 0
After:  [0, 0, 2, 0]

Before: [0, 2, 3, 1]
0 2 1 3
After:  [0, 2, 3, 2]

Before: [1, 2, 1, 2]
4 1 1 0
After:  [3, 2, 1, 2]

Before: [2, 1, 1, 2]
2 0 3 0
After:  [3, 1, 1, 2]

Before: [0, 2, 1, 3]
6 0 0 2
After:  [0, 2, 0, 3]

Before: [1, 0, 0, 1]
15 3 1 2
After:  [1, 0, 1, 1]

Before: [2, 3, 3, 0]
10 2 2 1
After:  [2, 2, 3, 0]

Before: [0, 1, 3, 1]
10 2 2 3
After:  [0, 1, 3, 2]

Before: [0, 0, 0, 2]
6 0 0 2
After:  [0, 0, 0, 2]

Before: [1, 2, 2, 1]
8 0 2 2
After:  [1, 2, 3, 1]

Before: [2, 3, 3, 3]
0 2 0 0
After:  [2, 3, 3, 3]

Before: [0, 3, 1, 2]
9 2 1 2
After:  [0, 3, 1, 2]

Before: [0, 1, 2, 3]
5 0 2 1
After:  [0, 0, 2, 3]

Before: [0, 3, 0, 3]
6 0 0 0
After:  [0, 3, 0, 3]

Before: [0, 2, 2, 1]
13 3 1 2
After:  [0, 2, 2, 1]

Before: [1, 3, 1, 3]
3 3 1 0
After:  [3, 3, 1, 3]

Before: [3, 3, 2, 3]
10 1 2 2
After:  [3, 3, 2, 3]

Before: [2, 2, 0, 3]
4 1 1 0
After:  [3, 2, 0, 3]

Before: [1, 1, 2, 3]
10 3 2 2
After:  [1, 1, 2, 3]

Before: [0, 2, 2, 1]
11 2 2 3
After:  [0, 2, 2, 4]

Before: [0, 1, 0, 2]
4 0 2 1
After:  [0, 2, 0, 2]

Before: [3, 1, 3, 0]
10 2 2 1
After:  [3, 2, 3, 0]

Before: [3, 3, 1, 1]
9 2 1 3
After:  [3, 3, 1, 1]

Before: [1, 3, 0, 3]
3 3 3 3
After:  [1, 3, 0, 3]

Before: [3, 0, 2, 1]
8 1 2 2
After:  [3, 0, 2, 1]

Before: [1, 0, 1, 3]
3 3 1 2
After:  [1, 0, 3, 3]

Before: [3, 2, 3, 2]
1 1 2 1
After:  [3, 4, 3, 2]

Before: [1, 0, 0, 1]
12 0 1 3
After:  [1, 0, 0, 1]

Before: [3, 0, 2, 3]
1 3 3 2
After:  [3, 0, 9, 3]

Before: [3, 2, 3, 2]
13 2 3 3
After:  [3, 2, 3, 6]

Before: [0, 0, 3, 3]
1 3 3 1
After:  [0, 9, 3, 3]

Before: [0, 2, 1, 3]
1 1 3 3
After:  [0, 2, 1, 6]

Before: [3, 1, 2, 3]
10 3 2 3
After:  [3, 1, 2, 2]

Before: [1, 3, 2, 0]
9 0 1 1
After:  [1, 1, 2, 0]

Before: [1, 0, 3, 1]
12 0 1 3
After:  [1, 0, 3, 1]

Before: [0, 2, 2, 3]
11 1 2 1
After:  [0, 4, 2, 3]

Before: [2, 0, 3, 0]
10 2 2 1
After:  [2, 2, 3, 0]

Before: [2, 1, 1, 2]
8 1 3 3
After:  [2, 1, 1, 3]

Before: [0, 0, 0, 0]
6 0 0 3
After:  [0, 0, 0, 0]

Before: [0, 0, 1, 0]
6 0 0 3
After:  [0, 0, 1, 0]

Before: [0, 1, 1, 0]
4 2 2 0
After:  [3, 1, 1, 0]

Before: [1, 0, 2, 1]
12 0 1 0
After:  [1, 0, 2, 1]

Before: [2, 3, 1, 3]
3 3 1 1
After:  [2, 3, 1, 3]

Before: [1, 0, 0, 3]
3 3 1 0
After:  [3, 0, 0, 3]

Before: [0, 3, 3, 3]
4 0 1 0
After:  [1, 3, 3, 3]

Before: [1, 3, 2, 0]
3 2 2 3
After:  [1, 3, 2, 2]

Before: [3, 1, 0, 2]
14 3 1 0
After:  [3, 1, 0, 2]

Before: [0, 2, 3, 3]
0 2 1 1
After:  [0, 2, 3, 3]

Before: [3, 2, 3, 2]
10 2 2 3
After:  [3, 2, 3, 2]

Before: [1, 1, 2, 1]
8 2 1 3
After:  [1, 1, 2, 3]

Before: [0, 3, 2, 3]
10 3 2 2
After:  [0, 3, 2, 3]

Before: [0, 3, 1, 0]
6 0 0 2
After:  [0, 3, 0, 0]

Before: [3, 0, 1, 1]
15 3 1 0
After:  [1, 0, 1, 1]

Before: [1, 2, 3, 3]
0 2 1 1
After:  [1, 2, 3, 3]

Before: [0, 0, 3, 1]
10 2 2 0
After:  [2, 0, 3, 1]

Before: [0, 1, 3, 1]
6 0 0 1
After:  [0, 0, 3, 1]

Before: [0, 2, 0, 1]
6 0 0 1
After:  [0, 0, 0, 1]

Before: [1, 0, 2, 1]
15 3 1 2
After:  [1, 0, 1, 1]

Before: [1, 2, 0, 3]
13 0 1 2
After:  [1, 2, 2, 3]

Before: [1, 0, 2, 0]
12 0 1 2
After:  [1, 0, 1, 0]

Before: [3, 3, 0, 2]
13 0 3 0
After:  [6, 3, 0, 2]

Before: [1, 2, 2, 1]
11 1 2 1
After:  [1, 4, 2, 1]

Before: [0, 3, 3, 0]
5 0 1 1
After:  [0, 0, 3, 0]

Before: [1, 1, 2, 2]
14 3 1 0
After:  [3, 1, 2, 2]

Before: [0, 2, 2, 2]
11 1 2 3
After:  [0, 2, 2, 4]

Before: [2, 1, 3, 3]
1 3 3 1
After:  [2, 9, 3, 3]

Before: [0, 2, 3, 0]
2 1 3 3
After:  [0, 2, 3, 3]

Before: [1, 2, 0, 2]
4 1 1 1
After:  [1, 3, 0, 2]

Before: [1, 0, 0, 1]
12 0 1 0
After:  [1, 0, 0, 1]

Before: [1, 1, 0, 0]
7 3 1 2
After:  [1, 1, 1, 0]

Before: [2, 1, 0, 0]
7 3 1 1
After:  [2, 1, 0, 0]

Before: [2, 3, 0, 3]
3 3 1 0
After:  [3, 3, 0, 3]

Before: [2, 0, 2, 1]
14 3 2 3
After:  [2, 0, 2, 3]

Before: [2, 3, 2, 3]
11 0 2 2
After:  [2, 3, 4, 3]

Before: [2, 0, 2, 1]
11 0 2 3
After:  [2, 0, 2, 4]

Before: [3, 3, 3, 2]
13 2 3 0
After:  [6, 3, 3, 2]

Before: [2, 2, 2, 1]
3 2 2 2
After:  [2, 2, 2, 1]

Before: [0, 1, 2, 3]
10 3 2 3
After:  [0, 1, 2, 2]

Before: [0, 3, 2, 3]
5 0 2 1
After:  [0, 0, 2, 3]

Before: [1, 0, 0, 2]
12 0 1 3
After:  [1, 0, 0, 1]

Before: [2, 1, 0, 1]
7 2 1 2
After:  [2, 1, 1, 1]

Before: [2, 0, 2, 1]
15 3 1 3
After:  [2, 0, 2, 1]

Before: [3, 2, 2, 1]
11 1 2 1
After:  [3, 4, 2, 1]

Before: [0, 1, 1, 2]
14 3 1 0
After:  [3, 1, 1, 2]

Before: [2, 2, 1, 2]
2 1 3 1
After:  [2, 3, 1, 2]

Before: [1, 1, 2, 0]
1 0 3 1
After:  [1, 3, 2, 0]

Before: [0, 0, 2, 2]
8 1 2 3
After:  [0, 0, 2, 2]

Before: [1, 0, 3, 0]
12 0 1 3
After:  [1, 0, 3, 1]

Before: [3, 0, 1, 2]
15 2 1 1
After:  [3, 1, 1, 2]

Before: [0, 3, 1, 3]
6 0 0 1
After:  [0, 0, 1, 3]

Before: [0, 1, 2, 0]
5 0 2 1
After:  [0, 0, 2, 0]

Before: [0, 0, 3, 0]
6 0 0 2
After:  [0, 0, 0, 0]

Before: [1, 1, 2, 0]
7 3 1 2
After:  [1, 1, 1, 0]

Before: [0, 2, 2, 2]
11 2 2 0
After:  [4, 2, 2, 2]

Before: [0, 2, 1, 3]
3 3 0 0
After:  [3, 2, 1, 3]

Before: [1, 2, 3, 1]
0 2 1 3
After:  [1, 2, 3, 2]

Before: [2, 1, 0, 2]
7 2 1 3
After:  [2, 1, 0, 1]

Before: [3, 0, 1, 2]
13 0 3 0
After:  [6, 0, 1, 2]

Before: [2, 2, 3, 2]
0 2 0 3
After:  [2, 2, 3, 2]

Before: [0, 2, 1, 3]
5 0 3 1
After:  [0, 0, 1, 3]

Before: [2, 1, 2, 0]
8 3 2 0
After:  [2, 1, 2, 0]

Before: [2, 2, 0, 1]
9 3 1 2
After:  [2, 2, 1, 1]

Before: [1, 1, 1, 0]
1 2 3 1
After:  [1, 3, 1, 0]

Before: [2, 0, 2, 0]
5 1 0 3
After:  [2, 0, 2, 0]

Before: [0, 2, 1, 2]
6 0 0 1
After:  [0, 0, 1, 2]

Before: [0, 1, 1, 2]
6 0 0 3
After:  [0, 1, 1, 0]

Before: [3, 0, 3, 3]
10 2 2 0
After:  [2, 0, 3, 3]

Before: [0, 3, 2, 2]
1 1 2 2
After:  [0, 3, 6, 2]

Before: [3, 3, 2, 0]
10 1 2 3
After:  [3, 3, 2, 2]

Before: [2, 3, 1, 3]
8 2 3 2
After:  [2, 3, 3, 3]

Before: [1, 0, 0, 1]
12 0 1 1
After:  [1, 1, 0, 1]

Before: [1, 0, 0, 2]
12 0 1 0
After:  [1, 0, 0, 2]

Before: [1, 3, 1, 2]
13 1 3 0
After:  [6, 3, 1, 2]

Before: [3, 1, 0, 2]
7 2 1 2
After:  [3, 1, 1, 2]

Before: [3, 0, 1, 1]
5 1 0 2
After:  [3, 0, 0, 1]

Before: [3, 1, 2, 0]
11 2 2 2
After:  [3, 1, 4, 0]

Before: [3, 3, 3, 2]
0 2 3 2
After:  [3, 3, 2, 2]

Before: [1, 3, 3, 3]
10 2 2 1
After:  [1, 2, 3, 3]

Before: [0, 0, 1, 0]
15 2 1 1
After:  [0, 1, 1, 0]

Before: [3, 2, 1, 1]
9 3 1 3
After:  [3, 2, 1, 1]

Before: [0, 3, 1, 0]
9 2 1 2
After:  [0, 3, 1, 0]

Before: [0, 1, 3, 3]
10 2 2 3
After:  [0, 1, 3, 2]

Before: [1, 2, 1, 0]
2 1 3 3
After:  [1, 2, 1, 3]

Before: [0, 1, 3, 2]
14 3 1 0
After:  [3, 1, 3, 2]

Before: [3, 1, 2, 0]
1 1 2 1
After:  [3, 2, 2, 0]

Before: [1, 0, 0, 0]
12 0 1 3
After:  [1, 0, 0, 1]

Before: [0, 1, 2, 1]
1 1 3 1
After:  [0, 3, 2, 1]

Before: [3, 2, 2, 1]
11 2 2 3
After:  [3, 2, 2, 4]

Before: [3, 0, 2, 0]
8 1 2 1
After:  [3, 2, 2, 0]

Before: [1, 0, 1, 3]
15 2 1 0
After:  [1, 0, 1, 3]

Before: [0, 2, 2, 2]
8 0 2 2
After:  [0, 2, 2, 2]

Before: [3, 0, 2, 1]
11 2 2 2
After:  [3, 0, 4, 1]

Before: [3, 2, 3, 1]
14 3 2 2
After:  [3, 2, 3, 1]

Before: [0, 2, 1, 1]
6 0 0 1
After:  [0, 0, 1, 1]

Before: [3, 2, 0, 1]
9 3 1 2
After:  [3, 2, 1, 1]

Before: [2, 0, 3, 1]
15 3 1 3
After:  [2, 0, 3, 1]

Before: [0, 1, 0, 3]
6 0 0 3
After:  [0, 1, 0, 0]

Before: [1, 0, 2, 3]
1 0 2 1
After:  [1, 2, 2, 3]

Before: [1, 3, 3, 2]
0 2 3 2
After:  [1, 3, 2, 2]

Before: [0, 0, 1, 3]
6 0 0 3
After:  [0, 0, 1, 0]

Before: [3, 3, 2, 0]
11 2 2 0
After:  [4, 3, 2, 0]

Before: [0, 0, 0, 3]
4 0 2 2
After:  [0, 0, 2, 3]

Before: [0, 3, 2, 2]
11 2 2 0
After:  [4, 3, 2, 2]

Before: [2, 3, 1, 3]
1 3 3 0
After:  [9, 3, 1, 3]

Before: [2, 0, 3, 3]
0 2 0 2
After:  [2, 0, 2, 3]

Before: [2, 3, 0, 2]
4 2 3 2
After:  [2, 3, 3, 2]

Before: [0, 2, 3, 3]
5 0 1 2
After:  [0, 2, 0, 3]

Before: [1, 0, 3, 1]
10 2 2 2
After:  [1, 0, 2, 1]

Before: [2, 0, 0, 3]
1 0 3 3
After:  [2, 0, 0, 6]

Before: [1, 3, 3, 0]
9 0 1 1
After:  [1, 1, 3, 0]

Before: [0, 3, 1, 2]
6 0 0 3
After:  [0, 3, 1, 0]

Before: [0, 0, 2, 0]
11 2 2 2
After:  [0, 0, 4, 0]

Before: [2, 1, 3, 2]
13 2 3 0
After:  [6, 1, 3, 2]

Before: [1, 0, 3, 2]
12 0 1 2
After:  [1, 0, 1, 2]

Before: [3, 1, 3, 2]
13 2 3 3
After:  [3, 1, 3, 6]

Before: [0, 3, 2, 0]
4 0 1 3
After:  [0, 3, 2, 1]

Before: [3, 3, 2, 2]
10 0 2 2
After:  [3, 3, 2, 2]

Before: [0, 2, 2, 0]
8 0 2 1
After:  [0, 2, 2, 0]

Before: [0, 0, 0, 3]
5 0 3 2
After:  [0, 0, 0, 3]

Before: [2, 2, 3, 1]
0 2 0 2
After:  [2, 2, 2, 1]

Before: [1, 0, 2, 1]
14 3 2 3
After:  [1, 0, 2, 3]

Before: [1, 0, 2, 2]
12 0 1 0
After:  [1, 0, 2, 2]

Before: [3, 0, 3, 0]
10 2 2 3
After:  [3, 0, 3, 2]

Before: [0, 1, 0, 1]
7 2 1 0
After:  [1, 1, 0, 1]

Before: [0, 1, 0, 0]
7 2 1 3
After:  [0, 1, 0, 1]

Before: [1, 1, 0, 3]
1 3 3 1
After:  [1, 9, 0, 3]

Before: [3, 0, 1, 0]
15 2 1 1
After:  [3, 1, 1, 0]

Before: [0, 3, 0, 3]
5 0 3 0
After:  [0, 3, 0, 3]

Before: [3, 1, 0, 1]
7 2 1 3
After:  [3, 1, 0, 1]

Before: [0, 3, 3, 1]
5 0 3 2
After:  [0, 3, 0, 1]

Before: [1, 1, 2, 1]
14 3 2 3
After:  [1, 1, 2, 3]

Before: [1, 2, 2, 0]
11 1 2 1
After:  [1, 4, 2, 0]

Before: [2, 2, 1, 3]
1 1 3 2
After:  [2, 2, 6, 3]

Before: [0, 2, 1, 0]
6 0 0 0
After:  [0, 2, 1, 0]

Before: [0, 0, 3, 3]
6 0 0 3
After:  [0, 0, 3, 0]

Before: [0, 0, 3, 1]
14 3 2 0
After:  [3, 0, 3, 1]

Before: [0, 0, 2, 1]
6 0 0 2
After:  [0, 0, 0, 1]

Before: [1, 0, 2, 1]
14 3 2 2
After:  [1, 0, 3, 1]

Before: [0, 2, 2, 1]
11 2 2 0
After:  [4, 2, 2, 1]

Before: [3, 0, 3, 3]
10 2 2 1
After:  [3, 2, 3, 3]

Before: [2, 0, 1, 0]
2 0 3 0
After:  [3, 0, 1, 0]

Before: [3, 3, 2, 3]
3 3 1 0
After:  [3, 3, 2, 3]

Before: [1, 3, 2, 1]
14 3 2 2
After:  [1, 3, 3, 1]

Before: [3, 0, 3, 2]
0 2 3 1
After:  [3, 2, 3, 2]

Before: [0, 0, 0, 1]
15 3 1 2
After:  [0, 0, 1, 1]

Before: [1, 1, 3, 1]
14 3 2 0
After:  [3, 1, 3, 1]

Before: [0, 2, 3, 2]
5 0 1 1
After:  [0, 0, 3, 2]

Before: [3, 1, 3, 3]
1 2 3 3
After:  [3, 1, 3, 9]

Before: [2, 0, 1, 1]
1 2 3 2
After:  [2, 0, 3, 1]

Before: [1, 0, 2, 3]
10 3 2 2
After:  [1, 0, 2, 3]

Before: [0, 2, 1, 2]
4 0 3 2
After:  [0, 2, 3, 2]

Before: [0, 3, 2, 0]
3 2 0 0
After:  [2, 3, 2, 0]

Before: [3, 2, 2, 2]
11 1 2 3
After:  [3, 2, 2, 4]

Before: [1, 0, 1, 2]
15 2 1 3
After:  [1, 0, 1, 1]

Before: [2, 1, 1, 2]
14 3 1 0
After:  [3, 1, 1, 2]

Before: [1, 3, 2, 3]
11 2 2 3
After:  [1, 3, 2, 4]

Before: [0, 2, 2, 1]
3 2 2 3
After:  [0, 2, 2, 2]

Before: [1, 0, 2, 3]
12 0 1 1
After:  [1, 1, 2, 3]

Before: [1, 3, 0, 3]
8 2 3 1
After:  [1, 3, 0, 3]

Before: [0, 2, 2, 3]
10 3 2 2
After:  [0, 2, 2, 3]

Before: [0, 1, 3, 2]
5 0 3 1
After:  [0, 0, 3, 2]

Before: [3, 1, 1, 2]
8 1 3 1
After:  [3, 3, 1, 2]

Before: [2, 3, 1, 3]
1 0 3 2
After:  [2, 3, 6, 3]

Before: [2, 0, 3, 1]
14 3 2 0
After:  [3, 0, 3, 1]

Before: [1, 2, 2, 1]
13 0 1 0
After:  [2, 2, 2, 1]

Before: [1, 2, 3, 3]
10 2 2 2
After:  [1, 2, 2, 3]

Before: [3, 1, 0, 0]
7 2 1 3
After:  [3, 1, 0, 1]

Before: [2, 3, 2, 2]
13 1 3 0
After:  [6, 3, 2, 2]

Before: [0, 1, 3, 3]
10 2 2 2
After:  [0, 1, 2, 3]

Before: [2, 1, 2, 2]
14 3 1 0
After:  [3, 1, 2, 2]

Before: [2, 3, 3, 2]
0 2 3 3
After:  [2, 3, 3, 2]

Before: [2, 3, 0, 1]
4 2 3 1
After:  [2, 3, 0, 1]

Before: [0, 1, 2, 0]
4 0 3 1
After:  [0, 3, 2, 0]

Before: [0, 1, 2, 0]
6 0 0 2
After:  [0, 1, 0, 0]

Before: [2, 1, 0, 2]
2 0 3 3
After:  [2, 1, 0, 3]

Before: [0, 3, 3, 0]
4 0 2 1
After:  [0, 2, 3, 0]

Before: [0, 1, 3, 3]
3 3 0 0
After:  [3, 1, 3, 3]

Before: [3, 1, 1, 0]
7 3 1 0
After:  [1, 1, 1, 0]

Before: [1, 3, 1, 1]
9 0 1 1
After:  [1, 1, 1, 1]

Before: [0, 2, 0, 1]
9 3 1 2
After:  [0, 2, 1, 1]

Before: [0, 0, 2, 3]
11 2 2 3
After:  [0, 0, 2, 4]

Before: [1, 2, 2, 1]
1 0 2 1
After:  [1, 2, 2, 1]

Before: [0, 2, 2, 2]
11 3 2 2
After:  [0, 2, 4, 2]

Before: [0, 1, 1, 0]
7 3 1 3
After:  [0, 1, 1, 1]

Before: [2, 3, 2, 0]
11 2 2 3
After:  [2, 3, 2, 4]

Before: [2, 0, 2, 0]
2 0 3 1
After:  [2, 3, 2, 0]

Before: [0, 3, 3, 3]
6 0 0 0
After:  [0, 3, 3, 3]

Before: [1, 1, 3, 1]
8 1 2 1
After:  [1, 3, 3, 1]

Before: [2, 3, 0, 3]
8 2 3 1
After:  [2, 3, 0, 3]

Before: [2, 2, 3, 2]
0 2 3 2
After:  [2, 2, 2, 2]

Before: [1, 2, 1, 1]
13 0 1 1
After:  [1, 2, 1, 1]

Before: [2, 3, 2, 2]
2 2 3 1
After:  [2, 3, 2, 2]

Before: [0, 1, 2, 0]
3 2 0 2
After:  [0, 1, 2, 0]

Before: [1, 3, 0, 3]
9 0 1 0
After:  [1, 3, 0, 3]

Before: [1, 1, 0, 3]
7 2 1 1
After:  [1, 1, 0, 3]

Before: [1, 0, 2, 1]
12 0 1 1
After:  [1, 1, 2, 1]

Before: [0, 0, 2, 0]
8 0 2 1
After:  [0, 2, 2, 0]

Before: [0, 2, 1, 0]
5 0 1 3
After:  [0, 2, 1, 0]

Before: [1, 2, 3, 0]
8 0 2 0
After:  [3, 2, 3, 0]

Before: [1, 0, 2, 2]
12 0 1 2
After:  [1, 0, 1, 2]

Before: [2, 3, 2, 0]
2 2 3 1
After:  [2, 3, 2, 0]

Before: [1, 3, 3, 2]
13 1 3 1
After:  [1, 6, 3, 2]

Before: [2, 0, 2, 1]
15 3 1 1
After:  [2, 1, 2, 1]

Before: [0, 3, 1, 3]
9 2 1 2
After:  [0, 3, 1, 3]

Before: [3, 3, 1, 0]
4 3 2 1
After:  [3, 2, 1, 0]

Before: [2, 1, 0, 2]
7 2 1 2
After:  [2, 1, 1, 2]

Before: [0, 2, 2, 3]
4 0 1 2
After:  [0, 2, 1, 3]

Before: [2, 0, 2, 1]
5 1 0 0
After:  [0, 0, 2, 1]

Before: [2, 0, 3, 0]
0 2 0 1
After:  [2, 2, 3, 0]

Before: [1, 3, 2, 3]
9 0 1 2
After:  [1, 3, 1, 3]

Before: [3, 1, 1, 3]
3 3 1 2
After:  [3, 1, 3, 3]

Before: [0, 1, 0, 2]
14 3 1 2
After:  [0, 1, 3, 2]

Before: [3, 0, 1, 2]
15 2 1 0
After:  [1, 0, 1, 2]

Before: [2, 2, 2, 3]
10 3 2 0
After:  [2, 2, 2, 3]

Before: [1, 2, 0, 1]
13 3 1 0
After:  [2, 2, 0, 1]

Before: [0, 3, 0, 3]
6 0 0 2
After:  [0, 3, 0, 3]

Before: [0, 2, 2, 1]
14 3 2 3
After:  [0, 2, 2, 3]

Before: [2, 1, 0, 3]
7 2 1 3
After:  [2, 1, 0, 1]

Before: [0, 1, 0, 3]
7 2 1 0
After:  [1, 1, 0, 3]

Before: [3, 0, 2, 3]
1 2 3 1
After:  [3, 6, 2, 3]

Before: [0, 2, 3, 2]
5 0 3 3
After:  [0, 2, 3, 0]

Before: [1, 3, 3, 2]
13 1 3 0
After:  [6, 3, 3, 2]

Before: [1, 1, 1, 3]
1 3 3 2
After:  [1, 1, 9, 3]

Before: [3, 2, 2, 0]
4 1 1 0
After:  [3, 2, 2, 0]

Before: [1, 1, 3, 2]
0 2 3 1
After:  [1, 2, 3, 2]

Before: [1, 0, 2, 0]
12 0 1 1
After:  [1, 1, 2, 0]

Before: [0, 0, 2, 1]
14 3 2 2
After:  [0, 0, 3, 1]

Before: [3, 1, 3, 0]
4 3 2 1
After:  [3, 2, 3, 0]

Before: [2, 0, 0, 3]
1 0 2 0
After:  [4, 0, 0, 3]

Before: [1, 2, 3, 0]
13 0 1 1
After:  [1, 2, 3, 0]

Before: [0, 1, 3, 0]
7 3 1 2
After:  [0, 1, 1, 0]

Before: [0, 1, 2, 0]
2 2 3 0
After:  [3, 1, 2, 0]

Before: [1, 0, 3, 2]
0 2 3 3
After:  [1, 0, 3, 2]

Before: [1, 3, 2, 3]
1 1 3 2
After:  [1, 3, 9, 3]

Before: [1, 0, 2, 3]
12 0 1 3
After:  [1, 0, 2, 1]

Before: [3, 2, 2, 2]
2 1 3 3
After:  [3, 2, 2, 3]

Before: [0, 1, 0, 1]
7 2 1 3
After:  [0, 1, 0, 1]

Before: [3, 0, 2, 3]
10 0 2 0
After:  [2, 0, 2, 3]

Before: [0, 3, 3, 3]
5 0 3 1
After:  [0, 0, 3, 3]

Before: [2, 1, 3, 1]
0 2 0 2
After:  [2, 1, 2, 1]

Before: [2, 1, 2, 1]
3 2 0 2
After:  [2, 1, 2, 1]

Before: [1, 2, 0, 0]
2 1 3 3
After:  [1, 2, 0, 3]

Before: [3, 0, 0, 1]
15 3 1 0
After:  [1, 0, 0, 1]

Before: [2, 2, 3, 0]
10 2 2 2
After:  [2, 2, 2, 0]

Before: [1, 1, 3, 0]
8 0 2 3
After:  [1, 1, 3, 3]

Before: [2, 1, 2, 2]
14 3 1 2
After:  [2, 1, 3, 2]

Before: [3, 1, 2, 2]
11 3 2 3
After:  [3, 1, 2, 4]

Before: [1, 1, 3, 0]
10 2 2 3
After:  [1, 1, 3, 2]

Before: [1, 2, 0, 1]
9 3 1 0
After:  [1, 2, 0, 1]

Before: [1, 3, 3, 2]
13 1 3 2
After:  [1, 3, 6, 2]

Before: [3, 3, 3, 2]
13 2 3 3
After:  [3, 3, 3, 6]

Before: [2, 1, 0, 2]
7 2 1 1
After:  [2, 1, 0, 2]

Before: [3, 2, 3, 1]
0 2 1 2
After:  [3, 2, 2, 1]

Before: [0, 0, 1, 1]
5 0 3 2
After:  [0, 0, 0, 1]

Before: [0, 1, 1, 0]
5 0 1 1
After:  [0, 0, 1, 0]

Before: [3, 1, 0, 1]
7 2 1 0
After:  [1, 1, 0, 1]

Before: [1, 1, 1, 3]
8 2 3 3
After:  [1, 1, 1, 3]

Before: [1, 0, 2, 1]
12 0 1 2
After:  [1, 0, 1, 1]

Before: [2, 2, 1, 0]
2 0 3 3
After:  [2, 2, 1, 3]

Before: [3, 0, 2, 2]
3 2 2 2
After:  [3, 0, 2, 2]

Before: [0, 2, 0, 0]
2 1 3 3
After:  [0, 2, 0, 3]

Before: [2, 2, 2, 1]
14 3 2 1
After:  [2, 3, 2, 1]

Before: [0, 1, 2, 3]
11 2 2 1
After:  [0, 4, 2, 3]

Before: [3, 2, 0, 0]
4 1 1 1
After:  [3, 3, 0, 0]

Before: [1, 1, 3, 3]
8 1 3 1
After:  [1, 3, 3, 3]

Before: [1, 0, 3, 2]
8 0 2 3
After:  [1, 0, 3, 3]

Before: [3, 1, 2, 3]
11 2 2 0
After:  [4, 1, 2, 3]

Before: [3, 1, 2, 1]
10 0 2 1
After:  [3, 2, 2, 1]

Before: [3, 1, 2, 1]
3 2 2 0
After:  [2, 1, 2, 1]

Before: [0, 1, 0, 0]
6 0 0 2
After:  [0, 1, 0, 0]

Before: [1, 0, 1, 2]
8 2 3 0
After:  [3, 0, 1, 2]

Before: [3, 0, 3, 2]
13 0 3 1
After:  [3, 6, 3, 2]

Before: [1, 2, 2, 1]
11 1 2 3
After:  [1, 2, 2, 4]

Before: [0, 2, 0, 3]
6 0 0 3
After:  [0, 2, 0, 0]

Before: [1, 0, 3, 3]
12 0 1 2
After:  [1, 0, 1, 3]

Before: [0, 1, 2, 2]
6 0 0 3
After:  [0, 1, 2, 0]

Before: [2, 2, 0, 0]
2 1 3 3
After:  [2, 2, 0, 3]

Before: [0, 1, 3, 2]
6 0 0 0
After:  [0, 1, 3, 2]

Before: [3, 0, 3, 1]
15 3 1 1
After:  [3, 1, 3, 1]

Before: [0, 0, 2, 1]
14 3 2 3
After:  [0, 0, 2, 3]

Before: [0, 3, 0, 1]
6 0 0 3
After:  [0, 3, 0, 0]

Before: [1, 3, 1, 1]
9 2 1 1
After:  [1, 1, 1, 1]

Before: [1, 0, 1, 0]
12 0 1 3
After:  [1, 0, 1, 1]

Before: [3, 0, 1, 1]
1 2 3 3
After:  [3, 0, 1, 3]

Before: [3, 3, 3, 1]
14 3 2 0
After:  [3, 3, 3, 1]

Before: [2, 2, 1, 1]
9 3 1 3
After:  [2, 2, 1, 1]

Before: [1, 1, 3, 2]
14 3 1 2
After:  [1, 1, 3, 2]

Before: [1, 0, 2, 2]
1 0 2 3
After:  [1, 0, 2, 2]

Before: [1, 2, 3, 3]
4 1 1 1
After:  [1, 3, 3, 3]

Before: [2, 2, 3, 1]
9 3 1 0
After:  [1, 2, 3, 1]

Before: [2, 2, 3, 0]
0 2 0 0
After:  [2, 2, 3, 0]

Before: [0, 1, 3, 1]
10 2 2 1
After:  [0, 2, 3, 1]

Before: [3, 1, 2, 3]
8 2 1 1
After:  [3, 3, 2, 3]

Before: [1, 0, 0, 3]
12 0 1 0
After:  [1, 0, 0, 3]

Before: [1, 0, 1, 0]
12 0 1 1
After:  [1, 1, 1, 0]

Before: [2, 2, 2, 2]
2 0 3 1
After:  [2, 3, 2, 2]

Before: [2, 1, 3, 0]
7 3 1 3
After:  [2, 1, 3, 1]

Before: [3, 2, 2, 0]
11 1 2 2
After:  [3, 2, 4, 0]

Before: [1, 0, 1, 3]
3 3 0 2
After:  [1, 0, 3, 3]

Before: [3, 3, 3, 1]
10 2 2 0
After:  [2, 3, 3, 1]

Before: [2, 0, 1, 1]
15 2 1 0
After:  [1, 0, 1, 1]

Before: [2, 0, 2, 2]
11 2 2 3
After:  [2, 0, 2, 4]

Before: [0, 0, 1, 1]
15 3 1 0
After:  [1, 0, 1, 1]

Before: [3, 2, 3, 0]
2 1 3 3
After:  [3, 2, 3, 3]

Before: [2, 1, 1, 2]
1 0 2 3
After:  [2, 1, 1, 4]

Before: [3, 2, 3, 1]
10 2 2 1
After:  [3, 2, 3, 1]

Before: [2, 2, 3, 2]
13 2 3 0
After:  [6, 2, 3, 2]

Before: [1, 3, 2, 1]
14 3 2 0
After:  [3, 3, 2, 1]

Before: [1, 0, 0, 3]
8 0 3 3
After:  [1, 0, 0, 3]

Before: [3, 1, 1, 2]
14 3 1 2
After:  [3, 1, 3, 2]

Before: [2, 3, 0, 3]
1 3 3 3
After:  [2, 3, 0, 9]

Before: [0, 3, 1, 3]
3 3 3 3
After:  [0, 3, 1, 3]

Before: [0, 2, 0, 1]
9 3 1 0
After:  [1, 2, 0, 1]

Before: [1, 2, 2, 1]
1 0 2 3
After:  [1, 2, 2, 2]

Before: [2, 0, 1, 0]
15 2 1 3
After:  [2, 0, 1, 1]

Before: [0, 1, 2, 3]
10 3 2 2
After:  [0, 1, 2, 3]

Before: [1, 1, 3, 2]
14 3 1 0
After:  [3, 1, 3, 2]

Before: [0, 0, 1, 3]
15 2 1 0
After:  [1, 0, 1, 3]

Before: [0, 1, 0, 1]
5 0 1 0
After:  [0, 1, 0, 1]

Before: [3, 0, 3, 2]
13 0 3 3
After:  [3, 0, 3, 6]

Before: [2, 3, 3, 1]
14 3 2 1
After:  [2, 3, 3, 1]

Before: [3, 0, 3, 1]
15 3 1 0
After:  [1, 0, 3, 1]

Before: [0, 2, 2, 3]
5 0 1 1
After:  [0, 0, 2, 3]

Before: [0, 3, 1, 0]
4 0 3 0
After:  [3, 3, 1, 0]

Before: [1, 0, 2, 3]
12 0 1 2
After:  [1, 0, 1, 3]

Before: [3, 0, 1, 1]
15 3 1 3
After:  [3, 0, 1, 1]

Before: [0, 3, 3, 3]
5 0 2 2
After:  [0, 3, 0, 3]

Before: [2, 0, 0, 3]
4 1 2 3
After:  [2, 0, 0, 2]

Before: [1, 3, 1, 0]
9 0 1 3
After:  [1, 3, 1, 1]

Before: [0, 0, 1, 2]
15 2 1 0
After:  [1, 0, 1, 2]

Before: [1, 0, 0, 3]
8 0 3 0
After:  [3, 0, 0, 3]

Before: [0, 2, 3, 2]
10 2 2 0
After:  [2, 2, 3, 2]

Before: [0, 1, 0, 2]
5 0 3 0
After:  [0, 1, 0, 2]

Before: [0, 0, 3, 0]
5 0 2 0
After:  [0, 0, 3, 0]

Before: [3, 2, 2, 2]
13 0 3 0
After:  [6, 2, 2, 2]

Before: [3, 0, 2, 1]
4 2 1 1
After:  [3, 3, 2, 1]

Before: [1, 3, 3, 1]
9 0 1 2
After:  [1, 3, 1, 1]

Before: [1, 0, 3, 3]
3 3 0 2
After:  [1, 0, 3, 3]

Before: [0, 1, 0, 2]
14 3 1 1
After:  [0, 3, 0, 2]

Before: [0, 0, 2, 3]
4 2 1 3
After:  [0, 0, 2, 3]

Before: [1, 2, 2, 3]
13 0 1 3
After:  [1, 2, 2, 2]

Before: [1, 1, 2, 0]
8 0 2 1
After:  [1, 3, 2, 0]

Before: [0, 0, 2, 2]
6 0 0 1
After:  [0, 0, 2, 2]

Before: [2, 2, 2, 3]
3 2 2 3
After:  [2, 2, 2, 2]

Before: [3, 0, 2, 2]
13 0 3 2
After:  [3, 0, 6, 2]

Before: [0, 2, 0, 2]
5 0 1 3
After:  [0, 2, 0, 0]

Before: [2, 0, 0, 3]
3 3 3 3
After:  [2, 0, 0, 3]

Before: [1, 3, 2, 1]
10 1 2 0
After:  [2, 3, 2, 1]

Before: [0, 1, 3, 2]
0 2 3 0
After:  [2, 1, 3, 2]

Before: [2, 0, 1, 3]
1 0 3 1
After:  [2, 6, 1, 3]

Before: [0, 3, 1, 2]
6 0 0 2
After:  [0, 3, 0, 2]

Before: [3, 1, 3, 0]
10 2 2 2
After:  [3, 1, 2, 0]

Before: [3, 1, 3, 2]
14 3 1 1
After:  [3, 3, 3, 2]

Before: [0, 1, 3, 2]
0 2 3 3
After:  [0, 1, 3, 2]

Before: [0, 1, 2, 1]
11 2 2 3
After:  [0, 1, 2, 4]

Before: [0, 2, 1, 0]
4 2 2 0
After:  [3, 2, 1, 0]

Before: [1, 1, 3, 1]
14 3 2 1
After:  [1, 3, 3, 1]

Before: [3, 3, 3, 3]
1 1 3 3
After:  [3, 3, 3, 9]

Before: [2, 3, 1, 1]
9 2 1 0
After:  [1, 3, 1, 1]

Before: [2, 1, 3, 2]
2 0 3 3
After:  [2, 1, 3, 3]

Before: [0, 1, 0, 2]
8 1 3 3
After:  [0, 1, 0, 3]

Before: [2, 3, 3, 2]
13 2 3 2
After:  [2, 3, 6, 2]

Before: [2, 3, 1, 2]
9 2 1 2
After:  [2, 3, 1, 2]

Before: [3, 2, 2, 0]
2 1 3 2
After:  [3, 2, 3, 0]

Before: [3, 2, 1, 1]
13 3 1 0
After:  [2, 2, 1, 1]

Before: [0, 0, 1, 3]
15 2 1 1
After:  [0, 1, 1, 3]

Before: [1, 3, 2, 1]
9 0 1 0
After:  [1, 3, 2, 1]

Before: [0, 0, 1, 2]
5 0 2 0
After:  [0, 0, 1, 2]

Before: [0, 1, 3, 1]
6 0 0 3
After:  [0, 1, 3, 0]

Before: [3, 1, 3, 0]
7 3 1 2
After:  [3, 1, 1, 0]

Before: [0, 3, 2, 1]
1 1 2 1
After:  [0, 6, 2, 1]

Before: [0, 2, 1, 3]
3 3 3 3
After:  [0, 2, 1, 3]

Before: [0, 0, 3, 3]
5 0 2 2
After:  [0, 0, 0, 3]

Before: [0, 2, 2, 0]
3 2 2 3
After:  [0, 2, 2, 2]

Before: [2, 0, 1, 0]
15 2 1 2
After:  [2, 0, 1, 0]

Before: [3, 2, 2, 3]
3 3 3 0
After:  [3, 2, 2, 3]

Before: [1, 0, 3, 0]
12 0 1 2
After:  [1, 0, 1, 0]

Before: [0, 1, 2, 0]
7 3 1 1
After:  [0, 1, 2, 0]

Before: [2, 0, 3, 1]
0 2 0 1
After:  [2, 2, 3, 1]

Before: [3, 3, 2, 2]
11 2 2 2
After:  [3, 3, 4, 2]

Before: [0, 0, 2, 3]
6 0 0 0
After:  [0, 0, 2, 3]

Before: [0, 3, 0, 2]
6 0 0 2
After:  [0, 3, 0, 2]

Before: [2, 1, 0, 2]
2 0 3 2
After:  [2, 1, 3, 2]

Before: [0, 3, 1, 0]
5 0 1 2
After:  [0, 3, 0, 0]

Before: [3, 1, 1, 1]
1 1 3 2
After:  [3, 1, 3, 1]

Before: [2, 0, 3, 1]
0 2 0 3
After:  [2, 0, 3, 2]

Before: [1, 0, 1, 1]
15 3 1 3
After:  [1, 0, 1, 1]

Before: [1, 0, 2, 1]
12 0 1 3
After:  [1, 0, 2, 1]

Before: [3, 2, 2, 3]
11 2 2 1
After:  [3, 4, 2, 3]

Before: [1, 3, 0, 0]
9 0 1 1
After:  [1, 1, 0, 0]

Before: [2, 1, 2, 0]
7 3 1 0
After:  [1, 1, 2, 0]

Before: [0, 3, 0, 3]
3 3 1 1
After:  [0, 3, 0, 3]

Before: [0, 1, 1, 3]
8 2 3 2
After:  [0, 1, 3, 3]

Before: [2, 1, 0, 3]
7 2 1 1
After:  [2, 1, 0, 3]

Before: [2, 2, 3, 1]
0 2 1 3
After:  [2, 2, 3, 2]

Before: [1, 0, 1, 1]
12 0 1 1
After:  [1, 1, 1, 1]

Before: [0, 3, 1, 0]
9 2 1 3
After:  [0, 3, 1, 1]

Before: [1, 0, 3, 0]
12 0 1 0
After:  [1, 0, 3, 0]

Before: [0, 0, 3, 2]
4 0 2 1
After:  [0, 2, 3, 2]

Before: [0, 0, 1, 1]
15 2 1 2
After:  [0, 0, 1, 1]

Before: [2, 2, 2, 2]
2 2 3 0
After:  [3, 2, 2, 2]

Before: [0, 0, 1, 1]
15 3 1 3
After:  [0, 0, 1, 1]

Before: [1, 0, 3, 3]
3 3 3 1
After:  [1, 3, 3, 3]

Before: [2, 0, 2, 2]
2 2 3 3
After:  [2, 0, 2, 3]

Before: [0, 1, 0, 1]
7 2 1 1
After:  [0, 1, 0, 1]

Before: [0, 2, 3, 1]
10 2 2 3
After:  [0, 2, 3, 2]

Before: [1, 0, 1, 2]
12 0 1 2
After:  [1, 0, 1, 2]

Before: [3, 1, 2, 0]
1 1 3 3
After:  [3, 1, 2, 3]

Before: [0, 3, 1, 0]
9 2 1 0
After:  [1, 3, 1, 0]

Before: [2, 0, 1, 2]
15 2 1 3
After:  [2, 0, 1, 1]

Before: [2, 3, 1, 0]
9 2 1 1
After:  [2, 1, 1, 0]

Before: [1, 0, 0, 0]
12 0 1 1
After:  [1, 1, 0, 0]

Before: [2, 2, 3, 3]
3 3 3 2
After:  [2, 2, 3, 3]

Before: [3, 3, 1, 1]
1 2 3 2
After:  [3, 3, 3, 1]

Before: [3, 3, 2, 2]
13 0 3 0
After:  [6, 3, 2, 2]

Before: [0, 1, 1, 0]
4 1 2 2
After:  [0, 1, 3, 0]

Before: [1, 3, 2, 0]
2 2 3 3
After:  [1, 3, 2, 3]

Before: [0, 3, 1, 1]
9 2 1 1
After:  [0, 1, 1, 1]

Before: [0, 2, 3, 1]
5 0 1 0
After:  [0, 2, 3, 1]

Before: [0, 2, 2, 2]
5 0 3 3
After:  [0, 2, 2, 0]

Before: [0, 3, 3, 3]
10 2 2 2
After:  [0, 3, 2, 3]

Before: [1, 3, 1, 3]
3 3 1 3
After:  [1, 3, 1, 3]

Before: [3, 3, 3, 2]
0 2 3 1
After:  [3, 2, 3, 2]

Before: [3, 3, 0, 1]
4 2 3 0
After:  [3, 3, 0, 1]

Before: [0, 0, 0, 3]
6 0 0 3
After:  [0, 0, 0, 0]

Before: [3, 0, 2, 1]
14 3 2 3
After:  [3, 0, 2, 3]

Before: [1, 0, 3, 2]
13 2 3 2
After:  [1, 0, 6, 2]

Before: [0, 1, 2, 0]
7 3 1 2
After:  [0, 1, 1, 0]

Before: [3, 3, 2, 2]
11 3 2 1
After:  [3, 4, 2, 2]

Before: [2, 2, 2, 3]
1 3 2 3
After:  [2, 2, 2, 6]

Before: [2, 0, 2, 2]
11 3 2 1
After:  [2, 4, 2, 2]

Before: [0, 2, 3, 2]
0 2 1 1
After:  [0, 2, 3, 2]

Before: [1, 0, 2, 0]
12 0 1 3
After:  [1, 0, 2, 1]

Before: [3, 3, 1, 2]
13 0 3 3
After:  [3, 3, 1, 6]

Before: [3, 2, 3, 1]
9 3 1 2
After:  [3, 2, 1, 1]

Before: [2, 2, 2, 0]
11 2 2 3
After:  [2, 2, 2, 4]

Before: [1, 0, 1, 1]
4 2 2 1
After:  [1, 3, 1, 1]

Before: [2, 2, 2, 1]
14 3 2 2
After:  [2, 2, 3, 1]

Before: [1, 1, 2, 2]
11 3 2 0
After:  [4, 1, 2, 2]

Before: [2, 2, 3, 2]
0 2 0 2
After:  [2, 2, 2, 2]

Before: [1, 1, 0, 1]
1 1 3 0
After:  [3, 1, 0, 1]

Before: [2, 3, 1, 0]
2 0 3 3
After:  [2, 3, 1, 3]

Before: [1, 3, 3, 1]
9 0 1 1
After:  [1, 1, 3, 1]

Before: [3, 3, 2, 2]
10 1 2 1
After:  [3, 2, 2, 2]

Before: [0, 2, 3, 0]
0 2 1 2
After:  [0, 2, 2, 0]

Before: [0, 3, 3, 1]
6 0 0 0
After:  [0, 3, 3, 1]

Before: [3, 2, 2, 2]
2 2 3 0
After:  [3, 2, 2, 2]

Before: [1, 0, 0, 2]
12 0 1 1
After:  [1, 1, 0, 2]

Before: [1, 0, 0, 2]
12 0 1 2
After:  [1, 0, 1, 2]

Before: [0, 2, 1, 2]
5 0 3 1
After:  [0, 0, 1, 2]

Before: [0, 0, 3, 3]
5 0 3 2
After:  [0, 0, 0, 3]

Before: [0, 1, 1, 0]
1 2 3 0
After:  [3, 1, 1, 0]

Before: [0, 1, 1, 2]
5 0 3 3
After:  [0, 1, 1, 0]

Before: [3, 3, 2, 0]
10 0 2 0
After:  [2, 3, 2, 0]

Before: [1, 0, 0, 1]
12 0 1 2
After:  [1, 0, 1, 1]

Before: [1, 3, 1, 1]
9 0 1 3
After:  [1, 3, 1, 1]

Before: [1, 0, 2, 1]
14 3 2 1
After:  [1, 3, 2, 1]

Before: [0, 0, 1, 1]
5 0 2 3
After:  [0, 0, 1, 0]

Before: [2, 3, 2, 3]
3 3 3 1
After:  [2, 3, 2, 3]

Before: [1, 2, 2, 0]
2 2 3 3
After:  [1, 2, 2, 3]

Before: [3, 3, 1, 0]
9 2 1 1
After:  [3, 1, 1, 0]

Before: [1, 0, 3, 3]
12 0 1 0
After:  [1, 0, 3, 3]

Before: [3, 0, 3, 0]
10 2 2 2
After:  [3, 0, 2, 0]

Before: [2, 2, 3, 2]
0 2 3 0
After:  [2, 2, 3, 2]

Before: [2, 0, 0, 2]
2 0 3 2
After:  [2, 0, 3, 2]

Before: [2, 1, 2, 3]
11 2 2 2
After:  [2, 1, 4, 3]

Before: [3, 3, 2, 2]
2 2 3 1
After:  [3, 3, 2, 2]

Before: [0, 0, 2, 1]
11 2 2 2
After:  [0, 0, 4, 1]

Before: [0, 3, 3, 1]
14 3 2 1
After:  [0, 3, 3, 1]

Before: [3, 2, 0, 2]
13 0 3 2
After:  [3, 2, 6, 2]

Before: [2, 2, 2, 0]
4 2 1 0
After:  [3, 2, 2, 0]

Before: [3, 0, 1, 1]
15 2 1 3
After:  [3, 0, 1, 1]

Before: [2, 1, 3, 2]
0 2 0 1
After:  [2, 2, 3, 2]

Before: [1, 3, 1, 0]
9 0 1 0
After:  [1, 3, 1, 0]

Before: [1, 1, 1, 0]
4 1 2 3
After:  [1, 1, 1, 3]

Before: [1, 1, 2, 0]
7 3 1 3
After:  [1, 1, 2, 1]

Before: [2, 3, 1, 3]
9 2 1 3
After:  [2, 3, 1, 1]

Before: [3, 3, 1, 0]
9 2 1 3
After:  [3, 3, 1, 1]

Before: [2, 3, 2, 3]
3 3 1 3
After:  [2, 3, 2, 3]

Before: [3, 1, 2, 2]
8 2 1 2
After:  [3, 1, 3, 2]

Before: [0, 0, 1, 0]
15 2 1 2
After:  [0, 0, 1, 0]

Before: [1, 0, 2, 2]
4 1 3 1
After:  [1, 3, 2, 2]

Before: [0, 3, 2, 1]
5 0 1 2
After:  [0, 3, 0, 1]

Before: [1, 3, 0, 3]
9 0 1 3
After:  [1, 3, 0, 1]

Before: [1, 2, 3, 2]
1 3 2 0
After:  [4, 2, 3, 2]

Before: [1, 1, 0, 0]
4 0 2 0
After:  [3, 1, 0, 0]

Before: [1, 0, 1, 0]
4 1 2 1
After:  [1, 2, 1, 0]

Before: [1, 3, 3, 2]
10 2 2 0
After:  [2, 3, 3, 2]

Before: [3, 2, 3, 2]
2 1 3 2
After:  [3, 2, 3, 2]

Before: [1, 2, 1, 1]
9 3 1 3
After:  [1, 2, 1, 1]

Before: [0, 1, 2, 2]
14 3 1 0
After:  [3, 1, 2, 2]

Before: [3, 3, 0, 2]
13 1 3 0
After:  [6, 3, 0, 2]

Before: [3, 0, 2, 0]
1 0 2 3
After:  [3, 0, 2, 6]

Before: [0, 3, 3, 2]
13 2 3 1
After:  [0, 6, 3, 2]

Before: [1, 0, 3, 1]
12 0 1 0
After:  [1, 0, 3, 1]

Before: [0, 0, 0, 1]
4 0 3 2
After:  [0, 0, 3, 1]

Before: [2, 0, 1, 1]
15 3 1 3
After:  [2, 0, 1, 1]

Before: [3, 0, 2, 1]
15 3 1 2
After:  [3, 0, 1, 1]

Before: [3, 3, 2, 3]
1 3 2 3
After:  [3, 3, 2, 6]

Before: [2, 1, 1, 3]
8 2 3 2
After:  [2, 1, 3, 3]

Before: [0, 0, 1, 3]
15 2 1 2
After:  [0, 0, 1, 3]

Before: [3, 1, 3, 1]
10 2 2 2
After:  [3, 1, 2, 1]

Before: [2, 3, 1, 0]
9 2 1 2
After:  [2, 3, 1, 0]

Before: [0, 0, 2, 2]
6 0 0 3
After:  [0, 0, 2, 0]

Before: [0, 0, 2, 0]
8 0 2 0
After:  [2, 0, 2, 0]

Before: [0, 0, 2, 1]
3 2 2 1
After:  [0, 2, 2, 1]

Before: [3, 2, 2, 0]
2 2 3 0
After:  [3, 2, 2, 0]

Before: [3, 2, 3, 2]
0 2 3 3
After:  [3, 2, 3, 2]

Before: [2, 0, 2, 3]
11 2 2 3
After:  [2, 0, 2, 4]

Before: [1, 2, 2, 2]
11 2 2 3
After:  [1, 2, 2, 4]

Before: [0, 1, 0, 1]
8 0 1 2
After:  [0, 1, 1, 1]

Before: [1, 0, 1, 2]
15 2 1 2
After:  [1, 0, 1, 2]

Before: [1, 2, 1, 1]
9 3 1 2
After:  [1, 2, 1, 1]

Before: [3, 1, 3, 0]
7 3 1 1
After:  [3, 1, 3, 0]

Before: [0, 1, 1, 3]
8 1 3 0
After:  [3, 1, 1, 3]

Before: [2, 2, 3, 0]
0 2 1 0
After:  [2, 2, 3, 0]

Before: [2, 0, 0, 3]
5 1 0 3
After:  [2, 0, 0, 0]

Before: [2, 0, 2, 2]
2 2 3 0
After:  [3, 0, 2, 2]

Before: [0, 2, 3, 3]
10 2 2 0
After:  [2, 2, 3, 3]

Before: [3, 0, 1, 2]
15 2 1 3
After:  [3, 0, 1, 1]

Before: [3, 1, 2, 0]
2 2 3 1
After:  [3, 3, 2, 0]

Before: [0, 1, 3, 2]
4 0 2 1
After:  [0, 2, 3, 2]

Before: [1, 0, 0, 3]
12 0 1 3
After:  [1, 0, 0, 1]

Before: [2, 2, 3, 3]
0 2 1 0
After:  [2, 2, 3, 3]

Before: [0, 1, 1, 1]
5 0 1 3
After:  [0, 1, 1, 0]

Before: [1, 0, 1, 2]
15 2 1 0
After:  [1, 0, 1, 2]

Before: [2, 1, 3, 0]
10 2 2 2
After:  [2, 1, 2, 0]

Before: [0, 2, 3, 2]
1 1 2 3
After:  [0, 2, 3, 4]

Before: [1, 1, 0, 1]
7 2 1 0
After:  [1, 1, 0, 1]

Before: [0, 3, 1, 0]
6 0 0 0
After:  [0, 3, 1, 0]

Before: [3, 1, 0, 0]
7 3 1 3
After:  [3, 1, 0, 1]

Before: [1, 0, 1, 3]
12 0 1 0
After:  [1, 0, 1, 3]

Before: [1, 0, 1, 1]
12 0 1 2
After:  [1, 0, 1, 1]

Before: [0, 3, 3, 3]
1 1 3 0
After:  [9, 3, 3, 3]

Before: [3, 0, 3, 2]
5 1 0 0
After:  [0, 0, 3, 2]

Before: [1, 2, 1, 1]
13 3 1 2
After:  [1, 2, 2, 1]

Before: [1, 3, 0, 3]
9 0 1 1
After:  [1, 1, 0, 3]

Before: [0, 3, 2, 3]
8 0 2 1
After:  [0, 2, 2, 3]

Before: [2, 1, 0, 1]
7 2 1 0
After:  [1, 1, 0, 1]

Before: [0, 0, 3, 2]
6 0 0 2
After:  [0, 0, 0, 2]

Before: [0, 3, 0, 2]
4 2 1 0
After:  [1, 3, 0, 2]

Before: [0, 1, 2, 1]
5 0 3 3
After:  [0, 1, 2, 0]

Before: [2, 3, 1, 2]
9 2 1 0
After:  [1, 3, 1, 2]

Before: [0, 3, 1, 2]
9 2 1 3
After:  [0, 3, 1, 1]

Before: [0, 2, 1, 2]
4 0 1 2
After:  [0, 2, 1, 2]

Before: [1, 0, 2, 2]
12 0 1 1
After:  [1, 1, 2, 2]

Before: [3, 3, 1, 2]
9 2 1 3
After:  [3, 3, 1, 1]

Before: [2, 2, 0, 2]
2 0 3 2
After:  [2, 2, 3, 2]

Before: [3, 2, 2, 0]
1 0 2 2
After:  [3, 2, 6, 0]

Before: [0, 3, 2, 0]
2 2 3 2
After:  [0, 3, 3, 0]

Before: [1, 2, 3, 2]
0 2 3 0
After:  [2, 2, 3, 2]

Before: [0, 1, 2, 3]
3 3 0 2
After:  [0, 1, 3, 3]

Before: [0, 3, 1, 2]
6 0 0 1
After:  [0, 0, 1, 2]

Before: [1, 2, 2, 0]
2 2 3 1
After:  [1, 3, 2, 0]

Before: [1, 3, 1, 0]
9 2 1 3
After:  [1, 3, 1, 1]

Before: [2, 1, 0, 0]
4 1 2 0
After:  [3, 1, 0, 0]

Before: [0, 1, 3, 2]
8 0 1 2
After:  [0, 1, 1, 2]

Before: [0, 2, 3, 2]
1 3 2 2
After:  [0, 2, 4, 2]

Before: [0, 1, 0, 0]
7 2 1 1
After:  [0, 1, 0, 0]

Before: [0, 2, 3, 1]
0 2 1 2
After:  [0, 2, 2, 1]

Before: [3, 3, 2, 2]
11 2 2 0
After:  [4, 3, 2, 2]

Before: [3, 0, 0, 3]
1 0 3 3
After:  [3, 0, 0, 9]

Before: [1, 1, 0, 3]
7 2 1 0
After:  [1, 1, 0, 3]

Before: [3, 1, 0, 2]
7 2 1 0
After:  [1, 1, 0, 2]

Before: [1, 0, 2, 0]
2 2 3 0
After:  [3, 0, 2, 0]

Before: [2, 1, 0, 0]
7 3 1 2
After:  [2, 1, 1, 0]

Before: [2, 2, 1, 2]
1 3 2 3
After:  [2, 2, 1, 4]

Before: [2, 0, 3, 0]
0 2 0 0
After:  [2, 0, 3, 0]

Before: [3, 0, 3, 2]
0 2 3 3
After:  [3, 0, 3, 2]

Before: [0, 1, 2, 2]
11 3 2 0
After:  [4, 1, 2, 2]

Before: [1, 1, 2, 0]
7 3 1 0
After:  [1, 1, 2, 0]

Before: [0, 1, 2, 0]
2 2 3 2
After:  [0, 1, 3, 0]

Before: [2, 0, 1, 1]
1 0 2 3
After:  [2, 0, 1, 4]

Before: [0, 1, 3, 1]
5 0 2 2
After:  [0, 1, 0, 1]

Before: [0, 2, 2, 0]
2 2 3 3
After:  [0, 2, 2, 3]

Before: [1, 3, 0, 3]
9 0 1 2
After:  [1, 3, 1, 3]

Before: [2, 0, 3, 3]
10 2 2 1
After:  [2, 2, 3, 3]

Before: [2, 2, 3, 1]
0 2 1 1
After:  [2, 2, 3, 1]

Before: [0, 0, 1, 2]
6 0 0 2
After:  [0, 0, 0, 2]

Before: [0, 0, 2, 3]
10 3 2 2
After:  [0, 0, 2, 3]

Before: [3, 2, 2, 1]
3 2 2 3
After:  [3, 2, 2, 2]

Before: [0, 0, 0, 2]
1 3 2 1
After:  [0, 4, 0, 2]

Before: [1, 0, 3, 3]
12 0 1 3
After:  [1, 0, 3, 1]

Before: [2, 1, 2, 2]
11 0 2 1
After:  [2, 4, 2, 2]

Before: [1, 3, 2, 3]
10 3 2 1
After:  [1, 2, 2, 3]

Before: [0, 0, 1, 2]
5 0 3 3
After:  [0, 0, 1, 0]

Before: [0, 0, 2, 0]
11 2 2 3
After:  [0, 0, 2, 4]

Before: [1, 1, 2, 0]
11 2 2 0
After:  [4, 1, 2, 0]

Before: [3, 1, 1, 3]
3 3 3 2
After:  [3, 1, 3, 3]

Before: [1, 3, 0, 2]
13 1 3 2
After:  [1, 3, 6, 2]

Before: [1, 1, 0, 0]
1 0 3 0
After:  [3, 1, 0, 0]

Before: [1, 0, 1, 1]
12 0 1 3
After:  [1, 0, 1, 1]

Before: [1, 0, 3, 2]
12 0 1 3
After:  [1, 0, 3, 1]

Before: [0, 0, 3, 3]
10 2 2 0
After:  [2, 0, 3, 3]

Before: [0, 2, 3, 3]
0 2 1 3
After:  [0, 2, 3, 2]

Before: [2, 2, 1, 1]
9 3 1 0
After:  [1, 2, 1, 1]

Before: [1, 3, 3, 2]
10 2 2 1
After:  [1, 2, 3, 2]

Before: [1, 3, 1, 3]
3 3 0 3
After:  [1, 3, 1, 3]

Before: [0, 0, 2, 3]
6 0 0 2
After:  [0, 0, 0, 3]

Before: [1, 1, 1, 0]
7 3 1 2
After:  [1, 1, 1, 0]

Before: [1, 1, 0, 1]
7 2 1 3
After:  [1, 1, 0, 1]

Before: [3, 3, 0, 0]
4 3 2 0
After:  [2, 3, 0, 0]

Before: [2, 1, 1, 1]
4 1 2 3
After:  [2, 1, 1, 3]

Before: [3, 0, 2, 3]
4 2 1 3
After:  [3, 0, 2, 3]

Before: [1, 0, 2, 0]
4 2 1 2
After:  [1, 0, 3, 0]

Before: [1, 0, 1, 2]
12 0 1 1
After:  [1, 1, 1, 2]

Before: [0, 1, 0, 0]
5 0 1 0
After:  [0, 1, 0, 0]

Before: [1, 1, 2, 0]
7 3 1 1
After:  [1, 1, 2, 0]

Before: [0, 2, 1, 0]
2 1 3 0
After:  [3, 2, 1, 0]

Before: [2, 1, 2, 0]
2 0 3 1
After:  [2, 3, 2, 0]

Before: [0, 3, 2, 2]
10 1 2 3
After:  [0, 3, 2, 2]

Before: [1, 0, 0, 0]
12 0 1 0
After:  [1, 0, 0, 0]

Before: [2, 1, 0, 2]
14 3 1 0
After:  [3, 1, 0, 2]

Before: [3, 2, 2, 1]
9 3 1 2
After:  [3, 2, 1, 1]

Before: [1, 0, 1, 2]
15 2 1 1
After:  [1, 1, 1, 2]

Before: [2, 0, 1, 1]
15 2 1 1
After:  [2, 1, 1, 1]

Before: [3, 0, 3, 3]
3 3 3 0
After:  [3, 0, 3, 3]

Before: [1, 1, 1, 0]
1 1 3 1
After:  [1, 3, 1, 0]

Before: [2, 2, 0, 1]
9 3 1 1
After:  [2, 1, 0, 1]

Before: [1, 3, 1, 2]
9 2 1 3
After:  [1, 3, 1, 1]

Before: [0, 3, 1, 1]
6 0 0 2
After:  [0, 3, 0, 1]

Before: [3, 1, 3, 1]
8 1 2 2
After:  [3, 1, 3, 1]

Before: [1, 2, 2, 1]
4 1 1 1
After:  [1, 3, 2, 1]

Before: [2, 3, 3, 0]
0 2 0 0
After:  [2, 3, 3, 0]

Before: [0, 2, 1, 1]
9 3 1 1
After:  [0, 1, 1, 1]

Before: [0, 3, 3, 0]
5 0 1 2
After:  [0, 3, 0, 0]

Before: [0, 3, 1, 0]
9 2 1 1
After:  [0, 1, 1, 0]

Before: [3, 2, 3, 2]
2 1 3 3
After:  [3, 2, 3, 3]

Before: [1, 1, 2, 2]
11 3 2 3
After:  [1, 1, 2, 4]

Before: [0, 3, 3, 3]
5 0 2 0
After:  [0, 3, 3, 3]

Before: [1, 0, 2, 2]
11 2 2 1
After:  [1, 4, 2, 2]

Before: [3, 2, 3, 1]
14 3 2 0
After:  [3, 2, 3, 1]

Before: [0, 3, 2, 0]
6 0 0 0
After:  [0, 3, 2, 0]

Before: [1, 1, 1, 3]
3 3 1 2
After:  [1, 1, 3, 3]

Before: [3, 1, 3, 2]
0 2 3 3
After:  [3, 1, 3, 2]

Before: [2, 1, 2, 2]
2 2 3 3
After:  [2, 1, 2, 3]

Before: [0, 3, 0, 3]
6 0 0 3
After:  [0, 3, 0, 0]

Before: [0, 2, 2, 3]
6 0 0 2
After:  [0, 2, 0, 3]

Before: [0, 1, 3, 3]
6 0 0 2
After:  [0, 1, 0, 3]

Before: [1, 1, 2, 2]
8 2 1 2
After:  [1, 1, 3, 2]

Before: [2, 2, 1, 1]
1 2 3 2
After:  [2, 2, 3, 1]

Before: [2, 0, 1, 2]
15 2 1 2
After:  [2, 0, 1, 2]

Before: [2, 1, 2, 3]
1 3 3 2
After:  [2, 1, 9, 3]

Before: [0, 1, 0, 0]
7 2 1 2
After:  [0, 1, 1, 0]

Before: [2, 1, 0, 3]
8 2 3 0
After:  [3, 1, 0, 3]

Before: [0, 3, 2, 1]
14 3 2 0
After:  [3, 3, 2, 1]

Before: [2, 0, 1, 2]
15 2 1 0
After:  [1, 0, 1, 2]

Before: [1, 2, 2, 1]
13 3 1 3
After:  [1, 2, 2, 2]

Before: [1, 0, 1, 0]
12 0 1 0
After:  [1, 0, 1, 0]

Before: [2, 2, 3, 0]
0 2 1 3
After:  [2, 2, 3, 2]

Before: [0, 0, 1, 1]
15 2 1 3
After:  [0, 0, 1, 1]

Before: [0, 3, 0, 3]
3 3 0 0
After:  [3, 3, 0, 3]

Before: [2, 2, 2, 1]
11 2 2 2
After:  [2, 2, 4, 1]

Before: [2, 1, 2, 0]
2 0 3 0
After:  [3, 1, 2, 0]

Before: [1, 2, 2, 0]
13 0 1 0
After:  [2, 2, 2, 0]

Before: [1, 0, 3, 0]
12 0 1 1
After:  [1, 1, 3, 0]

Before: [3, 1, 0, 3]
5 2 0 3
After:  [3, 1, 0, 0]

Before: [1, 2, 1, 0]
1 2 3 0
After:  [3, 2, 1, 0]

Before: [0, 1, 3, 2]
13 2 3 0
After:  [6, 1, 3, 2]

Before: [1, 0, 1, 2]
12 0 1 0
After:  [1, 0, 1, 2]

Before: [0, 0, 1, 1]
1 2 3 3
After:  [0, 0, 1, 3]

Before: [1, 3, 0, 2]
9 0 1 2
After:  [1, 3, 1, 2]

Before: [2, 3, 2, 2]
11 3 2 0
After:  [4, 3, 2, 2]

Before: [2, 2, 3, 1]
10 2 2 0
After:  [2, 2, 3, 1]

Before: [3, 0, 3, 2]
10 2 2 3
After:  [3, 0, 3, 2]

Before: [2, 1, 2, 2]
11 3 2 2
After:  [2, 1, 4, 2]

Before: [0, 3, 3, 1]
10 2 2 1
After:  [0, 2, 3, 1]

Before: [0, 0, 2, 1]
15 3 1 3
After:  [0, 0, 2, 1]

Before: [1, 2, 3, 2]
13 2 3 1
After:  [1, 6, 3, 2]

Before: [2, 3, 2, 1]
14 3 2 2
After:  [2, 3, 3, 1]

Before: [1, 0, 1, 3]
12 0 1 2
After:  [1, 0, 1, 3]

Before: [0, 2, 2, 3]
8 0 3 0
After:  [3, 2, 2, 3]

Before: [0, 1, 1, 2]
14 3 1 3
After:  [0, 1, 1, 3]

Before: [1, 3, 3, 2]
9 0 1 2
After:  [1, 3, 1, 2]

Before: [2, 2, 2, 1]
11 2 2 1
After:  [2, 4, 2, 1]

Before: [1, 3, 3, 3]
9 0 1 0
After:  [1, 3, 3, 3]

Before: [3, 3, 2, 1]
1 3 2 0
After:  [2, 3, 2, 1]

Before: [0, 1, 3, 1]
14 3 2 3
After:  [0, 1, 3, 3]

Before: [2, 0, 3, 3]
0 2 0 0
After:  [2, 0, 3, 3]

Before: [3, 2, 3, 2]
13 2 3 0
After:  [6, 2, 3, 2]

Before: [2, 3, 2, 1]
11 2 2 2
After:  [2, 3, 4, 1]

Before: [3, 0, 0, 2]
5 2 0 2
After:  [3, 0, 0, 2]

Before: [1, 1, 1, 3]
3 3 3 1
After:  [1, 3, 1, 3]

Before: [2, 1, 2, 0]
3 2 0 0
After:  [2, 1, 2, 0]

Before: [0, 3, 1, 3]
6 0 0 0
After:  [0, 3, 1, 3]

Before: [2, 1, 0, 0]
2 0 3 3
After:  [2, 1, 0, 3]

Before: [0, 1, 0, 3]
5 0 1 3
After:  [0, 1, 0, 0]

Before: [3, 0, 2, 1]
15 3 1 0
After:  [1, 0, 2, 1]

Before: [2, 2, 2, 2]
2 1 3 0
After:  [3, 2, 2, 2]

Before: [2, 1, 0, 2]
14 3 1 3
After:  [2, 1, 0, 3]

Before: [0, 0, 2, 1]
11 2 2 3
After:  [0, 0, 2, 4]

Before: [2, 3, 1, 2]
9 2 1 3
After:  [2, 3, 1, 1]

Before: [0, 3, 1, 1]
6 0 0 3
After:  [0, 3, 1, 0]



1 0 0 1
4 1 1 1
14 0 0 3
14 3 2 2
12 3 2 1
1 1 2 1
11 1 0 0
3 0 2 1
14 2 2 0
9 0 2 0
1 0 2 0
11 0 1 1
3 1 2 3
1 1 0 0
4 0 1 0
14 1 1 1
14 2 0 2
3 0 2 2
1 2 1 2
11 2 3 3
3 3 2 0
14 1 3 3
14 3 1 1
14 3 0 2
4 3 1 3
1 3 3 3
11 3 0 0
14 2 0 2
14 0 0 3
7 3 2 3
1 3 2 3
11 3 0 0
3 0 3 3
14 2 3 0
14 3 0 2
14 0 1 1
14 2 1 1
1 1 3 1
1 1 2 1
11 1 3 3
3 3 2 1
1 3 0 2
4 2 0 2
14 2 2 3
5 0 3 3
1 3 3 3
11 3 1 1
3 1 0 0
14 2 1 2
14 3 2 1
14 2 0 3
0 1 3 3
1 3 2 3
11 0 3 0
3 0 0 2
14 1 3 3
14 3 3 0
4 3 1 0
1 0 2 0
1 0 2 0
11 2 0 2
14 0 1 0
1 0 0 1
4 1 1 1
1 1 0 3
4 3 2 3
13 1 3 3
1 3 2 3
11 2 3 2
14 3 3 1
1 1 0 3
4 3 2 3
14 2 1 0
14 3 0 1
1 1 3 1
11 1 2 2
3 2 2 0
14 3 3 2
14 2 3 1
14 1 0 3
1 3 2 1
1 1 1 1
11 0 1 0
14 2 3 2
14 2 3 3
14 0 3 1
2 2 3 2
1 2 1 2
1 2 1 2
11 0 2 0
3 0 1 1
1 2 0 2
4 2 0 2
14 2 3 0
14 3 2 3
0 3 0 2
1 2 1 2
11 2 1 1
3 1 1 0
14 0 1 1
14 3 3 2
1 1 0 3
4 3 1 3
4 3 1 1
1 1 1 1
11 1 0 0
3 0 3 1
14 2 0 3
14 0 1 2
14 2 2 0
5 0 3 0
1 0 2 0
11 0 1 1
3 1 0 3
14 2 1 0
14 3 2 2
1 1 0 1
4 1 2 1
9 0 2 0
1 0 1 0
1 0 2 0
11 0 3 3
3 3 0 1
14 2 1 3
14 0 2 2
1 3 0 0
4 0 2 0
12 2 3 2
1 2 2 2
11 2 1 1
14 3 2 2
14 0 0 3
9 0 2 3
1 3 3 3
1 3 2 3
11 1 3 1
3 1 1 2
14 1 2 3
14 2 1 1
14 3 0 0
0 0 1 3
1 3 1 3
11 3 2 2
14 1 3 3
14 2 0 0
15 0 3 1
1 1 3 1
11 1 2 2
1 0 0 1
4 1 3 1
14 2 2 3
6 0 1 1
1 1 3 1
11 2 1 2
3 2 0 1
14 2 0 2
14 1 3 0
2 2 3 3
1 3 3 3
11 3 1 1
14 1 3 3
14 2 1 0
1 1 0 2
4 2 3 2
15 0 3 0
1 0 3 0
1 0 2 0
11 0 1 1
14 3 0 0
1 3 0 3
4 3 0 3
12 3 2 3
1 3 3 3
1 3 2 3
11 3 1 1
14 2 1 0
1 1 0 3
4 3 3 3
1 2 0 2
4 2 1 2
0 3 0 0
1 0 3 0
11 0 1 1
14 2 1 0
14 2 1 3
5 0 3 3
1 3 3 3
1 3 3 3
11 1 3 1
14 2 3 3
14 0 0 2
14 3 0 0
12 2 3 0
1 0 3 0
11 0 1 1
3 1 2 2
14 3 1 3
14 3 1 1
1 1 0 0
4 0 2 0
6 0 1 1
1 1 2 1
11 1 2 2
3 2 0 1
14 2 0 3
1 3 0 0
4 0 1 0
14 0 2 2
11 0 0 3
1 3 1 3
11 3 1 1
3 1 1 2
1 1 0 0
4 0 2 0
14 3 0 3
14 0 2 1
14 1 3 1
1 1 2 1
1 1 2 1
11 1 2 2
3 2 3 0
14 3 0 2
14 1 2 1
14 1 2 3
11 3 3 2
1 2 3 2
11 0 2 0
3 0 0 1
14 1 1 2
14 2 0 0
13 3 0 3
1 3 3 3
11 3 1 1
3 1 0 3
14 3 2 1
14 1 2 0
14 3 3 2
4 0 1 1
1 1 2 1
11 3 1 3
3 3 0 1
14 2 0 0
14 0 3 3
8 0 2 0
1 0 1 0
11 1 0 1
3 1 2 2
14 3 0 3
14 2 1 1
14 2 2 0
0 3 0 0
1 0 3 0
11 0 2 2
3 2 2 3
14 3 3 0
14 2 0 2
6 2 0 2
1 2 1 2
11 2 3 3
3 3 0 0
14 0 2 2
1 1 0 3
4 3 0 3
14 3 2 1
10 1 2 2
1 2 1 2
11 2 0 0
3 0 2 2
1 3 0 1
4 1 1 1
14 2 0 0
1 2 0 3
4 3 1 3
15 0 3 0
1 0 1 0
11 2 0 2
3 2 0 1
14 2 0 2
14 3 1 0
6 2 0 3
1 3 1 3
11 1 3 1
3 1 3 2
14 2 0 3
14 0 0 1
0 0 3 1
1 1 3 1
11 2 1 2
3 2 2 1
14 2 2 0
14 3 3 2
5 0 3 3
1 3 3 3
1 3 3 3
11 3 1 1
14 3 3 3
14 1 0 0
1 0 2 0
1 0 2 0
11 1 0 1
14 2 3 3
14 0 3 2
14 3 1 0
9 2 0 3
1 3 1 3
11 1 3 1
1 0 0 2
4 2 3 2
14 0 0 3
12 3 2 0
1 0 2 0
11 1 0 1
14 1 3 0
14 2 3 2
14 3 2 3
3 0 2 0
1 0 1 0
11 0 1 1
3 1 0 0
14 1 2 1
14 1 3 3
14 3 0 2
1 3 2 1
1 1 3 1
11 1 0 0
3 0 3 2
1 2 0 1
4 1 2 1
14 0 0 3
1 3 0 0
4 0 3 0
2 1 3 1
1 1 3 1
11 2 1 2
3 2 0 1
14 2 2 0
14 2 2 3
1 3 0 2
4 2 3 2
5 0 3 0
1 0 1 0
11 1 0 1
3 1 0 3
1 3 0 2
4 2 2 2
14 3 2 0
1 2 0 1
4 1 0 1
6 2 0 1
1 1 1 1
1 1 1 1
11 3 1 3
3 3 3 1
14 0 3 0
14 0 1 2
14 2 3 3
12 2 3 3
1 3 2 3
11 1 3 1
3 1 3 0
14 3 3 3
14 3 2 1
10 3 2 1
1 1 3 1
1 1 3 1
11 0 1 0
3 0 3 2
14 0 2 1
14 2 0 0
14 1 3 3
15 0 3 0
1 0 3 0
11 0 2 2
3 2 3 0
14 2 0 2
14 2 3 3
14 2 0 1
2 2 3 2
1 2 1 2
11 0 2 0
3 0 3 1
14 2 2 2
14 3 2 0
2 2 3 3
1 3 2 3
11 1 3 1
14 2 2 0
14 1 3 3
14 3 2 2
9 0 2 0
1 0 2 0
11 0 1 1
14 2 1 0
9 0 2 3
1 3 1 3
11 1 3 1
14 1 2 3
1 1 0 0
4 0 1 0
1 3 2 3
1 3 1 3
11 1 3 1
3 1 3 0
1 2 0 1
4 1 1 1
14 2 2 2
14 0 3 3
7 3 2 3
1 3 1 3
11 3 0 0
3 0 2 2
14 2 0 1
14 0 3 3
14 3 1 0
8 1 0 3
1 3 2 3
11 3 2 2
3 2 1 1
14 2 1 3
14 0 0 2
14 0 0 0
12 2 3 0
1 0 2 0
11 0 1 1
3 1 0 0
14 2 2 2
1 1 0 3
4 3 0 3
14 0 1 1
7 3 2 1
1 1 1 1
11 1 0 0
3 0 1 1
14 2 2 3
14 3 0 2
14 2 2 0
9 0 2 3
1 3 2 3
1 3 3 3
11 3 1 1
3 1 0 0
14 1 0 3
1 1 0 1
4 1 3 1
14 1 3 2
10 1 2 1
1 1 2 1
11 1 0 0
3 0 0 1
1 3 0 3
4 3 0 3
14 0 2 0
14 3 2 0
1 0 3 0
11 0 1 1
3 1 2 0
14 1 2 3
14 0 0 1
11 3 3 1
1 1 2 1
1 1 3 1
11 0 1 0
3 0 0 3
14 2 3 0
1 1 0 1
4 1 2 1
14 3 3 2
9 0 2 2
1 2 1 2
11 2 3 3
3 3 0 1
14 0 2 3
14 0 0 0
1 2 0 2
4 2 2 2
7 3 2 2
1 2 2 2
11 2 1 1
3 1 0 2
14 3 0 1
14 3 2 0
14 2 2 3
0 0 3 0
1 0 3 0
11 0 2 2
3 2 2 1
14 1 0 3
14 2 1 0
14 0 3 2
15 0 3 2
1 2 1 2
11 1 2 1
1 1 0 2
4 2 0 2
15 0 3 0
1 0 1 0
11 1 0 1
14 3 3 0
14 0 1 3
14 2 2 2
7 3 2 0
1 0 2 0
11 1 0 1
3 1 0 3
1 1 0 2
4 2 0 2
14 3 0 0
14 1 1 1
1 1 2 2
1 2 3 2
11 2 3 3
3 3 1 1
14 2 0 0
14 0 1 3
14 2 1 2
7 3 2 0
1 0 3 0
11 0 1 1
3 1 2 3
14 0 0 1
14 1 1 0
3 0 2 0
1 0 2 0
1 0 2 0
11 3 0 3
3 3 0 2
14 1 0 1
14 2 3 3
14 2 2 0
5 0 3 1
1 1 1 1
11 2 1 2
3 2 0 1
14 3 0 2
9 0 2 0
1 0 2 0
11 1 0 1
3 1 3 3
14 2 1 0
1 3 0 2
4 2 2 2
14 3 2 1
6 2 1 1
1 1 2 1
11 1 3 3
3 3 0 1
1 2 0 3
4 3 0 3
14 1 3 0
3 0 2 2
1 2 3 2
1 2 1 2
11 2 1 1
3 1 1 2
14 2 2 3
14 3 3 1
1 0 0 0
4 0 3 0
0 1 3 0
1 0 1 0
11 0 2 2
3 2 3 1
14 0 1 2
14 3 1 0
14 1 3 3
1 3 2 0
1 0 1 0
11 1 0 1
14 2 0 3
14 3 2 2
14 2 3 0
5 0 3 2
1 2 2 2
11 2 1 1
3 1 2 0
14 3 3 1
14 0 3 2
12 2 3 3
1 3 1 3
1 3 3 3
11 3 0 0
3 0 2 2
14 0 0 1
14 2 3 0
14 1 2 3
15 0 3 3
1 3 3 3
11 2 3 2
3 2 0 1
14 2 0 3
14 1 3 2
5 0 3 2
1 2 2 2
11 1 2 1
3 1 3 3
1 3 0 0
4 0 1 0
14 0 3 1
14 1 0 2
4 0 1 2
1 2 1 2
11 3 2 3
3 3 1 0
14 0 1 3
1 1 0 2
4 2 3 2
14 2 2 1
12 3 2 2
1 2 3 2
11 2 0 0
3 0 2 1
14 3 2 0
1 1 0 2
4 2 0 2
14 2 3 3
12 2 3 3
1 3 1 3
1 3 1 3
11 3 1 1
3 1 0 3
14 2 0 1
9 2 0 2
1 2 2 2
11 3 2 3
3 3 1 2
14 2 2 0
14 1 3 3
14 0 3 1
15 0 3 1
1 1 1 1
11 1 2 2
3 2 3 0
14 2 1 2
14 0 0 1
14 0 1 3
7 3 2 3
1 3 2 3
11 3 0 0
3 0 2 3
14 2 1 1
14 3 0 0
0 0 1 0
1 0 1 0
11 0 3 3
3 3 3 0
1 2 0 3
4 3 0 3
14 1 2 1
7 3 2 2
1 2 1 2
11 2 0 0
3 0 1 1
14 3 0 2
14 1 0 3
14 2 0 0
15 0 3 2
1 2 3 2
11 2 1 1
14 3 1 0
14 0 2 3
14 2 0 2
7 3 2 2
1 2 2 2
11 1 2 1
14 1 0 0
14 2 2 2
3 0 2 3
1 3 2 3
1 3 3 3
11 1 3 1
3 1 0 0
14 2 2 1
14 0 3 3
14 3 1 1
1 1 2 1
11 1 0 0
3 0 1 1
14 1 0 0
11 0 0 0
1 0 1 0
1 0 1 0
11 1 0 1
3 1 2 2
14 2 1 1
14 3 2 0
14 3 1 3
8 1 0 0
1 0 3 0
1 0 1 0
11 2 0 2
3 2 1 0
14 1 3 3
14 0 3 1
14 2 3 2
4 3 1 3
1 3 2 3
11 3 0 0
3 0 0 3
14 3 1 0
14 1 0 1
8 2 0 2
1 2 3 2
1 2 1 2
11 3 2 3
14 1 1 0
14 3 3 1
14 0 3 2
11 0 0 0
1 0 2 0
11 0 3 3
3 3 0 2
1 3 0 0
4 0 2 0
1 2 0 3
4 3 1 3
15 0 3 0
1 0 3 0
11 0 2 2
14 1 3 0
14 1 0 1
14 2 0 3
11 0 0 3
1 3 1 3
1 3 1 3
11 3 2 2
3 2 0 1
14 0 0 3
14 2 0 2
7 3 2 0
1 0 3 0
11 0 1 1
3 1 2 0
14 1 3 3
14 1 0 1
14 0 2 2
1 1 2 1
1 1 3 1
11 1 0 0
3 0 3 2
14 2 2 0
1 2 0 1
4 1 1 1
13 1 0 0
1 0 1 0
1 0 2 0
11 2 0 2
3 2 1 1
1 3 0 0
4 0 3 0
14 0 3 2
14 2 0 3
9 2 0 2
1 2 3 2
11 1 2 1
14 0 2 2
14 1 3 3
9 2 0 0
1 0 1 0
11 0 1 1
3 1 2 3
14 2 1 0
14 3 0 2
14 1 1 1
14 2 1 0
1 0 1 0
11 0 3 3
14 3 2 0
14 0 1 2
14 2 3 1
10 0 2 0
1 0 2 0
11 3 0 3
3 3 3 2
14 3 1 0
1 0 0 3
4 3 2 3
14 1 1 1
13 1 3 1
1 1 1 1
11 1 2 2
14 1 1 1
14 1 3 3
14 2 3 0
15 0 3 3
1 3 2 3
11 2 3 2
3 2 1 1
14 1 2 0
14 0 3 3
14 2 1 2
7 3 2 2
1 2 2 2
11 2 1 1
14 1 0 2
14 1 3 3
14 2 1 0
15 0 3 3
1 3 2 3
11 1 3 1
14 1 2 3
1 2 0 0
4 0 1 0
14 2 0 2
3 0 2 3
1 3 3 3
11 3 1 1
14 2 3 3
14 2 3 0
5 0 3 3
1 3 1 3
1 3 2 3
11 1 3 1
3 1 3 3
14 1 2 0
1 3 0 1
4 1 1 1
14 3 1 2
1 0 2 0
1 0 2 0
11 0 3 3
14 2 0 2
1 1 0 0
4 0 1 0
14 3 0 1
4 0 1 1
1 1 1 1
1 1 2 1
11 1 3 3
3 3 3 0
14 0 3 3
14 3 0 1
7 3 2 1
1 1 2 1
1 1 2 1
11 0 1 0
3 0 2 1
14 1 3 2
14 2 1 0
14 1 1 3
13 3 0 2
1 2 3 2
11 2 1 1
3 1 1 3
14 2 2 2
14 2 2 1
14 1 3 0
3 0 2 1
1 1 2 1
11 3 1 3
3 3 2 0
EOS

lines = input.lines.map(&:chomp)

samples = []
program = []

section2 = false
until section2
  line1 = lines.shift

  if line1.empty?
    lines.shift
    lines.shift
    section2 = true
  else
    line2 = lines.shift
    line3 = lines.shift
    lines.shift

    instruction = line2.split(" ").map(&:to_i)
    registers_before = line1[-11..-2].split(", ").map(&:to_i)
    registers_after  = line3[-11..-2].split(", ").map(&:to_i)

    samples << {
      instruction: instruction,
      registers_before: registers_before,
      registers_after: registers_after
    }
  end
end

lines.each do |line|
  program << line.split(" ").map(&:to_i)
end

instruction_codes = 16.times.to_a
instruction_names = %w[
  addr
  addi
  mulr
  muli
  banr
  bani
  borr
  bori
  setr
  seti
  gtir
  gtri
  gtrr
  eqir
  eqri
  eqrr
]

candidates = {}
instruction_codes.each do |ic|
  candidates[ic] = instruction_names.dup
end

samples.each do |sample|
  ic, a, b, c = sample[:instruction]

  candidates[ic].select! do |instruction_name|
    registers = sample[:registers_before].dup

    registers[c] = case instruction_name
                   when "addr" then registers[a] + registers[b]
                   when "addi" then registers[a] + b
                   when "mulr" then registers[a] * registers[b]
                   when "muli" then registers[a] * b
                   when "banr" then registers[a] & registers[b]
                   when "bani" then registers[a] & b
                   when "borr" then registers[a] | registers[b]
                   when "bori" then registers[a] | b
                   when "setr" then registers[a]
                   when "seti" then a
                   when "gtir" then a > registers[b] ? 1 : 0
                   when "gtri" then registers[a] > b ? 1 : 0
                   when "gtrr" then registers[a] > registers[b] ? 1 : 0
                   when "eqir" then a == registers[b] ? 1 : 0
                   when "eqri" then registers[a] == b ? 1 : 0
                   when "eqrr" then registers[a] == registers[b] ? 1 : 0
                   else raise "invalid instruction name #{instruction_name}"
                   end

    registers == sample[:registers_after]
  end
end

sure = {}

until sure.length == 16
  candidates.select { |k, v| v.length == 1 }.each do |k, vs|
    sure[k] = vs.first
  end

  sure.each do |k1, v1|
    candidates.each do |k2, v2|
      v2.delete(v1)
    end
  end
end

registers = [0, 0, 0, 0]

program.each do |instruction|
  ic, a, b, c = instruction

  registers[c] = case sure[ic]
                 when "addr" then registers[a] + registers[b]
                 when "addi" then registers[a] + b
                 when "mulr" then registers[a] * registers[b]
                 when "muli" then registers[a] * b
                 when "banr" then registers[a] & registers[b]
                 when "bani" then registers[a] & b
                 when "borr" then registers[a] | registers[b]
                 when "bori" then registers[a] | b
                 when "setr" then registers[a]
                 when "seti" then a
                 when "gtir" then a > registers[b] ? 1 : 0
                 when "gtri" then registers[a] > b ? 1 : 0
                 when "gtrr" then registers[a] > registers[b] ? 1 : 0
                 when "eqir" then a == registers[b] ? 1 : 0
                 when "eqri" then registers[a] == b ? 1 : 0
                 when "eqrr" then registers[a] == registers[b] ? 1 : 0
                 else raise "invalid instruction name #{instruction_name}"
                 end
end

puts registers[0]
