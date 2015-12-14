include <configuration.scad>
include <platform.scad>
include <motorMount.scad>
include <driveWheel.scad>
include <ZMount.scad>
include <pipeSupport.scad>
include <BedStabilizerBracket.scad>
include <BedArm.scad>
include <BearingScrew.scad>
include <limitSwitchHolder.scad>
include <Arms.scad>
include <HotendMount.scad>

base_thickness = 10;
module assembly() {
    // base 
    render()linear_extrude(base_thickness)base();
    // platform
    translate([0,0,platform_height + base_thickness])rotate([0,0,180])render()linear_extrude(base_thickness)platform();
    // motor mounts
    color([0.7,0,0,1])render()for (i=[1,-1]) {
        translate([i*(rodspacing/2-10),-60, base_thickness])rotate([90+i*45,-90,0])MotorMount(Height=60+i*10);
    }
    // limit switch holders
    translate([rodspacing/2, 0, base_thickness+100])rotate([180,0,180])render()limitSwitchHolder();
    translate([-rodspacing/2, 0, base_thickness+35])render()limitSwitchHolder();
    // Zmount bottom
    color([0,0,0.5,1])render()translate([0,0,base_thickness])ZMountBottom(rodspacing = rodspacing, rodsize = rod_diameter, thickness = 3);
    // Zmount top
    color([0,0,0.5,1])translate([0,0,platform_height + base_thickness])rotate([180,0,180])render()ZMountTop(rodspacing = rodspacing, rodsize = rod_diameter, thickness = 3);
    // drive wheels
    color([0,0.5,0,1])render() {
        translate([0,0,base_thickness + 65])rotate([0,180,0])beltWheelRod(75);
        translate([0,0,base_thickness + 70])beltWheelTube(75);
    }
    // Pipe supports
    color([1,0.7,1,1]) {
        // long support bottom
        translate([-150,0,base_thickness])render()pipeSupportLong();
        translate([150,0,base_thickness])rotate([0,0,90])render()pipeSupportLong();
        // long support top
        translate([20,130,platform_height + base_thickness])rotate([0,0,270])mirror([0,0,1])render()pipeSupportLong();
        translate([-20,130,platform_height + base_thickness])rotate([0,0,180])mirror([0,0,1])render()pipeSupportLong();
        // short support bottom
        translate([-140,160,base_thickness])rotate([0,0,180])render()pipeSupportShort();
        translate([140,160,base_thickness])rotate([0,0,180])render()pipeSupportShort();
        // short support top
        translate([-140,0,platform_height + base_thickness])mirror([0,0,1])render()pipeSupportShort();
        translate([140,0,platform_height + base_thickness])mirror([0,0,1])render()pipeSupportShort();
    }
    // Bed
    translate([0,0,300]) {
        // bed bracket
        rotate([0,180,180])render()ZMountBracket(bearing_diameter = bearing_diameter, bearing_length = bearing_length);
        // Bed arms
        for (i=[1,-1]) {
            translate([i*rodspacing/2,0,0])rotate([0,180,180])render()BedArm(bearing_diameter = bearing_diameter, bearing_length = bearing_length);
        }
        // Bearing screw
        translate([0,40,-4])rotate([0,0,120])mirror([0,0,1])render()BearingScrew(axis_dia = 8, bearing_od=13, bearing_id=4, bearing_h=5, lead = 16);    
        // Bearing screw
//        translate([0,40,0])rotate([0,0,120])render()BearingScrew(axis_dia = 8, bearing_od=13, bearing_id=4, bearing_h=5, lead = 16);    
    }
    // Arms
    translate([0,0,platform_height +base_thickness*2 + 70])rotate([180,0,-90])render()Arm1();
    translate([0,-arm1_length,platform_height +base_thickness*2 + 28])rotate([180,0,-90])render()Arm2();
    // Tool head
    translate([0,-arm1_length-arm2_length,platform_height +base_thickness*2])rotate([0,0,90])render() {
        translate([0,0,37])rotate([180,0,0])E3DMount();
        rotate([0,0,180])E3DMountClamp();
    }

    // Rods & pipes
    color([0.7,0.7,0.7,0.5]) {
        // axes
        for (i=[1,-1]) {
            translate([i*rodspacing/2, 0, base_thickness+3])cylinder(d=rod_diameter, h=platform_height-6);
        }
        // drive pipe
        translate([0, 0, base_thickness + 70])cylinder(d=Drive_pipe_OD, h=430);
        // drive rod
        translate([0, 0, 0])cylinder(d=8, h=600);
        // elbow rod
        translate([0,-arm1_length,platform_height +base_thickness*2 -10])cylinder(d=8, h=100);
        // Z screw
        translate([0, 40, 100 + base_thickness])cylinder(d=8, h=310);
        // support pipes
        translate([-150,0,base_thickness])pipe(PipeOD = PVC_pipe_OD, pipeLength = platform_height, target_x = 130, target_y = 130, target_z=platform_height);
        translate([150,0,base_thickness])rotate([0,0,90])pipe(PipeOD = PVC_pipe_OD, pipeLength = platform_height, target_x = 130, target_y = 130, target_z=platform_height);
        translate([-140,160,base_thickness])rotate([0,0,180])pipe(PipeOD = PVC_pipe_OD, pipeLength = platform_height, target_x = 0, target_y = 160, target_z=platform_height);
        translate([140,160,base_thickness])rotate([0,0,180])pipe(PipeOD = PVC_pipe_OD, pipeLength = platform_height, target_x = 0, target_y = 160, target_z=platform_height);
    }

}
$fs = 1;
$fa = 6;

assembly();