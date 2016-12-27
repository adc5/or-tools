jobs  (incl. supersource/sink ):	52
RESOURCES
- renewable                 : 4 R
- nonrenewable              : 2 N
- doubly constrained        : 0 D
************************************************************************
PRECEDENCE RELATIONS:
jobnr.    #modes  #successors   successors
1	1	2		2 3 
2	9	6		11 10 9 8 6 5 
3	9	5		16 15 11 7 4 
4	9	5		18 14 10 9 8 
5	9	3		15 14 7 
6	9	5		18 16 15 14 12 
7	9	3		20 18 13 
8	9	3		20 13 12 
9	9	3		20 17 13 
10	9	2		20 13 
11	9	1		12 
12	9	5		27 26 24 22 19 
13	9	4		27 26 24 19 
14	9	3		22 21 17 
15	9	2		21 17 
16	9	2		24 19 
17	9	4		27 25 24 23 
18	9	3		27 24 23 
19	9	2		25 21 
20	9	2		33 22 
21	9	5		35 33 31 28 23 
22	9	4		31 29 28 23 
23	9	7		43 40 38 37 36 32 30 
24	9	4		38 36 29 28 
25	9	6		40 38 37 36 32 30 
26	9	4		36 33 31 30 
27	9	4		41 35 33 31 
28	9	2		37 30 
29	9	2		40 30 
30	9	3		44 41 34 
31	9	3		44 37 34 
32	9	3		44 41 34 
33	9	2		40 34 
34	9	2		51 39 
35	9	2		51 39 
36	9	6		51 50 49 48 46 42 
37	9	1		39 
38	9	6		50 49 48 47 46 44 
39	9	5		50 49 48 46 42 
40	9	4		49 46 44 42 
41	9	3		48 46 45 
42	9	2		47 45 
43	9	2		46 45 
44	9	1		45 
45	9	1		52 
46	9	1		52 
47	9	1		52 
48	9	1		52 
49	9	1		52 
50	9	1		52 
51	9	1		52 
52	1	0		
************************************************************************
REQUESTS/DURATIONS
jobnr.	mode	dur	R1	R2	R3	R4	N1	N2	
------------------------------------------------------------------------
1	1	0	0	0	0	0	0	0	
2	1	8	4	4	4	5	27	10	
	2	9	4	4	3	4	26	10	
	3	10	4	4	3	4	26	9	
	4	17	4	4	3	4	26	8	
	5	22	4	4	3	4	25	8	
	6	24	4	4	2	4	25	8	
	7	25	4	4	2	4	24	8	
	8	27	4	4	2	4	24	7	
	9	29	4	4	2	4	24	6	
3	1	2	5	3	3	2	26	29	
	2	3	4	3	3	2	26	28	
	3	8	4	3	3	2	26	27	
	4	9	4	2	3	2	26	27	
	5	10	3	2	3	2	26	26	
	6	13	3	2	3	2	26	25	
	7	15	3	2	3	2	26	24	
	8	21	2	1	3	2	26	24	
	9	23	2	1	3	2	26	23	
4	1	4	2	3	4	3	24	17	
	2	9	2	3	4	2	24	17	
	3	10	2	3	4	2	24	16	
	4	11	2	3	4	2	24	15	
	5	12	2	2	4	1	24	14	
	6	12	1	2	4	1	24	15	
	7	13	1	2	4	1	24	14	
	8	16	1	2	4	1	24	13	
	9	17	1	2	4	1	24	12	
5	1	3	5	3	3	1	24	27	
	2	5	5	3	2	1	24	26	
	3	6	5	3	2	1	24	24	
	4	19	5	3	2	1	24	23	
	5	23	5	2	1	1	24	21	
	6	27	5	2	1	1	23	18	
	7	28	5	1	1	1	23	18	
	8	29	5	1	1	1	23	15	
	9	30	5	1	1	1	23	13	
6	1	3	5	3	2	4	25	20	
	2	5	4	3	2	3	23	19	
	3	6	4	3	2	3	22	18	
	4	10	4	3	2	3	20	17	
	5	14	3	3	2	3	18	15	
	6	22	3	3	2	3	18	14	
	7	26	2	3	2	3	15	14	
	8	28	2	3	2	3	14	13	
	9	29	2	3	2	3	14	12	
7	1	3	2	5	2	3	26	22	
	2	6	2	5	1	2	24	20	
	3	9	2	5	1	2	21	20	
	4	13	2	5	1	2	20	20	
	5	19	1	5	1	2	18	19	
	6	22	1	5	1	2	16	18	
	7	23	1	5	1	2	16	17	
	8	24	1	5	1	2	14	17	
	9	26	1	5	1	2	11	17	
