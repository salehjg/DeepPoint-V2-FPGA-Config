set(KernelsOnBank0 "\n=================================================\nKernel Parameters On DDR Bank 0:\n")
set(KernelsOnBank1 "\n=================================================\nKernel Parameters On DDR Bank 1:\n")
set(KernelsOnBank2 "\n=================================================\nKernel Parameters On DDR Bank 2:\n")
set(KernelsOnBank3 "\n=================================================\nKernel Parameters On DDR Bank 3:\n")

function(PadWithSpaces
    inStr
    outStr)

    string(LENGTH ${${inStr}} lenStr)
    set(pad "")
    foreach(iter RANGE ${lenStr} 15)
        set(pad "${pad} ")
    endforeach(iter)
    set(${outStr} "${${inStr}}${pad}" PARENT_SCOPE)
endfunction()

function(Report 
    argKernelName
    argParameterName
    argBank)

    set(KernelName "aa")
    set(ParameterName "aa")
    set(Bank "1")

    PadWithSpaces(argKernelName KernelName)
    PadWithSpaces(argParameterName ParameterName)
    PadWithSpaces(argBank Bank)

    if(${Bank} EQUAL 0)
        set(KernelsOnBank0 "${KernelsOnBank0}\n${KernelName} ${ParameterName}\t${Bank}" PARENT_SCOPE)
    elseif(${Bank} EQUAL 1)
        set(KernelsOnBank1 "${KernelsOnBank1}\n${KernelName} ${ParameterName}\t${Bank}" PARENT_SCOPE)
    elseif(${Bank} EQUAL 2)
        set(KernelsOnBank2 "${KernelsOnBank2}\n${KernelName} ${ParameterName}\t${Bank}" PARENT_SCOPE)
    elseif(${Bank} EQUAL 3)
        set(KernelsOnBank3 "${KernelsOnBank3}\n${KernelName} ${ParameterName}\t${Bank}" PARENT_SCOPE)
    endif()

endfunction()



Report("Convolution" "InputTn" ${CFG1_Conv2_DDRBANK_inputTn})
Report("Convolution" "WeightTn" ${CFG1_Conv2_DDRBANK_weightTn})
Report("Convolution" "BiasTn" ${CFG1_Conv2_DDRBANK_biasTn})
Report("Convolution" "OutputTn" ${CFG1_Conv2_DDRBANK_outputTn})

Report("TopK" "InputTn" ${CFG2_TopK_DDRBANK_inputTn})
Report("TopK" "IndicesSplitedTn" ${CFG2_TopK_DDRBANK_indicesSplitedTn}) 

Report("MatOps" "InputTn1" ${CFG3_BasicOps_DDRBANK_inputTn1})
Report("MatOps" "InputTn2" ${CFG3_BasicOps_DDRBANK_inputTn2})
Report("MatOps" "OutputTn" ${CFG3_BasicOps_DDRBANK_outputTn})

Report("Reduce" "InputTn" ${CFG4_Reduce_DDRBANK_inputTn})
Report("Reduce" "OutputTn" ${CFG4_Reduce_DDRBANK_outputTn}) 

Report("MatMul" "InputTn1" ${CFG5_MatMul_DDRBANK_inputTn1})
Report("MatMul" "InputTn2" ${CFG5_MatMul_DDRBANK_inputTn2})
Report("MatMul" "OutputTn" ${CFG5_MatMul_DDRBANK_outputTn}) 

Report("Tile" "InputTn" ${CFG6_Tile_DDRBANK_inputTn})
Report("Tile" "OutputTn" ${CFG6_Tile_DDRBANK_outputTn}) 

Report("Gather" "InputTn" ${CFG7_Gather_DDRBANK_inputTn})
Report("Gather" "IndicesTn" ${CFG7_Gather_DDRBANK_indicesTn}) 
Report("Gather" "OutputTn" ${CFG7_Gather_DDRBANK_outputTn}) 

Report("Concat" "InputTn1" ${CFG8_Concat_DDRBANK_inputTn1})
Report("Concat" "InputTn2" ${CFG8_Concat_DDRBANK_inputTn2})
Report("Concat" "OutputTn" ${CFG8_Concat_DDRBANK_outputTn}) 

Report("Transpose" "InputTn" ${CFG9_Transpose_DDRBANK_inputTn})
Report("Transpose" "OutputTn" ${CFG9_Transpose_DDRBANK_outputTn}) 

