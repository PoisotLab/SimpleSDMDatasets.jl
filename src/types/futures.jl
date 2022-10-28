abstract type FutureScenario end
abstract type FutureModel end

# CMIP 6 models and scenarios
abstract type CMIP6Scenario <: FutureScenario end
abstract type CMIP6Model <: FutureModel end

# SSP scenarios
struct SSP126 <: CMIP6Scenario end
struct SSP245 <: CMIP6Scenario end
struct SSP370 <: CMIP6Scenario end
struct SSP585 <: CMIP6Scenario end

# CMIP6 GCMs + variants
struct ACCESS_CM2 <: CMIP6Model end
struct ACCESS_ESM1_5 <: CMIP6Model end
struct BCC_CSM2_MR <: CMIP6Model end
struct CanESM5 <: CMIP6Model end
struct CanESM5_CanOE <: CMIP6Model end
struct CMCC_ESM2 <: CMIP6Model end
struct CNRM_CM6_1 <: CMIP6Model end
struct CNRM_CM6_1_HR <: CMIP6Model end
struct CNRM_ESM2_1 <: CMIP6Model end
struct EC_Earth3_Veg <: CMIP6Model end
struct EC_Earth3_Veg_LR <: CMIP6Model end
struct FIO_ESM_2_0 <: CMIP6Model end
struct GFDL_ESM4 <: CMIP6Model end
struct GISS_E2_1_G <: CMIP6Model end
struct GISS_E2_1_H <: CMIP6Model end
struct HadGEM3_GC31_LL <: CMIP6Model end
struct INM_CM4_8 <: CMIP6Model end
struct INM_CM5_0 <: CMIP6Model end
struct IPSL_CM6A_LR <: CMIP6Model end
struct MIROC_ES2L <: CMIP6Model end
struct MIROC6 <: CMIP6Model end
struct MPI_ESM1_2_LR <: CMIP6Model end
struct MPI_ESM1_2_HR <: CMIP6Model end
struct MRI_ESM2_0 <: CMIP6Model end
struct UKESM1_0_LL <: CMIP6Model end