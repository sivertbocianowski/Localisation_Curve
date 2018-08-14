from dolfin import *
import numpy as np

class E(Expression):
	def __init__(self, R, **kwargs):
		self.R = R
		self.N = len(R)
	
	def eval(self, value, x):
		value[0] = self.R[int(x[0]*self.N)][int(x[1]*self.N)]

if __name__=="__main__":
	R = np.random.rand(16,16)
	eps = E(R, degree=0)