Report("ReluSqrtSquare" "InputTn" ${CFG10_ReluSqrtSquare_DDRBANK_inputTn})
Report("ReluSqrtSquare" "OutputTn" ${CFG10_ReluSqrtSquare_DDRBANK_outputTn}) 

Report("PadUnpad" "InputTn" ${CFG11_PadUnpad_DDRBANK_inputTn})
Report("PadUnpad" "OutputTn" ${CFG11_PadUnpad_DDRBANK_outputTn})

message("${KernelsOnBank0}")
message("${KernelsOnBank1}")
message("${KernelsOnBank2}")
message("${KernelsOnBank3}\n=================================================\n")
message("DDR Merory Bank0: ${UseMemoryBank0}")
message("DDR Merory Bank1: ${UseMemoryBank1}")
message("DDR Merory Bank2: ${UseMemoryBank2}")
message("DDR Merory Bank3: ${UseMemoryBank3}")

# Sanity Checks
function(SanityCheckMemoryBank Bank)
    if(NOT ${UseMemoryBank0})
        if(${${Bank}} EQUAL "0")
            message(FATAL_ERROR "Memory bank 0 is disabled, but configuration requires bank 0 to be enabled.")
        endif()
    endif()
    if(NOT ${UseMemoryBank1})
        if(${${Bank}} EQUAL "1")
            message(FATAL_ERROR "Memory bank 1 is disabled, but configuration requires bank 1 to be enabled.")
        endif()
    endif()
    if(NOT ${UseMemoryBank2})
        if(${${Bank}} EQUAL "2")
            message(FATAL_ERROR "Memory bank 2 is disabled, but configuration requires bank 2 to be enabled.")
        endif()
    endif()
    if(NOT ${UseMemoryBank3})
        if(${${Bank}} EQUAL "3")
            message(FATAL_ERROR "Memory bank 3 is disabled, but configuration requires bank 3 to be enabled.")
        endif()
    endif()
endfunction()

SanityCheckMemoryBank(CFG1_Conv2_DDRBANK_inputTn)
SanityCheckMemoryBank(CFG1_Conv2_DDRBANK_weightTn)
SanityCheckMemoryBank(CFG1_Conv2_DDRBANK_biasTn)
SanityCheckMemoryBank(CFG1_Conv2_DDRBANK_outputTn)

SanityCheckMemoryBank(CFG2_TopK_DDRBANK_inputTn)
SanityCheckMemoryBank(CFG2_TopK_DDRBANK_indicesSplitedTn) 

SanityCheckMemoryBank(CFG3_BasicOps_DDRBANK_inputTn1)
SanityCheckMemoryBank(CFG3_BasicOps_DDRBANK_inputTn2)
SanityCheckMemoryBank(CFG3_BasicOps_DDRBANK_outputTn)

SanityCheckMemoryBank(CFG4_Reduce_DDRBANK_inputTn)
SanityCheckMemoryBank(CFG4_Reduce_DDRBANK_outputTn) 

SanityCheckMemoryBank(CFG5_MatMul_DDRBANK_inputTn1)
SanityCheckMemoryBank(CFG5_MatMul_DDRBANK_inputTn2)
SanityCheckMemoryBank(CFG5_MatMul_DDRBANK_outputTn) 

SanityCheckMemoryBank(CFG6_Tile_DDRBANK_inputTn)
SanityCheckMemoryBank(CFG6_Tile_DDRBANK_outputTn) 

SanityCheckMemoryBank(CFG7_Gather_DDRBANK_inputTn)
SanityCheckMemoryBank(CFG7_Gather_DDRBANK_indicesTn) 
SanityCheckMemoryBank(CFG7_Gather_DDRBANK_outputTn) 

SanityCheckMemoryBank(CFG8_Concat_DDRBANK_inputTn1)
SanityCheckMemoryBank(CFG8_Concat_DDRBANK_inputTn2)
SanityCheckMemoryBank(CFG8_Concat_DDRBANK_outputTn) 

SanityCheckMemoryBank(CFG9_Transpose_DDRBANK_inputTn)
SanityCheckMemoryBank(CFG9_Transpose_DDRBANK_outputTn) 

SanityCheckMemoryBank(CFG10_ReluSqrtSquare_DDRBANK_inputTn)
SanityCheckMemoryBank(CFG10_ReluSqrtSquare_DDRBANK_outputTn) 

SanityCheckMemoryBank(CFG11_PadUnpad_DDRBANK_inputTn)
SanityCheckMemoryBank(CFG11_PadUnpad_DDRBANK_outputTn)