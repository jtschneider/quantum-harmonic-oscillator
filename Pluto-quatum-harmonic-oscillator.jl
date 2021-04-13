### A Pluto.jl notebook ###
# v0.14.1

using Markdown
using InteractiveUtils

# This Pluto notebook uses @bind for interactivity. When running this notebook outside of Pluto, the following 'mock version' of @bind gives bound variables a default value (instead of an error).
macro bind(def, element)
    quote
        local el = $(esc(element))
        global $(esc(def)) = Core.applicable(Base.get, el) ? Base.get(el) : missing
        el
    end
end

# ╔═╡ be4635d0-9bc1-11eb-2efd-d500550f4620
begin
	using PlutoUI 	# use interactive HTML binding of variables
	using Plots 	# use Plot package to ... plot
	using Printf
	plotlyjs()		# use interactive javascript backend for Plots.jl
	# gr()				# use the more conventional GR backend for plotting
end

# ╔═╡ 955fe07b-dd41-447a-98d5-1866904eefc3
function CEven(n::Int,ε) # define even coefficients
	if n==0
		return 1.0
	elseif n == 1
		return 0.0
	end
	return CEven(n-2,ε) * (2.0*(n-2) + 1 - 2ε)/(n*(n-1))
end

# ╔═╡ a43cd1de-02d0-45e2-8610-dae931ab8c10
function COdd(n::Int,ε) # define odd coefficients
	if n==1
		return 1.0
	elseif n == 0
		return 0.0
	end
	return COdd(n-2,ε) * (2.0*(n-2) + 1 - 2ε)/(n*(n-1))
end

# ╔═╡ 460a5f0a-d776-4bfd-8e67-4cab0315fd85
numberOfTerms = 200

# ╔═╡ 66acd7ad-45a9-4af7-b940-4b7d2ca9691c
ψEven(x, ε) = sum( η -> CEven(η, ε) * x^η, 0:1:numberOfTerms) * exp(-x^2/2)

# ╔═╡ 3f79e204-a2a6-46a2-b910-a3ce919cf340
ψOdd(x, ε) = sum( η -> COdd(η, ε) * x^η, 0:1:numberOfTerms) * exp(-x^2/2)

# ╔═╡ f4eca874-f58f-422e-a31b-114bde7373cd
xPlot = collect(-5:0.01:5)

# ╔═╡ 4ec87017-4f8e-4d1e-b1e0-34d3f6ca62aa
@bind ε Slider(0.3:0.1:7.6; default=0.3, show_value=true)

# ╔═╡ c39942fc-dfad-4afe-abed-5f523c265caa
begin
	plotlyjs()
	plot1 = plot(xPlot, xPlot .^2, label="V(x) = x²")
		ylims!(plot1, (-4,4))
		title!(plot1, "Even wavefunctions")
		plot!(plot1, xPlot, ψEven.(xPlot, ε), label="ψ even, ε=$(@sprintf("%.2f",ε))")
	
end

# ╔═╡ 335d3458-a511-42bb-af11-ca18b11432c0
begin
	plotlyjs()
	plot2 = plot(xPlot, xPlot .^2, label="V(x) = x²")
	plot!(plot2, xPlot, ψOdd.(xPlot, ε), label="ψ odd, ε=$(@sprintf("%.2f",ε))")
	ylims!(plot2, (-4,4))
	title!(plot2, "Odd wavefunctions")
end

# ╔═╡ 98216100-19a0-46ca-802a-7cfe46e4e138
begin
	gr()
	@gif for ε ∈ 0.1:0.05:10.0
		plot(xPlot, xPlot .^2, label="V(x) = x²")
		ylims!((-4,4))
		title!("Even wavefunctions")
		plot!(xPlot, ψEven.(xPlot, ε), label="ψ even, ε=$(@sprintf("%.2f",ε))")
	end
end

# ╔═╡ b5fcc994-c771-46dd-9558-248c58ce08df
begin
	gr()
	@gif for ε ∈ 0.1:0.05:10.0
		plot(xPlot, xPlot .^2, label="V(x) = x²")
		ylims!((-4,4))
		title!("Odd wavefunctions")
		plot!(xPlot, ψOdd.(xPlot, ε), label="ψ odd, ε=$(@sprintf("%.2f",ε))")
	end
end

# ╔═╡ Cell order:
# ╠═be4635d0-9bc1-11eb-2efd-d500550f4620
# ╠═955fe07b-dd41-447a-98d5-1866904eefc3
# ╠═a43cd1de-02d0-45e2-8610-dae931ab8c10
# ╠═460a5f0a-d776-4bfd-8e67-4cab0315fd85
# ╠═66acd7ad-45a9-4af7-b940-4b7d2ca9691c
# ╠═3f79e204-a2a6-46a2-b910-a3ce919cf340
# ╠═f4eca874-f58f-422e-a31b-114bde7373cd
# ╠═4ec87017-4f8e-4d1e-b1e0-34d3f6ca62aa
# ╠═c39942fc-dfad-4afe-abed-5f523c265caa
# ╠═335d3458-a511-42bb-af11-ca18b11432c0
# ╠═98216100-19a0-46ca-802a-7cfe46e4e138
# ╠═b5fcc994-c771-46dd-9558-248c58ce08df