8	1	5	2	1	3	5	17	29	
	2	7	2	1	3	4	16	27	
	3	11	2	1	3	4	15	27	
	4	13	2	1	3	4	12	25	
	5	18	2	1	3	4	10	24	
	6	22	2	1	3	4	9	22	
	7	23	2	1	3	4	7	19	
	8	26	2	1	3	4	6	18	
	9	30	2	1	3	4	6	17	
9	1	5	4	3	5	3	17	24	
	2	8	4	3	4	2	17	23	
	3	9	4	3	4	2	16	22	
	4	12	3	2	3	2	13	22	
	5	13	3	2	2	2	13	21	
	6	17	2	2	2	2	10	21	
	7	21	1	2	1	2	8	20	
	8	25	1	1	1	2	8	20	
	9	27	1	1	1	2	6	19	
10	1	1	4	3	5	3	17	29	
	2	2	4	3	4	2	17	29	
	3	4	3	3	4	2	17	27	
	4	8	3	3	4	2	17	26	
	5	9	3	3	4	1	17	25	
	6	10	2	3	4	1	17	24	
	7	20	1	3	4	1	17	24	
	8	21	1	3	4	1	17	23	
	9	23	1	3	4	1	17	22	
11	1	7	2	5	4	4	25	19	
	2	10	2	4	4	3	21	18	
	3	11	2	4	4	3	20	15	
	4	12	2	4	3	3	18	12	
	5	18	2	3	3	2	17	10	
	6	19	2	3	3	2	16	7	
	7	23	2	2	2	1	13	6	
	8	26	2	2	2	1	10	4	
	9	27	2	2	2	1	10	2	
12	1	4	3	1	2	4	24	11	
	2	8	3	1	2	4	24	10	
	3	10	3	1	2	4	24	9	
	4	15	3	1	2	4	24	8	
	5	18	3	1	1	4	23	8	
	6	20	3	1	1	4	23	6	
	7	22	3	1	1	4	22	5	
	8	27	3	1	1	4	22	4	
	9	28	3	1	1	4	22	3	
13	1	15	4	3	3	4	25	9	
	2	19	4	3	2	4	23	8	
	3	20	4	3	2	4	22	7	
	4	21	3	3	2	4	21	6	
	5	23	3	2	2	4	19	5	
	6	24	2	2	2	4	19	5	
	7	26	2	2	2	4	18	3	
	8	28	1	2	2	4	16	2	
	9	29	1	2	2	4	15	2	
14	1	1	5	4	5	3	28	6	
	2	2	4	3	4	3	28	6	
	3	5	4	3	4	3	26	6	
	4	6	4	3	4	3	23	6	
	5	11	4	3	4	2	23	5	
	6	15	3	2	4	2	21	5	
	7	20	3	2	4	2	19	5	
	8	21	3	2	4	2	18	5	
	9	29	3	2	4	2	17	5	
15	1	2	4	3	3	1	17	30	
	2	6	3	3	3	1	16	29	
	3	7	3	3	3	1	15	29	
	4	8	3	3	2	1	15	29	
	5	10	3	3	2	1	13	29	
	6	14	3	3	2	1	12	29	
	7	19	3	3	1	1	11	29	
	8	22	3	3	1	1	11	28	
	9	26	3	3	1	1	9	29	
16	1	1	4	3	5	5	28	27	
	2	4	3	2	4	4	28	26	
	3	5	3	2	4	4	28	23	
	4	7	3	2	4	4	27	21	
	5	9	3	1	4	4	27	20	
	6	11	2	1	3	3	26	17	
	7	15	2	1	3	3	25	15	
	8	16	2	1	3	3	25	13	
	9	18	2	1	3	3	25	12	
17	1	2	4	4	3	4	28	19	
	2	5	4	4	3	4	27	19	
	3	8	3	4	3	4	25	19	
	4	15	3	4	3	4	23	19	
	5	17	2	4	2	4	21	18	
	6	20	2	4	2	4	19	18	
	7	21	2	4	1	4	16	18	
	8	23	1	4	1	4	14	17	
	9	29	1	4	1	4	13	17	
18	1	3	3	1	5	5	11	22	
	2	4	3	1	4	4	11	20	
	3	13	3	1	4	4	9	19	
	4	16	2	1	3	4	9	18	
	5	17	2	1	2	4	8	16	
	6	25	2	1	2	4	8	13	
	7	26	1	1	2	4	7	13	
	8	27	1	1	1	4	5	11	
	9	29	1	1	1	4	5	10	
