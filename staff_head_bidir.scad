use <list-comprehension-demos/sweep.scad>
use <scad-utils/transformations.scad>
use <scad-utils/shapes.scad>

// $fn = 100;
// pathstep = 0.2;
$fn = 20;
pathstep = 0.5;

dim = 35;
turns = 0.5;

height = 110;
rays = 7;
baseSquare = 7;

function modifyX(x) = pow(x, 1.5);
function func1(x) = dim * sin(180 * x);
function varfunc1(x) = dim * sin(180 * x);
function func4(x) = 720 * x / 2;





module spiral(turns, rays, direction = 1) {
    function xFunc(x) = func1(modifyX(x)) * (sin( 360 * modifyX(x) * turns) + direction * cos(360 * modifyX(x) * turns));
    function yFunc(x) = func1(modifyX(x)) * (sin( 360 * modifyX(x) * turns) - direction * cos(360 * modifyX(x) * turns));

    shape_points = square(baseSquare);
    path_transforms1 = [for (i=[0:pathstep:height]) let(t=i/height) translation([xFunc(t),yFunc(t),i]) * rotation([0,0,func4(t)])];

    for ( i = [0 : rays] ){
        rotate( i * 360 / rays, [0, 0, 1])
        sweep(shape_points, path_transforms1);
    }
}


poleR = 26 / 2;
wall = 3;
ringH = 20;

difference() {
    

    union(){
        cylinder(r=poleR + wall, h=ringH, center=false);

        translate([0,0,-5])    
            spiral(turns, rays, 1);
        
        translate([0,0,-5])    
            spiral(0.125, 5, -1);
    }

    translate([0,0,-1])
        cylinder(r=poleR, h=ringH + 2, center=false);

    translate([0,0,-dim/2])
        cube(size=[dim, dim, dim], center=true);

    d = 74;
    translate([0,0,d/2])
    cube(size=[200,200,d], center=true);
}

// color("red")
// translate([0,0,30])
// // rotate(180, [1,0,0])
// import("modified_gem.stl", convexity=3);