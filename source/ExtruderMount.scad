include <configuration.scad>
include <shapes.scad>

module BowdenAdapter() {
    width = 78;
    length = 28;

    difference() {
        translate([0,-width/2,0])union() {
            // base
            roundedBox([length, width, 5], radius = 3);
            translate([length/2,width/2,0])cylinder(d=15, h=10.5);
         }
        // M6 nut space
        translate([length/2,0,10.5-nutHeight(6)])cylinder(d=nutDia(6), h=30, $fn=6);
        // Slot for bowden tube
        hull() {
            translate([length/2,0,-1])cylinder(d=6.5, h=30);
            translate([length,0,-1])cylinder(d=6.5, h=30);
        }
        // screw holes
        for (i=[-25,25]) {
            translate([length/2,i,-1])cylinder(d=m4_dia, h=32);
        }
    }
}

module ExtruderMount(base_thickness = 18) {
    width = 78;
    length = 50;
    thickness = 5;

    translate([0,0,length])rotate([0,90,0])difference() {
        translate([0,-width/2,0])union() {
            // base
            roundedBox([length, width, thickness], radius = 3);
            translate([0,0,base_thickness + thickness])roundedBox([length, width, thickness], radius = 3);
            translate([length-7-10-thickness-m4_dia,0,0])cube([thickness, width, 2*thickness + base_thickness]);
        }
        // slice part off of top
        translate([-1,-width/2-1,base_thickness+thickness-1])cube([length-7-10-thickness-m4_dia+1, width+2, thickness +2]);
        // Slot for bowden tube
        hull() {
            translate([0,0,-1])cylinder(d=6.5, h=30);
            translate([14,0,-1])cylinder(d=6.5, h=30);
        }
        // screw holes
        for (i=[-25,25]) {
            translate([14,i,-1])cylinder(d=m4_dia, h=thickness + 2);
            translate([length-6,i,-1])cylinder(d=m4_dia, h=2*thickness  + base_thickness + 2);
        }
    }
}
//$fs=0.4;
//$fa=3;
//translate([-40,0,0])BowdenAdapter();
//
//ExtruderMount(19);