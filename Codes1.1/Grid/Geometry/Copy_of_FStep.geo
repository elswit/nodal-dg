// Gmsh project created on Fri Oct  2 22:29:21 2020
//+
Point(1) = {0, 0, 0, 1.0};
//+
Point(2) = {0.5, 0, 0, 1.0};
//+
Point(4) = {0, 1, 0, 1.0};
//+
Point(5) = {3, 0.2, 0, 1.0};
//+
Point(6) = {3, 1, 0, 1.0};
//+
Point(7) = {0.5, 0.2, 0, 1.0};
//+
Line(1) = {1, 2};
//+
Line(2) = {2, 7};
//+
Line(3) = {7, 5};
//+
Line(4) = {5, 6};
//+
Line(5) = {6, 4};
//+
Line(6) = {4, 1};
//+
Curve Loop(1) = {5, 6, 1, 2, 3, 4};
//+
Plane Surface(1) = {1};
//+
Physical Curve("Inflow", 111) = {6};
//+
Physical Curve("Outflow", 222) = {4};
//+
Physical Curve("Wall", 333) = {1, 2, 3, 5};
//+
Physical Surface("Domain", 777) = {1};
