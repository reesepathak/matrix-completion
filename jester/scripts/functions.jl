@everywhere begin
    function biased_projection(Y, r)
        U, S, V = tsvd(Y, r)
        return U * diagm(S) * V'
    end
end

@everywhere begin 
    function debiased_projection(Y, Wsqrt, r)
        W_inv_sqrt = 1 ./ Wsqrt 
        return W_inv_sqrt .* biased_projection(W_inv_sqrt .* Y, r)
    end
end

function get_random_matrix(d1, d2, rank)
    U = randn(d1, rank)
    V = randn(d2, rank)
    return U * V'
end

function get_random_mask(W)
    R = rand(size(W))
    return 1.0 * (R .<= W)
end
