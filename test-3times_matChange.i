[Mesh/gen]
  type = GeneratedMeshGenerator
  dim = 2
  nx = 10
  ny = 10
[]

[AuxVariables/aux]
  family = MONOMIAL
[]

[AuxKernels/mat]
  type = MaterialRealAux
  variable = aux
  property = prop
[]

[Problem]
  solve = false
  material_dependency_check = false
[]

[Materials]
  [prop0]
    type = GenericConstantMaterial
    prop_names = "prop"
    prop_values = "1"
  []
  [prop1]
    type = GenericConstantMaterial
    prop_names = "prop"
    prop_values = "2"
    enable = false
  []
  [prop2]
    type = GenericConstantMaterial
    prop_names = "prop"
    prop_values = "3"
    enable = false
  []
[]
[Executioner]
  type = Transient
  num_steps = 15
  dt = 0.1
[]

[Outputs]
  exodus = true
  [./controls]
    type = ControlOutput
    show_active_objects = false  
  [../]
[]

[Postprocessors/avg]
  type = ElementAverageValue  
  variable = aux
[]
# Using three different material properties at three different time periods  
[Controls]
 [control_0]
  type = TimePeriod
  enable_objects = '*/prop0'
  disable_objects = '*/prop1 */prop2'
  start_time = 0
  end_time = 0.5
  execute_on = 'INITIAL TIMESTEP_END'
 []
 [control_1]
  type = TimePeriod
  enable_objects = '*/prop1'
  disable_objects = '*/prop0 */prop2'
  start_time = 0.5
  end_time = 1
  execute_on = 'INITIAL TIMESTEP_END'
 []
 [control_2]
  type = TimePeriod
  enable_objects = '*/prop2'
  disable_objects = '*/prop0 */prop1'
  start_time = 1
  end_time = 1.5
  execute_on = 'INITIAL TIMESTEP_END'
 []
[]
