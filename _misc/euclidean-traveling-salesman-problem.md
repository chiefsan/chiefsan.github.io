---
layout: misc-layout
title:  "Euclidean Traveling Salesman Problem"
date:   2020-09-22 21:20:00 +0530
tags: ApproximationAlgorithms
---

## Euclidean TSP

The euclidean TSP is a special case of the Metric TSP. For a fixed d, given n points in <img src="https://gist.githubusercontent.com/chiefsan/2992da265f70b482f100cf01df961c5b/raw/e3c836052c142cf73591afdfb80e49a0.svg?invert_in_darkmode&sanitize=true" align=middle width=36.066788999999986pt height=27.91243950000002pt/>, the problem is to find the minimum length tour of the n points. The distance between two points x and y is given by <img src="https://gist.githubusercontent.com/chiefsan/2992da265f70b482f100cf01df961c5b/raw/548fb383b5a32f458fe67ca7eacf8f10.svg?invert_in_darkmode&sanitize=true" align=middle width=129.73545584999997pt height=24.65753399999998pt/>.

Though we don't know how to calculate square roots efficiently, we will derive a PTAS for this problem by employing the following techniques

- rounding the instance

- partitioning the space into squares and exploiting the structure of the problem

- applying dynamic programming

For the sake of simplicity, we concentrate on d=2.


### Bounding Box
> Smallest axis-parallel square that contains all n points. 

We set the length of each edge of the square to L=<img src="https://gist.githubusercontent.com/chiefsan/2992da265f70b482f100cf01df961c5b/raw/784d3fa4ae8fa5515403e72d906885b3.svg?invert_in_darkmode&sanitize=true" align=middle width=24.63863324999999pt height=26.76175259999998pt/>. This is possible by stretching all distances by an appropriate factor. The optimal tour in the original instance still stays an optimal tour (and vice versa) since the distances get scaled by the same factor. 

Assume w.l.o.g. that n is a power of two so that <img src="https://gist.githubusercontent.com/chiefsan/2992da265f70b482f100cf01df961c5b/raw/c44bdc383b8800a88505b6b071f9f94d.svg?invert_in_darkmode&sanitize=true" align=middle width=48.59011244999999pt height=27.91243950000002pt/>. Hence, <img src="https://gist.githubusercontent.com/chiefsan/2992da265f70b482f100cf01df961c5b/raw/c4810c462c3898f7245971f0a58da161.svg?invert_in_darkmode&sanitize=true" align=middle width=200.38856144999997pt height=24.65753399999998pt/>

<img alt="ETSP 1" src="https://gist.githubusercontent.com/chiefsan/2992da265f70b482f100cf01df961c5b/raw/etsp_1.PNG" style="display:block;float:none;margin-left:auto;margin-right:auto;">

Furthermore, we relocate every node of G to the nearest gridpoint so that all nodes get integer coordinates. Due to the following facts, the effect of this perturbation is bounded.

- A lower bound for the length of the optimal tour OPT is 2L because at least two nodes are situated at opposite edges of the bounding box (otherwise, we would choose a smaller bounding box).

- The absolute error per node is bounded by <img src="https://gist.githubusercontent.com/chiefsan/2992da265f70b482f100cf01df961c5b/raw/71486f265f83bc1e3d2b6f67704bcc23.svg?invert_in_darkmode&sanitize=true" align=middle width=21.91788224999999pt height=28.511366399999982pt/> as the maximum distance from an arbitrary point to the nearest grid point is <img src="https://gist.githubusercontent.com/chiefsan/2992da265f70b482f100cf01df961c5b/raw/3229ead1c7afe860d0500b3cbd5e94d2.svg?invert_in_darkmode&sanitize=true" align=middle width=17.351680499999997pt height=27.77565449999998pt/> and we cannot lose more than twice this distance. Hence, the total absolute error is bounded by <img src="https://gist.githubusercontent.com/chiefsan/2992da265f70b482f100cf01df961c5b/raw/f25ebf32f4308232536e175caaf3622a.svg?invert_in_darkmode&sanitize=true" align=middle width=31.784751899999986pt height=28.511366399999982pt/>.
    - Thus we obtain a bound for the relative error: 
