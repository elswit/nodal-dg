// Gmsh project created on Sat Oct  3 20:58:56 2020
//+
Point(1) = {0, -5, 0, 1.0};
//+
Point(2) = {0, 5, 0, 1.0};
//+
Point(3) = {10, -5, 0, 1.0};
//+
Point(4) = {10, 5, 0, 1.0};
//+
Line(1) = {1, 3};
//+
Line(2) = {3, 4};
//+
Line(3) = {4, 2};
//+
Line(4) = {2, 1};
//+
Curve Loop(1) = {4, 1, 2, 3};
//+
Plane Surface(1) = {1};
