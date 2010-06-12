import Blender
paths = Blender.GetPaths(1)
for f in paths:
	print "dependency: %s" % f
