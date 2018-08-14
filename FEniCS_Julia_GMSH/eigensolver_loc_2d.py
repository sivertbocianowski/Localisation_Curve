from dolfin import *
import numpy as np
from scipy import linalg, matrix
import Eclass2


def boundary(x, on_boundary):
    return on_boundary

#mesh_file = 'levy.xml'
#curve_file = 'levy_facet_region.xml'

#mesh = Mesh(mesh_file)
#f = MeshFunction('size_t', mesh, curve_file)

mesh = UnitSquareMesh(32,32)
V = FunctionSpace(mesh, "Lagrange", 1)
    
u = TrialFunction(V)
v = TestFunction(V)

bc =DirichletBC(V, Constant(0), boundary)

R = np.random.rand(16,16)
E = Eclass2.E(R, degree=0)
eps1 = 1E+5
eps = Constant(eps1)

a = inner(grad(u), grad(v))*dx + inner(eps*E*u, v)*dx
b = inner(u, v)*dx
L = inner(Constant(0), v)*dx

import matplotlib.pyplot as plt

A = PETScMatrix()
assemble(a, tensor=A)


# Create eigensolver
eigensolver = SLEPcEigenSolver(A)

# Compute all eigenvalues of A x = \lambda x
print("Computing eigenvalues. This can take a minute.")
eigensolver.solve()

# Extract largest (first) eigenpair
r, c, rx, cx = eigensolver.get_eigenpair(0)

print("Largest eigenvalue: ", r)

# Initialize function and assign eigenvector
u = Function(V)
u.vector()[:] = rx

# Plot eigenfunction
plot(u, title="Eigenfunction with random potential \n E is 16x16 and eps is: " + str(int(eps1)) + ".")
plt.show()


