include <shapes.scad>
include <configuration.scad>

arm1_length = 150;
arm2_length = 150;
connector_length = 60;
connector_dia = Drive_pipe_OD + 12;
tool_dia = 30;

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

module Joint(height = 45) {
    // 608zz
    bearing_od = 22;
    bearing_id = 8;
    bearing_h = 7;
   
    difference() {
        cylinder(d = connector_dia, h=height);
        // bolt hole
        translate([0,0,-1])cylinder(d=nutDia(bearing_id)+2, h = connector_dia + 10 + 2);
        // bearing hole
        cylinder(d=bearing_od + 0.3, h = bearing_h);
        translate([0,0,height - bearing_h])cylinder(d=bearing_od + 0.3, h = bearing_h);
    }
    
}

module TeardropBar(diameter = connector_dia, height = 45, length = arm1_length) {
    difference() {
        hull() {
            translate([0,0,diameter/2-diameter/9])rotate([0,90,0])cylinder(d=diameter, h = length);
            translate([0,0,height-0.5])rotate([0,90,0])cylinder(d=1, h = length);
        }
        translate([0,-diameter/2,-diameter/9])cube([length, diameter, diameter/9]);
    }
}

module TeardropHollowBar(diameter = connector_dia, height = 45, length = arm1_length) {
       difference() {
            TeardropBar(diameter = diameter, height = height, length = length);
            translate([0,0,3])TeardropBar(diameter = diameter-6, height = height - 8, length = arm1_length);
        }
 }


module Arm1() {
    PipeConnector();
    translate([arm1_length,0,0])Joint(height = 40);
    difference() {
        // Arm
        TeardropHollowBar(diameter = connector_dia, height = 40, length = arm1_length);
        // pipeconnector inside
        translate([0,0,-1])cylinder(d = Drive_pipe_OD, h = connector_length + 2);
        // nut holes
        rotate([0,0,60]) {
            translate([0,0,8])TightenerScrewHoles();
            translate([0,0,connector_length - 8])TightenerScrewHoles();
        }
        // space for joint
        translate([arm1_length,0,0])cylinder(d=connector_dia-1, h=connector_length);
    }
}

module Arm2() {
    dia = 24;
    height = 30;
    bearing_id = 8;
    difference() {
        // Arm
        union() {
            TeardropHollowBar(diameter = dia, height = height, length = arm2_length);
            hull() {
                translate([0,7,13])rotate([0,90,0])cylinder(d=8, h = arm2_length);
                translate([0,8,5])rotate([0,90,0])cylinder(d=1, h = arm2_length);
            }
            mirror([0,1,0])hull() {
                translate([0,7,13])rotate([0,90,0])cylinder(d=8, h = arm2_length);
                translate([0,8,5])rotate([0,90,0])cylinder(d=1, h = arm2_length);
            }
        }
        // long screw holes
        translate([-1,7,13])rotate([0,90,0])cylinder(d=boltDia(3), h = arm2_length+2);
        translate([-1,-7,13])rotate([0,90,0])cylinder(d=boltDia(3), h = arm2_length+2);
        // space for joint connector
        translate([0,0,-1])cylinder(d = dia-1, h = connector_length + 2);
        // space for tool
        translate([arm2_length,0,0])cylinder(d=connector_dia-1, h=connector_length);
        // slice sharp edged off 
        translate([arm2_length-14,-30,0])cube([8,60,30]);
        // Nut slots
        translate([arm2_length - 22, 0, 0]) {
            hull() {
                translate([0,8,13])rotate([0,90,0])rotate([0,0,30])cylinder(d=nutSlot(3), h = nutHeight(3), $fn=6);
                translate([0,15,13])rotate([0,90,0])cylinder(d=nutSlot(3), h = nutHeight(3), $fn=6);
            }
            mirror([0,1,0])hull() {
                translate([0,8,13])rotate([0,90,0])rotate([0,0,30])cylinder(d=nutSlot(3), h = nutHeight(3), $fn=6);
                translate([0,15,13])rotate([0,90,0])cylinder(d=nutSlot(3), h = nutHeight(3), $fn=6);
            }
        }

    }
    // joint side
    difference() {
        cylinder(d = dia, h = height);
        // bore hole
        translate([0,0,-1])cylinder(d = bearing_id, h = connector_length + 2);
        // nut hole
        translate([0,0,-2])cylinder(d = nutDia(bearing_id), h = nutHeight(bearing_id), $fn=6);
    }

}

$fs = 0.2;
$fa = 2;

translate([0,50,0])Arm1();

Arm2();

//Fastener();