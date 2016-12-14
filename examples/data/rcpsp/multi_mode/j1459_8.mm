************************************************************************
file with basedata            : md187_.bas
initial value random generator: 1439615839
************************************************************************
projects                      :  1
jobs (incl. supersource/sink ):  16
horizon                       :  122
RESOURCES
  - renewable                 :  2   R
  - nonrenewable              :  2   N
  - doubly constrained        :  0   D
************************************************************************
PROJECT INFORMATION:
pronr.  #jobs rel.date duedate tardcost  MPM-Time
    1     14      0       25       12       25
************************************************************************
PRECEDENCE RELATIONS:
jobnr.    #modes  #successors   successors
   1        1          3           2   3   4
   2        3          3           7   8  11
   3        3          3           6  11  15
   4        3          1           5
   5        3          3           6   8  11
   6        3          2           7  13
   7        3          1          14
   8        3          2           9  10
   9        3          2          12  15
  10        3          3          12  14  15
  11        3          2          12  14
  12        3          1          13
  13        3          1          16
  14        3          1          16
  15        3          1          16
  16        1          0        
************************************************************************
REQUESTS/DURATIONS:
jobnr. mode duration  R 1  R 2  N 1  N 2
------------------------------------------------------------------------
  1      1     0       0    0    0    0
  2      1     3       0    6    3    9
         2     6       0    3    3    6
         3    10       5    0    1    2
  3      1     3       0    8    5    8
         2    10       0    1    4    7
         3    10       0    4    3    7
  4      1     3       6    0    2    6
         2     7       5    0    2    4
         3     9       0   10    2    2
  5      1     4       0    8    7    9
         2     6       7    0    4    8
         3     9       0    5    3    7
  6      1     1       0    5   10    6
         2     3       9    0   10    6
         3    10       0    4    9    6
  7      1     2       6    0    5    4
         2     6       0    3    5    4
         3    10       6    0    5    1
  8      1     4       0    4    5    8
         2     7       0    4    5    3
         3     8       7    0    5    3
  9      1     4       8    0    4    8
         2     7       6    0    4    6
         3     9       0    7    4    4
 10      1     6       4    0    9    5
         2     7       2    0    8    4
         3    10       0    8    7    3
 11      1     4       0    5   10    8
         2     5       3    0    8    6
         3     7       3    0    4    4
 12      1     2       5    0    5    9
         2     7       0    7    4    8
         3     9       4    0    3    5
 13      1     6       0    3    9    6
         2     7       7    0    8    5
         3     9       7    0    4    5
 14      1     1       0    9    7   10
         2     2       3    0    6    6
         3     6       1    0    4    1
 15      1     3       5    0    4    4
         2     5       0    3    3    3
         3     6       0    2    3    3
 16      1     0       0    0    0    0
************************************************************************
RESOURCEAVAILABILITIES:
  R 1  R 2  N 1  N 2
   14   18   85  100
************************************************************************