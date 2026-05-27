/* creating staging for HCPs */
/* refer to source tables from source.yml */

{{ config(materialized='table') }}

with source_data as (

    select hcp_npi,hcp_first_name||' '||hcp_last_name as hcp_name,hcp_zip,hcp_team,hcp_territory
    from {{ source('raw_data_tables', 'LDG_HCP_DETAIL') }}

)

select *
from source_data