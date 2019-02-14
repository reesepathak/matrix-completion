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
ranks, num_trials, SVD_err, dSVD_err = 1:10, 50, [], []
num_tests = 25 
####################
## Run experiment
####################
for rank in ranks
    println("Rank r = $(rank)........")
    Xs = [get_random_matrix(d1, d2, rank) for _ in 1:num_trials]
    curr_SVD_err, curr_dSVD_err = 0, 0
    for trial in 1:num_trials
        X = Xs[trial]
        err_SVD(U) = vecnorm(sqrtW .* (X - biased_projection(U, rank))) / vecnorm(sqrtW)
        err_dSVD(U) = vecnorm(sqrtW .* (X - debiased_projection(U, sqrtW, rank))) / vecnorm(sqrtW)
    	Ys = [mask .* (X + randn(d1, d2)) for _ in 1:num_tests] 
    	curr_SVD_err += mean(pmap(err_SVD, Ys))
	curr_dSVD_err += mean(pmap(err_dSVD, Ys))
        print("$(trial)..")
    end	
    push!(SVD_err, curr_SVD_err / num_trials); push!(dSVD_err, curr_dSVD_err / num_trials)
end
save("output/output.jld", "SVD_err", SVD_err, "dSVD_err", dSVD_err, "ranks", ranks)


    
    
