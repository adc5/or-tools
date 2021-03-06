************************************************************************
file with basedata            : md229_.bas
initial value random generator: 1898673102
************************************************************************
projects                      :  1
jobs (incl. supersource/sink ):  18
horizon                       :  121
RESOURCES
  - renewable                 :  2   R
  - nonrenewable              :  2   N
  - doubly constrained        :  0   D
************************************************************************
PROJECT INFORMATION:
pronr.  #jobs rel.date duedate tardcost  MPM-Time
    1     16      0       23       15       23
************************************************************************
PRECEDENCE RELATIONS:
jobnr.    #modes  #successors   successors
   1        1          3           2   3   4
   2        3          2           5   6
   3        3          3           6   7   8
   4        3          2           6   8
   5        3          3          11  13  16
   6        3          3           9  10  16
   7        3          2           9  10
   8        3          3           9  14  16
   9        3          1          15
  10        3          2          12  13
  11        3          1          12
  12        3          2          14  15
  13        3          2          14  15
  14        3          1          17
  15        3          1          18
  16        3          1          18
  17        3          1          18
  18        1          0        
************************************************************************
REQUESTS/DURATIONS:
jobnr. mode duration  R 1  R 2  N 1  N 2
------------------------------------------------------------------------
  1      1     0       0    0    0    0
  2      1     1       6    9    9    4
         2     2       3    8    8    3
         3     9       2    7    7    2
  3      1     4       8    5    2    8
         2     4       7    3    4    7
         3     4       8    7    2    7
  4      1     1       2    7    8    7
         2     3       2    5    8    6
         3    10       2    2    7    4
  5      1     2       5    5    8    3
         2     2       7    6    7    3
         3     5       4    3    7    3
  6      1     7       9    5    4    3
         2     7       9    6    3    5
         3     9       6    3    3    3
  7      1     1       3    8    4    7
         2     4       3    4    3    7
         3     7       2    1    3    6
  8      1     4       7    5    7    2
         2     5       7    4    5    1
         3     7       6    4    3    1
  9      1     2       8    4    5    7
         2     4       8    4    4    6
         3     8       5    3    3    6
 10      1     3       5    8    9    6
         2     3       4    9    8    6
         3     8       4    4    6    6
 11      1     2       7    6    3   10
         2     4       4    3    3   10
         3     9       1    1    1   10
 12      1     2       7    8    6    3
         2     4       7    7    4    3
         3     6       6    6    2    3
 13      1     2       5    6    5   10
         2     3       5    5    5    6
         3     6       5    5    5    5
 14      1     2       4    2    6    6
         2     8       3    2    3    4
         3     8       4    2    2    5
 15      1     1       3    7    8    9
         2     6       3    6    5    7
         3     7       3    6    3    6
 16      1     1       8    9    9   10
         2     4       7    7    5   10
         3     8       6    6    4    9
 17      1     5       9    6    9    8
         2     5       8    7    9    8
         3    10       5    6    8    6
 18      1     0       0    0    0    0
************************************************************************
RESOURCEAVAILABILITIES:
  R 1  R 2  N 1  N 2
   12   12   76   87
************************************************************************
