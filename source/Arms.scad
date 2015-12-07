include <shapes.scad>
include <configuration.scad>

arm1_length = 150;
connector_length = 55;
connector_dia = Drive_pipe_OD + 12;

module TightenerScrewHoles() {
    for(a=[00:120:359]) {
        // screw hole
        rotate([0,90,a])cylinder(d=m4_dia, h=connector_dia);
        // nut hole
        rotate([0,90,a])cylinder(d=m4_nut_dia, h=Drive_pipe_OD/2+m4_nut_height, $fn=6);
        // screw head hole
        rotate([0,90,a])translate([0,0,connector_dia/2])cylinder(d=m4_nut_dia, h=20);
    }
}

module PipeConnector() {
    difference() {
        cylinder(d = connector_dia, h = connector_length);
        // inside
        translate([0,0,-1])cylinder(d = Drive_pipe_OD, h = connector_length + 2);
        // nut holes
        rotate([0,0,60]) {
            translate([0,0,8])TightenerScrewHoles();
            translate([0,0,connector_length - 8])TightenerScrewHoles();
        }
    }
}

module Fastener() {
    // 625zz
    bearing_od = 16;
    bearing_id = 5;
    bearing_h = 5;
   
    height = connector_dia + 10;
    difference() {
        cylinder(d = connector_dia, h=height);
        // bolt hole
        translate([0,0,-1])cylinder(d=nutDia(5)+2, h = connector_dia + 10 + 2);
        // bearing hole
        cylinder(d=bearing_od + 0.3, h = bearing_h);
        translate([0,0,height - bearing_h])cylinder(d=bearing_od + 0.3, h = bearing_h);
    }
    
}

module Arm1() {
    union() {
        PipeConnector();
        translate([arm1_length,0,10])Fastener();
        difference() {
            translate([0,0,connector_length-connector_dia/2 - 5])difference() {
                // arm
                rotate([0,90,0])cylinder(d=connector_dia + 10, h = arm1_length);
                // slice off sides
                translate([0, connector_dia/2, -connector_dia/2 - 5])cube([arm1_length, connector_dia, connector_dia + 10]);
                translate([0, -connector_dia*1.5, -connector_dia/2-5])cube([arm1_length, connector_dia, connector_dia + 10]);
            }
            // inside
            translate([0,0,-1])cylinder(d = Drive_pipe_OD, h = connector_length + 2);
            // nut holes
            rotate([0,0,60]) {
                translate([0,0,8])TightenerScrewHoles();
                translate([0,0,connector_length - 8])TightenerScrewHoles();
            }
            translate([arm1_length,0,0])cylinder(d=connector_dia-1, h=connector_length);
        }
    }
}

$fs = 0.2;
$fa = 2;

Arm1();
//Fastener();