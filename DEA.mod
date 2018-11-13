# ---- proposed model ----

# this model determines the relative efficiency of a decision making unit (ie. hospital, business, etc)
# this model can be used to rank decision making units as "better" or "worse" than others based on the given input and output metrics

# ---- define set(s) ----

set inputs;  # set of inputs
set outputs;  # set of outputs
set DMUs;  # set of decision making units (DMU)

# ---- define parameter(s) ----

param input_value{inputs,DMUs};  # the value of an input for a DMU (higher values should indicate having more resources, and vis versa)
param output_value{outputs,DMUs}; # the value of an output for a DMU (higher values should indicate better development, and vis versa)
param dmu symbolic;  # represents any single DMU

# ---- define variable(s) ----

var input_weight{inputs} >= 1e-16;  # a weight that converts inputs onto the same scale
var output_weight{outputs} >= 1e-16;  # a weight that converts outputs onto the same scale

# ---- define model formulation ----

maximize EFFICIENCY: sum{o in outputs}(output_value[o,dmu] * output_weight[o]);  # maximize total output (this is efficiency because the sum of inputs is required to equal 1)
s.t. OUTPUT{u in DMUs}: sum{i in inputs}(input_value[i,u] * input_weight[i]) - sum{o in outputs}(output_value[o,u] * output_weight[o]) >= 0;  # total output value cannot be greater than total input value (0% <= efficiency <= 100%)
s.t. INPUT: sum{i in inputs}(input_value[i,dmu] * input_weight[i]) = 1;  # total input value must equal 1 (your total input is 100% of your investment) 


