# Direct-Stiffness-Method-Solver-for-2D-Structures

**The .mlx file has provided a Comprehensive Instruction on how to use the program.**

The creator has tested the program with several Model Problems (see folder) with the comparison of the results from Commercial Software such as Tekla Tedds and RISA.

Users are encouraged to explore the program and feel free to add any features needed.

The Boundary_Process.m file has provided a General method for processing Stiffness Matrix with applied Eccential and Nature Boundary Conditions and is ready to be implemented into Finite Element Solver.

## Program Feature

### Graphic Illustration

<img width="1676" height="621" alt="Ilustration" src="https://github.com/user-attachments/assets/23b06e4a-17a5-4935-b876-e676a8086026" />

### Element Internal Force Diagram

<img width="1689" height="688" alt="Element Diagram" src="https://github.com/user-attachments/assets/c31e67d9-312f-48b2-8dd7-b4cc45688772" />



## Supported Problem Definition

### Deformation

Axial

Lateral Bending

### Element

Frame

Frame with Hinge on One End

Truss (Frame with Hinge on Both Ends)

### Eccentrail Boundary

Nodal Support (Arbitary Direction)

Nodal Movement

### Natural Boundary

Nodal Load

Element Load

## Function List
### Solver
DSM_Solver.mlx
### Computation
Boundary_Process.m

Element_Force_Vector.m

Element_Stiffness_Matrix.m

Global_Boundary_Force_Vector.m

Global_Boundary_Reaction.m

Global_Displacement.m

Global_Force_Vector.m

Global_Hinge_Check.m

Global_Stiffness_Matrix.m

Stability_Check.m

### Graph
Element_Diagram_Integral.m

Element_Force_Diagram.m

Graph_Boundary.m

Graph_Highlight_Element.m

Graph_Initial.m

Graph_Token_Process.m
