using PowerModels, PowerPlots, HiGHS, VegaLite   # 已经列全
using Plots                                      # 补上这句
using PowerModelsWildfire                        # 补上这句
gr()                                             # 初始化后端（可选）

# 1. 读网络
case = PowerModels.parse_file(joinpath(@__DIR__, "test", "networks", "case14_risk.m"))

# 2. 计算
sol = PowerModelsWildfire.run_ops(case, PowerModels.DCPPowerModel, HiGHS.Optimizer)

# 3. 把结果写回原始字典
PowerModels.update_data!(case, sol["solution"])

# 4. 画图 & 保存
p = powerplot(case)
display(p)
powerplot(case) |> save("ops.png")
println("✅ ops.png 已保存在当前目录")