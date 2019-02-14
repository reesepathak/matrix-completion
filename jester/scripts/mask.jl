#Pkg.add("CSV")
#Pkg.add("JLD")
using CSV, JLD

println("Starting to construct mask....")
data_dir = "./data"
csvs = readdir(data_dir)
masks = []
for csv in csvs
    df = CSV.read(data_dir * "/" * csv)
    A = convert(Array, df)
    A = convert(Array{Float64, 2}, A[:, 2:end])
    push!(masks, 1.0 * (A .!= 99))
end
mask = vcat(masks...)
save("output/mask.jld", "mask", mask)
println("....               (mask constructed)")