<p align="center"><img src="https://gist.githubusercontent.com/chiefsan/2992da265f70b482f100cf01df961c5b/raw/e31e8279e290c02fbf6b3d88755714c3.svg?invert_in_darkmode&sanitize=true" align=middle width=250.64660775pt height=40.66383749999999pt/></p>
We can conclude that 
<p align="center"><img src="https://gist.githubusercontent.com/chiefsan/2992da265f70b482f100cf01df961c5b/raw/9cd0413439aa6824c7a138e60c5cce50.svg?invert_in_darkmode&sanitize=true" align=middle width=185.20137734999997pt height=13.881256950000001pt/></p> 
Therefore, the relative error can be compensated by an appropriate adjustment of <img src="https://gist.githubusercontent.com/chiefsan/2992da265f70b482f100cf01df961c5b/raw/68f866ec42d387e31c9209f96dce21db.svg?invert_in_darkmode&sanitize=true" align=middle width=11.23861529999999pt height=14.15524440000002pt/>
 
### Basic Dissection
> Recursive partitioning into smaller squares.

<p align="center"><img src="https://gist.githubusercontent.com/chiefsan/2992da265f70b482f100cf01df961c5b/raw/3554f0fd7b8dbe0b79c80171f4f57e20.svg?invert_in_darkmode&sanitize=true" align=middle width=216.23665965pt height=33.62942055pt/></p>

It will be convenient to view this dissection as a 4-ary tree, T, whose root is the bounding box. The nodes of T are assigned levels. The root is at level 0, its children at level 1, and so on. The squares at level i have dimensions <img src="https://gist.githubusercontent.com/chiefsan/2992da265f70b482f100cf01df961c5b/raw/58aebfbc5e77f6b1f44c8c8da16b198b.svg?invert_in_darkmode&sanitize=true" align=middle width=47.556308249999994pt height=28.670654099999997pt/>. The dissection continues until we obtain unit squares. Clearly, T has depth k. 

**useful square**: square represented by a node in T. 

Next, let us define levels for the horizontal and vertical lines that accomplish the basic dissection. The two lines that divide the bounding box into four squares have level 1. In general, the <img src="https://gist.githubusercontent.com/chiefsan/2992da265f70b482f100cf01df961c5b/raw/3a4a83447347e8eae50b856ef8a03468.svg?invert_in_darkmode&sanitize=true" align=middle width=12.87010889999999pt height=27.15900329999998pt/> lines that divide the level i - 1 squares into level i squares each have level i. Therefore, a line of level i forms the edge of useful squares at levels <img src="https://gist.githubusercontent.com/chiefsan/2992da265f70b482f100cf01df961c5b/raw/a9561abdf325508c714431db106f6bd1.svg?invert_in_darkmode&sanitize=true" align=middle width=73.42661039999999pt height=21.68300969999999pt/> , i.e., the largest useful square on it has dimensions <img src="https://gist.githubusercontent.com/chiefsan/2992da265f70b482f100cf01df961c5b/raw/58aebfbc5e77f6b1f44c8c8da16b198b.svg?invert_in_darkmode&sanitize=true" align=middle width=47.556308249999994pt height=28.670654099999997pt/>.

<img alt="ETSP 2" src="https://gist.githubusercontent.com/chiefsan/2992da265f70b482f100cf01df961c5b/raw/etsp_2.gif" style="display:block;float:none;margin-left:auto;margin-right:auto;">

The lines of the basic dissection may be crossed only at certain points, called **portals**. Each square has one portal for each corner and additional m − 1 portals for each edge, i.e., each square has a total of 4m portals. The parameter m must lie in the interval <img src="https://gist.githubusercontent.com/chiefsan/2992da265f70b482f100cf01df961c5b/raw/b77d506ad5d085b49a56e37095dcc29c.svg?invert_in_darkmode&sanitize=true" align=middle width=72.59146784999999pt height=24.65753399999998pt/>. Furthermore, m has to be a power of two. This guarantees that a portal of a level i is a portal of a contained level i + 1 square as well. The distance between two consecutive portals of level i square is <img src="https://gist.githubusercontent.com/chiefsan/2992da265f70b482f100cf01df961c5b/raw/4f3b7e590d00969a68e15f565cb9a198.svg?invert_in_darkmode&sanitize=true" align=middle width=60.31699244999999pt height=27.15900329999998pt/>.

