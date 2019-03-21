push!(LOAD_PATH, ".")
using Grid_class, Sz, Reduction, PowerModels

PowerModels.silence()

rnc = PowerModels.parse_file("cases/case200.m")

obj = Grid_class.Grid_class_const(rnc,"case200")

# Grid_class.N_2_analysis(obj, "fast")

Reduction.remove_leafes(obj.E,obj.C,obj.P,obj.gr_bus,obj.x,obj.lim,obj.oldf,obj.rnc)
