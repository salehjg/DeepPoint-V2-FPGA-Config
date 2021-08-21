#-------------------------------------------------------------------------------
# CFG1: conv2_1x1 (gemm_hls)

#-------------------------------------------------------------------------------
# CFG2: TopK
#math(EXPR REM01 "(${CFG2_TopK_MaxSliceLen} % ${CFG0_M_AXI_WIDTH})")
#if(REM01 GREATER 0)
#    message(FATAL_ERROR "CFG2_TopK_MaxSliceLen of value ${CFG2_TopK_MaxSliceLen} should be divisible by maxi width of value ${CFG0_M_AXI_WIDTH}.")
#endif()

#math(EXPR VECS_PER_MAXSLICE "(${CFG2_TopK_MaxSliceLen} / ${CFG0_M_AXI_WIDTH})")
#if(CFG2_TopK_PipeDepth LESS VECS_PER_MAXSLICE)
#    message(WARNING "CFG2_TopK_PipeDepth of value ${CFG2_TopK_PipeDepth} is suggested to be equal or greater than CFG2_TopK_MaxSliceLen of value ${CFG2_TopK_MaxSliceLen} divided by maxi width of value ${CFG0_M_AXI_WIDTH} which is equal to ${VECS_PER_MAXSLICE}.")
#endif()

#-------------------------------------------------------------------------------
# CFG10: Transpose
math(EXPR REM02 "(${CFG9_Transpose_PipeDepth1} % ${CFG0_M_AXI_WIDTH})")
if(REM02 GREATER 0)
    message(FATAL_ERROR "CFG9_Transpose_PipeDepth1 of value ${CFG9_Transpose_PipeDepth1} should be divisible by maxi width of value ${CFG0_M_AXI_WIDTH}.")
endif()