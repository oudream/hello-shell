# exe
set(gsl_txjprotocolmodbustcp_cong_sources
        /include/modbustcp.h
        /src/modbustcp.cpp
        /main.cpp
        )

set(gs_project_txjprotocolmodbustcp_cong_path ${gs_project_protocols_path}/txjprotocolmodbustcp_cong)

mc_merge_file_path(${gs_project_txjprotocolmodbustcp_cong_path} "${gsl_txjprotocolmodbustcp_cong_sources}" gsl_source_filepaths)

# include
include_directories(${gs_project_txjprotocolmodbustcp_cong_path}/include)
include_directories(${gs_project_path}/includes)


# main app
add_library(txjprotocolmodbustcp_cong SHARED
        ${gsl_source_filepaths}
        )

mc_app_target_link(txjprotocolmodbustcp_cong)
