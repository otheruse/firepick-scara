include <shapes.scad>


module PnPHead() {
    difference() {
        union() {
            cylinder(d=30, h=34);
            translate([0,0,34])cylinder(d1=30, d2=27, h=2);
            // 
            cylinder(d=25, h=47);
            translate([0,0,36])rotate_extrude()translate([12.5,0])circle(d=2);
            translate([-15,-15,0])roundedCube([30,30,30]);
        }
        // Space for motor
        translate([-10.5,-10.5,2])roundedBox([21,21,30]);
        translate([0,0,4])cylinder(d=26, h=26);
        // front of motor
        translate([0,0,-1])cylinder(d=16, h=49);
        // Slice bottom off
//        translate([0,0,-1])cylinder(d=32, h=6);
        translate([0,0,15])rotate([0,90,0])cylinder(d=18, h=40, center=true);
        translate([0,0,15])rotate([90,90,0])cylinder(d=18, h=40, center=true);
        // Screw holes
        for (i=[-1,1]) {
            for (j=[-1,1]) {
                translate([i*8, j*8, -1])cylinder(d=2.3, h=50);
            }
        }
        
    }
}

PnPHead();
$fs = 0.2;
$fa = 2;
