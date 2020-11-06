// Gmsh project created on Sun Oct  4 01:05:03 2020
SetFactory("OpenCASCADE");
//+
Rectangle(1) = {-0.2, -0.2, 0, 2.2, 0.41, 0};
//+
Circle(5) = {0, 0, 0, 0.05, 0, 2*Pi};//+
Curve Loop(2) = {5};
//+
Plane Surface(2) = {2};
//+
BooleanDifference{ Surface{1}; Delete; }{ Surface{2}; Delete; }
//+
Physical Curve("In", 111) = {7};
//+
Physical Curve("out", 222) = {8};
//+
Physical Curve("wall", 333) = {6, 9};
//+
Physical Curve("cal", 888) = {5};
//+
Physical Surface("domain", 777) = {1};
