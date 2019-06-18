function reward_calculator(E, W, c1, c2)
  physical_impact_val = zeros(Sz.r(E))
  security_index = zeros(Sz.r(E))
  reward_val =  zeros(Sz.r(E))

  discount_factor = .9

  s_prime = 0

  for i in 1:Sz.r(E)
    transition_probability = pomdp_class.transition_probability()
    physical_impact_val[i] = physical_impact(W, E[i,1], E[i,2])

    security_index[i] = (physical_impact_val[i] + s_prime) * transition_probability * discount_factor
    reward_val[i] = (physical_impact_val[i] + s_prime) * transition_probability
    s_prime = security_index[i]
  end
  reward_val = reward_val ./ sum(reward_val)

  maximum_val = findmax(reward_val)[1]

  for i in 1:size(reward_val)[1]
    if E[i,1] == c1 || E[i,1] == c2
      reward_val[i] = 2 * maximum_val
    elseif E[i,2] == c1 || E[i,2] == c2
      reward_val[i] = 2 * maximum_val
    end
  end
  return hcat(E, reward_val)
end

function s_a_reward(pomdp, s, a)
  for j in 1:size(pomdp.rewards_arr)[1]
      if pomdp.rewards_arr[j,1] == s && pomdp.rewards_arr[j,2] == a
          return pomdp.rewards_arr[j,3]
      elseif pomdp.rewards_arr[j,2] == s && pomdp.rewards_arr[j,1] == a
          return pomdp.rewards_arr[j,3]
      end
  end
  return 0.
end

function potential_rewards(pomdp::PowerGridEnv, s)
  rewards = Float64[]
  for i in 1:length(pomdp.actions)
    push!(rewards, pomdp_class.s_a_reward(pomdp, s, pomdp.actions[i]))
  end
  return rewards
end