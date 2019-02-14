using PSPlot

##########
# Plotting
##########

# avg-per entry figure
figure()
plot(1:10, avg_err_bias, label="\hat M = biased (Vanilla)")
plot(1:10, avg_err_debias, label="\hat M = debiased (Our alg.)")
legend()
ylabel("||M - \hat M||_F")#/(d_1 * d_2)")
printfig("unnorm/avgerr_labels")

figure()
plot(1:10, avg_err_bias, label=" "^15)
plot(1:10, avg_err_debias, label=" "^15)
legend()
printfig("unnorm/avgerr_nolabels")

# weighted error
figure()
plot(1:10, weight_err_bias, label="\hat M = biased (Vanilla)")
plot(1:10, weight_err_debias, label="\hat M = debiased (Our alg.)")
legend()
ylabel("||Wsqrt \had (M - \hat M)||_F")#/||Wsqrt||_F")
printfig("unnorm/weighterr_labels")

figure()
plot(1:10, weight_err_bias, label=" "^15)
plot(1:10, weight_err_debias, label=" "^15)
legend()
printfig("unnorm/weighterr_nolabels")
