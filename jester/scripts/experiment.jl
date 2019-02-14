using TSVD, JLD; srand(1)
include("functions.jl")

println("Starting experiments.....")
####################
## Data
####################
mask = load("../output/mask.jld")["mask"]
sqrtW = sqrt.(biased_projection(mask, 1))
d1, d2 = size(mask)
ranks, n_trials, SVD_err, dSVD_err = 1:10, 50, [], []

####################
## Run experiment
####################
for rank in ranks
    println("Rank r = $(rank)........")
    Xs = [get_random(d1, d2, rank) for _ in 1:num_trials]
    curr_SVD_err, curr_dSVD_err = 0, 0
    for trial in 1:num_trials
    	Ys = [mask .* (X[trial] + randn(d1, d2)) for _ in 1:num_trials] 
    	SVD_errs = mean(vecnorm(sqrtW .* (X[trial] - biased_projection(Y, rank))) for Y in Ys)
	dSVD_errs = mean(vecnorm(sqrtW .* (X[trial] - biased_projection(Y, rank))) for Y in Ys)
	curr_SVD_err += SVD_errs / vecnorm(sqrtW)
	curr_dSVD_err += dSVD_errs / vecnorm(sqrtW)
    end	
    push!(SVD_err, curr_SVD_err); push!(dSVD_err, curr_dSVD_err)
end
save("../output/experiment-output.jld", "SVD_err", SVD_err, "dSVD_err", dSVD_err, "ranks", ranks)


    
    