19	1	8	4	3	5	5	20	22	
	2	14	3	2	4	5	17	22	
	3	15	3	2	4	5	17	21	
	4	18	3	2	4	5	15	22	
	5	19	3	2	4	5	14	21	
	6	20	2	1	4	5	13	21	
	7	27	2	1	4	5	11	20	
	8	27	2	1	4	5	9	21	
	9	28	2	1	4	5	9	20	
20	1	2	3	2	5	4	23	24	
	2	7	3	2	4	4	20	24	
	3	9	3	2	4	4	19	24	
	4	13	3	2	4	4	17	24	
	5	14	3	2	4	4	14	23	
	6	15	3	2	3	4	13	23	
	7	16	3	2	3	4	11	23	
	8	23	3	2	3	4	8	22	
	9	29	3	2	3	4	5	22	
21	1	6	5	5	4	3	16	9	
	2	13	4	4	4	3	13	8	
	3	16	4	4	4	3	12	8	
	4	21	3	4	4	3	11	8	
	5	24	3	3	3	3	9	8	
	6	25	2	3	3	3	8	8	
	7	26	2	3	3	3	7	8	
	8	28	1	2	3	3	4	8	
	9	30	1	2	3	3	4	7	
22	1	3	5	4	4	3	16	16	
	2	8	4	3	4	3	16	16	
	3	13	3	3	4	3	14	15	
	4	17	3	2	3	3	14	14	
	5	21	2	2	3	3	13	14	
	6	26	2	2	3	3	12	13	
	7	28	2	1	3	3	10	13	
	8	29	1	1	2	3	10	13	
	9	30	1	1	2	3	9	12	
23	1	6	4	2	4	2	7	30	
	2	8	3	2	4	2	7	28	
	3	10	3	2	4	2	6	27	
	4	11	3	2	3	2	5	26	
	5	12	2	2	3	2	4	24	
	6	17	2	1	3	2	4	24	
	7	21	1	1	2	2	3	23	
	8	26	1	1	2	2	2	21	
	9	27	1	1	2	2	2	20	
24	1	1	4	4	4	2	18	11	
	2	2	4	4	3	2	18	9	
	3	3	4	4	3	2	15	9	
	4	4	4	4	3	2	12	9	
	5	8	4	3	3	2	10	7	
	6	9	4	3	3	1	9	7	
	7	18	4	2	3	1	6	6	
	8	19	4	2	3	1	4	5	
	9	27	4	2	3	1	3	5	
25	1	9	4	3	2	3	10	25	
	2	12	3	3	2	2	9	25	
	3	13	3	3	2	2	7	25	
	4	17	3	2	2	2	7	25	
	5	21	3	2	2	2	6	25	
	6	25	3	2	2	2	6	24	
	7	27	3	2	2	2	5	24	
	8	28	3	1	2	2	4	24	
	9	30	3	1	2	2	3	24	
26	1	6	2	2	4	5	8	15	
	2	9	1	2	3	4	7	14	
	3	20	1	2	3	4	6	14	
	4	21	1	2	3	4	6	13	
	5	22	1	2	2	3	5	13	
	6	23	1	2	2	3	4	12	
	7	24	1	2	2	3	3	12	
	8	27	1	2	1	3	3	12	
	9	28	1	2	1	3	2	11	
27	1	3	3	3	5	1	11	23	
	2	8	3	2	5	1	10	20	
	3	9	3	2	5	1	10	19	
	4	12	3	2	5	1	9	18	
	5	19	3	2	5	1	9	16	
	6	22	3	1	5	1	9	15	
	7	25	3	1	5	1	8	14	
	8	26	3	1	5	1	8	13	
	9	29	3	1	5	1	8	12	
28	1	2	3	3	4	4	28	26	
	2	5	3	3	4	4	27	23	
	3	13	3	3	4	4	25	21	
	4	15	3	3	3	4	25	18	
	5	16	2	2	3	4	23	16	
	6	17	2	2	2	4	22	14	
	7	23	2	1	1	4	22	10	
	8	25	2	1	1	4	21	9	
	9	27	2	1	1	4	20	6	
29	1	4	1	4	4	3	25	24	
	2	9	1	4	4	2	24	23	
	3	12	1	4	4	2	23	23	
	4	17	1	4	4	2	20	22	
	5	18	1	3	3	2	19	21	
	6	19	1	3	3	2	18	20	
	7	22	1	3	3	2	18	19	
	8	23	1	2	2	2	15	17	
	9	29	1	2	2	2	15	16	
