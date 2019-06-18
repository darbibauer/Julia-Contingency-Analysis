module Wind

    include("pomdp.jl")

    using PowerModels,Grid_class, Reduction, Sz, LightGraphs, FileIO

    function wind_simulation(casename)

        case = string("cases/", casename, ".m")
        rnc = PowerModels.parse_file(case)
        rnc2 = PowerModels.parse_file(case)
        obj = Grid_class.Grid_class_const(rnc, rnc2, casename)

        Grid_class.N_1_analysis(obj);
        Grid_class.N_2_analysis(obj, "fast");
        arr = []
        W_list = Dict()

        # for i in 1:24
        #     if i != 1
        #         obj = Grid_class.Grid_class_const(rnc, rnc2, casename)
        #     end
        #     obj.f = obj.f[:,i]
        #     Grid_class.N_1_analysis(obj);
        #     Grid_class.N_2_analysis(obj, "fast");
        #
        #     loadcase = FileIO.load("str.jld")
        #     loadcase = loadcase["str"]["1"]["W_2"]
        #
        #     W_list["$i"] = loadcase
        #
        #     index_x = findmax(loadcase)
        #     push!(arr, index_x)
        # end

        loadcase = FileIO.load("str.jld")
        loadcase = loadcase["str"]["1"]["W_2"]

         # W_list["$i"] = loadcase
        W_list = loadcase

        W = findmax(loadcase)
        # index_x = W[1][2][1]
        # index_y = W[1][2][2]
        index_x = W[2][1]
        index_y = W[2][2]
        # W = W[2]

        # W = W_list["$W"]
        W = W_list

        g = Graph(length(obj.rnc["bus"]))
        for i in 1:Sz.r(obj.E)
            add_edge!(g, obj.E[i,1], obj.E[i,2])
        end

        A1 = obj.rc_original["branch"][string(index_x)]["f_bus"]
        A2 = obj.rc_original["branch"][string(index_x)]["t_bus"]
        B3 = obj.rc_original["branch"][string(index_y)]["f_bus"]
        B4 = obj.rc_original["branch"][string(index_y)]["t_bus"]

        return pomdp_class.shortest_path(obj, A1, A2, B3, B4), W,  obj
    end

end
