use <list-comprehension-demos/sweep.scad>
use <scad-utils/transformations.scad>
use <scad-utils/shapes.scad>

$fn = 100;

dim = 35;
turns = 0.5;
function modifyX(x) = pow(x, 1.5);
// function func0(x)= 1;
function func1(x) = dim * sin(180 * x);
//function xFunc(x) = func1(x)
function varfunc1(x) = dim * sin(180 * x);
function xFunc(x) = func1(modifyX(x)) * (sin( 360 * modifyX(x) * turns) + cos(360 * modifyX(x) * turns));
function yFunc(x) = func1(modifyX(x)) * (sin( 360 * modifyX(x) * turns) - cos(360 * modifyX(x) * turns));
// function func2(x) = -dim * sin(180 * x);
// function func3(x) = (sin(270 * (1 - x) - 90) * sqrt(6 * (1 - x)) + 2);
function func4(x) = 720 * x / 2;
// function func5(x) = 2 * 180 * x * x * x;
// function func6(x) = 3 - 2.5 * x;

pathstep = 0.2;
height = 110;

shape_points = square(7);
path_transforms1 = [for (i=[0:pathstep:height]) let(t=i/height) translation([xFunc(t),yFunc(t),i]) * rotation([0,0,func4(t)])];
// path_transforms1 = [for (i=[0:pathstep:height]) let(t=i/height) translation([func1(t),varfunc1(t),i]) * rotation([0,0,func4(t)])];
// path_transforms2 = [for (i=[0:pathstep:height]) let(t=i/height) translation([func2(t),func2(t),i]) * rotation([0,0,func4(t)])];
// path_transforms3 = [for (i=[0:pathstep:height]) let(t=i/height) translation([func1(t),func2(t),i]) * rotation([0,0,func4(t)])];
// path_transforms4 = [for (i=[0:pathstep:height]) let(t=i/height) translation([func2(t),func1(t),i]) * rotation([0,0,func4(t)])];

n = 7;


module spiral() {
    for ( i = [0 : n] ){
        rotate( i * 360 / n, [0, 0, 1])
        sweep(shape_points, path_transforms1);
    }
}


// sweep(shape_points, path_transforms2);
// sweep(shape_points, path_transforms3);
// sweep(shape_points, path_transforms4);


// path_transforms5 = [for (i=[0:pathstep:height]) let(t=i/height) translation([0,0,i]) * scaling([func3(t),func3(t),i]) * rotation([0,0,func4(t)])];
// translate([100, 0, 0]) sweep(shape_points, path_transforms5);


// path_transforms6 = [for (i=[0:pathstep:height]) let(t=i/height) translation([0,0,i]) * scaling([func6(t),func6(t),i]) * rotation([0,0,func5(t)])];
// translate([-100, 0, 0]) sweep(shape_points, path_transforms6);

// spiral();

poleR = 26 / 2;
wall = 3;
ringH = 20;

difference() {
    

    union(){
        cylinder(r=poleR + wall, h=ringH, center=false);

        translate([0,0,-5])    
            spiral();
        
    }

    translate([0,0,-1])
        cylinder(r=poleR, h=ringH + 2, center=false);

    translate([0,0,-dim/2])
        cube(size=[dim, dim, dim], center=true);
}

color("red")
translate([0,0,30])
// rotate(180, [1,0,0])
import("modified_gem.stl", convexity=3);