<img alt="ETSP 3" src="https://gist.githubusercontent.com/chiefsan/2992da265f70b482f100cf01df961c5b/raw/etsp_3.PNG" style="display:block;float:none;margin-left:auto;margin-right:auto;">

<br>

<img alt="ETSP 3" src="https://gist.githubusercontent.com/chiefsan/2992da265f70b482f100cf01df961c5b/raw/etsp_3.gif" style="display:block;float:none;margin-left:auto;margin-right:auto;">


We want a tour to cross the lines of the basic dissection only at portals. 

A tour <img src="https://gist.githubusercontent.com/chiefsan/2992da265f70b482f100cf01df961c5b/raw/0fe1677705e987cac4f589ed600aa6b3.svg?invert_in_darkmode&sanitize=true" align=middle width=9.046852649999991pt height=14.15524440000002pt/> is _well behaved w.r.t. the basic dissection_ if 
- it involves all vertices and a subset of portals
- no edge of the tour crosses a line of the basic dissection
- it is non-self-intersecting

|Self-intersecting|Non-self-intersecting|
|-|-|
|![etsp eg](https://gist.githubusercontent.com/chiefsan/2992da265f70b482f100cf01df961c5b/raw/etsp_crossing1.PNG)|![etsp eg](https://gist.githubusercontent.com/chiefsan/2992da265f70b482f100cf01df961c5b/raw/etsp_crossing2.PNG)|

A tour <img src="https://gist.githubusercontent.com/chiefsan/2992da265f70b482f100cf01df961c5b/raw/0fe1677705e987cac4f589ed600aa6b3.svg?invert_in_darkmode&sanitize=true" align=middle width=9.046852649999991pt height=14.15524440000002pt/> is well behaved w.r.t. the basic dissection and has limited crossings if it is well behaved w.r.t. the basic dissection, and furthermore, it visits each portal at most twice. 

__Lemma__: Let tour <img src="https://gist.githubusercontent.com/chiefsan/2992da265f70b482f100cf01df961c5b/raw/0fe1677705e987cac4f589ed600aa6b3.svg?invert_in_darkmode&sanitize=true" align=middle width=9.046852649999991pt height=14.15524440000002pt/> be well behaved w.r.t. the basic dissection. Then there must be a tour that is well behaved with limited crossings, whose length is at most that of <img src="https://gist.githubusercontent.com/chiefsan/2992da265f70b482f100cf01df961c5b/raw/0fe1677705e987cac4f589ed600aa6b3.svg?invert_in_darkmode&sanitize=true" align=middle width=9.046852649999991pt height=14.15524440000002pt/>. 

![etsp eg](https://gist.githubusercontent.com/chiefsan/2992da265f70b482f100cf01df961c5b/raw/etsp_4.gif)

### Computing a well behaved tour 

**Lemma**: An optimal well behaved tour w.r.t. the basic dissection, with limited crossings, can be computed in <img src="https://gist.githubusercontent.com/chiefsan/2992da265f70b482f100cf01df961c5b/raw/dfaff857efd01320936f842e3d01063e.svg?invert_in_darkmode&sanitize=true" align=middle width=112.51017854999998pt height=29.190975000000005pt/> time.

![etsp eg](https://gist.githubusercontent.com/chiefsan/2992da265f70b482f100cf01df961c5b/raw/etsp_5.gif)

Each portal can be used at most twice, i.e., it can be used 0, 1, or 2 times. Since a square has 4m portals, there are <img src="https://gist.githubusercontent.com/chiefsan/2992da265f70b482f100cf01df961c5b/raw/99d5ab0f81d956b46cc29d0b551875e7.svg?invert_in_darkmode&sanitize=true" align=middle width=98.43621644999999pt height=29.190975000000005pt/> possibilities. 


![etsp eg](https://gist.githubusercontent.com/chiefsan/2992da265f70b482f100cf01df961c5b/raw/etsp_6.gif)

Furthermore, no self-intersections are allowed inside a square. 

|Invalid|Valid|
|-|-|
|![etsp invalid](https://gist.githubusercontent.com/chiefsan/2992da265f70b482f100cf01df961c5b/raw/etsp_invalid.PNG)|![etsp valid](https://gist.githubusercontent.com/chiefsan/2992da265f70b482f100cf01df961c5b/raw/etsp_valid.PNG)|

Each valid pairing corresponds to a balanced arrangement of parenthesis; thus, the number of valid pairings is equal to the <img src="https://gist.githubusercontent.com/chiefsan/2992da265f70b482f100cf01df961c5b/raw/d72c17f60448a7b8a728914fd501cf0d.svg?invert_in_darkmode&sanitize=true" align=middle width=20.53477304999999pt height=27.91243950000002pt/> catalan number when 2r portals are used. It is bounded by <img src="https://gist.githubusercontent.com/chiefsan/2992da265f70b482f100cf01df961c5b/raw/41630c95caf4399703c645eda7e73f61.svg?invert_in_darkmode&sanitize=true" align=middle width=93.2287719pt height=29.190975000000005pt/>. Hence, the total number of valid visits in a useful square is bounded by <img src="https://gist.githubusercontent.com/chiefsan/2992da265f70b482f100cf01df961c5b/raw/f6a6bd7690b4565b2e9f011077a97621.svg?invert_in_darkmode&sanitize=true" align=middle width=49.26007019999999pt height=29.190975000000005pt/>.

![etsp eg](https://gist.githubusercontent.com/chiefsan/2992da265f70b482f100cf01df961c5b/raw/etsp_catalan.PNG)

We start at the leaves of the 4-ary tree and use the results of the four children squares to compute the visits of the corresponding parent square. For a given square Q and pairing P, 
- Iterate over all <img src="https://gist.githubusercontent.com/chiefsan/2992da265f70b482f100cf01df961c5b/raw/9af86a19966214b44e0d0d551739e5e8.svg?invert_in_darkmode&sanitize=true" align=middle width=141.41949689999998pt height=29.190975000000005pt/> crossing-free pairings of child-squares.
- Minimize the cost over all such pairings that respect P
- Correctness by induction

![etsp eg](https://gist.githubusercontent.com/chiefsan/2992da265f70b482f100cf01df961c5b/raw/etsp_7.gif)

We compute the optimal length for each of the <img src="https://gist.githubusercontent.com/chiefsan/2992da265f70b482f100cf01df961c5b/raw/95ebe218196f79fa22a088239483c1a8.svg?invert_in_darkmode&sanitize=true" align=middle width=49.26007019999999pt height=29.190975000000005pt/> possibilities and determine the minimum length of all possibilities. The total expense of this algorithm can be bounded by <img src="https://gist.githubusercontent.com/chiefsan/2992da265f70b482f100cf01df961c5b/raw/95ebe218196f79fa22a088239483c1a8.svg?invert_in_darkmode&sanitize=true" align=middle width=49.26007019999999pt height=29.190975000000005pt/>.


The best well-behaved tour can be a bad approximation. 
![etsp eg](https://gist.githubusercontent.com/chiefsan/2992da265f70b482f100cf01df961c5b/raw/etsp_indirection.PNG)

<br>

![etsp eg](https://gist.githubusercontent.com/chiefsan/2992da265f70b482f100cf01df961c5b/raw/etsp_bad_example.PNG)

Consider an (a,b)-shifted dissection: 
<p align="center"><img src="https://gist.githubusercontent.com/chiefsan/2992da265f70b482f100cf01df961c5b/raw/6d901efd73a2cd8c0bb5cc49f9d9fff8.svg?invert_in_darkmode&sanitize=true" align=middle width=150.5378292pt height=16.438356pt/></p> 
<p align="center"><img src="https://gist.githubusercontent.com/chiefsan/2992da265f70b482f100cf01df961c5b/raw/8733b8e85afc290709ac7c601332ab87.svg?invert_in_darkmode&sanitize=true" align=middle width=147.41190749999998pt height=16.438356pt/></p>

![etsp eg](https://gist.githubusercontent.com/chiefsan/2992da265f70b482f100cf01df961c5b/raw/etsp_8.gif)

__Lemma__: Let <img src="https://gist.githubusercontent.com/chiefsan/2992da265f70b482f100cf01df961c5b/raw/f30fdded685c83b0e7b446aa9c9aa120.svg?invert_in_darkmode&sanitize=true" align=middle width=9.96010619999999pt height=14.15524440000002pt/> be an optimal tour and <img src="https://gist.githubusercontent.com/chiefsan/2992da265f70b482f100cf01df961c5b/raw/cefc10a9a1882ee3e1ead5ee0c516188.svg?invert_in_darkmode&sanitize=true" align=middle width=37.74549074999999pt height=24.65753399999998pt/> be the number of crossings of <img src="https://gist.githubusercontent.com/chiefsan/2992da265f70b482f100cf01df961c5b/raw/f30fdded685c83b0e7b446aa9c9aa120.svg?invert_in_darkmode&sanitize=true" align=middle width=9.96010619999999pt height=14.15524440000002pt/> with the lines of the (L x L)-grid. Then we have <img src="https://gist.githubusercontent.com/chiefsan/2992da265f70b482f100cf01df961c5b/raw/5f716e6562eb80aa2bb640335a4c0ac8.svg?invert_in_darkmode&sanitize=true" align=middle width=121.99207514999999pt height=28.511366399999982pt/>.

![etsp eg](https://gist.githubusercontent.com/chiefsan/2992da265f70b482f100cf01df961c5b/raw/etsp_9.gif)

Consider a tour as an ordered cyclic sequence. Each edge e generates <img src="https://gist.githubusercontent.com/chiefsan/2992da265f70b482f100cf01df961c5b/raw/de04461985f69a7cb9c878b45f83920f.svg?invert_in_darkmode&sanitize=true" align=middle width=107.71696155pt height=22.465723500000017pt/> crossings. Crossings at the endpoint of an edge are not counted for the next edge. <p align="center"><img src="https://gist.githubusercontent.com/chiefsan/2992da265f70b482f100cf01df961c5b/raw/e9b08f5f92d4761f2db77a88b2a67311.svg?invert_in_darkmode&sanitize=true" align=middle width=306.66457634999995pt height=18.312383099999998pt/></p>

<p align="center"><img src="https://gist.githubusercontent.com/chiefsan/2992da265f70b482f100cf01df961c5b/raw/490b1becb8438f2f5233cde0058f7c16.svg?invert_in_darkmode&sanitize=true" align=middle width=292.44673919999997pt height=37.03538685pt/></p>

__Theorem__: Let <img src="https://gist.githubusercontent.com/chiefsan/2992da265f70b482f100cf01df961c5b/raw/2739ba24b983a6490f721b3d0fa89d09.svg?invert_in_darkmode&sanitize=true" align=middle width=107.29615544999997pt height=24.65753399999998pt/> be chosen independently and uniformly at random. Then the expected cost of an optimal well-behaved tour with respect to the (a,b)-shifted dissection is <img src="https://gist.githubusercontent.com/chiefsan/2992da265f70b482f100cf01df961c5b/raw/287cdf102ee69a4e5bc6d8c151b79fdb.svg?invert_in_darkmode&sanitize=true" align=middle width=131.1016971pt height=28.511366399999982pt/>.

Consider an optimal tour <img src="https://gist.githubusercontent.com/chiefsan/2992da265f70b482f100cf01df961c5b/raw/f30fdded685c83b0e7b446aa9c9aa120.svg?invert_in_darkmode&sanitize=true" align=middle width=9.96010619999999pt height=14.15524440000002pt/>. Make <img src="https://gist.githubusercontent.com/chiefsan/2992da265f70b482f100cf01df961c5b/raw/f30fdded685c83b0e7b446aa9c9aa120.svg?invert_in_darkmode&sanitize=true" align=middle width=9.96010619999999pt height=14.15524440000002pt/> well behaved by moving each intersection point with the (L x L)-grid to the nearest portal. The detour per instruction <img src="https://gist.githubusercontent.com/chiefsan/2992da265f70b482f100cf01df961c5b/raw/fc242b5b14374626de01eaa8d106d2ce.svg?invert_in_darkmode&sanitize=true" align=middle width=12.785434199999989pt height=20.908638300000003pt/> inter-portal distance. 

![etsp eg](https://gist.githubusercontent.com/chiefsan/2992da265f70b482f100cf01df961c5b/raw/etsp_10.gif)

Consider an intersection point between <img src="https://gist.githubusercontent.com/chiefsan/2992da265f70b482f100cf01df961c5b/raw/f30fdded685c83b0e7b446aa9c9aa120.svg?invert_in_darkmode&sanitize=true" align=middle width=9.96010619999999pt height=14.15524440000002pt/> and line <img src="https://gist.githubusercontent.com/chiefsan/2992da265f70b482f100cf01df961c5b/raw/2f2322dff5bde89c37bcae4116fe20a8.svg?invert_in_darkmode&sanitize=true" align=middle width=5.2283516999999895pt height=22.831056599999986pt/> of the (L x L)-grid. With probability <img src="https://gist.githubusercontent.com/chiefsan/2992da265f70b482f100cf01df961c5b/raw/72b9d571428656efc952552fd3db3cc9.svg?invert_in_darkmode&sanitize=true" align=middle width=33.09845879999999pt height=27.15900329999998pt/>, <img src="https://gist.githubusercontent.com/chiefsan/2992da265f70b482f100cf01df961c5b/raw/2f2322dff5bde89c37bcae4116fe20a8.svg?invert_in_darkmode&sanitize=true" align=middle width=5.2283516999999895pt height=22.831056599999986pt/> is a level i line <img src="https://gist.githubusercontent.com/chiefsan/2992da265f70b482f100cf01df961c5b/raw/3be60594adefab2632ee2b1e846b7566.svg?invert_in_darkmode&sanitize=true" align=middle width=16.43840384999999pt height=14.15524440000002pt/> an increase in tour length by a maximum of <img src="https://gist.githubusercontent.com/chiefsan/2992da265f70b482f100cf01df961c5b/raw/4f3b7e590d00969a68e15f565cb9a198.svg?invert_in_darkmode&sanitize=true" align=middle width=60.31699244999999pt height=27.15900329999998pt/> (inter-portal distance). Thus, the expected increase in tour length due to this intersection is at most:
<p align="center"><img src="https://gist.githubusercontent.com/chiefsan/2992da265f70b482f100cf01df961c5b/raw/78f8f6ea541995e7fb16b5a9a5177264.svg?invert_in_darkmode&sanitize=true" align=middle width=180.81551894999998pt height=47.93392394999999pt/></p>

Summing over all <img src="https://gist.githubusercontent.com/chiefsan/2992da265f70b482f100cf01df961c5b/raw/5f716e6562eb80aa2bb640335a4c0ac8.svg?invert_in_darkmode&sanitize=true" align=middle width=121.99207514999999pt height=28.511366399999982pt/> intersection points, and applying linearity of expectation, provides the claim.

Usually, we want an error parameter <img src="https://gist.githubusercontent.com/chiefsan/2992da265f70b482f100cf01df961c5b/raw/7ccca27b5ccc533a2dd72dc6fa28ed84.svg?invert_in_darkmode&sanitize=true" align=middle width=6.672392099999992pt height=14.15524440000002pt/> and not <img src="https://gist.githubusercontent.com/chiefsan/2992da265f70b482f100cf01df961c5b/raw/2595d1d8c33a08f1e4e35222e409da67.svg?invert_in_darkmode&sanitize=true" align=middle width=36.80947544999999pt height=28.511366399999982pt/>, but this is no problem as we can choose a parameter <img src="https://gist.githubusercontent.com/chiefsan/2992da265f70b482f100cf01df961c5b/raw/b97f244cf78952df82dc71b511bf1c55.svg?invert_in_darkmode&sanitize=true" align=middle width=41.421106649999984pt height=24.7161288pt/> such that <img src="https://gist.githubusercontent.com/chiefsan/2992da265f70b482f100cf01df961c5b/raw/f7d2f9e63c591c17c423f78cc52fd869.svg?invert_in_darkmode&sanitize=true" align=middle width=70.01137274999999pt height=28.511366399999982pt/>.

__Theorem__: There is a PTAS for the Euclidean TSP problem in <img src="https://gist.githubusercontent.com/chiefsan/2992da265f70b482f100cf01df961c5b/raw/433badc501d4f8a183b14684b47f305e.svg?invert_in_darkmode&sanitize=true" align=middle width=18.424726649999986pt height=26.76175259999998pt/>.

The algorithm can be derandomized by trying all possible shifts and choosing the shortest tour.

---

### References
Schultes, D. (2004). _Euclidean Traveling Salesman Problem_.

Philipp Kindermann. (2020). _An Approximation Scheme for EuclideanTSP_ [slides].

Vazirani, V. V. (2013). _Approximation algorithms_. Springer Science & Business Media.
