# Stream-Function
#### Determining Streamlines and Velocity Vectors by Solving the Laplace's Equation for the Stream Function Using Fortran

An incompressible ideal fluid flows steadily between the inlet and outlet of a reservoir.

The Laplace's equation for the stream function is solved using the finite difference method.

![AeQVVU8rT2SePBWLUKhTLQ2H](https://github.com/user-attachments/assets/ee7dafc4-906e-4013-bd58-2a1be92fe01e)

## Equation

$$ \frac{\partial^2 \psi}{\partial x^2} + \frac{\partial^2 \psi}{\partial y^2} = 0 $$

## Velocity

$$ u = \frac{\partial \psi}{\partial y} $$

$$ v = -\frac{\partial \psi}{\partial x} $$

The velocity profile at the inlet and outlet is parabolic.

## Discretization of the Equation

![grRt2JY2ReN3Wf49Qf0T6Wa2](https://github.com/user-attachments/assets/328e6ab2-a4de-4aac-a238-96aa134d705e)

## Velocity Discretization

$$
u(i,j) = \frac{\psi_{i,j+1} - \psi_{i,j-1}}{2 \Delta y}
$$

$$
v(i,j) = -\frac{\psi_{i+1,j} - \psi_{i-1,j}}{2 \Delta x}
$$