30	1	1	4	1	2	2	25	17	
	2	2	4	1	2	2	23	16	
	3	3	4	1	2	2	22	16	
	4	6	4	1	2	2	19	16	
	5	18	4	1	2	2	14	16	
	6	19	4	1	1	1	14	15	
	7	21	4	1	1	1	11	15	
	8	23	4	1	1	1	7	15	
	9	30	4	1	1	1	3	15	
31	1	2	2	3	2	3	18	15	
	2	5	2	3	2	3	17	14	
	3	8	2	3	2	3	14	13	
	4	12	2	3	2	3	12	11	
	5	17	2	3	2	2	10	11	
	6	18	2	3	2	2	9	10	
	7	22	2	3	2	2	5	9	
	8	29	2	3	2	1	3	7	
	9	30	2	3	2	1	2	7	
32	1	5	5	2	4	4	10	14	
	2	9	4	2	4	4	8	14	
	3	10	4	2	3	4	7	14	
	4	14	4	2	3	4	6	14	
	5	16	4	2	3	4	6	13	
	6	17	3	2	2	4	5	13	
	7	19	3	2	2	4	5	12	
	8	24	3	2	1	4	4	13	
	9	29	3	2	1	4	3	13	
33	1	3	4	4	4	4	17	25	
	2	4	4	4	4	4	16	24	
	3	13	3	4	3	4	16	23	
	4	16	3	4	3	3	15	20	
	5	19	3	4	2	3	15	19	
	6	21	2	4	2	2	14	17	
	7	24	1	4	1	1	13	15	
	8	26	1	4	1	1	13	14	
	9	28	1	4	1	1	13	13	
34	1	4	4	5	5	5	18	12	
	2	6	4	4	4	5	17	12	
	3	9	3	4	4	5	17	11	
	4	15	3	4	4	5	17	8	
	5	19	3	3	4	5	17	8	
	6	20	2	3	4	5	16	5	
	7	21	2	3	4	5	16	4	
	8	23	1	2	4	5	16	2	
	9	26	1	2	4	5	16	1	
35	1	2	3	2	4	4	14	28	
	2	3	3	2	3	4	14	27	
	3	6	3	2	3	4	14	26	
	4	11	3	2	3	4	14	25	
	5	17	2	2	2	4	14	22	
	6	19	2	2	2	4	14	21	
	7	20	1	2	2	4	14	20	
	8	21	1	2	2	4	14	17	
	9	22	1	2	2	4	14	16	
36	1	3	4	4	4	5	26	26	
	2	4	4	4	4	4	25	26	
	3	10	4	4	4	3	20	26	
	4	11	4	3	4	3	18	26	
	5	15	4	3	3	3	17	26	
	6	16	4	3	3	2	13	26	
	7	21	4	3	3	1	11	26	
	8	22	4	2	3	1	10	26	
	9	25	4	2	3	1	6	26	
37	1	5	4	4	4	5	18	2	
	2	17	4	3	4	4	18	2	
	3	18	4	3	4	3	16	2	
	4	19	4	3	3	3	16	2	
	5	21	3	3	2	3	15	1	
	6	25	3	2	2	2	13	1	
	7	26	3	2	2	1	11	1	
	8	28	3	2	1	1	11	1	
	9	29	3	2	1	1	10	1	
38	1	4	4	4	4	4	11	21	
	2	5	4	4	4	3	10	19	
	3	7	4	4	4	3	10	18	
	4	8	4	3	4	3	8	17	
	5	18	4	2	4	2	7	16	
	6	20	3	2	4	2	7	16	
	7	21	3	1	4	2	5	14	
	8	29	3	1	4	1	5	13	
	9	30	3	1	4	1	4	13	
39	1	5	2	5	3	3	18	30	
	2	9	2	4	3	2	17	29	
	3	12	2	4	3	2	16	27	
	4	15	2	4	3	2	15	26	
	5	16	2	4	3	1	13	25	
	6	17	1	4	2	1	12	25	
	7	19	1	4	2	1	10	24	
	8	21	1	4	2	1	8	22	
	9	28	1	4	2	1	8	21	
40	1	2	5	2	5	4	16	19	
	2	11	4	2	4	4	16	18	
	3	12	3	2	4	4	16	18	
	4	16	3	2	4	3	16	18	
	5	21	2	1	4	3	15	18	
	6	22	2	1	4	3	15	17	
	7	26	1	1	4	3	15	17	
	8	27	1	1	4	2	15	17	
	9	29	1	1	4	2	15	16	
