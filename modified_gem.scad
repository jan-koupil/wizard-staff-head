$fn = 100;

difference () {
translate([0,0,-3])
    import("gem.stl", convexity=3);

    cylinder(r=2.8 / 2, h=30, center=false);
    translate([0,0,-50 + 0.005])
        cube([100,100,100], center = true);
}