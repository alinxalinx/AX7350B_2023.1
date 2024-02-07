set tclPath [pwd]
cd $tclPath
cd ..
set projpath [pwd]
puts "Current workspace is $projpath"
setws $projpath
getws
set xsaName design_1_wrapper
set app0Name pcie
set app1Name xaxipcie_rc_enumerate_example_1

#Create a new platform
platform create -name $xsaName -hw $projpath/$xsaName.xsa -proc ps7_cortexa9_0 -os standalone -arch 32-bit -out $projpath
importprojects $projpath/$xsaName
platform active $xsaName
repo -add-platforms $xsaName
importsources -name $xsaName/zynq_fsbl -path $tclPath/src/fsbl -target-path ./
domain create -name "standalone_bsp_0" -os standalone -proc ps7_cortexa9_0
domain active standalone_domain
#Create a new application
app create -name $app0Name -platform $xsaName -domain standalone_domain -template "Empty Application"
importsources -name $app0Name -path $tclPath/src/$app0Name
domain active standalone_bsp_0
app create -name $app1Name -platform $xsaName -domain standalone_bsp_0 -template "Empty Application"
importsources -name $app1Name -path $tclPath/src/$app1Name

#Build platform project
platform generate
#Build application project
app build -name $app0Name
app build -name $app1Name