41	1	3	3	4	3	3	4	26	
	2	4	3	4	3	3	4	25	
	3	6	3	4	3	3	4	24	
	4	7	3	4	3	3	4	23	
	5	10	3	4	3	3	3	24	
	6	13	3	4	3	3	3	23	
	7	19	3	4	3	3	3	22	
	8	26	3	4	3	3	3	21	
	9	27	3	4	3	3	3	20	
42	1	1	2	4	4	1	26	30	
	2	2	2	4	4	1	26	29	
	3	9	2	4	4	1	25	29	
	4	12	2	4	3	1	23	29	
	5	16	2	4	2	1	23	29	
	6	17	2	4	2	1	22	28	
	7	24	2	4	1	1	22	28	
	8	24	2	4	1	1	20	29	
	9	25	2	4	1	1	20	28	
43	1	1	3	4	4	4	16	29	
	2	2	2	4	4	4	13	28	
	3	7	2	4	4	4	13	26	
	4	11	2	4	4	4	11	24	
	5	12	2	4	4	3	9	22	
	6	13	2	4	4	3	9	19	
	7	14	2	4	4	3	7	18	
	8	15	2	4	4	3	5	16	
	9	17	2	4	4	3	5	13	
44	1	2	5	2	2	5	25	19	
	2	4	4	2	2	4	25	16	
	3	11	4	2	2	4	20	14	
	4	12	4	2	2	4	19	13	
	5	14	3	1	2	4	13	13	
	6	15	3	1	2	3	10	11	
	7	19	2	1	2	3	8	10	
	8	22	2	1	2	3	4	7	
	9	28	2	1	2	3	3	7	
45	1	2	4	2	1	1	24	28	
	2	8	4	2	1	1	21	25	
	3	9	4	2	1	1	17	24	
	4	12	4	2	1	1	14	22	
	5	14	4	2	1	1	11	19	
	6	16	4	1	1	1	10	16	
	7	19	4	1	1	1	7	15	
	8	25	4	1	1	1	5	12	
	9	30	4	1	1	1	2	9	
46	1	6	2	3	4	3	26	27	
	2	10	2	2	4	3	24	26	
	3	17	2	2	3	3	24	25	
	4	19	2	2	3	3	22	25	
	5	21	1	2	2	3	20	24	
	6	23	1	2	2	3	19	22	
	7	24	1	2	2	3	17	22	
	8	27	1	2	1	3	16	21	
	9	30	1	2	1	3	16	19	
47	1	5	3	3	4	5	17	24	
	2	17	2	3	4	4	16	22	
	3	19	2	3	4	4	16	21	
	4	20	2	3	4	4	16	20	
	5	21	1	3	4	4	15	22	
	6	22	1	3	4	4	15	21	
	7	23	1	3	4	4	15	20	
	8	25	1	3	4	4	15	18	
	9	26	1	3	4	4	15	17	
48	1	4	3	5	4	5	8	8	
	2	5	3	4	4	4	7	6	
	3	11	3	4	4	4	7	5	
	4	16	2	4	3	4	6	6	
	5	18	2	3	3	4	6	5	
	6	21	2	3	2	4	5	4	
	7	22	2	2	1	4	5	4	
	8	23	1	2	1	4	4	2	
	9	28	1	2	1	4	4	1	
49	1	10	4	3	3	4	28	24	
	2	11	4	3	3	4	26	23	
	3	12	4	3	3	4	25	23	
	4	21	4	3	3	4	23	21	
	5	22	4	2	3	4	23	21	
	6	23	4	2	3	4	20	20	
	7	26	4	2	3	4	19	18	
	8	27	4	2	3	4	19	17	
	9	29	4	2	3	4	18	17	
50	1	4	1	3	4	3	28	16	
	2	6	1	3	3	2	27	15	
	3	10	1	3	3	2	23	14	
	4	14	1	3	3	2	23	13	
	5	15	1	3	3	2	18	12	
	6	16	1	3	3	1	18	12	
	7	19	1	3	3	1	15	10	
	8	22	1	3	3	1	13	10	
	9	30	1	3	3	1	11	9	
51	1	7	3	3	3	5	21	28	
	2	8	3	3	3	4	19	27	
	3	13	3	3	3	3	17	25	
	4	14	3	3	3	3	15	25	
	5	15	3	3	2	3	12	22	
	6	16	3	3	2	2	11	21	
	7	19	3	3	2	2	11	20	
	8	21	3	3	2	1	8	19	
	9	29	3	3	2	1	6	18	
52	1	0	0	0	0	0	0	0	
************************************************************************

 RESOURCE AVAILABILITIES 
	R 1	R 2	R 3	R 4	N 1	N 2
	23	19	21	22	654	775

************************************************************************