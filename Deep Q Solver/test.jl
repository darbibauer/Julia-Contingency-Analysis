push!(LOAD_PATH, ".")
include("pomdp.jl")

using Sz, Reduction, Grid_class, Wind, PowerModels, JLD, DeepQLearning
using LightGraphs, Random, Parameters, RLInterface, Flux, POMDPs, StatsBase
using POMDPModelTools, POMDPModels, POMDPSimulators, Convex

PowerModels.silence()

shortest_path, W, obj, contingencies = Wind.wind_simulation("cas")

contingencies

num_buses = length(obj.rnc["bus"])

sz = length(obj.E[:,1])
for i in 1:sz
    obj.E = vcat(obj.E, [obj.E[i,2] obj.E[i,1]])
end

ACTION_SET = pomdp_class.create_set(shortest_path[1], num_buses)
initial_state = Random.rand(1:num_buses)
initial_actions = ACTION_SET[initial_state]
initial_prev_action = initial_actions[Random.rand(1:length(initial_actions))]
c1 = shortest_path[2][1]
c2 = shortest_path[2][end]

rewards_arr = pomdp_class.reward_calculator(obj.E, W, c1, c2, obj)

pomdp_problem = pomdp_class.PowerGridEnv(ACTION_SET, initial_state, initial_prev_action, initial_actions, false, false,
                     c1, c2, rewards_arr, [], .2)

model = Chain(Dense(1, length(ACTION_SET)), Dense(length(ACTION_SET), length(ACTION_SET)))

solver = pomdp_class.DeepQLearningSolver(qnetwork = model, max_steps=1000,
                             learning_rate=0.005,log_freq=500, double_q=false,
                             dueling=false)

env = POMDPEnvironment(pomdp_problem, rng=solver.rng)

policy = pomdp_class.NNPolicy(pomdp_problem, model,
                                pomdp_class.actions(pomdp_problem),
                                length(pomdp_class.obs_dimensions(pomdp_problem)))

solved = pomdp_class.solve(solver, env, model, policy)

simul = HistoryRecorder(max_steps=43)

up = pomdp_class.HistoryUpdater(pomdp_problem)
r = simulate(simul, pomdp_problem, solved[1], up)

c1 in r.state_hist
140 in r.state_hist

c2 in r.state_hist
137 in r.state_hist

# using GraphPlot

# nodelabel = [i for i in 1:num_buses]
# gplot(shortest_path[1], nodelabel = nodelabel)
# r.state_hist

# for i in r.state_hist
#     println(i)
# end
