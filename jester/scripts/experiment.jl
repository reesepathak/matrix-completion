using JLD; srand(1); addprocs(3)
include("functions.jl")
@everywhere using TSVD

println("Starting experiments.....")
####################
## Data
####################
mask = load("output/mask.jld")["mask"]
sqrtW = sqrt.(biased_projection(mask, 1))
d1, d2 = size(mask)
ranks, num_trials = 1:10, 50
SVD_err, dSVD_err = zeros(length(ranks), num_trials), zeros(length(ranks), num_trials)
num_tests = 25 
####################
## Run experiment
####################
for rank in ranks
    println("Rank r = $(rank)........")
    Xs = [get_random_matrix(d1, d2, rank) for _ in 1:num_trials]
    for trial in 1:num_trials
        X = Xs[trial]
        err_SVD(U) = vecnorm(sqrtW .* (X - biased_projection(U, rank))) / vecnorm(sqrtW)
        err_dSVD(U) = vecnorm(sqrtW .* (X - debiased_projection(U, sqrtW, rank))) / vecnorm(sqrtW)
    	Ys = [mask .* (X + randn(d1, d2)) for _ in 1:num_tests] 
    	SVD_err[rank, trial] = mean(pmap(err_SVD, Ys))
	dSVD_err[rank, trial] = mean(pmap(err_dSVD, Ys))
        print("$(trial)..")
    end	
end
save("output/output.jld", "SVD_err", SVD_err, "dSVD_err", dSVD_err, "ranks", ranks)


    
    
