include <shapes.scad>
include <configuration.scad>

module ElbowJoint(height = 45, bearing_od = 22, bearing_id = 8, bearing_h = 7) {
    difference() {
        cylinder(d = 34, h=height);
         // bolt hole
        translate([0,0,-1])cylinder(d=nutDia(bearing_id)+2, h = 34 + 10 + 2);
        // bearing hole
        cylinder(d=bearing_od + 0.3, h = bearing_h);
        translate([0,0,height - bearing_h])cylinder(d=bearing_od + 0.3, h = bearing_h);
    }
    // print support
    color([1,0,0,1])translate([0,0,bearing_h])cylinder(d=bearing_od + 0.3, h = print_layer_height);
    
}

module TeardropBar(diameter, height = 45, length) {
    difference() {
        hull() {
            translate([0,0,diameter/2-diameter/9])rotate([0,90,0])cylinder(d=diameter, h = length);
            translate([0,0,height-0.5])rotate([0,90,0])cylinder(d=1, h = length);
        }
        translate([0,-diameter/2,-diameter/9])cube([length, diameter, diameter/9]);
    }
}

module TeardropHollowBar(diameter, height = 45, length) {
       difference() {
            TeardropBar(diameter = diameter, height = height, length = length);
            translate([0,0,3])TeardropBar(diameter = diameter-6, height = height - 8, length = length);
        }
 }


module TightenerScrewHoles(pipe_dia) {
    for(a=[00:120:359]) {
        // screw hole
        rotate([0,90,a])cylinder(d=m4_dia, h=pipe_dia);
        // nut hole
        rotate([0,90,a])cylinder(d=m4_nut_dia, h=Drive_pipe_OD/2+m4_nut_height, $fn=6);
        // screw head hole
        rotate([0,90,a])translate([0,0,pipe_dia/2])cylinder(d=m4_nut_dia, h=20);
    }
}


module Arm1(arm_length = 150, connector_length = 60, connector_dia = Drive_pipe_OD + 12) {
    // 608zz
    elbow_bearing_h = 7;
    elbow_bearing_od = 22;
    elbow_bearing_id = 8;
    // 608zz
    shoulder_bearing_h = 7;
    shoulder_bearing_od = 22;
    shoulder_bearing_id = 8;
    translate([arm_length,0,0])ElbowJoint(height = 40, bearing_od = elbow_bearing_od, bearing_id = elbow_bearing_id, bearing_h = elbow_bearing_h);
    difference() {
        union() {
            // Arm
            TeardropHollowBar(diameter = connector_dia, height = 40, length = arm_length);
            // Pipe connector
            cylinder(d = connector_dia, h = connector_length);
            // support for screws 
            intersection() {
                TeardropBar(diameter = connector_dia, height = 40, length = arm_length);
                for(a=[60:120:359]) {
                    translate([0,0,16])rotate([0,90,a])translate([0,0,connector_dia/2])cylinder(d=m4_nut_dia+6, h=20);

                }
            }
        }
        // grooves for alignment
        translate([0,18,connector_length/2])rotate([0,0,45])cube(size=[2,2,connector_length+2], center=true);
        translate([0,-18,connector_length/2])rotate([0,0,45])cube(size=[2,2,connector_length+2], center=true);
        translate([0,0,-1])rotate([0,45,0])cube(size=[2,connector_dia + 2,2], center=true);
        
        // pipeconnector inside
        translate([0,0,shoulder_bearing_h])cylinder(d = Drive_pipe_OD, h = connector_length);
        // bearing inside
        cylinder(d = shoulder_bearing_od + 0.3, h = shoulder_bearing_h);
        // break
        translate([0,0,shoulder_bearing_h + 1])rotate_extrude()translate([shoulder_bearing_od/2,0])circle(d=2);
        // nut holes
        rotate([0,0,60]) {
            translate([0,0,16])TightenerScrewHoles(pipe_dia = connector_dia);
            translate([0,0,connector_length - 8])TightenerScrewHoles(pipe_dia = connector_dia);
        }
        // space for elbow joint
        translate([arm_length,0,0])cylinder(d=connector_dia-1, h=connector_length);
    }
}

module Arm2(arm_length = 150) {
    dia = 24;
    height = 30;
    elbow_bearing_id = 8;
    difference() {
        // Arm
        union() {
            TeardropHollowBar(diameter = dia, height = height, length = arm_length);
            hull() {
                translate([0,7,13])rotate([0,90,0])cylinder(d=8, h = arm_length);
                translate([0,8,5])rotate([0,90,0])cylinder(d=1, h = arm_length);
            }
            mirror([0,1,0])hull() {
                translate([0,7,13])rotate([0,90,0])cylinder(d=8, h = arm_length);
                translate([0,8,5])rotate([0,90,0])cylinder(d=1, h = arm_length);
            }
        }
        // long screw holes
        translate([-1,7,13])rotate([0,90,0])cylinder(d=boltDia(3), h = arm_length+2);
        translate([-1,-7,13])rotate([0,90,0])cylinder(d=boltDia(3), h = arm_length+2);
        // space for elbow joint connector
        translate([0,0,-1])cylinder(d = dia-1, h = height + 2);
        // space for tool
        translate([arm_length,0,0])cylinder(d=tool_dia-1, h=height);
        // slice sharp edged off 
        translate([arm_length-11,-30,0])cube([8,60,30]);
        // Nut slots
        translate([arm_length - 22, 0, 0]) {
            hull() {
                translate([0,8,13])rotate([0,90,0])rotate([0,0,30])cylinder(d=nutDia(3), h = nutHeight(3), $fn=6);
                translate([0,15,13])rotate([0,90,0])cylinder(d=nutDia(3), h = nutHeight(3), $fn=6);
            }
            mirror([0,1,0])hull() {
                translate([0,8,13])rotate([0,90,0])rotate([0,0,30])cylinder(d=nutDia(3), h = nutHeight(3), $fn=6);
                translate([0,15,13])rotate([0,90,0])cylinder(d=nutDia(3), h = nutHeight(3), $fn=6);
            }
        }

    }
    module arrow(d = 1) {
        dd = sqrt(0.75*d*d);
         polyhedron(points=[[dd,0,0], [0,-d/2,0], [0,d/2,0], [0,0,dd]], faces=[[0,2,1], [0,1,3], [2,0,3], [1,2,3]]);
   }
    
    // joint side
    difference() {
        union() {
            cylinder(d = dia, h = height);
            rotate([0,0,90])translate([dia/2-1, 0, 0])arrow(d=5);
            rotate([0,0,-90])translate([dia/2-1, 0, 0])arrow(d=5);
        }
        // bore hole
        translate([0,0,-1])cylinder(d = elbow_bearing_id, h = height + 2);
        // nut hole
        translate([0,0,-2])cylinder(d = nutDia(elbow_bearing_id), h = nutHeight(elbow_bearing_id), $fn=6);
    }
    // print support
    color([1,0,0,1])translate([0,0,nutHeight(elbow_bearing_id)-2])cylinder(d = elbow_bearing_id, h = print_layer_height);

}

module ElbowNutSpacer() {
    translate([75,-30,0])difference() {
        cylinder(d = 13, h=40-2*7-8*0.8*2+2);
        cylinder(d = 9, h=40-2*7-8*0.8*2+2);
    }
}

//$fs = 0.2;
//$fa = 2;
//
//translate([0,50,0])
//Arm1();
//
//Arm2();


