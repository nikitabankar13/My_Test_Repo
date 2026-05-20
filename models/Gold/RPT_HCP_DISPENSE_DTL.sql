/* creating fact for prescriptions */

{{ config(materialized='table') }}

with stg_hcp as (
    select * from {{ ref('STG_HCP_DTL') }}
),
trx_hcp as (

    select * from {{ ref('F_TRX_HCP_DTL') }}

)

select hcp_npi,hcp_name,hcp_zip,hcp_team,hcp_territory,patient_count,trx_count,
case when shipment_count > 0 then 'Y' else 'N' end as shipment_flag,
total_qty
from
(select stg_hcp.*,
count(distinct patient_id) as patient_count,
count(distinct rx_number) as trx_count,
count(distinct shipment_date) as shipment_count,
sum(qty) as total_qty
from stg_hcp
left outer join trx_hcp
on (stg_hcp.hcp_npi = trx_hcp.hcp_npi)
group by all)
