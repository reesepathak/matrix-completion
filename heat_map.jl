using JLD, PSPlot

include("functions.jl")
mask = load("mask.jld")["mask"]
u, v = biased_projection(mask, 1, no_sv=true)
u_srt, v_srt = sort(u[:, 1], rev=true), sort(v[:, 1], rev=true)
mask_srt = u_srt * v_srt'

### plot
print("plotting....")
imshow(mask_srt, aspect="auto")
colorbar()
printfig("jester_heatmap")
